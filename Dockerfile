FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    FASTEMBED_CACHE_PATH=/workspaces/.cache/fastembed

COPY exercises/embedding_lab/requirements.txt /tmp/embedding-lab-requirements.txt
RUN pip install --no-cache-dir -r /tmp/embedding-lab-requirements.txt

WORKDIR /workspaces/CAS-HAIC-Slides
