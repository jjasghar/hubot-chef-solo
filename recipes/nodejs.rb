#
#
# Nodejs install
#
#

%w{curl build-essential wget libyaml-dev zlib1g-dev libreadline-dev
   libssl-dev tk-dev libgdbm-dev}.each do |pkg|
    package pkg do
      action [:install]
    end
end

bash "install nodejs" do
  user "vagrant"
  cwd "/home/vagrant/"
  creates "/home/vagrant/local"
  code <<-EOH
  STATUS=0
  echo 'export PATH=$HOME/local/bin:$PATH' >> ~/.bashrc || STATUS=1
  source ~/.bashrc || STATUS=1
  mkdir ~/local || STATUS=1
  mkdir ~/node-latest-install || STATUS=1
  cd ~/node-latest-install || STATUS=1
  curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1 || STATUS=1
  ./configure --prefix=~/local || STATUS=1
  make install # ok, fine, this step probably takes more than 30 seconds... || STATUS=1
  exit $STATUS
  EOH
end

bash "install npm" do
  user "root"
  cwd "/home/vagrant/"
  creates "/home/vagrant/local/bin/npm"
  code <<-EOH
  STATUS=0
  HOME=/home/vagrant
  export PATH=$HOME/local/bin:$PATH || STATUS=1
  curl -O https://npmjs.org/install.sh || STATUS=1
  sh install.sh || STATUS=1
  exit $STATUS
  EOH
end

