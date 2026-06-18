import { defineConfig } from 'astro/config'
import starlight from '@astrojs/starlight'

export default defineConfig({
  site: 'https://jakubkarwacki.github.io',
  base: '/myNotebook',
  trailingSlash: 'ignore',
  integrations: [
    starlight({
      title: 'myNotebook',
      description:
        'Zeszyt z notatkami szkolnymi (Linux/sieci, 2019/2020) — przepisany 2026 na współczesny dev-doc voice.',
      defaultLocale: 'root',
      locales: {
        root: { label: 'Polski', lang: 'pl' },
      },
      customCss: ['./src/styles/custom.css'],
      pagination: true,
      lastUpdated: false,
      social: [
        {
          icon: 'github',
          label: 'GitHub',
          href: 'https://github.com/JakubKarwacki/myNotebook',
        },
      ],
      sidebar: [
        { label: 'O notatkach', link: '/' },
        {
          label: 'Lekcje',
          items: [{ autogenerate: { directory: 'lekcje' } }],
        },
      ],
    }),
  ],
})
