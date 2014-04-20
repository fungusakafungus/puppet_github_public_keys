require 'octokit'

module Puppet::Parser::Functions
  newfunction(:github_public_keys, :type => :rvalue) do |args|
    raise Puppet::ParseError, "github_public_keys expects exaclty one argument" unless args.length == 1
    gh_user = args.first
    raise Puppet::ParseError, "github_public_keys argument '#{gh_user}' does not look like username" unless gh_user =~ /[[:alnum:]-]+/
    client = Octokit::Client.new
    j = client.user_keys gh_user
    j = j.map{|u| u['key'] + " #{gh_user}(#{u['id']})\n"}
    j.join
  end
end
