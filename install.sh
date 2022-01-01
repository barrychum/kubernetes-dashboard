
kubectl apply -f dashboard-install.yaml
 
kubectl -n kubernetes-dashboard patch service kubernetes-dashboard -p '{"spec":{"type":"NodePort"}}'

kubectl get svc --all-namespaces

kubectl apply -f admin-user.yaml 
kubectl apply -f ClusterRoleBinding.yaml 

kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

