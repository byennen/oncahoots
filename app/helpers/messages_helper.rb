module MessagesHelper
  def sender_image(msg_obj)
    sender = msg_obj.sender
    if sender.is_a?(User) && sender.super_admin?
      image_tag "/assets/logo.png", class: "circular cir-img thumb", style: "height: 77px;"
    elsif sender.is_a?(User) && sender.university_admin?
      image_tag sender.university.image.small, class: "circular cir-img"
    else
      display_image(sender.image, "thumb")
    end
  end

  def sender_name(msg_obj)
    sender = msg_obj.sender
    if sender.is_a?(User) && sender.super_admin?
      return "On Cahoots"
    elsif sender.is_a?(User) && sender.university_admin?
      return "#{msg_obj.sender.university.name} On Cahoots"
    else
      return sender.name
    end
  end
end
