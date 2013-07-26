function go (){
  arg1=$1
  if [ $arg1 == "add" ]
  then
    echo $2 >> ~/.go_history
  elif [ $arg1 == "-l" ]
  then
    file="/home/moebius/.go_history"
    while read line
    do
      echo $line
    done <"$file"
  elif [ $arg1 == "help" ]
  then
    echo "Usage: go [(number)] [-l] [add] (path)"
    echo "    (number): cd to stored path with number"
    echo "    show: list stored paths"
    echo "    add: store new path to navigate"
  else
    i=1
    file="/home/moebius/.go_history"
    while read line
     do
       lines[$i]="$line"
       i=`expr $i + 1`
     done <"$file"
     cd ${lines[$1]}
  fi
}
