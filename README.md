# Korifi Installation

## Pre-requisites and context
- I'm using Civo to host my Kubernetes cluster. The code assumes the civo cli is installed and setup in the machine

- Create Kubernetes Cluster: `make kubernetes``
- Install pre-requisites: `make all``
- Install Korifi:

```
source globals.sh

./korifi.sh
```

- Test Korifi:

```
source globals.sh
cf api https://api.$BASE_DOMAIN --skip-ssl-validation
cf login # choose the entry in the list associated to $ADMIN_USERNAME
cf create-org org1
cf create-space -o org1 space1
cf target -o org1
cd <directory of a test cf app>
cf push test-app
```

## References

- GoDaddy Domain Manager: https://dcc.godaddy.com/domains?showAdvanceListView=true
- How to change nameserver on GoDaddy: https://uk.godaddy.com/help/change-nameservers-for-my-domains-664
