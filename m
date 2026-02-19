Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23612DEA9D
	for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531542; cv=none; b=nspA9av0fzLlBe8bhZB0AQD58aRCfGRyO/TT/pfgE53oAd0REy8GWP65TD5CkJz1VnN9hFGFvCJsqqKWmgmxjUNSEGHEtRVRKTn/YLV0MFaqgcM6qbSMMs2rxYpYaCyuO9YtR1Wskcq7lVmSbv6fvV2jyjLHLe0eeSaewTIFH4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531542; c=relaxed/simple;
	bh=WQyPCMu2/LVxP1HRKmCCZGdKwmRzWEn+99ptBGf9kFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJSK1ICcq05Y9tM+3okL3DtMR5+hy955tESKCOzZuGxOHu7o3kD5I0A02A53RjLbGMTw9q32G4fJzKlLvCl4z+ZHZD58ohx9jCbAsKFyyK205zo+TI8s0XA8ZdlUIKT0U3xBijqE6uWQRGiRD39Q6BNY9Xw+mCTIQ/GBMWGkZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuS+4c3G; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuS+4c3G"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ad62a294bso1336896d50.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771531539; x=1772136339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i/0wTnFIm7HfE0FOOWnlBqJyTOzDQHrvyvLNh6JIe4=;
        b=CuS+4c3GjbnXeolZKsGMH36GQxpWc/g+jwVRHrSyvmGTbbZqp/tKlLrHsNogwvn2zX
         iX9vbck7mxdF2d5DQ2q1d8kLqSxnA6oHpoEYrmOfjz2S/4ayv1gkSF0BPupNpegdyibz
         VN4CA2/VApttCIsvXeslfnAcpHDjncDjaXWOBdgk3N4C25Dx2J2tSSziqYDdGVN8yHYR
         qpSqpdQi+6OUi2HrpE0FqYq8Zg6SgPRtTfrHMluqJI1bLfBQVIJHrAriV94tRlK5QuZg
         bEGtDQutvVKkxwJNt6loklSjlMSoXYyrQS2hXiL/2j3neADa43uouYXVwWB6Cak1BKvR
         SAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771531539; x=1772136339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9i/0wTnFIm7HfE0FOOWnlBqJyTOzDQHrvyvLNh6JIe4=;
        b=RwahZXhSVI+5peXwFfVAYw66+jrSxD7lgP0mr3S22GYgcbcaMOIIiWzgwN+bZt870+
         SvTqVDNKVJx2GYGBIRvZmu+T521/LkTA3WsNZuzY6mlDF+y7irm7aFts3yTBbgftltv/
         F07tSDbUjMYGzs6tLsAl9EV5vgbThaGcGdsuPkeZNXiODYyO/FWortbQ0utdAQTfxuDk
         muhWTb+UO2ZZKuee9VvydcgkHxOwZvJ9F8QXlQL7ZIdIzEMPlt1UD/23Ww6UOQA/z3Ks
         5G0eO5Naofbz//kMROYXRgG+B+FECkXpc5bKpRllPoDbgNqEa3DLi8A/ZhVe9oYJUC1F
         mwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx0Hgd0DhxHnhdnIS/zkS9ViidODwFdWr25uFpLXL+TK9UZBU94B+efI2dAZAKo77sRAv0srk9sfDIQ2abrsjJKLjSWKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEmvwSCyqkKCl/wb5k+ORpIrw69YrDkL3lkysuvR9rq5plgIN
	BysUXB2cCTKidwmOuM0q11f7EumCJ72NvR0EGcKZUa+lxQ8kQwVoeCwM
X-Gm-Gg: AZuq6aKFbHl1pjsZCUoP5voHIWUEywbsxvOV6amMSM/DdvvjXBrTm8Qgg+Z6V1Mdwxj
	PbJ0tpSaVugiAujyXtua+rrxaY+W/Z3stRNuUotn20oJKeEMzzpZJj6AMwdTW9Tq1jlNDL8pX8f
	1eean1PwioTZ9ansdmYhS9BoPOJAmfpevWmyO+Mhd3qLkmCsvTAc5sFYKCBh4P/Cl2strUVTxGq
	ZqxaPCd5XW0eYy4XoJahCtT3vNXQkEZpsqGGPm/1+GwkR1zaFcrN08XOYwPfsezyuLmpzPwVVT3
	ULvaXM2HKa1Ubl/xfYFsL2lFbhS3KhxW0vzPKVUT8FPaJkseleEGXGPyuGiofr43jtk17XvLa8G
	BMBQmq+7Kvx3y2dGQwlr7W3RIstYuW1ffuOhXWvlXj2y49oFV98WuUfgzp1Kk+WoYWNdQhD+h80
	OdzSgD5WTdYcFmyeADIH+8aKNwYz0S
X-Received: by 2002:a05:690e:16a0:b0:64a:f3fa:af58 with SMTP id 956f58d0204a3-64c21a43cf9mr15905823d50.17.1771531538628;
        Thu, 19 Feb 2026 12:05:38 -0800 (PST)
Received: from suesslenovo ([129.222.84.220])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e73125sm7292264d50.4.2026.02.19.12.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:05:38 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: utilityemal77@gmail.com
Cc: brauner@kernel.org,
	demiobenour@gmail.com,
	fahimitahera@gmail.com,
	gnoack3000@gmail.com,
	hi@alyssa.is,
	horms@kernel.org,
	ivanov.mikhail1@huawei-partners.com,
	jannh@google.com,
	jmorris@namei.org,
	john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	matthieu@buffet.re,
	mic@digikod.net,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	samasth.norway.ananda@oracle.com,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v6] lsm: Add LSM hook security_unix_find
Date: Thu, 19 Feb 2026 15:04:59 -0500
Message-ID: <20260219200459.1474232-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aZcPd3OKqxwCZV-5@suesslenovo>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index f6d56e70c7a2..41698460194b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1231,10 +1231,17 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 		goto path_put;
 
 	err = -EPROTOTYPE;
-	if (sk->sk_type == type)
-		touch_atime(&path);
-	else
+	if (sk->sk_type != type)
+		goto sock_put;
+
+	/*
+	 * We call the hook because we know that the inode is a socket and we
+	 * hold a valid reference to it via the path.
+	 */
+	err = security_unix_find(&path, sk, flags);
+	if (err)
 		goto sock_put;
+	touch_atime(&path);
 
 	path_put(&path);
 
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

