resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: 'esaci'
  location: resourceGroup().location
  properties: {
    ]
    containers: [
      {
        name: 'esaci'
        properties: {
          image: 'esAcr123.azurecr.io/example-flask-crud:latest'
          ports: [
            {
              port: 80
              protocol: 'TCP'
            }
          ]
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 2
            }
          }
        }
      }
    ]
    osType: 'Linux'
    restartPolicy: 'Always'
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: 80
          protocol: 'TCP'
        }
      ]
    }
  }
}
