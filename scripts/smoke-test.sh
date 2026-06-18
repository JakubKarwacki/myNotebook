#!/usr/bin/env bash
# Smoke test for deployed myNotebook site.
# Verifies: per-page link audit + key CTA + 404 page rendering.
#
# Usage:
#   scripts/smoke-test.sh                           # default URL
#   scripts/smoke-test.sh https://example.com/foo   # custom URL
#
# Exit codes:
#   0 — all checks passed
#   1 — broken internal links found
#   2 — hero CTA / lesson navigation broken
#   3 — 404 page not custom

set -euo pipefail

SITE="${1:-https://jakubkarwacki.github.io/myNotebook}"
SITE="${SITE%/}"
BASE_PATH=$(echo "$SITE" | sed -E 's|https?://[^/]+||')

echo "Smoke testing: $SITE"
echo "Base path: $BASE_PATH"
echo

LESSONS=(
  "/lekcje/01-organizacyjna/"
  "/lekcje/02-podstawowe-komendy-linux/"
  "/lekcje/03-instalacja-apache2/"
  "/lekcje/04-konfiguracja-sieciowa-linux/"
  "/lekcje/05-konfiguracja-sieciowa-ifconfig/"
  "/lekcje/06-konfiguracja-sieciowa-apt-ping/"
  "/lekcje/07-konfiguracja-sieciowa-ip/"
  "/lekcje/08-konfiguracja-hosta/"
  "/lekcje/09-poznanie-bash/"
  "/lekcje/10-skrypty-bash/"
  "/lekcje/11-konfiguracja-sieciowa/"
  "/lekcje/12-konfiguracja-grub/"
  "/lekcje/13-przypomnienie-komend/"
  "/lekcje/14-testy-linux/"
)

# 1. Landing + every lesson returns 200
echo "[1/4] HTTP status check (16 pages)..."
FAILED=0
for url in "/" "${LESSONS[@]}"; do
  code=$(curl -sf -o /dev/null -w '%{http_code}' "${SITE}${url}" || echo "000")
  if [ "$code" != "200" ]; then
    echo "  ✗ ${url} → ${code}"
    FAILED=1
  fi
done
[ "$FAILED" -eq 0 ] && echo "  ✓ All pages return 200" || { echo "  → page status FAIL"; exit 1; }

# 2. Per-page internal link audit
echo "[2/4] Internal link audit (must be base-prefixed or relative)..."
BROKEN_TOTAL=0
for url in "/" "${LESSONS[@]}"; do
  body=$(curl -sf "${SITE}${url}")
  broken=$(echo "$body" \
    | grep -oE 'href="/[^"]*"' \
    | grep -v "${BASE_PATH}/\|/_astro/\|/sitemap\|/favicon\|//github.com\|//www.youtube\|stylesheet\|#" \
    || true)
  if [ -n "$broken" ]; then
    echo "  ✗ BROKEN in ${url}:"
    echo "$broken" | head -5 | sed 's/^/      /'
    BROKEN_TOTAL=$((BROKEN_TOTAL + 1))
  fi
done
[ "$BROKEN_TOTAL" -eq 0 ] && echo "  ✓ All internal links properly prefixed" || { echo "  → link audit FAIL (${BROKEN_TOTAL} pages)"; exit 1; }

# 3. Hero CTA on landing leads to working lesson
echo "[3/4] Hero CTA verify..."
hero=$(curl -sf "${SITE}/" \
  | grep -oE 'href="[^"]*"[^>]*>[^<]*Zacznij' \
  | grep -oE 'href="[^"]*"' \
  | head -1 \
  | sed 's/href="//;s/"//')
if [ -z "$hero" ]; then
  echo "  ✗ Hero CTA not found on landing"
  exit 2
fi
hero_url="${hero}"
[[ "$hero" != http* && "$hero" != "${BASE_PATH}"* ]] && hero_url="${BASE_PATH}${hero}"
hero_code=$(curl -sf -o /dev/null -w '%{http_code}' "https://$(echo "$SITE" | sed -E 's|https?://||;s|/.*||')${hero_url}" || echo "000")
if [ "$hero_code" != "200" ]; then
  echo "  ✗ Hero CTA href=${hero} → ${hero_code}"
  exit 2
fi
echo "  ✓ Hero CTA → ${hero} → 200"

# 4. Custom 404 page renders (not default GitHub 404)
echo "[4/4] 404 page verify..."
not_found_code=$(curl -s -o /dev/null -w '%{http_code}' "${SITE}/this-route-does-not-exist")
if [ "$not_found_code" != "404" ]; then
  echo "  ✗ Non-existent URL returned ${not_found_code}, expected 404"
  exit 3
fi
not_found_body=$(curl -s "${SITE}/this-route-does-not-exist")
if ! echo "$not_found_body" | grep -q 'Ta strona nie istnieje'; then
  echo "  ✗ 404 page rendered but content is not custom PL Starlight page"
  exit 3
fi
echo "  ✓ Custom PL 404 page rendered"

echo
echo "All smoke checks PASSED"
