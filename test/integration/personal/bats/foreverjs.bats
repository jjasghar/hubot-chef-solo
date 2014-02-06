#!/usr/bin/env bats

@test "confirm npm is there" {
  run su vagrant -c vagrant npm --help
  [ "$status" -eq 0 ]
}

@test "confirm forever is installed" {
  run su vagrant -c forever --help
  [ "$status" -eq 0 ]
}
