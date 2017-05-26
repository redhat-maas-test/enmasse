local version = std.extVar("VERSION");
local k = import "../ksonnet-lib/ksonnet.beta.1/k.libsonnet";
local common = import "common.jsonnet";
{
  container(image_repo, addressEnv)::
    {
      "name": "forwarder",
      "env": [ addressEnv, {"name": "GROUP_ID", "value": "${NAME}"} ],
      "image": image_repo + ":" + version,
      "resources": {
          "requests": {
              "memory": "128Mi"
          },
          "limits": {
              "memory": "128Mi"
          }
      },
      "ports": [
        {
          "name": "health",
          "containerPort": 8080
        }
      ],
      "livenessProbe": {
        "httpGet": {
          "path": "/health",
          "port": "health"
        }
      }
    }
}
