Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F318641;
	Wed, 17 Jul 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244632; cv=none; b=QScLyCotSaAxZKAE5/1wAJMODazV9OcTKg8ejDa4/a2OVXS0c2jgkPuYWMHOYpiikXJEWhFBtW9SUK1OA8aDFPxDgxst8KgxEHy8HnMegpiActYWXOj2aGVzXlJWFOC+Oo6d0jWU0J9jnUWGQv48Eksbg5dozhOUYv9R4tFX2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244632; c=relaxed/simple;
	bh=X2vXEq9hXttjY2oUXpdodNiLPWdudJaKdhl5bdclwf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WagtcRzcias69g6jmpXc4rkraSBcAgHa/1UBD2g+oDAQ3rVAHb3LIV8oJxVIj2sjZlrWSIBRzWVs4sYIoldfeDSamcZH4e0QzTRLcfl0+MbIEwjuZqCNRQ484sPdpHvGkckiV03lo5iJGch3+TsDO6fpK1bv00/j//pdZ0WHvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cef1Wnsn; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cef1Wnsn"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eedec7fbc4so1026951fa.0;
        Wed, 17 Jul 2024 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721244628; x=1721849428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KQNNcJJvwr3DB7AU2YhhE3Rux/aVBmgy8x/TrO2xcsU=;
        b=cef1WnsnWdLa2LC1dd0IqYcEOEB3WLIUuiTlP+CcO8oBTNa2kzTcQZC5S+9apuN5sq
         rUuosz6Gb2GZkSZhy7o+t1MsnSBAhnZpvzzh6B6mZri3Dn+Oyd5v5GznmchVxpjC2twn
         +cuObID8f9buliCzKBh25PotC+n2vfo/uOglCSILHyFlpSgy9EXcI9wWngTz5zlO0MKA
         ELTVgJQPh4scpOHOgln2vwZnjVfSMjPq46gtJs365xRu0uw4SRkK7YgHWvSOKkZ3583w
         6joIxei296r+2LH3Gzw8Za3UVnBQUzyZXNQusnH5LmLFH+deawjPgwxMtcXuLV74Bisr
         cN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721244628; x=1721849428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQNNcJJvwr3DB7AU2YhhE3Rux/aVBmgy8x/TrO2xcsU=;
        b=CsykZWtbYxQJ62Z3akbEIGR1PeWYuJqQhR/SihzEcfeLT39o71kF8q2Wyohx7aM8xA
         T0+7oMFzYVqePUQgz75FJTwZi2NtY1Jo+/WAP+W0OcQT5A3pfJws7jY2f1gmtcHHnACP
         u/2X04MYDorwKCR5sr34KRw3Qb129hynD7DYmFfBngS9viRk9L14fK9yMRtNv63MoAGa
         V620da3JJPuAoiOxTiSGZqcwLDzkQ2z8n/tnXtealR+6E3uBqMt8mkXQbvljauF+1f9i
         KSBFJXB3aA07CMyzetmJpuiYf1qgzGBav0lHnWSqiAv2i79MJFruWQEdG16+BZh2qiDD
         rVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFnjXMFbZrlW47McYLLszctSrnwqUjHA3ENxjhk9X1Lq2mKtTNit/5o1tynFQvs2z+db5vy2zTCKXlsQIOB1nSBuIqPfuzdOHn5LEC
X-Gm-Message-State: AOJu0YzotPqnk1Gwvs+HSyEevkb4/hsQDGSy+p7OUAuHL34R1tbmzv5P
	VYjjEsH60kqOiOtwFLy3iYa4MwvRNsB2lEDgvtzyZIVKxzLgM+8xxm5RCg==
X-Google-Smtp-Source: AGHT+IELwK8RRqNe8PtXuyClZuTBOyJwKDrW4Ewf+aAWVuG4RwrkgbrQOHf1axYAdYs8jAjNhk/Ohw==
X-Received: by 2002:a2e:88c5:0:b0:2ec:557b:f89c with SMTP id 38308e7fff4ca-2ef05d43a9fmr2476691fa.31.1721244627786;
        Wed, 17 Jul 2024 12:30:27 -0700 (PDT)
Received: from f.. (cst-prg-77-238.cust.vodafone.cz. [46.135.77.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a290fsm7399561a12.77.2024.07.17.12.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:30:27 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] cred: separate the refcount from frequently read fields
Date: Wed, 17 Jul 2024 21:29:36 +0200
Message-ID: <20240717192937.527246-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refcount is modified a lot, for example every time a file is closed or
opened. Then this avoidably dirties the same cacheline which contains
uid, gid and other frequently read fields.

Also tidy up non_rcu handling -- it only transitions true->false once,
and even then only for a rare case (access(2) system call which had to
duplicate creds). As such the field belongs in the read-mostly area.

In order to avoid growing the struct fill in the space with keyring.

No change in size on typical configs on 64-bit architectures.

Validated with a simple test where one thread opens and closes a file,
while another keeps re-reading another file in a loop (ops/s):
before:	4353763
after:	4742792 (+9%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

Back in May I sent a patch to plug a small hole in the struct. I did not
get any traffic, but just in case I'll note it should be dropped in
favor of this one.

Also note this does not solve real scalability problems, but I'm going
to get to it at some point(tm).

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

