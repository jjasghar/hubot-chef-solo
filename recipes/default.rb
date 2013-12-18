#
# main default recipe, this is for testing only!
#

apt = execute "apt-get update" do
  action :nothing
end
 
if 'debian' == node['platform_family']
  if !File.exists?('/var/lib/apt/periodic/update-success-stamp')
    apt.run_action(:run)
  elsif File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
    apt.run_action(:run)
  end
end

include_recipe "hubot-solo::nodejs"
include_recipe "hubot-solo::personal_git_hubot"
include_recipe "hubot-solo::official_git_hubot"
include_recipe "hubot-solo::foreverjs"
include_recipe "hubot-solo::redis"

bash "run myhubot" do
  user "vagrant"
  cwd "/home/vagrant/repo/hubot"
  creates "maybe"
  code <<-EOH
  STATUS=0
  su vagrant -c bin/hubot --help || STATUS=1
  exit $STATUS
  EOH
end

