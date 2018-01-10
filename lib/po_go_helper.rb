require 'yaml'

class PoGoHelper
  def self.next_migration
    root = File.expand_path '../..', __FILE__
    last_migration_path = File.join(root, 'last_migration.yml')

    last_migration_hash = HashWithIndifferentAccess.new(YAML.load_file(last_migration_path))
    next_migration = last_migration_hash[:last_migration].to_date + 2.weeks

    if Time.now.to_date <= last_migration_hash[:last_migration].to_date
      last_migration_hash[:last_migration].to_time.strftime("%d/%m/%Y")
    else
      last_migration_hash[:last_migration] = next_migration.strftime('%d/%m/%Y')

      File.open(last_migration_path, 'w') do |f|
        f.puts last_migration_hash.to_yaml
      end

      next_migration.to_time.strftime("%d/%m/%Y")
    end
  end
end
