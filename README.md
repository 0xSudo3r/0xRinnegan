# Discord Recon Automation

Automated subdomain reconnaissance workflow that checks Discord every 5 minutes for new domains and runs subfinder.

## 📁 Project Structure

```
recon-automation/
├── .github/
│   └── workflows/
│       └── recon-monitor.yml          # Main GitHub Actions workflow
├── scripts/
│   ├── generate-website.sh            # Website generator script
│   └── notify-discord.sh              # Discord notification script
├── docs/                              # GitHub Pages website (auto-generated)
│   ├── index.html
│   ├── scans.json
│   └── scans/
│       └── subdomains_*.txt
├── results/                           # Temporary results storage
│   └── subdomains_*.txt
├── last_message_id.txt               # Tracks last processed Discord message
└── README.md                         # This file
```

## 🚀 Setup Instructions

### 1. Fork/Clone this Repository

```bash
git clone https://github.com/YOUR_USERNAME/recon-automation.git
cd recon-automation
```

### 2. Create Required Files

Create the scripts directory and make files executable:

```bash
mkdir -p scripts
chmod +x scripts/generate-website.sh
chmod +x scripts/notify-discord.sh
```

### 3. Set Up Discord Bot

1. Go to [Discord Developer Portal](https://discord.com/developers/applications)
2. Create a new application
3. Add a bot and copy the token
4. Enable "Message Content Intent"
5. Invite bot to your server with permissions:
   - View Channels
   - Send Messages
   - Read Message History
   - Add Reactions

### 4. Create Discord Channels

- `#recon-submit` - For submitting domains
- `#recon-results` - For receiving results

### 5. Get Discord IDs

**Get Channel ID:**
- Enable Developer Mode in Discord settings
- Right-click `#recon-submit` → Copy Channel ID

**Get Webhook URL:**
- Right-click `#recon-results` → Edit Channel → Integrations → Webhooks
- Create new webhook → Copy URL

### 6. Configure GitHub Secrets

Go to: **Settings → Secrets and variables → Actions**

Add these secrets:

| Secret Name | Description |
|------------|-------------|
| `DISCORD_BOT_TOKEN` | Your Discord bot token |
| `RECON_SUBMIT_CHANNEL_ID` | Channel ID for #recon-submit |
| `DISCORD_WEBHOOK_URL` | Webhook URL for #recon-results |

### 7. Enable GitHub Pages

1. Go to **Settings → Pages**
2. Source: **Deploy from a branch**
3. Branch: **gh-pages** / **(root)**
4. Save

### 8. Initialize Files

Create an empty `last_message_id.txt`:

```bash
touch last_message_id.txt
git add .
git commit -m "Initial setup"
git push
```

### 9. Test the Workflow

1. Go to **Actions** tab
2. Select "Discord Recon Monitor"
3. Click "Run workflow"
4. Check the logs to ensure it runs successfully

## 📖 Usage

### Submit a Domain

Simply type a domain in `#recon-submit`:

```
example.com
```

### What Happens

1. **Every 5 minutes**: GitHub Actions checks for new messages
2. **Processing**: Bot adds 🚀 reaction and runs subfinder
3. **Results**: Updates dashboard website
4. **Notification**: Sends results to `#recon-results`
5. **Complete**: Adds ✅ reaction

### View Results

Access your dashboard at:
```
https://YOUR_USERNAME.github.io/recon-automation/
```

## 🔧 Configuration

### Change Check Interval

Edit `.github/workflows/recon-monitor.yml`:

```yaml
schedule:
  - cron: '*/5 * * * *'  # Every 5 minutes
  # - cron: '*/10 * * * *'  # Every 10 minutes
  # - cron: '0 * * * *'     # Every hour
```

### Customize Notification

Edit `scripts/notify-discord.sh` to change message format.

### Modify Website Design

Edit the HTML template in `scripts/generate-website.sh`.

## 🛠️ File Descriptions

### `.github/workflows/recon-monitor.yml`
Main workflow that:
- Checks Discord every 5 minutes
- Processes new domains
- Runs subfinder
- Generates/updates website
- Sends notifications

### `scripts/generate-website.sh`
Bash script that:
- Updates `scans.json` with new results
- Copies subdomain files
- Generates main dashboard HTML

### `scripts/notify-discord.sh`
Bash script that:
- Configures ProjectDiscovery notify
- Creates notification message
- Sends to Discord via webhook

### `last_message_id.txt`
Tracks the last processed Discord message ID to avoid duplicates.

## 📊 Dashboard Features

- **Total Scans**: Count of all recon jobs
- **Total Subdomains**: Sum of all discovered subdomains
- **Latest Scan**: Most recent domain scanned
- **Interactive Cards**: Click to expand and view subdomains
- **Responsive Design**: Works on desktop and mobile

## 🐛 Troubleshooting

### Workflow not running
- Check if schedule is enabled in Actions tab
- Manually trigger via "Run workflow" button
- Verify GitHub Actions are enabled for the repo

### Bot not detecting domains
- Verify `RECON_SUBMIT_CHANNEL_ID` is correct
- Check bot has proper permissions
- Ensure domain format is valid (e.g., `example.com`)

### No Discord notifications
- Verify `DISCORD_WEBHOOK_URL` is correct
- Check webhook still exists in Discord
- Review workflow logs for errors

### Website not updating
- Ensure repo is Public
- Check GitHub Pages is enabled
- Wait 1-2 minutes after workflow completes
- Hard refresh browser (Ctrl+F5)

## 🔒 Security

- Never commit secrets to Git
- Use GitHub Secrets for all sensitive data
- Rotate tokens if exposed
- Keep bot permissions minimal

## 📈 Future Enhancements

- Add httpx for live host detection
- Integrate nuclei for vulnerability scanning
- Add port scanning with naabu
- Implement diff detection for new subdomains
- Add screenshot capture with gowitness
- Database integration for historical tracking

## 📝 License

MIT License - Feel free to modify and use as needed.

## 🤝 Contributing

Pull requests welcome! Feel free to improve the workflow or add features.

## ⚠️ Disclaimer

This tool is for authorized security testing only. Always ensure you have permission to scan target domains.
