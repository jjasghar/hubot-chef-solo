# Hubot chef-solo bootstrap

This is my chef-solo scripts to build a hubot. I have it pulling from my
[myhubot](https://github.com/jjasghar/myhubot) but you can also pull it 
directly from the "official" [hubot](https://github.com/github/hubot)
repo.

`hubot-solo::personal_git_hubot` - your (mine) personal github repo

`hubot-solo::offical_git_hubot` - a basic install for a hubot :+1:

`hubot::default` - the recipe i'm using for full testing

`hubot::irc` - a hubot recipe to connect/use the adapter for irc

`hubot::campfire` -a  hubot recipe to connect to  campfire

This will install nodejs as the user you specify in the attributes,
and also put foreverjs on the machine.
