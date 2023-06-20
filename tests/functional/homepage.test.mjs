/* global page */

describe('Homepage', () => {
  beforeAll(async () => {
    await page.goto('http://localhost:8888')
  })

  it('should have the correct title', async () => {
    await expect(page.title()).resolves.toMatch('Create online forms for GOV.UK')
  })
})
