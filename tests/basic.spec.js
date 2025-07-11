const { test, expect } = require('@playwright/test');

test.describe('Portfolio Site Tests', () => {
  test('homepage loads correctly', async ({ page }) => {
    await page.goto('/');

    // Check page title
    await expect(page).toHaveTitle(/Gavin Stewart/);

    // Check main heading
    await expect(page.locator('h1')).toContainText('Gavin Stewart');

    // Check navigation is present
    await expect(page.locator('nav')).toBeVisible();
  });

  test('navigation works correctly', async ({ page }) => {
    await page.goto('/');

    // Test navigation to About section
    await page.click('a[href="#about"]');
    await expect(page.locator('#about')).toBeVisible();

    // Test navigation to Skills section
    await page.click('a[href="#skills"]');
    await expect(page.locator('#skills')).toBeVisible();

    // Test navigation to Contact section
    await page.click('a[href="#contact"]');
    await expect(page.locator('#contact')).toBeVisible();
  });

  test('responsive design works', async ({ page }) => {
    await page.goto('/');

    // Test mobile viewport
    await page.setViewportSize({ width: 375, height: 667 });
    await expect(page.locator('.hero')).toBeVisible();

    // Test tablet viewport
    await page.setViewportSize({ width: 768, height: 1024 });
    await expect(page.locator('.hero')).toBeVisible();

    // Test desktop viewport
    await page.setViewportSize({ width: 1920, height: 1080 });
    await expect(page.locator('.hero')).toBeVisible();
  });

  test('external links open correctly', async ({ page }) => {
    await page.goto('/');

    // Check GitHub link
    const githubLink = page.locator('a[href*="github.com"]');
    await expect(githubLink).toBeVisible();
    await expect(githubLink).toHaveAttribute('target', '_blank');
    await expect(githubLink).toHaveAttribute('rel', 'noopener');

    // Check LinkedIn link
    const linkedinLink = page.locator('a[href*="linkedin.com"]');
    await expect(linkedinLink).toBeVisible();
    await expect(linkedinLink).toHaveAttribute('target', '_blank');
    await expect(linkedinLink).toHaveAttribute('rel', 'noopener');
  });

  test('accessibility features are present', async ({ page }) => {
    await page.goto('/');

    // Check for skip navigation link
    const skipLink = page.locator('a[href="#main-content"]');
    await expect(skipLink).toBeVisible();

    // Check for proper heading structure
    await expect(page.locator('h1')).toBeVisible();
    await expect(page.locator('h2')).toBeVisible();

    // Check for alt text on images (if any)
    const images = page.locator('img');
    const imageCount = await images.count();
    if (imageCount > 0) {
      for (let i = 0; i < imageCount; i++) {
        const alt = await images.nth(i).getAttribute('alt');
        expect(alt).toBeTruthy();
      }
    }
  });
});
