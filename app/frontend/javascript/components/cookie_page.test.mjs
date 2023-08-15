import { readFileSync } from 'fs'
import { CookiePage } from './cookie_page.mjs'

describe('CookiePage', () => {
  let cookiePage
  const cookiePageHTML = readFileSync('tests/fixtures/cookie_page.html', 'utf8')

  beforeEach(() => {
    document.body.innerHTML = cookiePageHTML
    cookiePage = new CookiePage(document.querySelector('[data-module="app-cookies-page"]'))
  })

  test('Initialzes ok when given valid html', () => {
    expect(cookiePage).toBeDefined()
  })
})
