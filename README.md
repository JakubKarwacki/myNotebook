# myNotebook

Zeszyt z notatkami szkolnymi (Linux i sieci komputerowe, technikum 2019/2020), przepisany
w 2026 jako [Starlight](https://starlight.astro.build) static site.

**Live:** [`jakubkarwacki.github.io/myNotebook`](https://jakubkarwacki.github.io/myNotebook/)

## O projekcie

14 lekcji z drugiego semestru drugiej klasy technikum informatycznego — administracja Linuksem,
konfiguracja sieci, podstawy Basha, GRUB. Oryginalnie napisane jako statyczne pliki HTML
z jQuery jako spis treści. W 2026 wszystko przepisałem na nowoczesny stack: MDX, jasny/ciemny
theme, full-text search, mobile responsive, optymalizacja obrazów.

Tematyka i kolejność lekcji są zachowane. Treść jest przepisana na współczesny dev-doc voice
(z poprawionymi literówkami, zmodernizowanymi komendami i lepszą strukturą sekcji). Oryginalne
pliki HTML znajdują się na branchu
[`archive-2019`](https://github.com/JakubKarwacki/myNotebook/tree/archive-2019).

## Stack

- [Astro](https://astro.build) 6 + [Starlight](https://starlight.astro.build) 0.40
- MDX z [`docsLoader`](https://starlight.astro.build/manual-setup/) content collection
- [Pagefind](https://pagefind.app) — static full-text search
- [Shiki](https://shiki.style) — syntax highlighting
- [Geist](https://vercel.com/font) Sans/Mono via `@fontsource-variable`
- TypeScript 6 strict
- pnpm 11

Deploy: GitHub Pages, tag-driven (`site-v*` → workflow).

## Development

Wymagania:
- Node `>=22.12.0`
- pnpm `>=11.0.0`

```bash
pnpm install
pnpm dev        # localhost:4321
pnpm build      # production build → dist/
pnpm preview    # preview production build
pnpm typecheck  # astro check
pnpm check      # typecheck + build
```

## Struktura

```
src/
├─ assets/lekcje/           # obrazki per-lekcja (importowane w MDX)
├─ content/
│  ├─ docs/
│  │  ├─ index.mdx          # landing / About
│  │  └─ lekcje/
│  │     ├─ 01-organizacyjna.mdx
│  │     ├─ 02-podstawowe-komendy-linux.mdx
│  │     └─ ...             # 14 lekcji łącznie
│  └─ ...
└─ styles/custom.css        # Starlight CSS custom property overrides
```

## Contributions

**Repo jest zamknięte na contributions.** To portfolio piece. PR-y nie są akceptowane.
Bugs w technologii hostującej (broken layout, etc.) — feel free to email lub otworzyć issue.

## License

[Proprietary](./LICENSE) — All Rights Reserved. Zobacz `LICENSE` dla pełnych terms.

## Security

[`SECURITY.md`](./SECURITY.md) — jak zgłosić problemy security.
