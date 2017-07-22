# from gist.github.com tjh/1711329
class ConvertTablesToUtf8 < ActiveRecord::Migration
  def db
    ActiveRecord::Base.connection
  end

  def up 
    execute "ALTER DATABASE `#{db.current_database}` CHARACTER SET utf8mb4;"
    db.tables.each do |table|
      next if %w(ar_internal_metadata schema_migrations).include?(table)
      #next if db.views.include?(table) # Skip views. This will not be necessary in Rails 5.1, when `db.tables` will change to only return actual tables.
      execute "ALTER TABLE `#{table}` CHARACTER SET = utf8mb4;"
      db.columns(table).each do |column|
        case column.sql_type 
        when /([a-z]*)text/i
          execute "ALTER TABLE `#{table}` CHANGE `#{column.name}` `#{column.name}` #{$1.upcase}TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
        when /((?:var)?char)\(([0-9]+)\)/i
          # InnoDB has a maximum index length of 767 bytes, so for utf8 or utf8mb4
          # columns, you can index a maximum of 255 or 191 characters, respectively.
          # If you currently have utf8 columns with indexes longer than 191 characters,
          # you will need to index a smaller number of characters.
          indexed_column = db.indexes(table).any? { |index| index.columns.include?(column.name) }

          sql_type = (indexed_column && $2.to_i > 191) ? "#{$1}(191)" : column.sql_type.upcase
          default = (column.default.nil?) ? '' : "DEFAULT '#{column.default}'"
          null = (column.null) ? '' : 'NOT NULL'
          execute "ALTER TABLE `#{table}` CHANGE `#{column.name}` `#{column.name}` #{sql_type} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci #{default} #{null};"
        end
      end
    end
  end
end
