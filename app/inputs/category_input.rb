class CategoryInput < SimpleForm::Inputs::Base

  CATEGORIES = Club::CATEGORIES
  def input
    "#{@builder.select(attribute_name, CATEGORIES, input_html_options)}".html_safe
  end

end
