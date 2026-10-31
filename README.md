# HIM

A privacy-preserving personal agent with a deliberately simple UI and an engineered
harness underneath: query routing, queryable environments instead of prompt stuffing,
a sandboxed Python REPL, an MCP tool bridge, hybrid semantic/lexical memory, and
parallel sub-agents. Nothing leaves the boundary the user chooses.

Status: specified and documented at the architecture level. Implementation is staged
module by module, starting with the router, the environment manager, and the
sandboxed REPL.

## Why it is showable

- Architecture showcase: https://gist.github.com/id-19/39e511ca05a848adcb85c072869a9238
- Module specifications and data flow live one level up in this repository.
- IDEA.md captures the original one-line concept.

## Core ideas

1. Privacy by construction. Model, memory, tools, and history run where the user decides. The REPL has no outbound network except to MCP servers.
2. Context as environment, not prompt. Conversation history, memory, and preferences are injected as queryable objects, keeping the parent model under roughly four thousand tokens even over hundred-turn conversations.
3. Hybrid retrieval. ChromaDB vectors plus SQLite FTS5 fused with reciprocal rank fusion handle both paraphrase and exact identifiers.
4. Parallel scale. llm_batch spawns isolated sub-agents that return summaries, giving roughly twenty-five to one compression on large datasets.
5. Observed cost. Every turn is logged for latency, model, tokens, cost, and success.

## Performance targets

Simple queries under two seconds, complex ones under ten seconds, MCP startup under one second, memory search under one hundred milliseconds, sub-agent spawn under five hundred milliseconds, local model load under five seconds, cost under 0.01 USD per query.

## Security

Docker isolation with seccomp, read-only filesystem, memory and CPU caps, a thirty second execution timeout, an outbound network allowlist limited to MCP servers, credentials in the OS keyring, and a cap of three concurrent MCP servers.

## Quick start for a screen share

Spin it up locally in one command:

```bash
cd /Users/id19/Programming/HIM
make serve   # or ./serve.sh, or: python3 -m http.server 8080
```

Then open http://127.0.0.1:8080 in a browser. The showcase is `index.html`; no
build step and no dependencies beyond Python 3.

For a public link (so you can share it without sharing your screen), push the
folder to any static host; the same `index.html` works on GitHub Pages, Netlify,
or Vercel as-is.
