export default {
  launch: {
    devtools: false,
    headless: 'new'
  },
  server: {
    command: './bin/rails s -p 8888',
    port: 8888,
    launchTimeout: 18000,
    debug: true,
    usedPortAction: 'kill'
  }
}
