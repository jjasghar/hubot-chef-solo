#
# my personal irc recipe
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


package "git-core"

include_recipe "hubot-solo::nodejs"
include_recipe "hubot-solo::foreverjs"
include_recipe "hubot-solo::redis"

hubot_home="#{node[:hubotsolo][:deploy_home]}"

bash "install hubot-irc" do
  user node[:hubotsolo][:deploy_user]
  cwd node[:hubotsolo][:deploy_home]
  creates "/home/vagrant/node_modules/hubot-irc/Makefile"
  code <<-EOH
  STATUS=0
  HOME=/home/vagrant
  export PATH=/home/vagrant/local/bin:$PATH || STATUS=1
  cd $HOME
  npm install hubot-irc || STATUS=1
  exit $STATUS
  EOH
end

directory "#{hubot_home}/repo/" do
  user node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_group]
  recursive true
end

directory "#{hubot_home}/scripts" do
  user node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_group]
  recursive true
end

git "#{hubot_home}/repo/hubot" do
  repo node[:hubotsolo][:personal_hubot_repo]
  user node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_group]
  action :sync
end

template "/home/vagrant/repo/hubot/live_hubot.sh" do
  user node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_group]
  mode "0755"
  source "irc_live_hubot.sh.erb"
end

file "/home/vagrant/repo/hubot/forever.log" do
  user node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_group]
  mode "0644"
  action :delete
end

file "/home/vagrant/repo/hubot/out.log" do
  user node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_group]
  mode "0644"
  action :delete
end

file "/home/vagrant/repo/hubot/err.log" do
  user node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_group]
  mode "0644"
  action :delete
end

file "/home/vagrant/.forever/forever.log" do
  user node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_group]
  mode "0644"
  action :delete
end

bash "run myhubot" do
  user "vagrant"
  cwd "/home/vagrant/repo/hubot"
  creates "maybe"
  code <<-EOH
  STATUS=0
  HOME=/home/vagrant
  export PATH=$HOME/local/bin:$PATH || STATUS=1
  export HUBOT_IRC_SERVER=irc.freenode.net || STATUS=1
  export HUBOT_IRC_ROOMS="#jjtesting-irc" || STATUS=1
  export HUBOT_IRC_NICK="jjhubot" || STATUS=1
  export HUBOT_IRC_UNFLOOD="true" || STATUS=1
  forever start -l forever.log -o out.log -e err.log \
     -c bash live_hubot.sh || STATUS=1
  exit $STATUS
  EOH
end

# stop the forever via
# forever stop bin/hubot

