FROM mcr.microsoft.com/mssql/server:2019-CU14-ubuntu-20.04
COPY . /mssql
USER root
RUN chmod +x /mssql/db-init.sh
RUN /opt/mssql/bin/mssql-conf set sqlagent.enabled true
USER mssql
CMD /bin/bash ./mssql/entrypoint.sh
