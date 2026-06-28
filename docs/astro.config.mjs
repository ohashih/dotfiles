import starlight from "@astrojs/starlight";
import { defineConfig } from "astro/config";
import mermaid from "astro-mermaid";
import { remarkJapaneseBreak } from "./src/plugins/remark-japanese-break.mjs";
import path from "path";
import { fileURLToPath } from "url";
import react from "@astrojs/react";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export default defineConfig({
  site: "https://docs.kurage-admin.com",
  markdown: {
    remarkPlugins: [remarkJapaneseBreak],
  },
  integrations: [
    react(),
    mermaid({
      theme: "default",
      autoTheme: true,
      mermaidConfig: {
        flowchart: {
          curve: "basis",
        },
      },
    }),
    starlight({
      title: "Documentation",
      customCss: ["./src/styles/custom.css"],
      locales: {
        root: {
          label: "日本語",
          lang: "ja",
        },
      },
      sidebar: [
        {
          label: "Keybindings",
          collapsed: false,
          items: [{ autogenerate: { directory: "keybindings" } }],
        },
      ],
    }),
  ],
  vite: {
    resolve: {
      alias: {
        "@": path.resolve(__dirname, "./src"),
        "~": path.resolve(__dirname, "./src"),
      },
    },
  },
});
