import js from "@eslint/js";
import { defineConfig } from "eslint/config";
import tseslint from "typescript-eslint";
import eslintPluginAstro from "eslint-plugin-astro";
import eslintMarkdownLintPlugin from "eslint-plugin-markdownlint";
import eslintMarkdownLintParser from "eslint-plugin-markdownlint/parser.js";
import eslintPrettierConfig from "eslint-config-prettier";

export default defineConfig([
  {
    files: ["**/*.{js,ts}"],
    extends: [js.configs.recommended, tseslint.configs.recommended],
  },
  ...eslintPluginAstro.configs.recommended,
  {
    files: ["**/*.md"],
    plugins: { markdownlint: eslintMarkdownLintPlugin },
    languageOptions: { parser: eslintMarkdownLintParser },
    rules: {
      ...eslintMarkdownLintPlugin.configs.recommended.rules,
      "markdownlint/md013": "off",
    },
  },
  eslintPrettierConfig,
  {
    ignores: ["dist/", ".astro/", "node_modules/"],
  },
]);
