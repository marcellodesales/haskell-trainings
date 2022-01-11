# Haskell 101 Codelab

## Setup

To setup your machine please consult [the official haskell website](https://www.haskell.org/platform/). We have also provided a docker container that can be used to run the test suite. This method for running the tests requires [Docker](https://www.docker.com/get-started) and [Docker compose](https://docs.docker.com/compose/install/) but avoids the need to set up haskell on your machine.

## Running tests

To run the tests just run `make` in each of the directories. The special `00_setup` directory is only used for testing the environment, but all others contain exercises to resolve.

For each of the exercises, replace `codelab` with your implementation. When complete, running `make` would result in an output similar to below:
```
add       1 2                             OK got: 3
subtract  7 2                             OK got: 5
double    3                               OK got: 6
multiply  3 11                            OK got: 33
divide    9 2                             OK got: 4.5
divide    8 4                             OK got: 2.0
factorial 30                              OK got: 265252859812191058636308480000000
gcd       12 4                            OK got: 4
gcd       17 7                            OK got: 1
```

If you are using the docker container, build and run the tests run with `docker-compose run <directory>` (without the trailing slash). For example, for `docker-compose run 01-functions`, you should see output similar to below:
```
Creating network "codelab_default" with the default driver
Building 01_functions
Step 1/3 : FROM haskell:8
8: Pulling from library/haskell
9b99af5931b3: Pull complete
580a548160a1: Pull complete
5d8e6deeb485: Pull complete
70b0645032d3: Pull complete
03b69c8eaa80: Pull complete
Digest: sha256:d26c7a6853190096137361cfe65f5b7fc6e69ec4660ffb9583ec323e85b524e6
Status: Downloaded newer image for haskell:8
 ---> 3baac1927856
Step 2/3 : WORKDIR .
 ---> Running in 7b9c08684455
Removing intermediate container 7b9c08684455
 ---> bd1bd24a236d
Step 3/3 : COPY . .
 ---> 5012253dbb4f

Successfully built 5012253dbb4f
Successfully tagged haskell101:latest
Creating codelab_01_functions_run ... done
make: Entering directory '/01_functions'
...
Completed 3 action(s).
add       1 2                             OK got: 3
subtract  7 2                             OK got: 5
double    3                               OK got: 6
multiply  3 11                            OK got: 33
divide    9 2                             OK got: 4.5
divide    8 4                             OK got: 2.0
factorial 30                              OK got: 265252859812191058636308480000000
gcd       12 4                            OK got: 4
gcd       17 7                            OK got: 1
make: Leaving directory '/01_functions'
```

Running the first time would result in downloading and compiling needed dependencies (omitted from the above screen output).

When done, you can cleanup Docker services with `docker-compose down`.

# Resolving with docker-compose

```console
$ docker-compose up --build 02_datatypes
Building 02_datatypes
[+] Building 0.2s (10/10) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                      0
 => => transferring dockerfile: 37B                                                                                                                                       0
 => [internal] load .dockerignore                                                                                                                                         0
 => => transferring context: 2B                                                                                                                                           0
 => [internal] load metadata for registry.gitlab.com/supercash/core/haskell-stack-base:stack-2.7.3_haskell-8.10.7_13057207-master                                         0
 => [1/5] FROM registry.gitlab.com/supercash/core/haskell-stack-base:stack-2.7.3_haskell-8.10.7_13057207-master                                                           0
 => [internal] load build context                                                                                                                                         0
 => => transferring context: 19.90kB                                                                                                                                      0
 => CACHED [2/5] WORKDIR /google/trainings/haskell                                                                                                                        0
 => CACHED [3/5] COPY . .                                                                                                                                                 0
 => CACHED [4/5] RUN ls -d */ | awk '{ print $1 }' | xargs -I {} cp $(pwd)/Makefile $(pwd)/{}                                                                             0
 => CACHED [5/5] RUN ls -d */ | awk '{ print $1 }' | xargs -I {} make -C {} deps                                                                                          0
 => exporting to image                                                                                                                                                    0
 => => exporting layers                                                                                                                                                   0
 => => writing image sha256:6d799087e01a19d121c45ecc60a0ebdcfe1e0d6155369d01efe135cb4d8544cc                                                                              0
 => => naming to docker.io/google/haskell-trainings                                                                                                                       0
Starting codelab_02_datatypes_1 ... done
Attaching to codelab_02_datatypes_1
02_datatypes_1     | make: Entering directory '/google/trainings/haskell/02_datatypes'
02_datatypes_1     | hours (Minutes 271)                       OK got: 4
02_datatypes_1     | hours (Minutes 15)                        OK got: 0
02_datatypes_1     | timeDistance (Minutes 15) (Minutes 25)    !! error: SOMETHING IS NOT IMPLEMENTED!
02_datatypes_1     | timeDistance (Minutes 99) (Minutes 47)    !! error: SOMETHING IS NOT IMPLEMENTED!
02_datatypes_1     | pointDistance (1, 1) (1, 3)               !! error: SOMETHING IS NOT IMPLEMENTED!
02_datatypes_1     | pointDistance (3, 4) (0, 0)               !! error: SOMETHING IS NOT IMPLEMENTED!
02_datatypes_1     | make: *** [Makefile:34: run] Error 1
02_datatypes_1     | make: Leaving directory '/google/trainings/haskell/02_datatypes'
codelab_02_datatypes_1 exited with code 2
```
