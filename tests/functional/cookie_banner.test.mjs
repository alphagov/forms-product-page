/* global page */

describe('Cookie banner', () => {
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

    await page.goto('http://localhost:8888/')
  })

  describe('when JavaScript is disabled', () => {
    it('is hidden', async () => {
      await page.setJavaScriptEnabled(false)

      // Reload page again
      await page.reload()

      await expect(page).toMatchElement('#cookie-banner', { visible: false })
      await expect(page).not.toMatchElement('script[src^="https://www.googletagmanager.com"]', { visible: false })
    })
  })

  describe('when JavaScript is enabled', () => {
    it('is visible if there is no consent cookie', async () => {
      await expect(page).toMatchElement('#cookie-banner', { visible: true })
    })

    it('is hidden if the consent cookie version is valid', async () => {
      await page.setCookie(cookieParam)

      // Reload page again
      await page.reload()

      await expect(page).toMatchElement('#cookie-banner', { visible: false })
    })
  })

  describe('accept button', () => {
    it('sets the consent cookie and adds the goolgle tag script to the page', async () => {
      await expect(page.cookies()).resolves.toEqual([])
      await expect(page).toClick('button', { text: 'Accept analytics cookies' })

      await expect(page.cookies()).resolves.toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            name: cookieParam.name,
            value: 'true'
          })
        ])
      )

      await expect(page).toMatchElement('script[src^="https://www.googletagmanager.com"]', { visible: false })
    })

    it('hides the cookie message', async () => {
      await expect(page).toClick('button', { text: 'Accept analytics cookies' })
      await expect(page).toMatchElement('#cookie-banner', { visible: false })
    })
  })

  describe('reject button', () => {
    it('sets the consent cookie', async () => {
      await expect(page.cookies()).resolves.toEqual([])
      await expect(page).toClick('button', { text: 'Reject analytics cookies' })

      await expect(page.cookies()).resolves.toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            name: cookieParam.name,
            value: 'false'
          })
        ])
      )

      await expect(page).not.toMatchElement('script[src^="https://www.googletagmanager.com"]', { visible: false })
    })

    it('hides the cookie message', async () => {
      await expect(page).toClick('button', { text: 'Reject analytics cookies' })
      await expect(page).toMatchElement('#cookie-banner', { visible: false })
    })
  })

  describe('cookies page link', () => {
    it('leads to the cookies page', async () => {
      await expect(page).toMatchElement('#cookie-banner [href="/cookies"]', { text: 'How we use cookies' })
    })
  })
})
