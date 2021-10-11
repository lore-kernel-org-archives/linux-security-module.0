Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5DEC433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Oct 2021 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9160E60BD3
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Oct 2021 14:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbhJKOfb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbhJKOf3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Oct 2021 10:35:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35228C061570;
        Mon, 11 Oct 2021 07:33:29 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mZwMm-0001Z7-Ci; Mon, 11 Oct 2021 16:33:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [PATCH smack] smack: remove duplicated hook function
Date:   Mon, 11 Oct 2021 16:33:09 +0200
Message-Id: <20211011143309.17203-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

ipv4 and ipv6 hook functions are identical, remove one.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 patch targets next branch of
 git://github.com/cschaufler/smack-next.

 security/smack/smack_netfilter.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index fc7399b45373..a7ef2e2abc8a 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -18,27 +18,7 @@
 #include <net/net_namespace.h>
 #include "smack.h"
 
-#if IS_ENABLED(CONFIG_IPV6)
-
-static unsigned int smack_ipv6_output(void *priv,
-					struct sk_buff *skb,
-					const struct nf_hook_state *state)
-{
-	struct sock *sk = skb_to_full_sk(skb);
-	struct socket_smack *ssp;
-	struct smack_known *skp;
-
-	if (sk && sk->sk_security) {
-		ssp = sk->sk_security;
-		skp = ssp->smk_out;
-		skb->secmark = skp->smk_secid;
-	}
-
-	return NF_ACCEPT;
-}
-#endif	/* IPV6 */
-
-static unsigned int smack_ipv4_output(void *priv,
+static unsigned int smack_hook_output(void *priv,
 					struct sk_buff *skb,
 					const struct nf_hook_state *state)
 {
@@ -57,14 +37,14 @@ static unsigned int smack_ipv4_output(void *priv,
 
 static const struct nf_hook_ops smack_nf_ops[] = {
 	{
-		.hook =		smack_ipv4_output,
+		.hook =		smack_hook_output,
 		.pf =		NFPROTO_IPV4,
 		.hooknum =	NF_INET_LOCAL_OUT,
 		.priority =	NF_IP_PRI_SELINUX_FIRST,
 	},
 #if IS_ENABLED(CONFIG_IPV6)
 	{
-		.hook =		smack_ipv6_output,
+		.hook =		smack_hook_output,
 		.pf =		NFPROTO_IPV6,
 		.hooknum =	NF_INET_LOCAL_OUT,
 		.priority =	NF_IP6_PRI_SELINUX_FIRST,
-- 
2.32.0

