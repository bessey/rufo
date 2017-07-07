require "stackprof"
require "flamegraph"
require "benchmark/ips"
require_relative "../lib/rufo"

def test_harness
  # Benchmark with the biggest file in the repo.
  Rufo::Command.run(["./lib/rufo/formatter.rb"])
end

Benchmark.ips do |x|
  x.config(time: 60, warmup: 5)

  x.report("debug on ") do
    $DEBUG = true
    test_harness
  end

  x.report("debug off") do
    $DEBUG = false
    test_harness
  end

  x.compare!
end


output_file = "benchmarking.html"
Flamegraph.generate("./#{output_file}", fidelity: 0.1) do
  test_harness
end
puts "Finished, results are in #{output_file}"


# NOTES

# Warming up --------------------------------------
#         debug on      1.000  i/100ms
#         debug off     1.000  i/100ms
# Calculating -------------------------------------
#         debug on       8.467  (±11.8%) i/s -    502.000  in  60.105954s
#         debug off      8.637  (±11.6%) i/s -    511.000  in  60.096254s
