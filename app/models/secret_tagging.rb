class SecretTagging < ActiveRecord::Base
  attr_accessible :secret_id, :tag_id

  belongs_to :secret
  belongs_to :tag
end
