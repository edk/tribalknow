# t.string     :title
# t.references :topic, :index=>true
# t.text       :timeline
# t.text       :content
# 
# t.userstamps

class Multimedia < ActiveRecord::Base
  
  belongs_to :topic
  has_many   :clips, -> { order('position ASC, id ASC') }, :class_name=>'MultimediaClip' # audio and video
  default_scope {where(tenant_id:Tenant.current_id) if Tenant.current_id }
end
