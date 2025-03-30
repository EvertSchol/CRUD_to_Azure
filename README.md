# CRUD_to_Azure
Assignment 2: Azure Infrastructure-as-Code 

Dit project laat zien hoe je een CRUD-applicatie kunt deployen naar Azure met behulp van Infrastructure as Code (IaC) via Bicep-templates.

Stap1:
git clone https://github.com/EvertSchol/CRUD_to_Azure.git

Stap2:
docker build -t mijn-crud-app:latest .

Stap3:
Pas de acr.bicep template aan met de naam die je wilt.

Stap4:
az deployment group create --resource-group RGnaam --template-file acr.bicep

Stap5:
Push de image naar ACR

az acr login --name acrnaam
docker tag mijncrudapp:latest ACRnaam.azurecr.io/mijncrudapp:latest
docker push ACRnaam.azurecr.io/mijncrudapp:latest

Stap6:
Maak je pull token aan.

az acr scope-map create --name pull-only --registry ACRnaam --repository repoNaam content/read --resource-group NaamRg
az acr token create --name pull-token --registry ACRnaam --scope-map pull-only --resource-group NaamRg
az acr token credential generate --name pull-token --registry ACRnaam --resource-group NaamRg

Stap7:
Pass de aci.bicep file aan met jouw TokenNaam,TokenPassword,recource group en container naam.



Stap8:
deploy aci.bicep

az deployment group create --resource-group RGnaam --template-file aci.bicep
az bicep build --file aci.bicep


Stap9:
Ga in portal.azure naar je container en zoek je publiek ip op, nu kan je hierna surfen.  
