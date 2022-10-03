FROM lscr.io/linuxserver/code-server:4.7.1

LABEL maintainer="Jonathan Boeckel <jonnyb@jonnyb.name>"

RUN sudo apt-get update && \
	apt-get install -y --no-install-recommends \
        shellcheck \
        software-properties-common \
        yadm \
        zsh && \
# SDKMan
    apt-get install -y zip unzip && \
    curl -s "https://get.sdkman.io" | bash && \
    bash -c "source /config/.bashrc; sdk install java 18.0.1-amzn; sdk install maven 3.8.5" && \
# Dotnet 
	curl https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -o packages-microsoft-prod.deb && \
	dpkg -i packages-microsoft-prod.deb && \
	rm packages-microsoft-prod.deb && \
	sudo apt-get update; \
    apt-get install -y --no-install-recommends dotnet-sdk-6.0 && \
# Ansible
    add-apt-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y --no-install-recommends ansible && \
# Cleanup
	rm -rf /var/lib/apt/lists/*
