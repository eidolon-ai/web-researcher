ARG EIDOLON_VERSION=0.1.184
FROM python:3.11-slim AS builder
RUN pip install poetry==1.8
RUN poetry config virtualenvs.create false --local
COPY pyproject.toml pyproject.toml
RUN poetry remove --lock eidolon-ai-sdk
COPY components/ components/
COPY README.md README.md
RUN mkdir dist
RUN touch dist/requirements.txt
RUN poetry export --without dev --without-hashes --format=requirements.txt > dist/requirements.txt
RUN poetry export --without-hashes --format=requirements.txt > dist/pre_requirements.txt --only preinstall
RUN poetry build

FROM docker.io/eidolonai/sdk_base:$EIDOLON_VERSION AS agent-machine-base

# Install playwright since it should be static
ENV PLAYWRIGHT_BROWSERS_PATH=/opt/playwright
COPY --from=builder dist/pre_requirements.txt /tmp/agent-machine/pre_requirements.txt
RUN pip install -r /tmp/agent-machine/pre_requirements.txt --no-cache --no-deps
RUN playwright install --with-deps chromium

# First copy builder requirements so dependency cache layer is cached
COPY --from=builder dist/requirements.txt /tmp/agent-machine/requirements.txt
RUN pip install -r /tmp/agent-machine/requirements.txt --no-cache --no-deps

# Then install poetry project wheel since it will change more frequently
COPY --from=builder dist/*.whl /tmp/agent-machine/
RUN pip install /tmp/agent-machine/*.whl --no-cache --no-deps


FROM agent-machine-base AS agent-machine
# Finally copy resources over since they will mutate most frequently
COPY metrics.json /app/metrics.json

FROM agent-machine
WORKDIR /app
RUN addgroup --system --gid 1001 eidolon && adduser --system --uid 1001 --ingroup eidolon eidolon
RUN mkdir -p /data/eidolon/files && chown -R eidolon:eidolon /data/eidolon
USER eidolon
EXPOSE 8080
ENV PYTHONUNBUFFERED=1
ENTRYPOINT ["eidolon-server"]
