# Helm

*Initialize Helm on client:* ```helm init --client-only``` (omit ```—client-only``` if you want to initialize it on both client and server)

*List repositories:* ```helm repo list```  

*Add a repository:* ```helm repo add here-helm https://s3.amazonaws.com/here-helm/```  

*Search Repository:* ```helm search```  (supply repository/software name to search specific repository/software)  

*Update information of available charts from repositories:* ```helm repo update```  

*Create chart:* ```helm create <chart-name>```  

*Verify if chart follows best practices:* ```helm lint <chart-name>```  

*Dry run a chart without installation:*  ```helm install --dry-run --debug <chart>```  

*Package chart:* ```helm package <chart-name>```  

*Inspect a helm chart:* ```helm inspect here-helm/webapp```   

*Install a helm chart from repository:* ```helm install <repository_name>/webapp```  

*Install local chart from unpacked chart directory:* ```helm install path/to/foo```  

*Install local chart archive:* ```helm install ./foo-0.1.1.tgz```  

*Install chart from remote URL:* ```helm install https://example.com/charts/foo-1.2.3.tgz```  

*Customize a chart before deployment:*
   - Show values that can be customized: ```helm inspect values <chart>```   
   - You can use: ```--set``` (and its variants ```--set-string``` and ```--set-file```) to override on command line.   
   - Alternatively create a yaml file setting desired values (e.g., config.yaml) then use: ```helm install -f config.yaml <chart>```  

*List deployed releases:* ```helm list```  

*Check status of a release:* ```helm status <release-name>```  

*Delete a release:* ```helm delete <release-name>```  

## Tillerless Helm

1. Install Helm>=2.11 

2. Insall helm-tiller plug-in (Helm 3.0+ already has this plug-in)
	```helm plugin install https://github.com/rimusz/helm-tiller```

3. Set ```KUBECONIG``` and ```TILLER_NAMESPACE```

4. Start tillerless Helm. It will start an interactive bash shell; you can use all functions of Helm as usual (deploy, delete etc.). Once done exit shell and stop tiller ```helm tiller stop```  

	```helm tiller start $TILLER_NAMESPACE```

5. Alternatively you can run ```helm tiller run helm <any-helm-command>``` without launching interactive shell  

## Reference:

- https://docs.helm.sh/
- https://github.com/helm/helm/blob/master/docs/using_helm.md
- https://medium.com/containerum/- how-to-make-and-share-your-own-helm-package-50ae40f6c221
- https://docs.bitnami.com/kubernetes/how-to/create-your-first-helm-chart/
- https://hackernoon.com/- using-a-private-github-repo-as-helm-chart-repo-https-access-95629b2af27c-
- https://docs.helm.sh/chart_best_practices/
- https://rimusz.net/tillerless-helm (Tillerless Helm)
