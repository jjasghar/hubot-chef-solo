#
#
# Pull your hubot scripts down from github
#
#

package "git-core"

directory "/home/vagrant/repo/" do
  owner node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_user]
  recursive true
end

directory "/home/vagrant/scripts" do
  owner node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_user]
  recursive true
end

git "/home/vagrant/repo/hubot" do
  repo node[:hubotsolo][:personal_hubot_repo]
  user node[:hubotsolo][:deploy_user]
  group node[:hubotsolo][:deploy_user]
  action :sync
end
