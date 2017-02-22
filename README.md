# mrtg
Dockerized MRTG build for Raspberry Pi

# RUN
docker run -tdP -v /volume/to/mrtg:/var/www/mrtg azcoigreach/mrtg

# Notes
This build is designed to evaluate a router at public@192.168.1.1, store that data in /var/www/mrtg and output the MRTG data to a shared volume. 

MRTG configuration file is located at /mrtgcfg/mrtg.cfg

The supervisord plugin is also included.  And is managing the SSH connection as well as deamonizing the MRTG program.

Use 'docker ps' ps to identify which port instance the container is connected too.  'ssh root@localhost -p [container-port]'

Root password for the container is set in the Dockerfile.  Replace screencast with your password and build.

# indexmaker
Commands can also be sent to the container after is is running without SSH. Using the 'docker exec' command.

Get container ID's : docker ps -a
Rename the mrtg container: docker rename [container id] mrtg

*It may take up to 5 minutes after mrtg runs for data to accumlate for the indemaker to function properly.
Run mrtg indexmaker : docker exec mrtg indexmaker /mrtgcfg/mrtg.cfg
