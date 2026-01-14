# Model Context Protocol (MCP) Architecture

The Model Context Protocol (MCP) is an open standard that enables AI applications to connect with external data sources and tools through a unified interface.

## Overview

![MCP Architecture](https://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/keugenek/plantuml-ent-kit/main/catalogue/reference-architectures/uml/mcp-architecture.puml)

## Pattern Description

MCP provides a standardized way for AI applications (hosts) to communicate with external systems (servers) using a client-server architecture with JSON-RPC 2.0 messaging.

## Components

### MCP Host
- **Purpose**: The AI application that needs external capabilities
- **Examples**: Claude Desktop, IDEs, custom AI applications
- **Contains**: MCP Client for managing server connections

### MCP Client
- **Purpose**: Manages connections to MCP servers
- **Key Responsibilities**:
  - Server discovery and connection
  - Capability negotiation
  - Request routing and response handling
  - Connection lifecycle management

### MCP Server
- **Purpose**: Exposes capabilities to AI applications
- **Primitives Provided**:
  - **Tools**: Executable functions the AI can invoke
  - **Resources**: Data and context the AI can read
  - **Prompts**: Reusable prompt templates

## Communication Protocol

| Method | Purpose | Example |
|--------|---------|---------|
| `tools/list` | Discover available tools | List all executable functions |
| `tools/call` | Execute a tool | Run a database query |
| `resources/list` | Discover available resources | List accessible files |
| `resources/read` | Read a resource | Get file contents |
| `prompts/list` | Discover available prompts | List prompt templates |
| `prompts/get` | Get a prompt | Retrieve template with args |

## Server Examples

### File System Server
```json
{
  "tools": [
    {
      "name": "read_file",
      "description": "Read contents of a file",
      "inputSchema": {
        "type": "object",
        "properties": {
          "path": { "type": "string" }
        }
      }
    }
  ]
}
```

### Database Server
```json
{
  "tools": [
    {
      "name": "query",
      "description": "Execute SQL query",
      "inputSchema": {
        "type": "object",
        "properties": {
          "sql": { "type": "string" }
        }
      }
    }
  ],
  "resources": [
    {
      "uri": "db://schema",
      "name": "Database Schema",
      "mimeType": "application/json"
    }
  ]
}
```

## When to Use

- Building AI applications that need external data access
- Creating reusable tool integrations across multiple AI hosts
- Standardizing how AI connects to enterprise systems
- Developing IDE extensions with AI capabilities
- Building composable AI agent architectures

## Benefits

| Benefit | Description |
|---------|-------------|
| **Standardization** | One protocol for all integrations |
| **Reusability** | Servers work with any MCP-compatible host |
| **Security** | Controlled access through capability negotiation |
| **Composability** | Mix and match servers for different use cases |

## Related Patterns

| Pattern | Relationship |
|---------|-------------|
| [LLM Tool Call](llm-tool-call.md) | MCP standardizes tool calling |
| [Skills Pattern](skills-pattern.md) | Skills can be exposed via MCP |
| [Agent Orchestration](agent-orchestration.md) | Agents can use MCP for tool access |

## Resources

- [MCP Specification](https://modelcontextprotocol.io)
- [MCP SDKs](https://github.com/modelcontextprotocol)
