Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A777EC433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Oct 2021 14:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C9760EB6
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Oct 2021 14:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbhJKOoM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243759AbhJKOn7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Oct 2021 10:43:59 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88ABC0612EA;
        Mon, 11 Oct 2021 07:39:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mZwSF-0001fN-Sj; Mon, 11 Oct 2021 16:39:03 +0200
From:   Florian Westphal <fw@strlen.de>
To:     linux-security-module@vger.kernel.org
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [PATCH apparmor] apparmor: remove unneeded one-line hook wrappers
Date:   Mon, 11 Oct 2021 16:38:54 +0200
Message-Id: <20211011143854.17917-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use the common function directly.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 security/apparmor/lsm.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f72406fe1bf2..eafb44aa553a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1773,32 +1773,16 @@ static unsigned int apparmor_ip_postroute(void *priv,
 
 }
 
-static unsigned int apparmor_ipv4_postroute(void *priv,
-					    struct sk_buff *skb,
-					    const struct nf_hook_state *state)
-{
-	return apparmor_ip_postroute(priv, skb, state);
-}
-
-#if IS_ENABLED(CONFIG_IPV6)
-static unsigned int apparmor_ipv6_postroute(void *priv,
-					    struct sk_buff *skb,
-					    const struct nf_hook_state *state)
-{
-	return apparmor_ip_postroute(priv, skb, state);
-}
-#endif
-
 static const struct nf_hook_ops apparmor_nf_ops[] = {
 	{
-		.hook =         apparmor_ipv4_postroute,
+		.hook =         apparmor_ip_postroute,
 		.pf =           NFPROTO_IPV4,
 		.hooknum =      NF_INET_POST_ROUTING,
 		.priority =     NF_IP_PRI_SELINUX_FIRST,
 	},
 #if IS_ENABLED(CONFIG_IPV6)
 	{
-		.hook =         apparmor_ipv6_postroute,
+		.hook =         apparmor_ip_postroute,
 		.pf =           NFPROTO_IPV6,
 		.hooknum =      NF_INET_POST_ROUTING,
 		.priority =     NF_IP6_PRI_SELINUX_FIRST,
-- 
2.32.0

