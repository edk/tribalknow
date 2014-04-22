# t.references :multimedia, index: true
# t.integer    :position # order in the list of multimedia clips
# t.string     :title
# t.string     :type
# t.integer    :size
# t.integer    :seconds
# t.text       :data
# t.attachment :file
# 
# t.userstamps

class MultimediaClip < ActiveRecord::Base
  belongs_to :multimedia
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }
end
