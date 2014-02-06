#!/usr/bin/env bats

@test "confirm that redis untared and directory is there" {
  run ls /tmp/redis-2.8.3
  [ "$status" -eq 0 ]
}

@test "confirm that redis-server is there" {
  run ls /tmp/redis-2.8.3/src/redis-server
  [ "$status" -eq 0 ]
}
