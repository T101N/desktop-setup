!/bin/bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo dnf check-update \
      && sudo dnf install code

code  --install-extension PeterJausovec.vscode-docker \
      --install-extension Zim.vsc-docker \
      --install-extension dbaeumer.vscode-eslint \
      --install-extension formulahendry.code-runner \
      --install-extension jchannon.csharpextensions \
      --install-extension k--kato.intellij-idea-keybindings \
      --install-extension ms-vscode.cpptools \
      --install-extension ms-vscode.csharp \
      --install-extension msjsdiag.debugger-for-chrome \
      --install-extension octref.vetur \
      --install-extension vector-of-bool.cmake-tools