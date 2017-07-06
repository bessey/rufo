require "stackprof"
require "flamegraph"
require_relative "../lib/rufo"

output_file = "benchmarking.html"
Flamegraph.generate("./#{output_file}", fidelity: 0.1) do
  # Benchmark with the biggest file in the repo.
  Rufo::Command.run(["./lib/rufo/formatter.rb"])
end

puts "Finished, results are in #{output_file}"
