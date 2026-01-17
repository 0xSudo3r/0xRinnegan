#!/bin/bash
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# Create notify config
mkdir -p ~/.config/notify
cat > ~/.config/notify/provider-config.yaml << EOF
discord:
  - id: "recon-results"
    discord_channel: "recon-results"
    discord_username: "0xM4dara's 3ye"
    discord_format: "{{data}}"
    discord_webhook_url: "$DISCORD_WEBHOOK"
    discord_avatar_url: "https://cdn.discordapp.com/attachments/1462106915764047995/1462107890625286247/discord-bot-icon.jpg?ex=696cfd95&is=696bac15&hm=c3b8f526c32b98541ce4db88fed2da7bdfd372a571345d478969f8eb794318e3&"
EOF

# Build GitHub Pages URL
PAGES_URL="https://${REPO_OWNER}.github.io/${REPO_NAME}/"

# Get the 10 latest subdomains
LATEST_SUBS=$(head -10 results/subdomains_${DOMAIN}.txt)

# Create notification message - everything in ONE message
cat > notification.txt << ENDOFMSG
**✅ Recon Complete!**

**Target:** \`${DOMAIN}\`
**Subdomains Found:** ${COUNT}
**Timestamp:** ${TIMESTAMP}

🔗 **[View Full Results](${PAGES_URL})**

**Latest subdomains discovered:**
${LATEST_SUBS}
ENDOFMSG

# Send notification using notify
cat notification.txt | notify -provider-config ~/.config/notify/provider-config.yaml -provider discord -id recon-results

echo "✅ Discord notification sent"
