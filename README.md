# handson-cloud-msa-outer

## 시작하기

참고 : https://github.com/hashicorp/learn-terraform-provision-gke-cluster

### gcloud 설치

Google Cloud CLI를 설치하고 초기화합니다.

``` bash
$ gcloud init
```

gcloud를 초기화한 다음에는 다음과 같이 입력하여 계정을 Application Default Credentials(ADC)에 추가합니다. Terraform은 ADC를 이용하여 gcloud에 리소스를 프로비저닝할 수 있습니다.

### Terraform 설치

다음과 같이 terraform을 다운로드 받아서 설치합니다.

``` bash
$ wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
$ unzip ./terraform_0.13.5_linux_amd64.zip
$ sudo  mv ./terraform /usr/local/bin
```
다음과 같이 입력하여 정상적으로 설치가 되었는지 확인합니다.

``` bash
$ terraform -help
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    env                Workspace management
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a Terraform working directory
    login              Obtain and save credentials for a remote host
    logout             Remove locally-stored credentials for a remote host
    output             Read an output from a state file
    plan               Generate and show an execution plan
    providers          Prints a tree of the providers used in the configuration
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    taint              Manually mark a resource for recreation
    untaint            Manually unmark a resource as tainted
    validate           Validates the Terraform files
    version            Prints the Terraform version
    workspace          Workspace management

All other commands:
    0.12upgrade        Rewrites pre-0.12 module source code for v0.12
    0.13upgrade        Rewrites pre-0.13 module source code for v0.13
    debug              Debug output management (experimental)
    force-unlock       Manually unlock the terraform state
    push               Obsolete command for Terraform Enterprise legacy (v1)
    state              Advanced state management
```

### .tfvars 수정 및 terraform 초기화

terraform 디렉토리로 이동합니다.

``` bash
$ cd ./terraform
```

terraform.tfvars에 있는 project_id, member_id, region을 적당한 값으로 고칩니다.
member_id는 실습생이 여러 명일 때 구분하기 위한 용도로 사용됩니다.

다음과 같이 입력하여 terraform을 초기화합니다.

``` bash
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "google" (hashicorp/google) 3.13.0...
Terraform has been successfully initialized!
```

다음과 같이 입력하여 GKE 클러스터를 생성합니다.

``` bash
$ terraform apply

# Output truncated...

Plan: 4 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

# Output truncated...

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_cluster_name = dos-terraform-edu-gke
region = us-central1
```

### Kubectl 설정하기

다음과 같이 입력하여 kubectl을 설정합니다.

``` bash
$ gcloud container clusters get-credentials <<클러스터 이름>> --region <<생성 리전>>
```

### Kubernetes Dashboard 설치 및 접속

다음과 같이 입력하여 Kubernetes Dashboard를 설치합니다.

``` bash
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
namespace/kubernetes-dashboard created
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
secret/kubernetes-dashboard-key-holder created
configmap/kubernetes-dashboard-settings created
role.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/dashboard-metrics-scraper created
deployment.apps/dashboard-metrics-scraper created
```

Kubernetes Dashboard에 접속하기 위해 프록시를 설정합니다.

``` bash
$ kubectl proxy
Starting to serve on 127.0.0.1:8001
```

다음 경로를 이용하여 Kubernetes Dashboard에 접속할 수 있습니다.

* http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/.

