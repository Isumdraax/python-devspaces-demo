FROM registry.access.redhat.com/ubi9/ubi-init:9.2

LABEL io.k8s.description="Python DevSpaces demo." \
      io.k8s.display-name="APython DevSpaces demo." \
      io.openshift.tags="python" \
      name="python-devspaces-demo"

RUN dnf -y update \
    && dnf install python3 python3-pip -y \
    && dnf clean all \
    && rm -rf /var/lib/yum/* 

WORKDIR /code

COPY requirements.txt /code/requirements.txt

RUN python3 -m pip install -r /code/requirements.txt

COPY ./app /code/app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080", "--proxy-headers"]
