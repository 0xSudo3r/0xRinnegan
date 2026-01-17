#!/bin/bash
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# Build GitHub Pages URL
PAGES_URL="https://${REPO_OWNER}.github.io/${REPO_NAME}/"

# Get the 10 latest subdomains
LATEST_SUBS=$(head -10 results/subdomains_${DOMAIN}.txt)

# Create the message content
MESSAGE="**✅ Recon Complete!**

**Target:** \`${DOMAIN}\`
**Subdomains Found:** ${COUNT}
**Timestamp:** ${TIMESTAMP}

🔗 **[View Full Results](${PAGES_URL})**

**Latest subdomains discovered:**

\`\`\`
${LATEST_SUBS}
\`\`\`"

# ⭐ ADD YOUR IMAGE URL HERE ⭐
AVATAR_URL="https://cdn.discordapp.com/attachments/1462106915764047995/1462107890625286247/discord-bot-icon.jpg?ex=696cfd95&is=696bac15&hm=c3b8f526c32b98541ce4db88fed2da7bdfd372a571345d478969f8eb794318e3&"

# Send directly to Discord webhook with avatar
curl -H "Content-Type: application/json" \
     -X POST \
     -d "$(jq -n \
       --arg content "$MESSAGE" \
       --arg username "0xM4dara's 3ye" \
       --arg avatar "$AVATAR_URL" \
       '{
         content: $content,
         username: $username,
         avatar_url: $avatar
       }')" \
     "$DISCORD_WEBHOOK"

echo "✅ Discord notification sent"
