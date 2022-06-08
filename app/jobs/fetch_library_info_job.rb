require 'net/http'
require 'JSON'

class FetchLibraryInfoJob < ApplicationJob
  queue_as :default

  def perform(libarary_id)
    @library = Library.find(libarary_id)

    uri = URI(@library.url.gsub("https://github.com/", "https://api.github.com/repos/"))
    req = Net::HTTP::Get.new(uri)
    req['Accept'] = "application/vnd.github.v3+json"
    req['Authorization'] = "token #{ENV['TOKEN']}"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }

    json = JSON.parse(res.body)
    return if json['id'] == nil
    last_commit = (DateTime.now - DateTime.parse(json['pushed_at'])).round.to_i
    @library.update(stars: json['watchers'], last_commit: last_commit)
  end
end
