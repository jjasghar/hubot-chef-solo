#!/usr/bin/env bats

@test "check git is installed" {
  run git --help
  [ "$status" -eq 0 ]
}

@test "git installed at /usr/bin/git" {
  run which git
  [ "$output" = "/usr/bin/git" ]
}


