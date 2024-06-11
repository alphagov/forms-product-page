/**
 * @vitest-environment jsdom
 */

import { deleteGoogleAnalyticsCookies, installAnalyticsScript } from './google_tag.mjs'
import { describe, afterEach, it, expect } from 'vitest'

describe('google_tag.mjs', () => {
  afterEach(() => {
    document.getElementsByTagName('html')[0].innerHTML = ''
  })

  describe('deleteGoogleAnalyticsCookies()', () => {
    it('removes google cookies', function () {
      document.cookie = '_ga=GA1.1.120966789.1687349767'
      document.cookie = 'analytics_consent=true'
      document.cookie = '_ga_B0CQCNQ8PH=GS1.1.1687430125.5.0.1687430125.0.0.0'

      deleteGoogleAnalyticsCookies()
      expect(document.cookie).toContain('analytics_consent=true')
    })
  })

  describe('installAnalyticsScript()', () => {
    it('adds script tag to DOM', function () {
      installAnalyticsScript(window)
      expect(document.querySelectorAll('script[src^="https://www.googletagmanager.com/gtm.js"]').length).toBe(1)
    })
  })

  it('does not add script tag ig ga already present on window', function () {
    window.document.write = ''
    Object.defineProperty(window, 'ga', {
      writable: true,
      value: true
    })
    installAnalyticsScript(window)
    expect(document.querySelectorAll('script[src^="https://www.googletagmanager.com/gtm.js"]').length).toBe(0)
  })
})
