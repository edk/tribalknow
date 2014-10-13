class AddAasmStateToVideoAsset < ActiveRecord::Migration
  def change
    add_column :file_assets, :aasm_state, :string
    add_index :file_assets, :aasm_state
  end
end
