local mqtt = import "mqtt.jsonnet";
local common = import "common.jsonnet";
{
  deployment(instance, image_repo, mqtt_secret)::
    {
      "apiVersion": "extensions/v1beta1",
      "kind": "Deployment",
      "metadata": {
        "labels": {
          "name": "mqtt-gateway",
          "app": "enmasse"
        },
        "annotations": {
          "instance": instance
        },
        "name": "mqtt-gateway"
      },
      "spec": {
        "replicas": 1,
        "template": {
          "metadata": {
            "labels": {
              "name": "mqtt-gateway",
              "app": "enmasse"
            },
            "annotations": {
              "instance": instance
            }
          },
          "spec": {
            "containers": [
              mqtt.container(true, image_repo),
              mqtt.container(false, image_repo)
            ],
            "volumes": [
              mqtt.secret_volume(mqtt_secret)
            ]
          }
        }
      }
    }
}
