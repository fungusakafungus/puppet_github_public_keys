require 'octokit'

module Puppet::Parser::Functions
  newfunction(:github_public_keys, :type => :rvalue) do |args|
    client = Octokit::Client.new
    users_keys = args.map do |gh_user|
      raise Puppet::ParseError, "github_public_keys argument '#{gh_user}' does not look like username" unless gh_user =~ /[[:alnum:]-]+/
      j = client.user_keys gh_user
      j = j.map{|u| u['key'] + " #{gh_user}(#{u['id']})"}
      j.join "\n"
    end
    users_keys
  end
end
