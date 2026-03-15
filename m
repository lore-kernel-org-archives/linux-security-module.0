Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDE30B535
	for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773613374; cv=none; b=CPIvB9MhHYyhzwTnP7imjcBK0Qd6G7HB87aQv6knHfdu1z7Is3fNa7t9KiVr05x9la9r/46T0cxcuOKObOzcrHnLkpHA8yB2TeYvOqS44j6aRzmkf0afbJkywNhtFOM0XenQScMgB2BgcVRO0D0PzE0udVOIYT8/q+TtiUxjVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773613374; c=relaxed/simple;
	bh=a5clCKlVVaQsoPp19uxbvBmg6L1SRgS0j6aD/5JG0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwUndJw+D6AJJqt5CUZDEORrVXZVyfbHwtXhC6FaHpQaodBfCkqFiHVqNqwukeZD7YGLuh2sKHM0Pm3gKqguBMasfjJxWqWX/CbrZbNpniaFQxU0h97jQm4ApvoT9O8rKCzJafhd3EACyDvijmkBP8dR3yClzcO8sXSClPuQ4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWfANPRz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWfANPRz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48540355459so35779665e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 15:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773613371; x=1774218171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vYb8zk77RJeTsnuwNyjP2YHLld02/2ZSGp8Cefi3f4=;
        b=hWfANPRzVQwHvuEGVysRPXAOjzMgqW+cED4k4G1hceQZSNSIC0GzYYRjPlO7VOjwTY
         7bEfvxxFc/fTFMUHl16/zmES+LG7ayuIIIv/pettHZ/8JUPzsyRZFZvNh8PO9lXEIx3S
         gJbQuXtOV/QcKmj8qmBSAy0WqLGC95A9jmZCr4sXL+hZ9U0hxa7upC9BwR8OblniJXi6
         S/E2alp2GBMGTUEPWPm1CRA/2hgkUIk/SMDf92xiYGOHNILC3Rx6p4k0/K91iCLGyEFJ
         3ZxL2vpAW1HVthr6IlgAkTn+Ohofv9HpkLZW6yys5x96oYN21eciXkJzD+ejQ0lJ+t0p
         fsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773613371; x=1774218171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vYb8zk77RJeTsnuwNyjP2YHLld02/2ZSGp8Cefi3f4=;
        b=m2UDUz8k1GhTLDVXl1zn9QINrU/i9/9dekC6gRPEn9Gk+0kC4sCSijy3o1FKuI3mob
         KnSdCl/djeUw9Rx+xx6W1FCvIP8Zb8wOn4NumP0oPONgpJKPIOLYPurGL/qC+/qh03k/
         34zX1yt+1wPJ/MlkB8G9ork+Ln9X6ludYBmw+17RzHtNJtXT/znAMHhIxY+cGVMdoAJW
         sBJ6NLOlDeP73mRZZ4ykXTwDwwRa1Jd3UJynfZXkBqGvE4CrStHx1GNNEpIfVee2H8F3
         T6jPts6eu/B/HZUbB9v99TSk/20f1SrLZiEZobMRk7nKCjzPnJonr2Uxu4emWwANzzg3
         MxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi1I6MOIqchEEKsJK7UAT3Fw06cSS6nMvcrILoMuNuG0Ucu9ztkhpiz3Eg4v+MtOgxQ0pAyuLlRpMQ11WLSti2X14E+YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnPLlkJaH/1tDr2eG0Ri6hjkyYdpCoUnxpyghKWfk12Lmmd0b
	fNaKOhe7lRr8DxmEH4Ghcz+UsGqUj0yi/zaHUkwfg/b/W/dGezmQa7Xm
X-Gm-Gg: ATEYQzyYGPIuEFYCZvITTSNv6C3I7XnahpAIkubTXydo9PGOIDbyUdz8LtxGwoOnG0f
	GtNSKpSlRkdVlla0PJxK+u722ChUyVsxQNydPP12U8ACrsf193DnrU4vr9i4skOacvrtFKz/6u/
	Wzuj7Pi0TlmIX3p3HFef6tpUXstWg+3EhIbQaACn6M25E8floUowESzb9Mnho9OJh+OFoyr+xIY
	g5j0XOuJKbc08GcMLA3emgKGv2C4KaGobSc0xE4oLBTxdzWf96oY7gNxz1d0c588SGLaNH7GSng
	QjpymyaYPivGDJzT0ctbsWYss6OuWEh9CqfPDfJNVkzCO7xeC/6351+tskPWJaANhvEFdIAYMAO
	Vn7LVICBnii5NnvTx6CHwRSRuMTkYoSVV27Fap1xC9fuL3NftoJJmRDt2ysnY98uhhrEzStdg/L
	5EM2lvgpJU1jqz6UXD7BaR47ocdTpJ+DUrwyfTR5JMRNf9LCMD
X-Received: by 2002:a05:600c:3b14:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-485566d94afmr156892115e9.13.1773613371161;
        Sun, 15 Mar 2026 15:22:51 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6e25bsm74817505e9.27.2026.03.15.15.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:22:50 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>,
	"Paul Moore" <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
Date: Sun, 15 Mar 2026 23:21:42 +0100
Message-ID: <20260315222150.121952-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315222150.121952-1-gnoack3000@gmail.com>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Justin Suess <utilityemal77@gmail.com>

Add a LSM hook security_unix_find.

This hook is called to check the path of a named unix socket before a
connection is initiated. The peer socket may be inspected as well.

Why existing hooks are unsuitable:

Existing socket hooks, security_unix_stream_connect(),
security_unix_may_send(), and security_socket_connect() don't provide
TOCTOU-free / namespace independent access to the paths of sockets.

(1) We cannot resolve the path from the struct sockaddr in existing hooks.
This requires another path lookup. A change in the path between the
two lookups will cause a TOCTOU bug.

(2) We cannot use the struct path from the listening socket, because it
may be bound to a path in a different namespace than the caller,
resulting in a path that cannot be referenced at policy creation time.

Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/linux/lsm_hook_defs.h |  5 +++++
 include/linux/security.h      | 11 +++++++++++
 net/unix/af_unix.c            | 13 ++++++++++---
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..7a0fd3dbfa29 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -317,6 +317,11 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
 LSM_HOOK(int, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
+	 int flags)
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..99a33d8eb28d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+
+int security_unix_find(const struct path *path, struct sock *other, int flags);
+
+#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
 int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3756a93dc63a..aced28179bac 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1231,11 +1231,18 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 		goto path_put;
 
 	err = -EPROTOTYPE;
-	if (sk->sk_type == type)
-		touch_atime(&path);
-	else
+	if (sk->sk_type != type)
 		goto sock_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket and we
+	 * hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, sk, flags);
+	if (err)
+		goto sock_put;
+	touch_atime(&path);
+
 	path_put(&path);
 
 	return sk;
diff --git a/security/security.c b/security/security.c
index 67af9228c4e9..c73196b8db4b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+/**
+ * security_unix_find() - Check if a named AF_UNIX socket can connect
+ * @path: path of the socket being connected to
+ * @other: peer sock
+ * @flags: flags associated with the socket
+ *
+ * This hook is called to check permissions before connecting to a named
+ * AF_UNIX socket.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_unix_find(const struct path *path, struct sock *other, int flags)
+{
+	return call_int_hook(unix_find, path, other, flags);
+}
+EXPORT_SYMBOL(security_unix_find);
+
+#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 /**
  * security_ib_pkey_access() - Check if access to an IB pkey is allowed
-- 
2.53.0

