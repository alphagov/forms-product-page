import { initAll } from 'govuk-frontend'

import { loadConsentStatus, CONSENT_STATUS } from './services/cookie.mjs'
import { installAnalyticsScript, setDefaultConsent, sendPageViewEvent, attachExternaLinkTracker } from './services/google_tag.mjs'

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

