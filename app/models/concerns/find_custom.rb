module FindCustom
  extend ActiveSupport::Concern

  class_methods do
    def get_custom(key)
      c = Customization.where(key: key).first
      c ? c['content'].html_safe : nil
    end
  end
end
