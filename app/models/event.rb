class Event < ActiveRecord::Base
  attr_accessible :title, :location, :description, :category,
                  :image, :free_food, :on_date, :at_time, :university_id, :club_id, :display_on_uc

  belongs_to :user
  belongs_to :university
  belongs_to :club

  mount_uploader :image, ImageUploader

  scope :free_food, where(free_food: true)
  scope :non_free_food, where(free_food: !true)
  scope :display_on_university_calendar, where(display_on_wc: true)
  scope :active, where("on_date >= ?", Date.today)

  validates :title, presence: true

  def date
    on_date.strftime("%m/%d/%Y") if on_date
  end

  def time
    at_time.strftime("%I:%M %p") if at_time
  end

  class << self
    def search_all(params)
      return where("1=1") if params.blank?
      search_title(params[:title]).search_date(params[:on_date]).search_time(params[:time])
      .search_location(params[:location]).search_category(params[:category]).search_free_food(params[:free_food])
    end

    def search_title(title)
      return where("1=1") if title.blank?
      where("lower(title) like ?", "%#{title.downcase}%")
    end

    def search_location(location)
      return where("1=1") if location.blank?
      where("lower(location) like ?", "%#{location.downcase}%")
    end

    def search_category(category)
      return where("1=1") if category.blank? || category == "All category"
      where("lower(category) like ?", "%#{category.downcase}%")
    end

    def search_date(date)
      return where("1=1") if date.blank?
      where(on_date: date)
    end

    def search_free_food(free)
      return where("1=1") if free.blank? || free=="All"
      free=='free' ? free_food : non_free_food
    end

    def search_time(range)
      return where("1=1") if range.blank? || range =="All"
      hmin = TIME_RANGE[range].first
      hmax = TIME_RANGE[range].last
      min=Time.strptime("2000/01/01 #{hmin}:00 UTC","%Y/%m/%d %H:%M %Z")
      max=Time.strptime("2000/01/01 #{hmax}:59 UTC","%Y/%m/%d %H:%M %Z")
      where("at_time >= ? and at_time <= ?", min, max)
    end

  end

  TIME_RANGE = {"0 - 2 AM" => [0,2], "2 - 4 AM" => [2,4], "4 - 6 AM" => [4,6], "6 - 8 AM" => [6,8], "8 - 10 AM" => [8,10], "10AM - 12 PM" => [10,12],
     "12 - 2 PM" => [12,14], "2 - 4 PM" => [14,16], "4 - 6 PM" => [16,18], "6 - 8 PM" => [18,20], "8 - 10 PM" => [20, 22], "10 - 0 AM" => [22,24]}

  after_create :add_club_update

  private
    def add_club_update
      if club
        update=club.updates.new(headline: title, body: description)
        update.image = image.file unless image.blank?
        update.save
      end
    end
end
