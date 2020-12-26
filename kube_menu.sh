#!/bin/bash 

###################################################################
#Script Name	:                                                                                               
#Description	:                                                                                 
#Args         	:                                                                                           
#Author       	: Tharaka Mahabage
#Email         	: tharaka.mahabage.01@gmail.com
###################################################################

# Setting up env
touch $PWD/.ns
source $PWD/.ns

menu_option_one() {
kubectl get svc -A
}

menu_option_two() {
kubectl get po -A
}

menu_option_three() {
kubectl get deploy -A
}

menu_option_four() {
kubectl api-resources -o wide
}

menu_option_five() {
kubectl get events --sort-by=.metadata.creationTimestamp -A
}

menu_option_six() {
kubectl get ep -A
}

menu_option_seven() {
kubectl get nodes
echo ""
kubectl get ns
}




menu_option_eight() {
echo "Set namespace : " ;
read ns ;
echo "ns=$ns" > .ns
echo "Namespace set $ns";

}


menu_option_nine() {
echo "Namespace set $ns";
kubectl get svc -n $ns
}

menu_option_ten() {
echo "Namespace set $ns";
kubectl get po -n $ns

}

menu_option_eleven() {
echo "Namespace set $ns";
kubectl get deploy -n $ns
}

menu_option_twelve() {
echo "Namespace set $ns";
kubectl get pods -A -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' |sort

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
  echo "Kubernetes Management Console V1"
  echo "==================="
  echo ""
  echo " Default Namespace is set to :" $ns
  echo ""
  echo " Kubernetes Operation Console"
  echo ""
  echo " Select the operation ************"
  echo ""
  echo "  1 -  View Services - All Namespaces"
  echo "  2 -  View Pods - All Namespaces"
  echo "  3 -  View Deployments - All Namespaces"
  echo "  4 -  View All resources"
  echo "  5 -  View Events - All Namespaces"
  echo "  6 -  View All Endpoints- All Namespaces"
  echo "  7 -  View Namespaces and Nodes"
  echo "  8 -  Set custom namespace for monitoring"
  echo "  9 -  View Services - selected namespace" 
  echo "  10 - View Pods - selected namespace" 
  echo "  11 - View Deployments - selected namespace"
  echo "  12 - List Container images by Pod"
  echo "  0  - Exit"
  echo -n "  Enter selection: "
  read selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_one ; press_enter ;;
    2 ) clear ; menu_option_two ; press_enter ;;
    3 ) clear ; menu_option_three ; press_enter ;;
    4 ) clear ; menu_option_four ; press_enter ;;
    5 ) clear ; menu_option_five ; press_enter ;;
    6 ) clear ; menu_option_six ; press_enter ;;
    7 ) clear ; menu_option_seven ; press_enter ;;
    8 ) clear ; menu_option_eight ; press_enter ;;
    9 ) clear ; menu_option_nine ; press_enter ;;
    10 ) clear ; menu_option_ten ; press_enter ;;
    11 ) clear ; menu_option_eleven ; press_enter ;;
    12 ) clear ; menu_option_twelve ; press_enter ;;
    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
