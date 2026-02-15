Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D82D97AA
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152755; cv=none; b=qpXpZyfJdQUlx4nvH+HRxFGg0T9qXqL1tsJJk4WKLR2H2z2h7hcAhv7bfziCst17IyvkTHNIV2nekRW0L4gDiOEt2Pvl3Pw4fqe2/Kb52tHpSUzAy0OUgCAYejMOIwGDrRoQW2I2dfyGwq/9zU8Cl1/l3jEG8Jp+cW+kXsGCqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152755; c=relaxed/simple;
	bh=GoqhMJKhaJ1HZGtd8+mstOosyCtSnaRv6aqq7FIKLoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cinPgiiFPVR0CrAVUkdw55t/uS0nU7sQ9zawCWjf1/O5JOTCyLvRxP601tnKu1bfWpioGKa01g8aUe4wX3iTQOawwEFzZ5SQVeRSGsH4YU2BQNJipEluP06qow+3MLCfqoGhzlXG5b+9Kyw03g3e9UG72Yc0zhO7yajMPmuq+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMysdLQB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMysdLQB"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4377174e1ebso1621780f8f.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152752; x=1771757552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JsuwT0fFKTk/5Y4e+BUZmVtnwD4XLKYci9RQL+AL/4=;
        b=UMysdLQBV3hq0ZuCWODtS/RlmmS6+GheKlgncHHFIpJNitz/UlQKT/bEp++g33JR0q
         t9kg4Zd8pqSllGgchPrObwhDl2sxPA/oHGbJmIZNNwyBv32QlnQHW3HApOxYsiQaNiAA
         wOAt90UDhRSBejHE1XlSvO/6eZT/QSxHz7yALMx1yBZ/BlrS29j5hZM1TybBXw/J8NEU
         +F9lF6Qjy74oIUBSgHsfh86yZ6qTUzxEq6DV2hIkDpqrBPHTmPu6aou37fkIyRZX+WZu
         OjwqrW8WA/oZB+wQiAdVRCrMDHezIa+9hihShgjPmbRH42h/991G55M8dNtLAHnt+Ycx
         RcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152752; x=1771757552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5JsuwT0fFKTk/5Y4e+BUZmVtnwD4XLKYci9RQL+AL/4=;
        b=CmdU7dX6cRa6s9ROCKkrrszJtcryskUYrLTD4QLSfYeS1IXoWDSp8SqDXcR2cZR3yl
         ozXPOsp0kE6R8OHoYw9ow13XB9CsUxK/ZKVclUC8fkpwUY30LpFVaIMiqQY9goxCVUM7
         Of4A8lEbrheODo6hxVwYMkTp8WTU5vuhhe/7kQtYv+pRI1CPaDhPkoOBjm7p7OOIdqM7
         Yt2062woOQRa5j4IhEVCtBYg+sTiYpFtNf8EE9ikZIP4/NfEP3RJgrmO8EkaG+YbSoEz
         ihhJhXlhJjaRFQj5ywok8HJQKZhKvn5DlqCTssUMgLh8YW6psX6HmDiuFZaoA304Wq2Y
         70Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUCZ17UsatroMy0oCF7IAQYpCyWFP+Z+SNBzB8JA65WvmidJ88sIgyK4a7eMGDWsq/7m5Yyu/m+cDK0bIEAW9+eoF3PFmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUSvZLOFx7iwzIFZgmxnoA8T+4Th6snKKtpAJaIol3IiGe9RPc
	FLvS0U0y0y8W0fcqfcfiqzg2czFVPrIovQLUT3FWBq06vDA0dET0dYl+
X-Gm-Gg: AZuq6aLSLaq4VySCGMdYh50EPX+fia4DvKq8GDN5vLQV4j2oLURnTi6kfOK7AF+2ray
	RRwzWda5ngpOqdKiD8+feZwDrTqMu4EMOIyQVvYX7ujBclRNxe10WZNZ7XbMEN8/IcdpYLbUaeq
	SDnG5B92McluverAduhrrynIDsy5SFH69l6hGX24vaOAp4vv8HU1D3TQk3soAPQIv3TfiBHFwSK
	znS8c/XgOdhpIg43WTg5q0xLDmS3qfkYEPSRVHO5d3zbKY25Q64E6h8t8FeyNPX8SY7bVcMPHIk
	UD+ufxoQekMnXWsiSZ6jLQufimKCiuJJQah0siTO/6fFcH1MAvvRNaC4qvwbdjus7K+tdgE5hcx
	DPWcNQj1srcJjDM2DwKEeofSYiftQG4gmZlhivjq2yPor96v1euLQbygXid5oFF+COrYSnVeUps
	i7Ue4SIxs9KvCK0GK7nZg/VIlulqverAS72eKdFq+Is021ZIW0
X-Received: by 2002:a05:6000:1447:b0:435:8fd6:5949 with SMTP id ffacd0b85a97d-43797919068mr15171721f8f.46.1771152752220;
        Sun, 15 Feb 2026 02:52:32 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437969fd36dsm20044307f8f.0.2026.02.15.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:31 -0800 (PST)
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
Subject: [PATCH v5 1/9] lsm: Add LSM hook security_unix_find
Date: Sun, 15 Feb 2026 11:51:49 +0100
Message-ID: <20260215105158.28132-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215105158.28132-1-gnoack3000@gmail.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
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
 net/unix/af_unix.c            |  8 ++++++++
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 44 insertions(+)

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
index d0511225799b..369812b79dd8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1230,6 +1230,14 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	if (!sk)
 		goto path_put;
 
+	/*
+	 * We call the hook because we know that the inode is a socket and we
+	 * hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, sk, flags);
+	if (err)
+		goto sock_put;
+
 	err = -EPROTOTYPE;
 	if (sk->sk_type == type)
 		touch_atime(&path);
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
2.52.0

