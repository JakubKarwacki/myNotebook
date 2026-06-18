# Security Policy

myNotebook to **statyczny portfolio site** — bez backendu, bez DB, bez auth.
Powierzchnia ataku jest minimalna. Mimo to przyjmuję security reports.

## Reporting

**Nie używaj GitHub Issues** dla security findings — wszystko publiczne. Zamiast tego:

📧 **awdykowicz.jakub@gmail.com** — opisz vulnerability + repro steps + impact.

Odpowiedź zazwyczaj w 48h (single-maintainer best effort, EU timezone).

## Scope

In-scope:

- XSS w renderowanych MDX content (skopiowane user-content, link targets)
- Subresource integrity / dependency poisoning w buildzie
- Linki na niezamierzony content (broken/maliciously-redirected external linki)

Out-of-scope:

- Wszystko wymagające server-side state (nie ma takiego)
- Bug bounty — to single-maintainer side project, nagrody nie są dostępne
- "Add CSP header" / general best practices bez konkretnego exploit path

## Disclosure

Patch w next deploy tag (`site-v*`). Wide-impact issues — coordinated disclosure z reporter.
