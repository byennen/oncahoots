module Dev
  class << self
    def create_metropolitan_clubs
      Club.where(type: "MetropolitantClub").destroy_all
      University.all.each do |university|
        university.create_metropolitan_clubs
      end
    end

    def update_college_images
      file_path = "#{Rails.root}/public/raw-images/universities/banner/"
      University.all.each do |university|
        image_banner = "#{file_path}#{university.slug.split('-')[0].capitalize}Header.jpg"
        image_file = "#{file_path}#{university.slug.split('-')[0].capitalize}Logo.jpg"
        begin
          university.banner.store!(File.open(image_banner)) if File.exist?(image_banner)
          university.image.store!(File.open(image_file)) if File.exist?(image_file)
          university.save!
          puts "Created image for #{university.name}"
        rescue Exception => e
          p e
        end
      end
    end
  end
end