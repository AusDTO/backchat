# https://gist.github.com/vjt/4548844
# https://stackoverflow.com/questions/24395618/invoking-a-large-set-of-sql-from-a-rails-4-application/24561299#24561299
namespace :db do
  namespace :structure do
    desc "Load structure.sql file into the current environment's database"
    task :ar_load do
      # Loads the db/structure.sql file into current environment's database.
      #
      script = Rails.root.join('db/structure.sql').read
      ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
      # this needs to match the delimiter of your queries
      STATEMENT_SEPARATOR = ";\n\n"
      BLACKLIST_SQL = "COMMENT ON EXTENSION"
      ActiveRecord::Base.transaction do
        script.split(STATEMENT_SEPARATOR).each do |stmt|
          if not stmt.include?(BLACKLIST_SQL)
            puts stmt
            ActiveRecord::Base.connection.execute(stmt)
          end
        end
      end
    end
  end
end