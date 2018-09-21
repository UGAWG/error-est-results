#!/usr/bin/env ruby

t=90
root='Flow/sinatan'
norm=2

(1..t).each do |i|
  truth=sprintf("%s%02d",root,t)
  candidate=sprintf("%s%02d",root,i)
  comm = "mpiexec -np 28 ~/refine/zoltan/src/ref_interp_test --error #{truth}.meshb #{truth}-scalar.solb #{candidate}.meshb #{candidate}-scalar.solb #{norm}"
  system comm
end
