{
  route(instance, hostname)::
  {
    "kind": "Route",
    "apiVersion": "v1",
    "metadata": {
        "labels": {
          "app": "enmasse"
        },
        "annotations": {
          "instance": instance
        },
        "name": "messaging"
    },
    "spec": {
        "host": hostname,
        "to": {
            "kind": "Service",
            "name": "messaging",
            "weight": 100
        },
        "port": {
            "targetPort": "amqps"
        },
        "tls": {
            "termination": "passthrough"
        }
    }
  },

  ingress(instance, hostname)::
    {
      "kind": "Ingress",
      "apiVersion": "extensions/v1beta1",
      "metadata": {
          "labels": {
            "app": "enmasse",
          },
          "annotations": {
            "instance": instance
          },
          "name": "messaging"
      },
      "spec": {
        "tls": {
          "host": hostname,
          "secretName": ""
        },
        "backend": {
          "serviceName": "messaging",
          "servicePort": 5671
        }
      }
    }
}
