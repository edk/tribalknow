# with some helpers in application_helper, such as render_custom_text
# this is to allow custom text and page titles without the full blown
# overhead of a CMS
class CustomizedPage < ApplicationRecord
  stampable

  default_scope {
    if Tenant.current_id
      where(tenant_id:Tenant.current_id)
    else
      where('1=1')
    end
  }

  def self.location location
    where(page: location, active: true).first
  end

  def at position
    # look through all positions.  a kind of poor-mans has_many association
    found = %w[1 2 3 4].detect { |n| send("position#{n}") == position } # checking the contents of position for a match
    if found
      return [send("header#{found}"), send("content#{found}")]
    end
  end

end
