export default {
  projects: [
    {
      displayName: 'unit',
      testEnvironment: 'jsdom',
      testMatch: [
        '**/app/frontend/javascript/**/*.test.{js,mjs}'
      ]
    },
    {
      displayName: 'e2e',
      preset: 'jest-puppeteer',
      testMatch: [
        '<rootDir>/tests/functional/**/*.test.{js,mjs}'
      ]
    }
  ]
}
