# Eidolon Web Researcher Recipe

This project shows an example of a multi-llm multimedia enabled chatbot that can do web research. This example supports accessing
the researcher agent either directly, using REST, or through a chatbot interface

## Agents
### research_agent
The `research_agent` is the top level agent that coordinates web research using the search_agent and scraping_agent.

### search_agent
Can perform free form research on the web using a Google Custom Search Engine.

### scraping_agent
Can navigate web pages (including javascript loaded content) to perform in-depth research.

## Prerequisites
### OpenAI API Key
This example is currently configured to use an OpenAI LLM. See our [authenticating guide](https://www.eidolonai.com/docs/howto/authenticate_llm)
for help finding your API key. To swap out the LLM for a different provider (or host your own) see Eidolon's documentation 
on [swapping LLMs](https://www.eidolonai.com/docs/howto/swap_llm).

### Google Programmable Search Engine ID / Token
You will need to create a [Google Programmable Search Engine](https://programmablesearchengine.google.com).

After creating this resource, you will be prompted for the search engine ID (`CSE_ID`) and token (`CSE_TOKEN`) when you run the server. 

## Running the Server in Docker

To the server using docker, use the following command:

```bash
make docker-serve
```

The first time you run this command, you may be prompted to enter credentials that the machine needs 
to run (ie, OpenAI API Key, CSE_ID / CSE_TOKEN from Prerequisites).

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
