import mdx from "@astrojs/mdx";
import { defineConfig } from "astro/config";
import rehypeMinifyHtml from "rehype-preset-minify";
import remarkToc from "remark-toc";
import tailwind from "@astrojs/tailwind";

export default defineConfig({
  site: 'https://codediaz.github.io',
  base: '/GdgGye',
  output: 'static',
  image: {
    domains: ["static.wikia.nocookie.net"],
  },
  integrations: [
    tailwind({
      configFile: "./tailwind.config.ts",
    }),
    mdx({
      syntaxHighlight: "shiki",
      shikiConfig: { theme: "dracula" },
      remarkPlugins: [remarkToc],
      rehypePlugins: [rehypeMinifyHtml],
      remarkRehype: { footnoteLabel: "Footnotes" },
      gfm: false,
    }),
  ],
  build: {
    assets: 'astro'
  }
});
