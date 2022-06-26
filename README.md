# kubernetes-dashboard
Reference  
https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/ 

`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml`

added token-ttl to the above install yaml


Install dashboard  
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml`
 
patch service to expose  
`kubectl -n kubernetes-dashboard patch service kubernetes-dashboard -p '{"spec":{"type":"NodePort"}}'`  
  or  
`kubectl -n kubernetes-dashboard edit service kubernetes-dashboard`  
  or  
`kubectl proxy --address='0.0.0.0' --accept-hosts='^*$'`

Check exposed NodePort  
`kubectl get svc --all-namespaces`

Create admin user  
`kubectl apply -f admin-user.yaml` 

Create admin role binding  
`kubectl apply -f ClusterRoleBinding.yaml` 

Get the admin-user token to login  (only works before kubernetes v1.24)
`kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"`

From k8s v1.24, you need to create a token manually
`kubectl -n kubernetes-dashboard create token admin-user`

Delete admin user and role binding if needed  
`kubectl -n kubernetes-dashboard delete serviceaccount admin-user`  
`kubectl -n kubernetes-dashboard delete clusterrolebinding admin-user`  
