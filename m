Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E46C282CE
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FAC2171F
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDLLAS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:00:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59848 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfDLLAR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Apr 2019 07:00:17 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3CB00SU021127;
        Fri, 12 Apr 2019 20:00:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Fri, 12 Apr 2019 20:00:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank060157095162.bbtec.net [60.157.95.162])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3CAxsBP021068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Apr 2019 20:00:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 2/3] smack: Check address length before reading address family
Date:   Fri, 12 Apr 2019 19:59:35 +0900
Message-Id: <1555066776-9758-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

KMSAN will complain if valid address length passed to bind()/connect()/
sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.

Also, since smk_ipv6_port_label()/smack_netlabel_send()/
smack_ipv6host_label()/smk_ipv6_check()/smk_ipv6_port_check() are not
checking valid address length and/or address family, make sure we check
both. The minimal valid length in smack_socket_connect() is changed from
sizeof(struct sockaddr_in6) bytes to SIN6_LEN_RFC2133 bytes, for it seems
that Smack is not using "struct sockaddr_in6"->sin6_scope_id field.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/smack/smack_lsm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5c1613519d5a..4b59e4519e0c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2805,13 +2805,17 @@ static int smack_socket_socketpair(struct socket *socka,
  *
  * Records the label bound to a port.
  *
- * Returns 0
+ * Returns 0 on success, and error code otherwise
  */
 static int smack_socket_bind(struct socket *sock, struct sockaddr *address,
 				int addrlen)
 {
-	if (sock->sk != NULL && sock->sk->sk_family == PF_INET6)
+	if (sock->sk != NULL && sock->sk->sk_family == PF_INET6) {
+		if (addrlen < SIN6_LEN_RFC2133 ||
+		    address->sa_family != AF_INET6)
+			return -EINVAL;
 		smk_ipv6_port_label(sock, address);
+	}
 	return 0;
 }
 #endif /* SMACK_IPV6_PORT_LABELING */
@@ -2847,12 +2851,13 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 
 	switch (sock->sk->sk_family) {
 	case PF_INET:
-		if (addrlen < sizeof(struct sockaddr_in))
+		if (addrlen < sizeof(struct sockaddr_in) ||
+		    sap->sa_family != AF_INET)
 			return -EINVAL;
 		rc = smack_netlabel_send(sock->sk, (struct sockaddr_in *)sap);
 		break;
 	case PF_INET6:
-		if (addrlen < sizeof(struct sockaddr_in6))
+		if (addrlen < SIN6_LEN_RFC2133 || sap->sa_family != AF_INET6)
 			return -EINVAL;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		rsp = smack_ipv6host_label(sip);
@@ -3682,9 +3687,15 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	switch (sock->sk->sk_family) {
 	case AF_INET:
+		if (msg->msg_namelen < sizeof(struct sockaddr_in) ||
+		    sip->sin_family != AF_INET)
+			return -EINVAL;
 		rc = smack_netlabel_send(sock->sk, sip);
 		break;
 	case AF_INET6:
+		if (msg->msg_namelen < SIN6_LEN_RFC2133 ||
+		    sap->sin6_family != AF_INET6)
+			return -EINVAL;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		rsp = smack_ipv6host_label(sap);
 		if (rsp != NULL)
-- 
2.16.5

