require 'rest-client'

class Puller
  attr_reader :repo, :owner

  BadParamError = Class.new(StandardError)

  def initialize(owner, repo)
    @repo = repo
    @owner = owner
  end

  def create_pull_request(title, head, base, body = nil)
    raise BadParamError unless title && head && base
    raise BadParamError if [title, head, base].map(&:empty?).any?

    params = {
      title: title,
      head: head,
      base: base,
      body: body,
      maintainer_can_modify: true,
    }

    RestClient.post(url, params, headers)
  end

  private

  def headers
    {
      "Accept" => "application/vnd.github.v3+json",
    }
  end

  def url
    "https://api.github.com/repos/#{owner}/#{repo}/pulls"
  end
end
