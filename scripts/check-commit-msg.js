#!/usr/bin/env node
// Block AI co-author trailers — kept honest about authorship.
// Hook: simple-git-hooks commit-msg → `node scripts/check-commit-msg.js $1`

import { readFileSync } from 'node:fs'

const msgPath = process.argv[2]
if (!msgPath) {
  console.error('check-commit-msg.js: brak ścieżki do COMMIT_EDITMSG')
  process.exit(1)
}

const msg = readFileSync(msgPath, 'utf8')

const forbidden = [
  /Co-Authored-By:\s*Claude/i,
  /Co-Authored-By:.*<noreply@anthropic\.com>/i,
  /Generated with \[Claude Code\]/i,
  /🤖 Generated with/i,
]

for (const pattern of forbidden) {
  if (pattern.test(msg)) {
    console.error('')
    console.error('❌ commit-msg: AI co-author trailer wykryty')
    console.error('   Wzorzec:', pattern)
    console.error('   Wytnij sekcję "Generated with..." / "Co-Authored-By: Claude" i commituj ponownie.')
    console.error('')
    process.exit(1)
  }
}
