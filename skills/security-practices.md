## Security practices

- Never commit secrets, credentials, API keys, or tokens to source control.
- Validate and sanitize all external input before use.
- Use parameterized queries or an ORM to prevent SQL injection.
- Apply the principle of least privilege: request only the permissions actually needed.
- Prefer well-maintained libraries over hand-rolled security primitives (e.g., use bcrypt for password hashing, not MD5/SHA1).
- Flag any code that handles authentication, authorization, or sensitive data for extra scrutiny.
