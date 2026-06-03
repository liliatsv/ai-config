# Shared Rules (applied to all agents)

## Project Context
- Spring Boot Java project
- Package structure follows standard Maven layout: src/main/java, src/test/java
- Update DB migration tool below to match your project (Liquibase or Flyway)

## Behavior Rules
- Always reference specific file paths and class names
- Ask before making changes that affect more than one file
- Do not invent dependencies — only use what's already in pom.xml/build.gradle
- When unsure, say so — do not hallucinate APIs or class names
- Prefer small, focused changes over large rewrites

## Communication Style
- Be concise. Skip preamble like "Great question!" or "Certainly!"
- Lead with the answer, then explain
- Use code blocks for all code, even one-liners
