echo  "#PBS -l walltime="$4                                     >> $1.batch
echo  "#PBS -l select="$3":ncpus="$6":mpiprocs="$6":mem="$5"GB" >> $1.batch
echo  "#PBS -N " $1                                             >> $1.batch


echo "module load profile/advanced"                             >> $1.batch
echo "module load gnu"                                          >> $1.batch
echo "module load openmpi/1-10.3--gnu--6.1.0"                   >> $1.batch
echo "module load fftw/3.3.4--openmpi--1-10.3--gnu--6.1.0"      >> $1.batch



echo  cd `pwd`                                                  >> $1.batch


echo "ulimit -s unlimited"                                      >> $1.batch
echo "ulimit -t unlimited"                                      >> $1.batch

echo "#run_applicarion"                                         >> $1.batch
echo "sleep 5"                                                  >> $1.batch


#if file primo is in the directory
#initialize counter RSAVE_STEP
# and delete primo
#else write the step on theend file

echo "if [ -n "primo" ]"                                       >> $1.batch
echo "then"                                                    >> $1.batch
echo " RSAVE_STEP=1"                                           >> $1.batch
echo "rm primo"                                                >> $1.batch
echo "else"                                                    >> $1.batch
echo " RSAVE_STEP=RSAVE_STEP+1"                                >> $1.batch
echo " echo \$RSAVE_STEP >> theend$1.txt" >> $1.batch
echo "fi"                                                      >> $1.batch

# Check if the job is finished and if it is not
# resubmit this file
#
echo "if grep CONTINUE ../restart.txt"                       >> $1.batch
echo "then"                                                  >> $1.batch
echo "  qsub $1.batch"                                       >> $1.batch
echo "elif grep FINISHED ../restart.txt"                            >> $1.batch
echo "then"                                                  >> $1.batch
echo "echo dopo \$RSAVE_STEP iterazioni concluso il lavoro $1 >> theend$1.txt" >> $1.batch
echo "fi" >> $1.batch
echo "exit 0" >> $1.batch
    
qsub $1.batch
sleep 3
qstat -u aremigi0



