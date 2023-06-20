beforeAll(async () => {
  await import('./site.mjs')
})

// An example test which doesn't do anything other than check that the test
// setup is working correctly
test('simple test', () => {
  expect(true).toBe(true)
})
