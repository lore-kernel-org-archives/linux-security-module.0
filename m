Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A41CBEB9
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592281; cv=none; b=Ny6GeMJwObXR/VdvIGS+0nJyouhgpP27Xg9H/318710alQ0Hgp6PfM9YrNbmeIf9SzPbk2Lq5DT70xV44DMJE9RbcxuncF3Qzb/IAn8P0sCi2RomXINF6NBbSJMwaLYdQpw5vaGpmCq2NZKoxCcoaz4M8j0X8o2f3JWYZLHtqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592281; c=relaxed/simple;
	bh=cNt5CUg+QKY5vJPuqYDNNo/2PhXuTN/ysasTKNiRRjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uns1CQrW7TXgwmJPKB2hQMe4W+k7gzbPFuUUZmLc5Kv8wazuMiZKlguWyUNeNXtawbQmwyw9RKDkk73kihZlzwqocCCt0kOgiqh06tAUACX2C81DsVl2O4oXEj6JK4MapTgq85ah1ft/1mQyUJRIZAG2EUaC0KHmCY0/6PWc5lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNvttg/N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNvttg/N"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48068127f00so35397155e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770592280; x=1771197080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOB4dYixsjnFCU7RCtCj08R/1mgwYw7mAEm9A45N/uY=;
        b=UNvttg/N1a+zZbozh8XhzU0IJYblaRiQP6rGmEqHxF3Wvgn+P2W1DQhtqkYnHNbqgb
         hlD2BMVbthaR12mPWHL5YVfkte7VZTHOyBDI0fL5RP5mnCNvBPkf85B9jmUuGB01PwsD
         YfSbGVV2BnwllCHIZSbjC2FFzR9qYBAnAXqj/5/QAlkshyyiBN1ocDrDScDAx5GuKeZ4
         /xHTVKMvT5fJ4+VsRSAlq57RRGhWyDX9MUMJ92i34sKQp0zPxslP/qOZA3HzEJA8UNgC
         AiSNTFbuU46LtVIA5WEzPUEOWPq4FduMeSRIwFRkhC+eHws3WRtLT99Duzcw3LKZEKlg
         UNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592280; x=1771197080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pOB4dYixsjnFCU7RCtCj08R/1mgwYw7mAEm9A45N/uY=;
        b=bmVvjBl6xBizJDH+TVZxuwDWwsWugqWiOkvX5/gk6igfbhy1XAxyH2qZ30A9zCmnfJ
         S0ue9ErWsqIE1yylDK6OgNgdOEU0KL0NYbKd1mSrfRMS5BRtVg1QtSeWQni8geT1kUon
         UJkS9d9J02nEGZZcLhqM6+wwWbS4rdyM50u/3rLGjyRSxTB1UOyD0bADV/AsvbydvbXf
         Qd63xBG4He9pT0zu7GupcWzmfmIhoPpkCWWlfbU9fVPkNVcv6hXNG9JT1Wga5nwSYHDJ
         JksMyDM9AGqHCzzTfn0xHtnMGqROtNGpD95ehWjYJ8ETSc5lPxb2FhCMAAmcpchj0FlQ
         dzGA==
X-Forwarded-Encrypted: i=1; AJvYcCUV79APrxUfAG9YzMGoUzyim+L17I/jf12u9zcKE0rG4ZfrZ6vv8Ioowv3Uv9ue1uHkfG31hQyW6kHJZsMRJ2KQfwz4kYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3F23sZom+qCHhBllMqZ9/IEOZcvBoKH8kMQjHJnMxrFdbMCL
	hHYXDrRPY1PqgiaV/yVZ1QZ8J3JE/HbBxhQn7P7qH1/jrdJjHuMtIBnZ
X-Gm-Gg: AZuq6aJ2/EiltyUI+Nxv0vl5nVnPNWivQJQmb9lz0bEfZFCKTIiKS8WdbT48QYhbF59
	JPGfEv0v77cmVrM6HU4k9EhrCDINWAq2qJqL9g4CLtNL5dj351id0FQ7NPOi3JEfrhMsTNmfTlu
	645GA90b1EZIg3AXotzt+7viPJzNEK+7pio/3dqleZJZDrbTldWOm1AqnREyUtwPzDJDUS9Gi+w
	CMiKmhDqiy/5xon17BrEgtKbwnD3L1GUujxZH+BYO0Kg4qiF7pyuXlyI2hpO87WRhJ5Kw7vvzpH
	JCvE8n01z9Yq3EKOLmcPLhVYuZnjlnqT/1X8wpf+VDulK4jENCFLv6BNOjfNT2eHU8xH+jgP+AG
	0Lct+GYPb/UQLSv3FS5ljWq5U0UlqjvodCey1whxQmFxH59uRIyU4AYdqd5b18mODqziP33y/Ma
	ZpoxiTEoTLY0ZZvFvdxlReXDH1mRvT6iP/zRvr
X-Received: by 2002:a05:600c:8b56:b0:480:3bba:1ca9 with SMTP id 5b1f17b1804b1-483201fff35mr127058665e9.4.1770592279741;
        Sun, 08 Feb 2026 15:11:19 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c0296dsm200490325e9.1.2026.02.08.15.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:11:19 -0800 (PST)
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
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 1/6] lsm: Add LSM hook security_unix_find
Date: Mon,  9 Feb 2026 00:10:11 +0100
Message-ID: <20260208231017.114343-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208231017.114343-1-gnoack3000@gmail.com>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
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
 net/unix/af_unix.c            |  9 +++++++++
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 45 insertions(+)

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
index d0511225799b..db9d279b3883 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1226,10 +1226,19 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	if (!S_ISSOCK(inode->i_mode))
 		goto path_put;
 
+	err = -ECONNREFUSED;
 	sk = unix_find_socket_byinode(inode);
 	if (!sk)
 		goto path_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket
+	 * and we hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, sk, flags);
+	if (err)
+		goto sock_put;
+
 	err = -EPROTOTYPE;
 	if (sk->sk_type == type)
 		touch_atime(&path);
diff --git a/security/security.c b/security/security.c
index 31a688650601..9e9515955098 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
+/*
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
2.52.0

