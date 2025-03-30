// Define the Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'esVnet'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
  }
}

// Define the Subnet with delegation for ACI
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: 'esSubnet'
  parent: vnet
  properties: {
    addressPrefix: '10.0.1.0/24'
    delegations: [
      {
        name: 'aciDelegation'
        properties: {
          serviceName: 'Microsoft.ContainerInstance/containerGroups'
        }
      }
    ]
  }
}

// Define the Network Profile
resource networkProfile 'Microsoft.Network/networkProfiles@2021-05-01' = {
  name: 'esNetworkProfile'
  location: resourceGroup().location
  properties: {
    containerNetworkInterfaceConfigurations: [
      {
        name: 'eth0'
        properties: {
          ipConfigurations: [
            {
              name: 'ipconfig1'
              properties: {
                subnet: {
                  id: subnet.id
                }
              }
            }
          ]
        }
      }
    ]
  }
}

// Define the ACI resource
resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: 'esaci'
  location: resourceGroup().location
  properties: {
    imageRegistryCredentials: [
      {
        server: 'yourACR.azurecr.io'
        username: InsertUsernameHere
        password: InsertPasswordHere
      }
    ]
    containers: [
      {
        name: 'YourAci'
        properties: {
          image: 'ContainerRG.azurecr.io/example-flask-crud:latest'
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
