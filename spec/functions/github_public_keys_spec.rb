require 'spec_helper'
require 'octokit'

describe 'github_public_keys' do
  api_response = [
    {
      "id" => "keyid1",
      "key" => "some key"
    },
    {
      "id" => "keyid2",
      "key" => "some other key"
    },
  ]

  it "should return contactenated keys with username and key ids" do
    client = mock('Octokit::Client')
    Octokit::Client.any_instance.stubs(:user_keys).returns api_response
    should run.with_params("someuser").and_return <<-EOF
some key someuser(keyid1)
some other key someuser(keyid2)
EOF
  end
end
