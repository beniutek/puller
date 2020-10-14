require 'mime/types'
require 'net/http'
require 'rest-client'

class Puller
  attr_reader :repo, :owne

  def initialize(repo, owner)
    @repo = repo
    @owner = owner
  end

  def create_pull_request(title, head, base, body)
    params = {
      title: title,
      head: head,
      base: base,
      body: body,
      maintainer_can_modify: true,
    }
    headers = {
      "Accept" => "application/vnd.github.v3+json",
    }
    url = "https://api.github.com/repos/#{owner}/#{repo}/pulls"

    RestClient.post(url, params, headers)
  end
end
