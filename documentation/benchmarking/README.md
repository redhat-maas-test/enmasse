# Benchmarking

EnMasse provides a benchmarking suite, ebench, that can run alongside the EnMasse cluster or
on a separate set of machines. The suite is composed of an agent that sends messages to a specific
address and a collector that aggregates metrics from multiple agents. To start an agent and a
collector, invoke the benchmark template:

    oc process -f include/benchmark-template.json | oc create -f -

The agent and collector is parameterized using environment variables defined in the specification
file. 

You can scale the number of agents by adjusting the number of replicas, and the collector will
automatically pick up the changes and display aggregated results for all agents running.
