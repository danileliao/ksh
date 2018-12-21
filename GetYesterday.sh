#!/bin/ksh
########################################################
# Daniel Liao(danileliao@gmail.com) 2008/01/24
# object: to get the any day before the yesterday
# Usage: Getyesterday [N dyas] default: 1(Yesterday)
# Output Form: YYYY/MM/DD
########################################################

#set -x
# Set the current month day and year.
month=`date +%m`
day=`date +%d`
year=`date +%Y`

## Daniel 2008/01/24 process the date format
formatDate()
{
    if [ $month -lt 10 ]; then
        month="0$month"
    fi
    
    if [ $day -lt 10 ]; then
        day="0$day"
    fi
}

CHKDAY()
{
    # If the day is 0 then determine the last
    # day of the previous month.

    if [ $day -gt 0 ]; then
        formatDate
    else
        # Find the preivous month.
        month=`expr $month - 1`

        if [ $month -gt 0 ]; then
            adjustday
        else
            # If the month is 0 then it is Dec 31 of
            # the previous year.
            month=12
            ## get the day
            adjustday
            year=`expr $year - 1`  
            # If the month is not zero we need to find
            # the last day of the month.
        fi

        formatDate
    fi
}

adjustday()
{
    ## keep the first day
    b_day=$day

    case $month in
      1|3|5|7|8|10|12) day=31;;
      4|6|9|11) day=30;;
      2)
        if [ `expr $year % 4` -eq 0 ]; then
          if [ `expr $year % 400` -eq 0 ]; then
            day=29
          elif [ `expr $year % 100` -eq 0 ]; then
            day=28
          else
            day=29
          fi
        else
          day=28
        fi
      ;;
    esac

   ## calc the day 
   day=`expr $day + $b_day`

   ## recheck the day
   CHKDAY
}

## main process
## get input value of N for get before D-N days
if [ $# = 0 ]; then
   dayCnt=1
else
   dayCnt=$1
fi

# Add 0 to month. This is a
# trick to make month an unpadded integer.
month=`expr $month + 0`

# Subtract one from the current day.
day=`expr $day - $dayCnt`

## process the date
CHKDAY

# Print the month day and year.
echo $year/$month/$day
exit 0  

