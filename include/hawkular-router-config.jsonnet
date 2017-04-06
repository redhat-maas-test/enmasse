{
  "apiVersion": "v1",
  "kind": "ConfigMap",
  "metadata": {
    "name": "hawkular-router-config"
  },
  "data": {
    "hawkular-openshift-agent": std.toString({
      "endpoints": [
        {
          "type": "prometheus",
          "protocol": "http",
          "port": 8080,
          "path": "/metrics/",
          "collection_interval": "60s",
          "metrics": [
            {
              "name": "num_connections",
              "id": "numConnections",
              "description": "Current number of connections",
              "type": "gauge",
              "tags": {
                "messagingComponent": "router",
                "messagingMetricType": "numConnections"
              }
            }
          ]
        }
      ]
    })
  }
}
