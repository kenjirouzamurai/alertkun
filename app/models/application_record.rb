class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

protected

  def set_uuid
    if self.uuid.blank?
      self.uuid = SecureRandom.base58(8)
    end
  end
end
