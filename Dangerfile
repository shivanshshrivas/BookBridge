# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Add a CHANGELOG entry for app changes
unless git.modified_files.include?("CHANGELOG.md") || declared_trivial
  warn("Please include a CHANGELOG entry.")
end

def migrations_added_or_updated?
  added_or_modified_files = git.modified_files + git.added_files
  added_or_modified_files.any? { |file| file.start_with?("db/migrate/") }
end

if migrations_added_or_updated? && (!git.modified_files.any? { |file| file.end_with?("_seeds.rb") } || !git.modified_files.any? { |file| file.end_with?(".seeds.rb") })
  warn("Please update your seeds. A migration has been added or updated")
end
