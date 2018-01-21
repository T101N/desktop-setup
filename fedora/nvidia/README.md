# Install and Setup of nvidia drivers

### Install
`sudo ./install.sh`

### Monitor and Fancontrol
In cli-tools, `gpu-fancontrol.sh` and `gpu-monitor.sh` can be run with watch commands. Do note that execution will terminate upon exiting the session. Maybe making a systemd service would be a better approach for handling fan speeds.

e.g.
`watch --color -n 3 ./cli-tools/gpu-monitor.sh`
