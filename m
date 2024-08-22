Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478551CB14A;
	Thu, 22 Aug 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332556; cv=none; b=T0kzA9ylKrJQmg2QIh2OCRaEcWPHscWyGwLr01weVDdQCvqG+rLriRBJjALIa/xgeuYzXOC2faOniSxAGQ+CV37aqUXIAF1uvAGRFvlPpsla8ymXZ+KhyQ49BqfaG2hvlKMPvtU4vKlAQRSYcIl1ICUbSNmIhAlNz29qJKN5KfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332556; c=relaxed/simple;
	bh=shBXYRqMx0IAfmMpg2wQxeQLtHqZY5+uN391kqnTO3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9+Ezc/C7/ac1JBiAr16h6+G7ZwPz/g2ZRq8vAOQYg1izuZn6QMQdp+QvaS2wPAzAa6qAV7RVXNgKOc2hS1ScB11JJedRzNqr5eejUfSw8+v5d4FaZGXRsO0jFNNDJ8GQCVW5u8HJdMOPDV2Q+Y2p1TAa3jyEqS0icdahsiM5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMXMdHmi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMXMdHmi"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso7754171fa.2;
        Thu, 22 Aug 2024 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724332552; x=1724937352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6gdj/0hP+mZgd6u8VFFrAhOgItw0v7uJFK6VqA6SLE=;
        b=ZMXMdHmiY3elAMguHL2ls3EtL3npT3IfR8LpN2atybi8n+gVQi+rOTk46wj4VgDg01
         1Tru5aE8fRg9hMfUwCT01PaIAZDzlOGNcEb8rJBUK6oi+KFFMuaFTXNs2ojdo9G1WVto
         l+8yoKv+plosE59ILbI6U89zHcNjk+fGMqqLgVIdc7zsO1eZij09pPeaS9Xc5Mrmnu6v
         LyhIRv1/z9YeAo9J7YlmibIWABFtlYt6jmCuT6IfP9Hv1G65/wP/d8i0lffd+r9CoL+3
         m6MWXIWBm8xUI7MdTt1xzFiY9ZEUvmVxzNh15Ipvu3HVArkbnIJgkhzIt0PCBRDjo31z
         lhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724332552; x=1724937352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6gdj/0hP+mZgd6u8VFFrAhOgItw0v7uJFK6VqA6SLE=;
        b=AZAWn12Rxvghs+SIkAyXNAqTWxcnUZ8OuHxGLuVwOjD3xF5Tit9MlOCt3kkda2HPfD
         d3tKGS+h9Y5RGG6u0BQwoQ14+Ik6tUn5utMb0dLJCFggyYRQanH6X+K4xVHYfWnxKswN
         bI/QMbugnXBALZ7q6YpUc+ExIAQ/PrOEYwKGKn5TWmR9Y/TxLDRjzOuyVvg6iYG+e7zQ
         X5g7wNkDDAOskoRZhgoNoOByK7u07qubruRpJAyG+eMEnMhjd339eOCXeEdN4pAQP+G7
         YX6IFoBO42Ogkuuhe/LhXrg2KK7r5jMRCSTGF9Q7K+jVNnF8jZr22ZV3p0UmCOZMw7Ah
         hi4g==
X-Forwarded-Encrypted: i=1; AJvYcCXo2Klw41eJQFNO41T1Fl6NNIYDh1L6BKjXjkv+Ls/6k7AMG2VVJ9syXW8C+4tqh3pcLoMlR7HRgI8/iVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LXv3n1BnKlr06ZrchCpvqZVVby5Ve6l3NbYyJBjKZ61n//QY
	fUGeSTOAM0b24K5opT/zt4pC0sWvIfAJMb3Aati/IaHrIo3PPXcGB3pFFZZ1
X-Google-Smtp-Source: AGHT+IHvpnRh4MEQc506ZZstwf+9J9oXOoIFS3485d8YKvY/RjnFOk6N6jiuq1nTQBYmICpM2vLTdQ==
X-Received: by 2002:a2e:3c08:0:b0:2f3:f82d:bb21 with SMTP id 38308e7fff4ca-2f3f89191dbmr34811891fa.29.1724332551849;
        Thu, 22 Aug 2024 06:15:51 -0700 (PDT)
