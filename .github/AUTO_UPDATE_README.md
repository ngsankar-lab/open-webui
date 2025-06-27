# 🤖 Automated Update System for LZB AI Platform

This document explains the automated update system that keeps your LZB AI Platform fork synchronized with the latest Open WebUI releases while preserving your custom branding.

## 🔄 How It Works

The automated update system runs weekly (every Monday at 9 AM UTC) and:

1. **Checks for new releases** from the official Open WebUI repository
2. **Automatically merges** new updates when possible
3. **Preserves your LZB customizations** during the merge process
4. **Creates pull requests** for you to review and approve updates
5. **Handles conflicts gracefully** by creating issues for manual intervention

## 📋 What Gets Preserved

The system automatically verifies that these LZB customizations remain intact:

- ✅ **App Title**: "LZB AI Platform" in both frontend and backend
- ✅ **Custom Favicon**: Blue circular design with "LZB" text
- ✅ **Splash Screens**: Custom LZB branding for light/dark modes
- ✅ **Configuration Files**: All your custom settings and environment variables
- ✅ **Documentation**: CLAUDE.md and other custom docs

## 🎯 When Updates Happen

### Automatic Success ✅
When there are no conflicts, you'll get:
- A **pull request** with the title: "🤖 Auto-update to Open WebUI vX.X.X"
- **Verified LZB customizations** in the PR description
- **Labels**: `🤖 automated`, `⬆️ update`, `🔧 maintenance`
- **Testing instructions** for optional manual verification

### Manual Intervention Required ⚠️
When there are merge conflicts, you'll get:
- An **issue** with detailed resolution steps
- **Specific files** that need attention listed
- **Step-by-step commands** to resolve conflicts manually
- **Labels**: `🚨 manual-intervention`, `⬆️ update`, `🔧 maintenance`

## 🛠️ Manual Trigger

You can manually trigger an update check at any time:

1. Go to **Actions** tab in your GitHub repository
2. Select **"Auto-Update from Upstream"** workflow
3. Click **"Run workflow"** button
4. Choose the `main` branch and click **"Run workflow"**

## 📊 Workflow File Location

The automation is defined in: `.github/workflows/auto-update-upstream.yml`

## 🔧 Configuration Options

### Change Update Frequency

Edit the cron schedule in the workflow file:

```yaml
schedule:
  # Current: Every Monday at 9 AM UTC
  - cron: '0 9 * * 1'
  
  # Examples:
  # Daily at 2 AM UTC: '0 2 * * *'
  # Every Friday at 6 PM UTC: '0 18 * * 5'
  # Twice per month (1st and 15th): '0 9 1,15 * *'
```

### Customize Verification Checks

The workflow verifies your customizations by checking:
- `src/lib/constants.ts` contains "LZB AI Platform"
- `backend/open_webui/env.py` contains "LZB AI Platform"
- `static/favicon.svg` exists and contains "LZB"
- `CLAUDE.md` exists (optional)

You can modify these checks in the "Verify LZB customizations" step.

## 🚨 Troubleshooting

### Workflow Fails to Run
- Check that GitHub Actions are enabled in your repository settings
- Ensure the `GITHUB_TOKEN` has sufficient permissions

### Merge Conflicts
- Follow the step-by-step instructions in the created issue
- Pay special attention to files containing LZB branding
- Test locally before creating the PR

### False Positive Updates
- The workflow checks semantic versions only (e.g., v0.6.15)
- Pre-release versions (e.g., v0.7.0-beta) are ignored
- If you see unwanted updates, check the version comparison logic

## 🎉 Benefits

✅ **Stay Updated**: Automatically get the latest Open WebUI features and security fixes  
✅ **Preserve Branding**: Your LZB customizations are never lost  
✅ **Review Control**: You approve all updates via pull requests  
✅ **Conflict Handling**: Clear guidance when manual intervention is needed  
✅ **Zero Maintenance**: Runs automatically in the background  

## 📚 Next Steps

1. **Review this first auto-update PR** when it arrives
2. **Test the updated application** if desired
3. **Merge when ready** to apply the update
4. **Enjoy automated updates** going forward!

---

🤖 **Generated for LZB AI Platform**  
💡 **Questions?** Check the [GitHub Actions documentation](https://docs.github.com/en/actions) or review the workflow file.