# Eidolon Web Researcher Recipe

This project shows an example of a multi-llm multimedia enabled chatbot that can do web research. This example supports accessing
the researcher agent either directly, using REST, or through a chatbot interface

## Core Concepts
1. Customizing the AgentProcessingUnit
2. Running the UI

## Directory Structure

- `resources`: This directory contains additional resources for the project. An example agent is provided for reference.
- `components`: This directory is where any custom code should be placed.

## Running the Server in Docker

First you need to clone the project and navigate to the project directory:

```bash
git clone https://github.com/eidolon-ai/web-researcher.git
cd web-researcher
```

Then run the server using docker, use the following command:

```bash
make docker-serve
```

**WARNING:** By default the server is running in dev mode which does not persist the machine state between restarts. 
To start the server in non-dev mode, use the following command:

```bash
  make serve
```

This will assume mongodb is running locally on the default port. If you need to connect to a different mongodb instance,
you can set the `MONGO_CONNECTION_STR` and `MONGO_DATABASE_NAME` environment variables to the appropriate connection string.

The first time you run this command, you may be prompted to enter credentials that the machine needs 
to run (ie, OpenAI API Key, Google CSE key, and Google CSE Token).

These resources will be saved in the `.env` file in the project root.

To use other LLM services, you will need to add the appropriate credentials to the `.env` file in the project root. 
(ie, ANTHROPIC_API_KEY, MISTRAL_API_KEY, OLLAMA_URL, etc.)

This command will download the dependencies required to run your agent machine and start the Eidolon http server in 
"dev-mode".

If the server starts successfully, you should see the following output:
```
Starting Server...
INFO:     Started server process [34623]
INFO:     Waiting for application startup.
INFO - Building machine 'local_dev'
...
INFO - Server Started in 1.50s
```

## Running the server in K8s

### Prerequisites

WARNING: This will work for local k8s environments only. See [Readme.md in the k8s directory](./k8s/Readme.md) if you are using this against a cloud based k8s environment.

To use kubernetes for local development, you will need to have the following installed:
* [Docker](https://docs.docker.com/get-docker/)
* [Kubernetes](https://kubernetes.io/docs/tasks/tools/)
* [Helm](https://helm.sh/docs/intro/install/)

Clone the project and navigate to the project directory:

```bash
git clone https://github.com/eidolon-ai/agent-machine.git
cd agent-machine
```

### Installation

Make sure your kubernetes environment is set up properly and install the Eidolon k8s operator.

```bash
make k8s-operator
```

This will install the Eidolon operator in your k8s cluster. **This only needs to be done once.**

Next install the Eidolon resources. This will create an Eidolon machine and an Eidolon agent in your cluster, start them, and tail the logs:

```bash
make k8s-serve
```

If the server starts successfully, you should see the following output:
```
Deployment is ready. Tailing logs from new pods...
INFO:     Started server process [1]
INFO:     Waiting for application startup.
INFO - Building machine 'local-dev'
INFO - Starting agent 'hello-world'
INFO - Server Started in 0.86s
```
