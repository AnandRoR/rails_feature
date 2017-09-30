class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # def find_by_string(field_name="", value="")
  # 	where("#{field_name} LIKE (?)", "%#{value}")
  # end
end
