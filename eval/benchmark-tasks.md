# Benchmark Tasks — Run These to Test Agent Quality

Run each task on your agents. You already know the right answer, so scoring is honest.

## Task 1 — Project Manager
**Prompt:** "We need to add rate limiting to our REST API. All endpoints should be limited to 100 requests/minute per user."
**Expected:** A plan listing affected layers, risks (auth, anonymous users), and questions about the rate limit store (in-memory vs Redis).

## Task 2 — Backend Developer  
**Prompt:** "Add a `GET /api/users/{id}/orders` endpoint that returns all orders for a user, with 404 if user not found."
**Expected:** Thin controller, service method with Optional handling, repository call, proper HTTP status codes, no business logic in controller.

## Task 3 — DB Specialist
**Prompt:** "We need to add a `last_login` timestamp column to the `users` table."
**Expected:** Flyway migration file with proper naming, rollback note, no data loss risk.

## Task 4 — QA Engineer
**Prompt:** "Write tests for a UserService.findById(Long id) that returns Optional<User>."
**Expected:** Tests for found case, not-found case, null input. given_when_then naming. Mockito for repo.

## Task 5 — Code Reviewer
**Prompt:** [Paste a small piece of your actual code and ask for review]
**Expected:** Structured feedback with severity levels, specific suggestions, not just vague comments.
