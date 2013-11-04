class Event < ActiveRecord::Base
  attr_accessible :title, :location, :description, :category,
                  :image, :free_food, :on_date, :at_time, :eventable_type, :club_id, :display_on_uc

  belongs_to :eventable, polymorphic: true

  mount_uploader :image, ImageUploader

  scope :free_food, where(free_food: true)
  scope :non_free_food, where(free_food: !true)
  scope :display_on_university_calendar, where(display_on_wc: true)

  validates :title, presence: true

  def date
    on_date.strftime("%Y-%m-%d") if on_date
  end

  def time
    at_time.strftime("%H:%M") if at_time
  end

  class << self
    def search_all(params)
      return where("1=1") if params.blank?
      search_title(params[:title]).search_date(params[:on_date]).search_time(params["at_time(4i)"], params["at_time(5i)"])
      .search_location(params[:location]).search_category(params[:category])
    end

    def search_title(title)
      return where("1=1") if name.blank?
      where("lower(title) like ?", "%#{title.downcase}%")
    end

    def search_location(location)
      return where("1=1") if location.blank?
      where("lower(location) like ?", "%#{location.downcase}%")
    end

    def search_category(category)
      return where("1=1") if category.blank?
      where("lower(category) like ?", "%#{category.downcase}%")
    end

    def search_date(date)
      return where("1=1") if date.blank?
      where(on_date: date)
    end

    def search_time(h,m)
      if h.blank? || m.
      time=Time.strptime("#{h}#{m}","%H:%M")
      return where("1=1") if time.blank?
      where(at_time: time)
    end

  end
end
