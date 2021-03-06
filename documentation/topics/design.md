This document describes the design for topics in EnMasse.

# Overview

In EnMasse, a multicast address will create an isolated cluster for a topic. Supporting topics in EnMasse is simple with 1 broker. When multiple brokers are needed, some form of sharding needs to be in place.

The current design rely on two components:

   1. A component responsible for tracking durable subscriptions
   2. A component forwarding messages between brokers in a cluster to ensure messages arrive at all subscribers

The clustering feature of artemis was considered as a way to support topics, but it would complicate the broker setup and not handle durable subscriptions in a generic way. A long term design for topics should be independent of the broker implementation.

## Message forwarding

The current approach to forwarding messages is to add a 'topic-forwarder' container in the same pod
as the broker. The forwarder is responsible for forwarding messages from the local broker instances
to all other broker instances. The other broker instances are discovered using the openshift API.
The forwarder uses durable subscriptions and end2end flow control and dispositions to ensure that
messages are stored on the target broker before acknowledging to the local broker.



### Alternatives

An alternative to using core bridges is to either

   1. Modify the qpid dispatch router to support discovery of brokers and become topic aware.
   2. Use a core bridge in artemis to forward messages for a given address to multiple other brokers. To avoid a loopback effect, the bridge is configured with a custom transformer that adds a property to signal that the message was forwarded, and a filter that filters messages that are forwarded. To forward a message to all other brokers, a broker needs to know their hosts. Since there are no static hosts in openshift, the hosts must be discovered using openshift mechanisms. Artemis supports doing discovery of hosts using jgroups. Jgroups in turn support discovering hosts using a plugin called jgroups-kubernetes. By configuring the bridge to discover groups using jgroups and configuring jgroups correctly, brokers can discover other hosts in the cluster that it should forward messages to.

One of these alternatives might be implemented once we need a generic way of supporting topics.

## Subscription management

TODO