Received: from f.. (cst-prg-86-203.cust.vodafone.cz. [46.135.86.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a961esm904010a12.83.2024.08.22.06.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:15:51 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org,
	paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RESEND PATCH] cred: separate the refcount from frequently read fields
Date: Thu, 22 Aug 2024 15:15:41 +0200
Message-ID: <20240822131542.785546-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refcount shares the cacheline with uid, gid and other frequently
read fields.

Said counter gest modified a lot (for example every time a file is
closed or opened) in turn causing avoidable bounces when another thread
tries to do permission checks. Said bouncing can be avoided without
growing the struct by reordering the fields -- keyring (enabled by
default) is comparatively rarely used and can suffer bouncing instead.

An additional store is performed to clear the non_rcu flag. Since the
flag is rarely set (a special case in the access(2) system call) and
transitions at most once, it can get placed in a read-mostly area and is
only conditionally written to.

With this in place regular permission checks no longer bounce cachelines
in face of refcount changes.

Validated with a simple test where one thread opens and closes a file
(dirtying creds twice), while another keeps re-reading *another* file in
a loop (ops/s):
before:	4353763
after:	4742792 (+9%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This is a resend with a reworded commit message and added Linus since he
wrote the non_rcu thing.

Note each process has its on creds, so this is not causing bounces
globally.

Even so, there is stuff I plan to do in the area and this patch can be
considered prep (only one store to non_rcu).

I'll also note I don't see a way to *whack* non_rcu either. :)

0 rush

 fs/open.c            |  2 +-
 include/linux/cred.h | 31 +++++++++++++++----------------
 kernel/cred.c        |  6 +++---
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..930e22fe8dba 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -455,7 +455,7 @@ static const struct cred *access_override_creds(void)
 	 * cred accesses will keep things non-racy to avoid RCU
 	 * freeing.
 	 */
-	override_cred->non_rcu = 1;
+	override_cred->non_rcu = true;
 
 	old_cred = override_creds(override_cred);
 
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..3127eaad4140 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -110,7 +110,16 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
  */
 struct cred {
 	atomic_long_t	usage;
-	kuid_t		uid;		/* real UID of the task */
+	struct rcu_head	rcu;		/* RCU deletion hook */
+#ifdef CONFIG_KEYS
+	unsigned char	jit_keyring;	/* default keyring to attach requested
+					 * keys to */
+	struct key	*session_keyring; /* keyring inherited over fork */
+	struct key	*process_keyring; /* keyring private to this process */
+	struct key	*thread_keyring; /* keyring private to this thread */
+	struct key	*request_key_auth; /* assumed request_key authority */
+#endif
+	kuid_t		uid ____cacheline_aligned_in_smp;/* real UID of the task */
 	kgid_t		gid;		/* real GID of the task */
 	kuid_t		suid;		/* saved UID of the task */
 	kgid_t		sgid;		/* saved GID of the task */
@@ -119,19 +128,12 @@ struct cred {
 	kuid_t		fsuid;		/* UID for VFS ops */
 	kgid_t		fsgid;		/* GID for VFS ops */
 	unsigned	securebits;	/* SUID-less security management */
+	bool		non_rcu;	/* Can we skip RCU deletion? */
 	kernel_cap_t	cap_inheritable; /* caps our children can inherit */
 	kernel_cap_t	cap_permitted;	/* caps we're permitted */
 	kernel_cap_t	cap_effective;	/* caps we can actually use */
 	kernel_cap_t	cap_bset;	/* capability bounding set */
 	kernel_cap_t	cap_ambient;	/* Ambient capability set */
-#ifdef CONFIG_KEYS
-	unsigned char	jit_keyring;	/* default keyring to attach requested
-					 * keys to */
-	struct key	*session_keyring; /* keyring inherited over fork */
-	struct key	*process_keyring; /* keyring private to this process */
-	struct key	*thread_keyring; /* keyring private to this thread */
-	struct key	*request_key_auth; /* assumed request_key authority */
-#endif
 #ifdef CONFIG_SECURITY
 	void		*security;	/* LSM security */
 #endif
@@ -139,11 +141,6 @@ struct cred {
 	struct user_namespace *user_ns; /* user_ns the caps and keyrings are relative to. */
 	struct ucounts *ucounts;
 	struct group_info *group_info;	/* supplementary groups for euid/fsgid */
-	/* RCU deletion */
-	union {
-		int non_rcu;			/* Can we skip RCU deletion? */
-		struct rcu_head	rcu;		/* RCU deletion hook */
-	};
 } __randomize_layout;
 
 extern void __put_cred(struct cred *);
@@ -217,7 +214,8 @@ static inline const struct cred *get_cred_many(const struct cred *cred, int nr)
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return cred;
-	nonconst_cred->non_rcu = 0;
+	if (unlikely(nonconst_cred->non_rcu))
+		WRITE_ONCE(nonconst_cred->non_rcu, false);
 	return get_new_cred_many(nonconst_cred, nr);
 }
 
@@ -242,7 +240,8 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 		return NULL;
 	if (!atomic_long_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
-	nonconst_cred->non_rcu = 0;
+	if (unlikely(nonconst_cred->non_rcu))
+		WRITE_ONCE(nonconst_cred->non_rcu, false);
 	return cred;
 }
 
diff --git a/kernel/cred.c b/kernel/cred.c
index 075cfa7c896f..23b73ee2ec63 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -104,7 +104,7 @@ void __put_cred(struct cred *cred)
 	BUG_ON(cred == current->cred);
 	BUG_ON(cred == current->real_cred);
 
-	if (cred->non_rcu)
+	if (unlikely(cred->non_rcu))
 		put_cred_rcu(&cred->rcu);
 	else
 		call_rcu(&cred->rcu, put_cred_rcu);
@@ -218,7 +218,7 @@ struct cred *prepare_creds(void)
 	old = task->cred;
 	memcpy(new, old, sizeof(struct cred));
 
-	new->non_rcu = 0;
+	new->non_rcu = false;
 	atomic_long_set(&new->usage, 1);
 	get_group_info(new->group_info);
 	get_uid(new->user);
@@ -643,7 +643,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 	old = get_task_cred(daemon);
 
 	*new = *old;
-	new->non_rcu = 0;
+	new->non_rcu = false;
 	atomic_long_set(&new->usage, 1);
 	get_uid(new->user);
 	get_user_ns(new->user_ns);
-- 
2.43.0

