{
  route(instance, hostname)::
  {
    "kind": "Route",
    "apiVersion": "v1",
    "metadata": {
        "labels": {
          "app": "enmasse",
        },
        "annotations": {
          "instance": instance
        },
        "name": "mqtt"
    },
    "spec": {
        "host": hostname,
        "to": {
            "kind": "Service",
            "name": "mqtt",
            "weight": 100
        },
        "port": {
            "targetPort": "secure-mqtt"
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
          "name": "mqtt"
      },
      "spec": {
        "tls": {
          "host": hostname,
          "secretName": ""
        },
        "backend": {
          "serviceName": "mqtt",
          "servicePort": 8883
        }
      }
    }
}
