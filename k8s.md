# Kubernetes

- [Concepts](#concepts)
- [Tools](#tools)
- [Playing with Local Kubernetes Cluster](#playing-with-local-kubernetes-cluster)
- [Resources](#resources)

## Concepts

Kubernetes coordinates a highly available cluster of computers that are connected to work as a single unit.

### Master
The ***master*** is responsible for managing the cluster. 

### Node
A ***node*** is a VM or a physical computer that serves as a worker machine in a Kubernetes cluster. Each node runs a local agent called ***kubelet*** that communicate with master using Kubernetes API. Node also runs a containerization software like Docker or rkt. kubelet and container software are collectively called *node processes*.

### Pod
A ***Pod*** is a Kubernetes abstraction that represents a group of one or more application containers (such as Docker or rkt) tied together for the purposes of administration and networking, and some shared resources for those containers. Those resources include shared storage (as volumes), networking (a unique cluster of IP address), and information about how to run each container such as the container image version or specific ports to use. A Pod models an application-specific "logical host" and can contain different application containers which are relatively tightly coupled. The containers in a Pod share an IP Address and port space, are always co-located and co-scheduled, and run in a shared context on the same Node. A Pod always runs on a Node, and a node can run multiple pods. Each Pod in a Kubernetes cluster has a unique IP address, even Pods on the same Node. Pods are mortal, when a worker node dies pods running on the node are also lost, a replication controller then dynamically drive the cluster back to desired state via creation of new pods to keep application running. Replicas are fungible; the front-end system should not care about backend replicas or even if a Pod is lost and recreated.

### Deployment

In order to deploy your containerized application to a cluster you need to create a ***deployment***. The deployment instructs Kubernetes how to create and update instances of your application. Deployments are a way to manage the creation and scaling of pods. A Kubernetes Deployment Controller continuously monitor application instances. If the Node hosting an instance goes down or is deleted, the Deployment controller replaces it. This provides a self-healing mechanism to address machine failure or maintenance. In pre-orchestration world installation scripts would often be used to start applications but they didn’t allow recovery from machine failure. Kubernetes Deployments provide a fundamentally different approach, they both create application instances and keep them running across Nodes. When you create a Deployment, you'll need to specify the container image for your application and the number of replicas that you want to run.

*Scaling* is accomplished by changing the number of replicas in a Deployment. When traffic increases, we will need to scale the application to keep up with user demand. Scaling out a Deployment will ensure new Pods are created and scheduled to Nodes with available resources. Kubernetes also supports autoscaling of Pods. Running multiple instances of an application will require a way to distribute the traffic to all of them. Services have an integrated load-balancer that will distribute network traffic to all Pods of an exposed Deployment. Services will monitor continuously the running Pods using endpoints, to ensure the traffic is sent only to available Pods. Once you have multiple instances of an Application running, you would be able to do Rolling updates without downtime.

Rolling updates allow Deployments update to take place with zero downtime by incrementally updating Pods instances with new ones. The new Pods will be scheduled on Nodes with available resources. Similar to application Scaling, if a Deployment is exposed publicly, the Service will load-balance the traffic only to available Pods during the update. Rolling updates also allow you to rollback to previous versions of application..

### Service
Pods that are running inside Kubernetes are running on a private, isolated network. By default they are visible from other pods and services within the same kubernetes cluster, but not outside that network. A Kubernetes ***service*** is an abstraction layer which defines a logical set of Pods and enables external traffic exposure, load balancing and service discovery for those Pods. A Service routes traffic across a set of Pods. Services allow pods to die and replicate in Kubernetes without impacting your application. To make it accessible from outside the Kubernetes virtual network, you have to expose the Pod using ```kubectl expose``` command (you can also create a Service at the same time you create a Deployment by using ```--expose``` flag in kubectl.). Services can be exposed in different ways by specifying a type in the Service Specs. where type can be:
  - *ClusterIP (default):* Exposes the Service on an internal IP in the cluster. This type makes the Service only reachable from within the cluster.
  - *NodePort:*  Exposes the Service on the same port of each selected Node in the cluster using NAT. Makes a Service accessible from outside the cluster using <NodeIP>:<NodePort>. Superset of ClusterIP.
  - *LoadBalancer:* Creates an external load balancer in the current cloud (if supported) and assigns a fixed, external IP to the Service. Superset of NodePort.
  - *ExternalName:* Exposes the Service using an arbitrary name (specified by externalName in the spec) by returning a CNAME record with the name. 

(Another way to temporarily expose pod to outside world is to create a proxy using ```kubectl proxy``` command, that will forward communication into cluster. Service is the standard and preferred way.)

Services match a set of Pods using *labels and selectors*, a grouping primitive that allows logical operation on objects in Kubernetes. Labels are key/value pairs attached to objects and can be used in any number of ways (Use ```kubectl label <resource type> <resource-name> <label>=<value>``` to attach labels with a resource (e.g., ```kubectl label pod hello-node-asdfa44qw app=v1```; then query pods by this label: ```kubectl get pods -l app=v1```).

## Tools

### minikube
```minikube``` is a lightweight Kubernetes implementation that creates a VM on your local machine and deploys a simple cluster containing only one node. A real-world cluster can be deployed on several physical or virtual machines.

### kubectl
```kubectl``` is a CLI tool to interact with a running Kubernetes cluster. Some useful kubectl command include  
   - ```get```  - list resources  
   - ```describe``` - show detailed information about a resource  
   - ```logs``` - pint logs from a container in a pod  
   - ```exec``` - execute a command on a container in a pod

## Playing with Local Kubernetes Cluster

#### Manage local cluster

*Get Minikube Version:* ```minikube version```  

*Start Local Cluster:* ```minikube start --vm-driver=hyperkit```  

*Open Kubernetes Dashboard in browser:* ```minikube dashboard```  

*Get minikube ip:* ```minikube ip```  

*List addons:* ```minikube addons list```  

*Enable addons:* ```minikube addons enable heapster```  

*Open endpoint to interact with heapster:* ```minikube addons open heapster```  

*SSH into minikube cluster:* ```minikube ssh```  

*Run any commands in Kubernetes without logging in to cluster:* ```minikube ssh <command>``` e.g., ```minikube ssh docker images```  

*Point kubectl to local minikube cluster:* ```kubectl config use-context minikube```  

*Get Cluster Details:* ```kubectl cluster-info```, ```kubectl get namespaces```, ```kubectl get nodes```  

*Point ‘docker’ command to Minikube’s Docker daemon:* ```eval $(minikube docker-env)``` (from now on all ```docker``` commands will run against minikube instead of your local Docker daemon)  

*Build Docker image for your app:* ```docker build -t <image-name>:<version> .```  

*Point Docker back to local Docker dadmon:* ```eval $(minikube docker-env -u)```  

*Stop minikube:* ```minikube stop```  

*Delete minikube VM:* ```minikube delete```  


#### Create deployment for your application

*Create deployment for your Dockerized app:*``` kubectl run <deployment-name> --image=<image path and name>:<image version> --port=<port number>```  
e.g., ```kubectl run hello-node --image=hello-node:v1 --port=8080```  

*List deployment:* ```kubectl get deployments```  

*List Pods:* ```kubectl get pods```  

*View pod logs:* ```kubectl logs <pod-name>```  

*Run commands in a pod:* ```kubectl exec <pod name> <command>``` (in multi-container pod this will run command in first container as listed in deployment, add ```-c <container*id>``` to run it in different container)  

*Start an interactive shell in a pod:* ```kubectl exec -it <pod-name> bash```  

*Delete deployment:* ```kubectl delete deployment hello-node```  


#### Expose your application
*Expose your app as service to access it from outside:* ```kubectl expose deployment <deployment name> --type=LoadBalancer```  

*Verify service is created:* ```kubectl get services -o wide```  

*Test your service (this opens a browser window pointing to service URL, can also use ```curl $(minkube ip):<port>```):* ```minikube service <service name> ```   

*Delete a service:* ```kubectl delete service <service-name>``` (or service label, e.g., ```-l run=hello-node```)  

*Verify service is no longer there:* ```kubectl get services -Ao wide```  

*Verify pod is still reachable inside cluster:* ```kubectl exec -it $POD*NAME curl localhost:8080```  


#### Scale deployment

*Scaling up a deployment:* ```kubectl scale deployments/<deployment-name> --replicas=<no. of replicas>```  

*Verify desired number of replicas for deployment:* ```kubectl get deployments```  

*Next check if number of pods has changed (should be 4 pods now with different IPs):* ```kubectl get pods -o wide```  

*The change was registered in the Deployment events log:* ```kubectl describe deployments/hello-node```  

*Scaling down a deployment:* same as above, just use lower number of replicas  


#### Update application

*Update Application:* ```kubectl set image deployments/<deployment-name> <new image version>```  

*Verify pods are running latest image:* ```kubectl describe pods```  

*The update can be confirmed also by running a rollout status command:* ```kubectl rollout status deployment/<deployment-name>```  

*Rollback an update:* ```kubectl rollout undo deployments/<deployment-name>```  


#### Other useful command

*Use Port Forwarding to Access Applications in a Cluster:* ```kubectl port-forward <kind>/<id> <port>|<local-port:remote-port>```  
e.g., ```kubectl port-forward pods/myapp-765d459796-258hz 8080```, then ```curl http://localhost:8080/health```

*Directly access Kuberenetes API via 'kubectl' Reverse Proxy:* ```kubectl proxy --port=8080``` then you can explore the API with ```curl```, ```wget```, or a browser
  - Get info: ```curl http://localhost:8080/api/```
  - Get list of pods: ```curl http://localhost:8080/api/v1/namespaces/default/pods```
  - Access a service in browser: ```http://localhost:8080/api/v1/namespaces/<namespace>/services/<service-name>:ui/proxy/#/overview```


## Resources

- https://kubernetes.io/
- https://medium.com/google-cloud/kubernetes-day-one-30a80b5dcb29 (Good read, also includes resources on Cron Jobs, Background Tasks, and Autoscaling etc.)
- https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational
- https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/#define-clusters-users-and-contexts
- https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-context-and-configuration
- https://kubernetes.io/docs/reference/kubectl/cheatsheet/
