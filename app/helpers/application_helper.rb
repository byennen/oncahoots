module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  #for nested forms
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn new1", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def close_modal_button
    "<button type='button' class='close' data-dismiss='modal'>&times;</button>"
  end

  def week_title(week_start)
    week_end = week_start + 6.days
    str = "#{week_start.strftime("%b")} #{week_start.strftime("%d")} - "
    str = "#{str}#{week_end.strftime("%b")} " if week_start.month != week_end.month
    str = "#{str}#{week_end.strftime("%d")}"
  end

  def display_image(image, size, options={})
    if image.blank?
      "<img id='#{options[:id]}' src='/assets/bg.png' class='circular cir-img #{size}'></image><div class='no-img-title title-#{size}'><div class='title-in'>No Image</div></div>".html_safe
    else
      image_tag image.send(size), class: "circular cir-img", id: options[:id]
    end
  end

  def display_image_square(image, size)
    if image.blank?
      "<img src='/assets/bg.png' class='square cir-img #{size}'></image><div class='no-img-title title-#{size}'><div class='title-in'>No Image</div></div>".html_safe
    else
      image_tag image.send(size), class: "square cir-img"
    end
  end

  def bg_class
    "bg-image bg-image2" if controller_name == "universities" || controller_name == "metropolitan_clubs" || (controller_name == "clubs" && params[:action] != 'index')
  end

  def hero_banner(options={})
    if controller_name == "universities" || controller_name == "metropolitan_clubs" || (controller_name == "clubs" && params[:action] != 'index')
      if club = options[:club]
        "background-image: url('#{club.image.url}')" unless club.image.blank?
      elsif university = options[:university]
        "background: url('#{university.banner.url}') no-repeat" unless university.banner.blank?
      end
    end
  end

  def hour_range(step=2)
    ["0 - 2 AM", "2 - 4 AM", "4 - 6 AM", "6 - 8 AM", "8 - 10 AM", "10AM - 12 PM",
     "12 - 2 PM", "2 - 4 PM", "4 - 6 PM", "6 - 8 PM", "8 - 10 PM", "10 - 0 AM"]
  end

  def alert_name(alertable)
    Rails.logger.debug(alertable.inspect)
    if alertable.class == User
      return alertable.name
    else
      return alertable.name
    end
  end

end
