#!/bin/bash 

###################################################################
#Script Name	:                                                                                               
#Description	:                                                                                 
#Args         	:                                                                                           
#Author       	: Tharaka Mahabage
#Email         	: tharaka.mahabage.01@gmail.com
###################################################################

# Setting up env


menu_option_one() {

rm -f $PWD/recommended.yaml*

wget https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

kubectl apply -f $PWD/recommended.yaml
kubectl -n  kubernetes-dashboard get  service kubernetes-dashboard -oyaml >kubernetes-dashboard.yaml
sed -i 's,ClusterIP,NodePort,g' kubernetes-dashboard.yaml
kubectl apply -f kubernetes-dashboard.yaml

kubectl -n kubernetes-dashboard get services
 

}

menu_option_two() {
kubectl -n kube-system get secret -n kube-system -o name | grep namespace
mysecret=`kubectl -n kube-system get secret -n kube-system|grep name |awk {'print $1'} `

kubectl -n kube-system describe secret $mysecret

echo ""
echo "Cluster IP"
kubectl describe nodes |grep Internal 
echo ""
echo "Node port"
kubectl get svc -n kubernetes-dashboard -owide
echo ""
}



press_enter() {
  echo ""
  echo -n "	Press Enter to continue "
  read
  clear
}

incorrect_selection() {
  echo "Incorrect selection! Try again."
}

until [ "$selection" = "0" ]; do
  clear
  echo "Kubernetes Dashboard installer V1"
  echo "==================="
  echo ""
  echo " Select the operation ************"
  echo ""
  echo "  1 -  Install Kubernetes-dashboard Configure Kubernetes-dashboard to run on NodePort"
  echo "  2 -  View token"
  echo "  0  - Exit"
  echo -n "  Enter selection: "
  read selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_one ; press_enter ;;
    2 ) clear ; menu_option_two ; press_enter ;;
    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
