#!/bin/bash --login

###
# job name
#SBATCH --job-name=pbrt-test
# job stdout file
#SBATCH --output=pbrt.%J.out
# job stderr file
#SBATCH --error=pbrt.%J.err
# On failure, requeue for another try
#SBATCH --requeue
# maximum job time in HH:MM:SS
#SBATCH --time=10:00:00
# maximum memory
#SBATCH --mem-per-cpu=8192
# run a single task
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
###


XDG_RUNTIME_DIR=""
cluster=casablanca-mgmt1
port=6274
node=$(hostname -s)
user=$(whoami)

# print tunneling instructions
echo -e "

MacOS or linux terminal command to create your ssh tunnel
ssh -N -L ${port}:${node}:${port} ${user}@${cluster}.us.cray.com

If connecting from another job within the cluster, use
${node}:${port}

"

module load pbrt/3.0

SCENE_DIR=/home/users/msrinivasa/develop/pbrt-scenes/bedroom
SCENE_FILE=scene.pbrt
srun pbrt $SCENE_DIR/$SCENE_FILE --nthreads=32
