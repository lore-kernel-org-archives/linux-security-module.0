Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3F2417C3
	for <linux-security-module@vger.kernel.org>; Thu,  7 Aug 2025 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553460; cv=none; b=ZLyBk0IarpK+vs2tisNdM4LeqwOiVQduimbkivxoX0k20hNVMYGSWzz3fBJO+S8kZBDxMvUQuhMCxKelxDqyAvzpf9QjNLrVHTxYmOaM3ZVhoVLD6eZbIrLcOF+AwLW5TYmxxh9zg40p/j6tXtNOmj76HhmogycJvz0RkVX1F0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553460; c=relaxed/simple;
	bh=qfxUK/7tbAm4+fSRT0kOqzlxvDzJPvrpN7Ck+0QWw/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nyqmJ4RwVOB+o1Pje68PRQ86Wdwv/KbXZkxpYNg3FKKiuo28ssfRbVQE8RiJJZ/0BJEZmwTs7ZIeHwaShNQW9650Kq9mrmbTS4fmNhMoio0DI1XF/mwktLYUjZOpM40kkzST0TdSivtHRkiDzgvrdA/2gROHDxxExgKH9MnQcfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VI7UsoNs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VI7UsoNs"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so1279401a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 07 Aug 2025 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754553458; x=1755158258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVn3pXWrE8ptkNx3q5SpDyS1PDtyVrfoh2hP9Ksy/jA=;
        b=VI7UsoNsmSbvVLQYrqZ7KoRVFj97BSuRN0I2w0Tabs+ms+/S5z5dF54ge4J8cy3BlV
         Q5bKRQhDkkuFH4LXPizlzbSgXfDd68wcT1JjRsJNNkrl2ZNPC8dn4x12xPbmMZQlerLd
         vMHO/Q4d9ykjrStMn4HkAg9x1yKQ9Nte0g63aitOz5fzCn8xsdYAb3KGJrHiQKFOJ6dR
         ZqVQe2nPEz8h7PIIehdxtU7ZtD4X1B4Y3D8cufzcUgTMh6aX7yuorNROFhn8kbDcM7Pr
         vSVW8jW7+uycbXja+rLO3aOIE9XWbL9/9pZpVug9/a5e+jo1xKRbD5XOSyIZPd9utd5C
         qzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553458; x=1755158258;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVn3pXWrE8ptkNx3q5SpDyS1PDtyVrfoh2hP9Ksy/jA=;
        b=vTVQc7FK+oFIBiEKiB/dYXxNLi43KznxYd2VvDaYsfy76NS6q8gpRSLV1oS72zBeFC
         6aa9M+ftTmkXD1Z31QqpxIwaEYpCPfJzhirsedDDvOsru/+RsHBuGnnJ/dtIoWtm7bg7
         J+SKhdGkR4eB9lDwaPzCNxHIsD6MAN+3AG+E8AuJK6PTTFpkBhqGJpm3VTE1hBHx5gKf
         LSQsOWG9fGzewUM8lBvAeWzUNmj2VaU4hoZLjr9f9CFgTn0KbpBR7+ubcydjmT2BJ+Qh
         Kw1voVBF3dN7w1Pqhg7yGlIWLC7N0Ldmbh9pjVzR88yHFr6OmNgfv0bn5lMl8qNmTc8l
         mEBw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Giisu+p2XKdMSEC/OCLofxOqGC9UFuXPIt8bwqlYHB+W9Uxs0XN60wjnZnBZx8ovjBobiARd6no5uJA7gJdRODPmiHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+jAm2tZ4Qd1ML1qOABaL03cM2UAvwQsNonxipQLN7rj6ouUl
	V3PYf++vtL++EuSfnaBeOqyf0cmseXHLXecD6JQREb216riYXUo8puBY1WbaI1XRHtKXRN8UGbX
	X7Q==
X-Google-Smtp-Source: AGHT+IF2BSxC7vgD0XYWFDXuPwuLdGaPbk25UgUn3Ax0OeCunYBG+ypLlIzyUoGX5ubXzQtF7kNtY9S3RA==
X-Received: from pgbcu5.prod.google.com ([2002:a05:6a02:2185:b0:b42:8b90:cffa])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1611:b0:1f5:72eb:8b62
 with SMTP id adf61e73a8af0-240312c56d8mr9197770637.20.1754553457811; Thu, 07
 Aug 2025 00:57:37 -0700 (PDT)
