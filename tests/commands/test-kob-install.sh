#!/bin/bash

function kob_init {

  #TODO:- Initialization of KOBman environment variables.(e.g- KOB_DIR ).
  #TODO:- Set path_to_kob_env_tests(e.g - src/tests/envs), kob_environment_under_test, kob_test_namespace.
  PATH_TO_KOB_ENV="${KOBMAN_DIR}/env"
  KOBMAN_ENV_NAME=${KOBMAN_ENV_NAME:-tobvon}
  KOBMAN_NAMESPACE=${KOBMAN_NAMESPACE:-hyperledgerkochi}
  # echo $KOBMAN_ENV_NAME
  # echo $KOBMAN_NAMESPACE
  #TODO:- Check $kob command (e.g - $kob --version or $kob).
  curl -L https://raw.githubusercontent.com/hyperledgerkochi/KOBman/master/get.kobman.io | bash > /dev/null 2>&1
  source "/home/user/.kobman/bin/kobman-init.sh"
  kob | grep -i "KOBman" >/dev/null
  if [ $? -eq 0 ];
        then echo "kob found"
  else
        echo "kob not found"
  fi

  #TODO:- Load function to test kob_environment_under_test(i.e source $path_to_kob_env_tests/test-$(kob_environment_under_test).sh).
  function _test_kob_env {
    source "$path_to_kob_env_tests/test-${KOBMAN_ENV_NAME}.sh"
  }

}

function kob_execute {

  #TODO:- kob install --environment ${ kob_environment_under_test } --namespace ${ kob_test_namespace }. ---> output file.
  kob install --environment ${KOBMAN_ENV_NAME} --namespace ${KOBMAN_NAMESPACE} &> output.txt
  #TODO:- Check output log file.
  tail -1 output.txt

}

#function kob_verify {

   #TODO:- Call function __test_kobman_$(environment_under_name)_ validate_install( optional arguments) --> output file.
 #  __test_kobman_$(environment_under_name)_ validate_install( optional arguments) --> output file
   #TODO:- Check Output log file.

#}

function kob_cleanup {

    #TODO:- Unset environment variables , delete any temp file written by the test.
    rm output.txt
    #TODO:- Remove function __test_kobman_$(environment_under_name)_ validate_install().

}

kob_init "$1" "$2"
kob_execute
kob_cleanup
