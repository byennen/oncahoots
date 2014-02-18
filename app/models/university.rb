class University < ActiveRecord::Base
  has_many :users
  has_many :updates, as: :updateable

  has_many :clubs, dependent: :destroy
  has_many :metropolitan_clubs, dependent: :destroy
  has_many :events

  attr_accessible :location, :mascot, :name, :image, :banner, :slug

  mount_uploader :image, ImageUploader
  mount_uploader :banner, BannerUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  after_create :create_metropolitan_clubs

  def metropolitan_club(city_id)
    metropolitan_clubs.find_by_city_id city_id
  end

  def most_popular_club
    club_id = Rails.cache.fetch "university_#{name}_most_popular_club", expires_in: 1.hour do
      most_popular_club_grouped_membership_id = Membership.membership_counts_sorted_by_popularity.where("university_id = ?", id).limit(1)[0]
      club_ids = clubs.pluck(:id)
      most_popular_club_grouped_membership_id.present? ? most_popular_club_grouped_membership_id.club_id : club_ids[rand(club_ids.length)]
    end
    Club.find_by_id(club_id)
  end

  def metropolitan_clubs_sorted_by_popularity
    club_ids = Rails.cache.fetch "university_#{name}_metropolitan_clubs_sorted_by_popularity", expires_in: 1.hour do
      university_metropolitan_clubs_sorted_by_popularity = Membership.membership_counts_sorted_by_popularity.where("clubs.type = 'MetropolitanClub'").where("university_id = ?", id).limit(200).to_a.map(&:club_id)
      other_metropolitan_clubs = MetropolitanClub.select("clubs.id").includes(:memberships).where(university_id: id, memberships: {club_id: nil}).limit(200).to_a.map(&:id)
      (university_metropolitan_clubs_sorted_by_popularity + other_metropolitan_clubs).compact
    end
    MetropolitanClub.where(id: club_ids)
  end

  def create_metropolitan_clubs
    owner = User.find_by_email(ENV['UNIVERSITY_ADMIN_EMAIL'])
    file_path = "#{Rails.root}/public/raw-images/metropolitan-clubs/banner/"
    puts "create metropolitan clubs for #{name}"
    City.all.each do |city|
      count = MetropolitanClub.where(university_id: id, city_id: city.id).size
      if count == 0
        puts "............at #{city.name}"
        club=metropolitan_clubs.build(city_id: city.id)
        club.name = "#{name} of #{city.name}"
        club.user = owner
        if File.exist?("#{file_path}#{city.slug}.jpeg")
          @image_file = "#{file_path}#{city.slug}.jpeg"
        elsif File.exist?("#{file_path}#{city.slug}.jpg")
          @image_file = "#{file_path}#{city.slug}.jpg"
        end
        next if @image_file.nil?
        club.save(validate: false)
        club.memberships.create!(admin: true, title: 'Founder', user_id: club.user.id)
        if club.valid?
          puts "Club #{club.name} created successfully."
        else
          puts club.errors.full_messages.join(",")
        end
        # this is needed because we are embedding the ID of the model in the image path; not available till after save
        club.image.store!(File.open(@image_file))
        club.save!
      else
        puts "++++++++#{name} of #{city.name} already exits"
      end
    end
  end
end
