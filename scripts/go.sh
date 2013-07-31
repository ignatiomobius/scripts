function go (){
  if [ $# == "0" ] || [ $1 == "-h" ]
  then
    echo "Usage: go [(number)] [-l] [-a (path)] [-r (number)] [-h]"
    echo "    (number): cd to stored path with number"
    echo "    -l: list stored paths"
    echo "    -a: store new path to navigate"
    echo "    -r: remove entry stored at given number"
    echo "    -h: show this help"
  elif [ $1 == "-a" ]
  then
    echo $2 >> /home/moebius/.go_history
  elif [ $1 == "-l" ]
  then
    file="/home/moebius/.go_history"
    while read line
    do
      echo $line
    done <"$file"
  elif [ $1 == "-r" ]
  then
    sed -i $2'd' /home/moebius/.go_history
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
