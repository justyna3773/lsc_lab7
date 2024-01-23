FROM python:3.10-slim-bullseye as builder
SHELL ["/bin/bash", "-c"]
USER root
RUN apt-get update; apt-get install git -y;\
pip install -t /site-packages git+https://github.com/aws/aws-cli.git

FROM python:3.10-slim-bullseye as lab7
SHELL ["/bin/bash", "-c"]
ENV PYTHONPATH=/site-packages
RUN echo "alias aws='python -m awscli'" >>  /root/.bashrc
COPY --from=builder /site-packages /site-packages
CMD /bin/bash

