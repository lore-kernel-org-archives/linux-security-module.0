Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991B17FAC2
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jan 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131848; cv=none; b=hWxVxbcyGqvh1ZBsS7DppeNT3YPhMDnu5lc969b7OoByCJu1eI0nWR3BePA0sD/4MR3zCgvY3E21RRzlqaOdz8FgUyVTTm/PH+RGlDR1j2LQAgRD2DyhEnu74+ACnvZ/cATL+PvZAZEeQBZ+R/9DAiop0Ct3uWrwDtJVJkUUjJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131848; c=relaxed/simple;
	bh=3jR9lpnCer8Ct9VHMHErwW3Ou+hGWTE2dUET4Wa225Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGRQP0beKCxNNls0izsYa4K5uXVJBEfHxGWu1QTN9M974KHg9+U8pZ4/8Xl/v7Tr99nUrdn4sqmupDQYvyGT52C8Y4YTM5qSpsUKmYmZkDc3c9RTzGyPwFPU/atEGnii0EbYuJcU39dGiGcGGVlqu2nat9yHR1cuilkXmItHpOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=Cp0ybS2+; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="Cp0ybS2+"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737131838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iePLVgHxEy9DkKuWgeAB/jEmJdl/6D85fhrUCW0v8NU=;
	b=Cp0ybS2+p8BXtloB6vkUGVsc3LUZQ+NCfHJpUQPJ0WKIPzuTVFG8+T2Bri15fHv68ovcPv
	jIYX7vNITBoagnFPvQw1JApb+OCXtWu4IRFn2gIP1aE49GAf3kear/zU8U5HegnxiPCZKK
	lUILOW852TnlVE4nDAci5X8eyE1stxc=
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] smack: dont compile ipv6 code unless ipv6 is configured
Date: Fri, 17 Jan 2025 19:36:42 +0300
Message-ID: <20250117163645.3069927-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I want to be sure that ipv6-specific code
is not compiled in kernel binaries
if ipv6 is not configured.

[1] was getting rid of "unused variable" warning, but,
with that, it also mandated compilation of a handful ipv6-
specific functions in ipv4-only kernel configurations:

smk_ipv6_localhost, smack_ipv6host_label, smk_ipv6_check.

Their compiled bodies are likely to be removed by compiler
from the resulting binary, but, to be on the safe side,
I remove them from the compiler view.

[1]
Fixes: 00720f0e7f28 ("smack: avoid unused 'sip' variable warning")

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack.h     |  6 ++++++
 security/smack/smack_lsm.c | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 4608b07607a3..c4d998972ba5 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -152,6 +152,7 @@ struct smk_net4addr {
 	struct smack_known	*smk_label;	/* label */
 };
 
+#if IS_ENABLED(CONFIG_IPV6)
 /*
  * An entry in the table identifying IPv6 hosts.
  */
@@ -162,7 +163,9 @@ struct smk_net6addr {
 	int			smk_masks;	/* mask size */
 	struct smack_known	*smk_label;	/* label */
 };
+#endif /* CONFIG_IPV6 */
 
+#ifdef SMACK_IPV6_PORT_LABELING
 /*
  * An entry in the table identifying ports.
  */
@@ -175,6 +178,7 @@ struct smk_port_label {
 	short			smk_sock_type;	/* Socket type */
 	short			smk_can_reuse;
 };
+#endif /* SMACK_IPV6_PORT_LABELING */
 
 struct smack_known_list_elem {
 	struct list_head	list;
@@ -315,7 +319,9 @@ extern struct smack_known smack_known_web;
 extern struct mutex	smack_known_lock;
 extern struct list_head smack_known_list;
 extern struct list_head smk_net4addr_list;
+#if IS_ENABLED(CONFIG_IPV6)
 extern struct list_head smk_net6addr_list;
+#endif /* CONFIG_IPV6 */
 
 extern struct mutex     smack_onlycap_lock;
 extern struct list_head smack_onlycap_list;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c3f8de53aefd..ce7d44509973 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2492,6 +2492,7 @@ static struct smack_known *smack_ipv4host_label(struct sockaddr_in *sip)
 	return NULL;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 /*
  * smk_ipv6_localhost - Check for local ipv6 host address
  * @sip: the address
@@ -2559,6 +2560,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
 
 	return NULL;
 }
+#endif /* CONFIG_IPV6 */
 
 /**
  * smack_netlbl_add - Set the secattr on a socket
@@ -2663,6 +2665,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 	return rc;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 /**
  * smk_ipv6_check - check Smack access
  * @subject: subject Smack label
@@ -2695,6 +2698,7 @@ static int smk_ipv6_check(struct smack_known *subject,
 	rc = smk_bu_note("IPv6 check", subject, object, MAY_WRITE, rc);
 	return rc;
 }
+#endif /* CONFIG_IPV6 */
 
 #ifdef SMACK_IPV6_PORT_LABELING
 /**
@@ -3027,7 +3031,9 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 		return 0;
 	if (addrlen < offsetofend(struct sockaddr, sa_family))
 		return 0;
-	if (IS_ENABLED(CONFIG_IPV6) && sap->sa_family == AF_INET6) {
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sap->sa_family == AF_INET6) {
 		struct sockaddr_in6 *sip = (struct sockaddr_in6 *)sap;
 		struct smack_known *rsp = NULL;
 
@@ -3047,6 +3053,8 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 
 		return rc;
 	}
+#endif /* CONFIG_IPV6 */
+
 	if (sap->sa_family != AF_INET || addrlen < sizeof(struct sockaddr_in))
 		return 0;
 	rc = smk_ipv4_check(sock->sk, (struct sockaddr_in *)sap);
-- 
2.43.0

