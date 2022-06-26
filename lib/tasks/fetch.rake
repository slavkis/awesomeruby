require 'net/http'

task fetch: :environment do
  REPO_README_URL = "https://raw.githubusercontent.com/markets/awesome-ruby/master/README.md"

  def fetch_readme
    uri = URI(REPO_README_URL)
    response = Net::HTTP.get(uri)
  end

  def parse_category(line)
    name = line.delete_prefix("## ")
    @category = Category.find_or_create_by(name: name)
  end

  def parse_library(line)
    name = line.split("](").first.delete_prefix("* [").to_s
    url = line.split("](").second.to_s.split(")").first
    description = line.split(") - ").second.to_s
    category_id = @category.id
    @library = Library.find_or_create_by(name: name,
      url: url,
      description: description,
      category_id: category_id)
  end

  fetch_readme.split("\n").each do |line|
    if line.start_with?('##')
      parse_category(line)
    elsif line.start_with?('*') && (line.include?("http://") || line.include?("https://"))
      parse_library(line)
      FetchLibraryInfoJob.perform_later(@library.id) if @library.url.starts_with?('https://github.com/')
    end
  end
end