Date: Thu,  7 Aug 2025 17:56:46 +1000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807075647.755848-1-tweek@google.com>
Subject: [RFC PATCH 1/2] lsm: add type to security_inode_init_security_anon
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Hugh Dickins <hughd@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduce a new enum (lsm_anon_inode_id) to identify the type of
anonymous inode being created. This enum is passed down to the
security_inode_init_security_anon LSM hook.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 fs/anon_inodes.c              | 5 +++--
 include/linux/lsm_hook_defs.h | 3 ++-
 include/linux/security.h      | 8 ++++++++
 security/security.c           | 4 +++-
 security/selinux/hooks.c      | 1 +
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 1d847a939f29..9a2f09808f86 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -21,6 +21,7 @@
 #include <linux/magic.h>
 #include <linux/anon_inodes.h>
 #include <linux/pseudo_fs.h>
+#include <linux/security.h>
=20
 #include <linux/uaccess.h>
=20
@@ -121,8 +122,8 @@ struct inode *anon_inode_make_secure_inode(struct super=
_block *sb, const char *n
 		return inode;
 	inode->i_flags &=3D ~S_PRIVATE;
 	inode->i_op =3D &anon_inode_operations;
-	error =3D	security_inode_init_security_anon(inode, &QSTR(name),
-						  context_inode);
+	error =3D security_inode_init_security_anon(inode, LSM_ANON_INODE_GENERIC=
,
+						  &QSTR(name), context_inode);
 	if (error) {
 		iput(inode);
 		return ERR_PTR(error);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index fd11fffdd3c3..1634f41f7a3c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -119,7 +119,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct =
inode *inode,
 	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
 	 int *xattr_count)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
-	 const struct qstr *name, const struct inode *context_inode)
+	 enum lsm_anon_inode_id type, const struct qstr *name,
+	 const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *=
idmap,
diff --git a/include/linux/security.h b/include/linux/security.h
index 521bcb5b9717..98a97b8a1093 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -263,6 +263,12 @@ struct request_sock;
 #define LSM_UNSAFE_PTRACE	2
 #define LSM_UNSAFE_NO_NEW_PRIVS	4
=20
+/* anon_inode types */
+enum lsm_anon_inode_id {
+	LSM_ANON_INODE_GENERIC,
+	LSM_ANON_INODE_MEMFD
+};
+
 #ifdef CONFIG_MMU
 extern int mmap_min_addr_handler(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos);
@@ -402,6 +408,7 @@ int security_inode_init_security(struct inode *inode, s=
truct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
 int security_inode_init_security_anon(struct inode *inode,
+				      enum lsm_anon_inode_id type,
 				      const struct qstr *name,
 				      const struct inode *context_inode);
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_=
t mode);
@@ -889,6 +896,7 @@ static inline int security_inode_init_security(struct i=
node *inode,
 }
=20
 static inline int security_inode_init_security_anon(struct inode *inode,
+						    enum lsm_anon_inode_id type,
 						    const struct qstr *name,
 						    const struct inode *context_inode)
 {
diff --git a/security/security.c b/security/security.c
index ad163f06bf7a..09aa858819a2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1861,6 +1861,7 @@ EXPORT_SYMBOL(security_inode_init_security);
 /**
  * security_inode_init_security_anon() - Initialize an anonymous inode
  * @inode: the inode
+ * @type: the type of anonymous inode
  * @name: the anonymous inode class
  * @context_inode: an optional related inode
  *
@@ -1871,10 +1872,11 @@ EXPORT_SYMBOL(security_inode_init_security);
  * creation of this inode, or another -errno upon other errors.
  */
 int security_inode_init_security_anon(struct inode *inode,
+				      enum lsm_anon_inode_id type,
 				      const struct qstr *name,
 				      const struct inode *context_inode)
 {
-	return call_int_hook(inode_init_security_anon, inode, name,
+	return call_int_hook(inode_init_security_anon, inode, type, name,
 			     context_inode);
 }
=20
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c95a5874bf7d..8d36d5ebb6e5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2967,6 +2967,7 @@ static int selinux_inode_init_security(struct inode *=
inode, struct inode *dir,
 }
=20
 static int selinux_inode_init_security_anon(struct inode *inode,
+					    enum lsm_anon_inode_id type,
 					    const struct qstr *name,
 					    const struct inode *context_inode)
 {
--=20
2.50.1.703.g449372360f-goog

