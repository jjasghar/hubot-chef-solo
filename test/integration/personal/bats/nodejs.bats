#!/usr/bin/env bats

@test "confirm that local directory is there" {
  run ls /home/vagrant/local
  [ "$status" -eq 0 ]
}

@test "confirm that node-latest-install directory is there" {
  run ls /home/vagrant/node-latest-install
  [ "$status" -eq 0 ]
}
