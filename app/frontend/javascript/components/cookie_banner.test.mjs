import { readFileSync } from 'fs'
import { CookieBanner } from './cookie_banner.mjs'

describe('CookieBanner', () => {
  let cookieBanner
  const cookieBannerHTML = readFileSync('tests/fixtures/cookie_banner.html', 'utf8')

  beforeEach(() => {
    document.body.innerHTML = cookieBannerHTML
    cookieBanner = new CookieBanner(document.querySelector('#cookie-banner'))
  })

  test('Initialzes ok when given valid html', () => {
    expect(cookieBanner).toBeDefined()
  })

  describe('When given no options', () => {
    test('is hidden', () => {
      cookieBanner.init()
      expect(document.querySelector('#cookie-banner').getAttribute('hidden')).toBe('true')
    })
  })

  test('show', () => {
    cookieBanner.show()
    expect(document.querySelector('#cookie-banner').hasAttribute('hidden')).toBe(false)
  })
})
