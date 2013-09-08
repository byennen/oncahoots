class CategoryInput < SimpleForm::Inputs::Base

  CATEGORIES = [
    "Academic",
    "Alumni",
    "Arts",
    "Social",
    "Gender",
    "Health",
    "Media",
    "Performance",
    "Political",
    "Recreational",
    "Sports",
    "Religious",
    "Service",
    "Student Govt",
    "Union Board"
  ]

  def input
    "#{@builder.select(attribute_name, CATEGORIES, input_html_options)}".html_safe
  end

end
