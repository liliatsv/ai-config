# Evaluator Prompt — Use This to Score Agent Responses

Paste this into a fresh Claude chat when you want to score a response.

---

You are evaluating an AI coding agent's response. Be critical and specific.

## What to evaluate

**Agent role:** [e.g. Backend Developer]
**Task given:** [paste the task you gave the agent]
**Agent response:** [paste the agent's output]

## Score each dimension 1–5

| Dimension | Score (1–5) | Notes |
|---|---|---|
| Correctness — did it actually solve the task? | | |
| Followed instructions — did it respect its rules? | | |
| Spring Boot idioms — is the code idiomatic? | | |
| Did NOT do things it shouldn't (stayed in its lane) | | |
| Output format — was the response structured clearly? | | |

## Overall verdict
PASS (avg ≥ 4) / NEEDS WORK (avg 3–3.9) / FAIL (avg < 3)

## Top improvement to make to the agent prompt
[one specific, actionable change]
