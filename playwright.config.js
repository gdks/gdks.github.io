module.exports = {
  testDir: './tests',
  use: {
    baseURL: 'http://localhost:8000',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
  projects: [
    {
      name: 'chrome',
      use: {
        ...require('@playwright/test').devices['Desktop Chrome'],
      },
    },
    {
      name: 'firefox',
      use: {
        ...require('@playwright/test').devices['Desktop Firefox'],
      },
    },
    {
      name: 'edge',
      use: {
        ...require('@playwright/test').devices['Desktop Edge'],
      },
    },
  ],
  webServer: {
    command: 'python3 -m http.server 8000',
    port: 8000,
    reuseExistingServer: false,
  },
  reporter: [['list'], ['html', { outputFolder: 'playwright-report' }]],
  timeout: 30000,
};
