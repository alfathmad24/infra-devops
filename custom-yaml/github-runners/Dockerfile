FROM ubuntu:20.04

ARG GH_ACTIONS_RUNNER_VERSION=2.304.0
ARG PACKAGES="gnupg2 apt-transport-https ca-certificates software-properties-common pwgen git make curl wget zip libicu-dev build-essential libssl-dev"

# install basic stuff
RUN apt-get update \
    && apt-get install -y -q ${PACKAGES} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# create "runner" user
RUN useradd -d /runner --uid=1000 runner \
    && echo 'runner:runner' | chpasswd \
    && mkdir /runner \
    && chown -R runner:runner /runner

USER runner
WORKDIR /runner



# install github actions runner
RUN curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/v${GH_ACTIONS_RUNNER_VERSION}/actions-runner-linux-x64-${GH_ACTIONS_RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64.tar.gz \
    && rm -f actions-runner-linux-x64.tar.gz

CMD ./run.sh