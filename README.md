# Eidolon Web Researcher Recipe

This project shows an example of a multi-llm multimedia enabled chatbot that can do web research. This example supports accessing
the researcher agent either directly, using REST, or through a chatbot interface

## Core Concepts
1. Customizing the AgentProcessingUnit
2. Running the UI

## Directory Structure

- `resources`: This directory contains additional resources for the project. An example agent is provided for reference.
- `components`: This directory is where any custom code should be placed.

## Running the Server

First you need to clone the project and navigate to the project directory:

```bash
git clone https://github.com/eidolon-ai/web-researcher.git
cd web-researcher
```

Then run the server in dev mode, use the following command:

```bash
make serve-dev
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

Next let's run the UI. Open a new terminal and run the following command:

```bash
docker run -e "EIDOLON_SERVER=http://host.docker.internal:8080" -p 3000:3000 eidolonai/webui:latest
```

Now Head over to the chatbot ui in your favorite browser and start chatting with your new agent.
