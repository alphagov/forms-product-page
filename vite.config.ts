import * as path from 'node:path'
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import { NodePackageImporter } from 'sass'

export default defineConfig({
  plugins: [RubyPlugin()],
  build: { emptyOutDir: true },
  css: {
    preprocessorOptions: {
      scss: {
        api: 'modern',
        importers: [new NodePackageImporter()],
        quietDeps: true
      },
      devSourcemaps: true
    }
  },
  resolve: {
    alias: {
      '@govuk': path.resolve(
        __dirname,
        'node_modules/govuk-frontend/dist/govuk'
      ),
      '@images': path.resolve(__dirname, 'app/frontend/images')
    }
  }
})
