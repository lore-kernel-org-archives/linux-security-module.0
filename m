Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DF19F127
	for <linux-security-module@vger.kernel.org>; Mon, 21 Apr 2025 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745275997; cv=none; b=OFDds1y3lyVJSQmyKIYN+88oKBLS2oxucMrrzmFFkzir1yB1o4+ENZANo54ly1ICMEy1oR1SqAl5CRjNpyRnHvY7ggTQFYvELXV0HZI5PKw9OXvf7tpDTfe/J2wW7tu8QUXaS79repgb+Uj2a+Zyc1RmWY0D46T3Tu+/DYaWGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745275997; c=relaxed/simple;
	bh=e2Pw7ojxkDIC5p9uswMLzqK7nsMw6fRib6LcsHnG5Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USJsp7vzx7EmZ8mbDFYpBQUd1JELOZBiRHFBxIEHJhLpd71+Iitv8eEX1dvLAJv1rz6FGz1lBzrl2DPFqyRxh1O8xylnWtBnmUNTY4i0rC7uDAU2wdSSfVzETqMuAPkLwfjB85Wty5ZrGdQ+Lz0FQyS1KkOhB+C58ZPmgkMzqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGHEbiIm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGHEbiIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164BDC4CEEC;
	Mon, 21 Apr 2025 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745275996;
	bh=e2Pw7ojxkDIC5p9uswMLzqK7nsMw6fRib6LcsHnG5Nc=;
	h=From:To:Cc:Subject:Date:From;
	b=cGHEbiIm7Y2s/urAvLIwXVfr/mOVQU+2hUi/YfUQSaMl2vjATPn/zwECHnti4KvrS
	 ugpMUBw+KsVDt6o7B9i10dB2I4ON24AEygy5uUZcF81SDobpZDZUW+PSEViJ5qNV2R
	 LxWjXxQ71xHhj4GKE9WMQ3n80vDEeHOnpgL8DmrsrHU57q8HrJDDnIX/tFxxHZdtDY
	 tpzUyoKmEzF8KTzEp/kJVv+FvdCivY8ql1SyghrdJbXw6zhbPuztrcCWLHQaaU+Un+
	 LsjCx+CSqslQGk0OKXU0VPxz1GDqjVYX3OQVQxp0LM98QdYr8+b7OM11VhtiZr+WQP
	 r3y8rF7t6S+uA==
From: Song Liu <song@kernel.org>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH] lsm: Move security_netlink_send to under CONFIG_SECURITY_NETWORK
Date: Mon, 21 Apr 2025 15:52:50 -0700
Message-ID: <20250421225250.2544754-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

security_netlink_send() is a networking hook, so it fits better under
CONFIG_SECURITY_NETWORK.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/security.h | 12 ++++++------
 security/security.c      | 36 ++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 25811836afb7..6a09318e2bf9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -563,7 +563,6 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
-int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, struct lsm_context *cp);
 int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp);
@@ -1527,11 +1526,6 @@ static inline int security_setprocattr(int lsmid, char *name, void *value,
 	return -EINVAL;
 }
 
-static inline int security_netlink_send(struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
 static inline int security_ismaclabel(const char *name)
 {
 	return 0;
@@ -1629,6 +1623,7 @@ static inline int security_watch_key(struct key *key)
 
 #ifdef CONFIG_SECURITY_NETWORK
 
+int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
 int security_unix_may_send(struct socket *sock,  struct socket *other);
 int security_socket_create(int family, int type, int protocol, int kern);
@@ -1684,6 +1679,11 @@ int security_sctp_assoc_established(struct sctp_association *asoc,
 int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk);
 
 #else	/* CONFIG_SECURITY_NETWORK */
+static inline int security_netlink_send(struct sock *sk, struct sk_buff *skb)
+{
+	return 0;
+}
+
 static inline int security_unix_stream_connect(struct sock *sock,
 					       struct sock *other,
 					       struct sock *newsk)
diff --git a/security/security.c b/security/security.c
index dbfe95eb3064..0193bf8f1dae 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4274,24 +4274,6 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
 	return LSM_RET_DEFAULT(setprocattr);
 }
 
-/**
- * security_netlink_send() - Save info and check if netlink sending is allowed
- * @sk: sending socket
- * @skb: netlink message
- *
- * Save security information for a netlink message so that permission checking
- * can be performed when the message is processed.  The security information
- * can be saved using the eff_cap field of the netlink_skb_parms structure.
- * Also may be used to provide fine grained control over message transmission.
- *
- * Return: Returns 0 if the information was successfully saved and message is
- *         allowed to be transmitted.
- */
-int security_netlink_send(struct sock *sk, struct sk_buff *skb)
-{
-	return call_int_hook(netlink_send, sk, skb);
-}
-
 /**
  * security_ismaclabel() - Check if the named attribute is a MAC label
  * @name: full extended attribute name
@@ -4481,6 +4463,24 @@ int security_watch_key(struct key *key)
 #endif /* CONFIG_KEY_NOTIFICATIONS */
 
 #ifdef CONFIG_SECURITY_NETWORK
+/**
+ * security_netlink_send() - Save info and check if netlink sending is allowed
+ * @sk: sending socket
+ * @skb: netlink message
+ *
+ * Save security information for a netlink message so that permission checking
+ * can be performed when the message is processed.  The security information
+ * can be saved using the eff_cap field of the netlink_skb_parms structure.
+ * Also may be used to provide fine grained control over message transmission.
+ *
+ * Return: Returns 0 if the information was successfully saved and message is
+ *         allowed to be transmitted.
+ */
+int security_netlink_send(struct sock *sk, struct sk_buff *skb)
+{
+	return call_int_hook(netlink_send, sk, skb);
+}
+
 /**
  * security_unix_stream_connect() - Check if a AF_UNIX stream is allowed
  * @sock: originating sock
-- 
2.47.1

