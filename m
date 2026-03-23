Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594873C344E
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285091; cv=none; b=A775eIUw8nPa3wJKRqw1NTRZ/wGylErfkYSw1c83POGcDon+EDjsE1Qv0KKtnghAnBgCTwb7LU5XFIGqq+nguVQKJ1s68CYttuAerXCnK++CJwD9+dkx6OdV8hFuHWVIlhkinAwvUQ0tlIo+4tIXKbld/AdcGAraZ05mDkl+0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285091; c=relaxed/simple;
	bh=1R5QoRjpryjEmRKSu+GecPhvfAVUv2rQ3tJZWgcI/Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/cyXf3mFW001S6sbXCHM6DDAKFXnm4YH01PRBcBeLD/RlzHqTiBwGwQumeJXCzjCNX6PfIqmzXUubDHtrQwUWc8wWhvuU/LdwsgicnReB9V6AuGAHW9Alv7HzTNDRAawAAm33Ijl/SmvrqQ3mwpLG/H4We4WAfDIwd7CQlGTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WokUWn77; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WokUWn77"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so29124095e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774285089; x=1774889889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B00FySKCwug1nr/4nnc+9QuABBXvC6ZmF4Hl8lqc1Mc=;
        b=WokUWn77bNg4m3RJZ2v3v+14q9Ar4NcJTUCza8vlgLp0hb4ri1Iol4gwrKxlNvWm0n
         b1SNdbw3CpEgWhPQpe9YHixU/Ys3li5gahv7zM6dUBVqGblXrq+TGQ1kFqdmPHb1q34U
         JPahDYQeml6xVMVsde8T+YXfKNM/Hyv/6b7QP0cwo/MxaCM8VgLPjzBEQbnTMtPeZuy5
         b/wYD1o7IQAbLdvYVjSBct6jUzXtTPDOIzNtWbuRgu8OtaQNhwh77uT8v5s6zS8indEj
         uZALbpK0C2XCDrrnVx4bymsJ2pNs9qaXf8E7hvDUe//VT7OVFOd6Y/k35L3KEe2TdWcf
         zvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285089; x=1774889889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B00FySKCwug1nr/4nnc+9QuABBXvC6ZmF4Hl8lqc1Mc=;
        b=e6hKEIzcR21yqySHPV5GTvZRsPMy5e7FIgNBomgBN33GZEe9me9qlZzHf0f6+/PEde
         7HfAjDg/TXB7MFGMGb1ebct2NwdxW+WvSAfXOuy0kM1lrvyFZlZwCMtBHZPZpZ2LCI2b
         2spZqhJDILjVWE3ug3GZjaZKuzPyxfXP/zePU/d3/sewj1BTVOlSegGu9wK0ufcxKDnq
         6zoR30EJN3u3hPkpmyzB+EpkyY8csdsqxlr/Rix4dZ5EVn2QsSYj8w8Kxi/LPFn+cd6b
         6bGFF8fSEidaVRKwyQFEjBfqhetMNuj58NNvRtg44+jA4/BXiYH2uZk85NpQGQls1YD4
         j+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW+AajhRCmgMaeA+IGGi4tkbnnAE1AvZwUaqp0qa7sH32GMG/YxD4S2iXXMRKeCCkkiycUrKy39Vbk+MTrhgFhZb4eh3jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwliPhde82n4P9U4IOSRuLr76BB/nH93Au5onO4NrrXSENHmnPJ
	1rcmsS5pURRHw9KUPa1yOV09d9se1+ugnjrMqzeV9YkCq+s+W0UezT73
X-Gm-Gg: ATEYQzyOUclBhMSq5Sl93gZjXkZmOv33n9Q2ohpoVO7ITQ+g+HsimTy5BIhoEOcuKyE
	Mx5SfbkZtpAM49LVyS+QcSCQ8HpMMcumsr3cQ+IVQs0eqCW1UcqYLllzTH0gnkebIlgj+whObZG
	09pAD5sVKcOsJjzbG/4cpQdB4zwCWhjcoeGGebunYW1L6/xQvXY5EjplX+ShEwYG6ENEYlS7ORJ
	eYCJWDSPGjnIpX5A306MRLAz7R5kM/8hAwr+6tsa7xpy3N/CCuAD3y5YGIRmVYz//fVZu2sZueA
	hCNVX3wvQq8WA0T3zomLsHmwgg+acniVrO/zNmLbV8Q1pb3WwRRKRkjp//dfT/lC4pMwkWniW6c
	kiI3COgQaQUDZ338jKakaio+zvijdaaCLPAU0fkVit9SBZTJhTniGN8tRxaOBkhh7KK/ytq4kPK
	TqKkdFcJ+jihyKUOrtuxqcUSnq7CZDuIYcCFzgqppKwoD47s+M
X-Received: by 2002:a05:600c:45c5:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-486febbc74dmr180324395e9.5.1774285088614;
        Mon, 23 Mar 2026 09:58:08 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487004e7bc4sm120537085e9.2.2026.03.23.09.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:08 -0700 (PDT)
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
Subject: [PATCH v7 01/11] lsm: Add LSM hook security_unix_find
Date: Mon, 23 Mar 2026 17:56:43 +0100
Message-ID: <20260323165654.193957-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165654.193957-1-gnoack3000@gmail.com>
References: <20260323165654.193957-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Justin Suess <utilityemal77@gmail.com>

Add an LSM hook security_unix_find.

This hook is called to check the path of a named UNIX socket before a
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

Consumers of the hook wishing to reference @other are responsible
for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
therein, ensuring the socket hasn't died since lookup.

Cc: Günther Noack <gnoack3000@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/linux/lsm_hook_defs.h |  5 +++++
 include/linux/security.h      | 11 +++++++++++
 net/unix/af_unix.c            | 10 +++++++---
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 43 insertions(+), 3 deletions(-)

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
index 3756a93dc63a..5ef3c2e31757 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1231,11 +1231,15 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 		goto path_put;
 
 	err = -EPROTOTYPE;
-	if (sk->sk_type == type)
-		touch_atime(&path);
-	else
+	if (sk->sk_type != type)
 		goto sock_put;
 
+	err = security_unix_find(&path, sk, flags);
+	if (err)
+		goto sock_put;
+
+	touch_atime(&path);
+
 	path_put(&path);
 
 	return sk;
diff --git a/security/security.c b/security/security.c
index 67af9228c4e9..28ccea205874 100644
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
+ * AF_UNIX socket. The caller does not hold any locks on @other.
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

