Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A4C10F14
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E96D2083E
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDLLAS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:00:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59843 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfDLLAR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Apr 2019 07:00:17 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3CB009E021124;
        Fri, 12 Apr 2019 20:00:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Fri, 12 Apr 2019 20:00:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank060157095162.bbtec.net [60.157.95.162])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3CAxsBO021068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Apr 2019 20:00:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 1/3] selinux: Check address length before reading address family
Date:   Fri, 12 Apr 2019 19:59:34 +0900
Message-Id: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

KMSAN will complain if valid address length passed to bind()/connect() is
shorter than sizeof("struct sockaddr"->sa_family) bytes.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/selinux/hooks.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d5fdcb0d26fe..c61787b15f27 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4512,7 +4512,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		struct lsm_network_audit net = {0,};
 		struct sockaddr_in *addr4 = NULL;
 		struct sockaddr_in6 *addr6 = NULL;
-		u16 family_sa = address->sa_family;
+		u16 family_sa;
 		unsigned short snum;
 		u32 sid, node_perm;
 
@@ -4522,6 +4522,9 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		 * need to check address->sa_family as it is possible to have
 		 * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
 		 */
+		if (addrlen < offsetofend(struct sockaddr, sa_family))
+			return -EINVAL;
+		family_sa = address->sa_family;
 		switch (family_sa) {
 		case AF_UNSPEC:
 		case AF_INET:
@@ -4654,6 +4657,8 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		 * need to check address->sa_family as it is possible to have
 		 * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
 		 */
+		if (addrlen < offsetofend(struct sockaddr, sa_family))
+			return -EINVAL;
 		switch (address->sa_family) {
 		case AF_INET:
 			addr4 = (struct sockaddr_in *)address;
-- 
2.16.5

