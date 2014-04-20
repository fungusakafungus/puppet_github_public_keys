require 'octokit'

module GithubFunctions
  def get_public_keys gh_user
    raise Puppet::ParseError, "github_public_keys argument '#{gh_user}' does not look like username" unless gh_user =~ /[[:alnum:]-]+/
    client = Octokit::Client.new
    j = client.user_keys gh_user
    j.map {|u| u['key']}
  end
end
module Puppet::Parser::Functions
  newfunction(:github_public_keys, :type => :rvalue) do |args|
    include GithubFunctions
    args.map(get_public_keys).flatten
  end
end
