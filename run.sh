#/bin/sh

cd /runner

if [ -f input ]; then
	echo "ALREADY CONFIGURED"
else
	echo "RUNNER COPY"
	cp /actions-runner/actions-runner-linux-x64-2.304.0.tar.gz /runner/actions-runner.tar.gz
	tar xzf ./actions-runner.tar.gz
	echo "RUNNER CONFIGURE"
	cp /actions-runner/input /runner/input
	RUNNER_ALLOW_RUNASROOT=1 ./config.sh remove --token $TOKEN
	RUNNER_ALLOW_RUNASROOT=1 ./config.sh --url $URL --token $TOKEN < input
fi

echo "RUNNER RUNNING"
RUNNER_ALLOW_RUNASROOT=1 ./run.sh
