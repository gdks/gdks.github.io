const { test, expect } = require('@playwright/test');

test('homepage loads correctly', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('h1')).toContainText('Gavin Stewart');
  await expect(await page.title()).toContain(
    'Gavin Stewart - Software Engineer'
  );
});

test('navigation works', async ({ page }) => {
  await page.goto('/');
  await page.click('a[href="#about"]');
  await expect(page.locator('#about')).toBeVisible();
});

test('responsive design', async ({ page }) => {
  await page.goto('/');
  await page.setViewportSize({ width: 375, height: 667 });
  await expect(page.locator('.hero')).toBeVisible();
});
