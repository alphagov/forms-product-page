export default {
  projects: [
    {
      displayName: 'unit',
      testEnvironment: 'jsdom',
      testMatch: [
        '**/source/javascripts/**/*.test.{js,mjs}'
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
