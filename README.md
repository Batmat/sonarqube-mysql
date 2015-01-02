SonarQube + MySQL Docker image
==============================

Goal: have a simple way to run SonarQube. MySQL server is also in the image
to ease the use.

Planned improvements :
* make processes run as non-root as much as possible (see 
  https://groups.google.com/forum/#!topic/docker-user/sN13yP2s5S8 as to why)
* document and clarify the parameters to use to be able to persist the data
  externally (or study data containers for that purpose)
