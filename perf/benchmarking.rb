require "stackprof"
require "flamegraph"
require "benchmark/ips"
require_relative "../lib/rufo"

def test_harness
  # Benchmark with the biggest file in the repo.
  Rufo::Command.run(["./lib/rufo/formatter.rb"])
end

Benchmark.ips do |x|
  x.config(time: 15, warmup: 1)

  x.report("formatter.rb") { test_harness }
  # TODO faster version ;)
  # x.report("formatter.rb") { test_harness }

  x.compare!
end


output_file = "benchmarking.html"
Flamegraph.generate("./#{output_file}", fidelity: 0.1) do
  test_harness
end
puts "Finished, results are in #{output_file}"


# NOTES

# Warming up --------------------------------------
#         formatter.rb     1.000  i/100ms
# Calculating -------------------------------------
#         formatter.rb      8.331  (±12.0%) i/s -    124.000  in  15.087705s
