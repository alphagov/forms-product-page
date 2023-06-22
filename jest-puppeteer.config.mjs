export default {
  launch: {
    devtools: false,
    headless: 'new'
  },
  server: {
    command: 'bundle exec middleman --port 8888 --watcher-disable',
    port: 8888,
    launchTimeout: 9000,
    debug: true,
    usedPortAction: 'kill'
  }
}
