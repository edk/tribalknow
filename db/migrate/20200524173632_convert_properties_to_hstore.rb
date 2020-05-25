class ConvertPropertiesToHstore < ActiveRecord::Migration[5.2]
  def up
    # convert text filed to jsonb in-place
    execute "alter table ahoy_events alter column properties type jsonb using properties::JSON"
  end
  def down
    execute "alter table ahoy_events alter column properties type text"
  end
end
