{
  local port = {
    "name": "amqp",
    "port": 5672,
    "protocol": "TCP",
    "targetPort": 5672
  },
  generate(instance)::
    {
      "apiVersion": "v1",
      "kind": "Service",
      "metadata": {
        "labels": {
          "app": "enmasse",
        },
        "annotations": {
          "instance": instance
        },
        "name": "amqp-kafka-bridge"
      },
      "spec": {
        "ports": [port],
        "selector": {
          "capability": "bridge"
        }
      }
    }
}
