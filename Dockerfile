LABEL Author="Sotirov"
LABEL Email="sotirov.sasho@gmail.com"
FROM summerwind/actions-runner:v2.303.0-ubuntu-20.04-3417c5a
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
RUN sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s \
    https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl