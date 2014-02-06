#!/usr/bin/env bats

@test "check git is installed" {
  run git --help
  [ "$status" -eq 0 ]
}

@test "git installed at /usr/bin/git" {
  run which git
  [ "$output" = "/usr/bin/git" ]
}

@test "confirm that the hubot install happened" {
  run ls /home/vagrant/repo/hubot
  [ "$status" -eq 0 ]
}

@test "confirm that the git init happened" {
  run ls /home/vagrant/repo/hubot/.git
  [ "$status" -eq 0 ]
}


