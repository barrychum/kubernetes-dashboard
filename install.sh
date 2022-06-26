
kubectl apply -f dashboard-install.yaml

# Choose your type of service to expose dashboard
# If you don't have metalLB, you can use NodePort
# kubectl --namespace kubernetes-dashboard patch svc kubernetes-dashboard -p '{"spec": {"type": "NodePort"}}'
kubectl --namespace kubernetes-dashboard patch svc kubernetes-dashboard -p '{"spec": {"type": "LoadBalancer"}}'

kubectl get svc --all-namespaces

kubectl apply -f admin-user.yaml 
kubectl apply -f ClusterRoleBinding.yaml 

# Starting from kubernetes v1.24, LegacyServiceAccountTokenNoAutoGeneration applies.
# The following command will not get a token.
# instead, you can use kubectl create token to create API token
# https://github.com/kubernetes/kubernetes/issues/110113
# kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
kubectl -n kubernetes-dashboard create token admin-user
