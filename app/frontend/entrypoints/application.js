import { initAll } from 'govuk-frontend'

import { CookieBanner } from '../javascript/components/cookie_banner.mjs'
import { CookiePage } from '../javascript/components/cookie_page.mjs'

import {
  loadConsentStatus,
  saveConsentStatus,
  CONSENT_STATUS
} from '../javascript/services/cookie.mjs'
import {
  installAnalyticsScript,
  deleteGoogleAnalyticsCookies,
  setDefaultConsent,
  updateCookieConsent,
  sendPageViewEvent,
  attachExternaLinkTracker
} from '../javascript/services/google_tag.mjs'

initAll()

const analyticsConsentStatus = loadConsentStatus()

setDefaultConsent(analyticsConsentStatus === CONSENT_STATUS.GRANTED)

// send pageview regardless of consent value - if consent has not been granted
// yet, GTM won't be loaded and no data is sent to Google analytics. Doing this
// now means that if consent is granted later on this page, the event will be
// sent
sendPageViewEvent()
attachExternaLinkTracker()

if (analyticsConsentStatus === CONSENT_STATUS.GRANTED) {
  installAnalyticsScript(window)
}

// Initialise cookie banner
const $banners = document.querySelectorAll('[data-module="cookie-banner"]')
$banners.forEach(function ($banner) {
  new CookieBanner($banner).init({
    showBanner: analyticsConsentStatus === CONSENT_STATUS.UNKNOWN,
    onSubmit: handleUpdateConsent
  })
})

// Initialise cookie page
const $cookiesPage = document.querySelector('[data-module="app-cookies-page"]')
if ($cookiesPage) {
  new CookiePage($cookiesPage).init({
    allowAnalyticsCookies: analyticsConsentStatus === CONSENT_STATUS.GRANTED,
    onSubmit: handleUpdateConsent
  })
}

function handleUpdateConsent (consentedToAnalyticsCookies) {
  saveConsentStatus(consentedToAnalyticsCookies)

  updateCookieConsent(consentedToAnalyticsCookies)

  if (consentedToAnalyticsCookies === false) {
    deleteGoogleAnalyticsCookies()
  } else {
    installAnalyticsScript(window)
  }
}
