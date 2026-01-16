import { defineConfig } from 'astro/config';

export default defineConfig({
  output: 'static',
  build: {
    assets: 'assets',
    inlineStylesheets: 'auto'
  },
  vite: {
    build: {
      cssMinify: true,
      minify: true
    }
  },
  compressHTML: true,
  prefetch: {
    prefetchAll: true
  }
});
