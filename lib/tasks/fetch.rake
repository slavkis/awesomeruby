require 'net/http'

task fetch: :environment do
  REPO_README_URL = "https://raw.githubusercontent.com/markets/awesome-ruby/master/README.md"

  def fetch_reame
    uri = URI(REPO_README_URL)
    response = Net::HTTP.get(uri)
  end

  def parse_category(line)
    name = line.delete_prefix("## ")
    @category = Category.create(name: name)
  end

  def parse_library(line)
    name = line.split("](").first.delete_prefix("* [").to_s
    url = line.split("](").second.to_s.split(")").first
    description = line.split(") - ").second.to_s
    category_id = @category.id
    Library.create(name: name,
    url: url,
    description: description,
    category_id: category_id)
  end

  fetch_reame.split("\n").each do |line|
    if line.start_with?('##')
      parse_category(line)
    elsif line.start_with?('*') && (line.include?("http://") || line.include?("https://"))
      parse_library(line)
    end


  end
end
# description = line.split(")").second.to_s.delete_prefix(" - ")
# description = line.split(")").delete_if {|a| a.to_s.starts_with?("*")} #почти описание
# line.split("](").second.to_s.split(")").first #url
# name = line.delete_prefix("* [").split("]").first.to_s 
