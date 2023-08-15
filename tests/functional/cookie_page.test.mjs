/* global page */

describe('Cookie Page', () => {
  // Default cookie
  const cookieParam = {
    name: 'analytics_consent',
    value: 'true',
    url: 'http://localhost:8888'
  }

  beforeEach(async () => {
    await page.deleteCookie({
      name: cookieParam.name,
      url: cookieParam.url
    })

    await page.setJavaScriptEnabled(true)

    await page.goto('http://localhost:8888/cookies')
  })

  describe('when JavaScript is disabled', () => {
    it('form is hidden', async () => {
      await page.setJavaScriptEnabled(false)
      await page.reload()

      await expect(page).toMatchElement('button', { visible: false, text: 'Save cookie settings' })
      await expect(page).not.toMatchElement('script[src^="https://www.googletagmanager.com"]', { visible: false })
    })
  })

  describe('when JavaScript is enabled', () => {
    it('form is visible', async () => {
      await expect(page).toMatchElement('button', { visible: true, text: 'Save cookie settings' })
    })

    it('set to false if the consent cookie is not set to true', async () => {
      await expect(page).toMatchElement('input[name="analytics"][value="no"]:checked', { visible: true })
    })

    it('set to true if the consent cookie is set to true', async () => {
      await page.setCookie(cookieParam)
      await page.reload()

      await expect(page).toMatchElement('input[name="analytics"][value="yes"]:checked', { visible: true })
    })
  })

  describe('selecting yes and submitting form', () => {
    it('sets consent cookie, adds the google tag script, shows notification banner', async () => {
      await expect(page.cookies()).resolves.toEqual([])
      await expect(page).toClick('input[name="analytics"][value="yes"]', { visible: true })
      await expect(page).toClick('button', { text: 'Save cookie settings' })

      await expect(page.cookies()).resolves.toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            name: cookieParam.name,
            value: 'true'
          })
        ])
      )

      await expect(page).toMatchElement('script[src^="https://www.googletagmanager.com"]', { visible: false })
      await expect(page).toMatchElement('.govuk-notification-banner', { visible: true })
    })
  })

  describe('selecting no and submitting form', () => {
    it('sets consent cookie, shows notification banner', async () => {
      await expect(page.cookies()).resolves.toEqual([])
      await expect(page).toClick('input[name="analytics"][value="no"]', { visible: true })
      await expect(page).toClick('button', { text: 'Save cookie settings' })

      await expect(page.cookies()).resolves.toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            name: cookieParam.name,
            value: 'false'
          })
        ])
      )

      await expect(page).not.toMatchElement('script[src^="https://www.googletagmanager.com"]', { visible: false })
      await expect(page).toMatchElement('.govuk-notification-banner', { visible: true })
    })
  })
})
