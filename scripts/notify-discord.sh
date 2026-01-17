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

AVATAR_URL="https://cdn.discordapp.com/attachments/1462106915764047995/1462154294995452118/rinnegan.png?ex=696d28cd&is=696bd74d&hm=c56161d8260514c63f9fe699f8bf20e1348918a83fc991ab98b0491d82224e07&"

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
