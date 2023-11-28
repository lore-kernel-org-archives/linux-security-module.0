Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9NeJgOg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A55DA
	for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0zwWzL4LnouvSC6RVe208OxiX7Lwfh27TloREnRbLc=;
	b=X9NeJgOgSAE+NbUXq+CGDkAd9Ao9G5sjdSEFBRDXPRyzTsShhtgw9mBRCwYuVGR7vPQy9a
	n2hSJnWvRR/4WwDp3Cx9DdNWKmR5e3yoruISJmN2V2ZdL7yei83d54rHQgMOzWW2eNa3mP
	mYX78b+WN2IuAMXNyY1he6Rk4SSk8jU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-HOEAWJ7oPmWmupf6NCgUTA-1; Tue, 28 Nov 2023 11:03:46 -0500
X-MC-Unique: HOEAWJ7oPmWmupf6NCgUTA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b23aef363so36108975e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 08:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187425; x=1701792225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0zwWzL4LnouvSC6RVe208OxiX7Lwfh27TloREnRbLc=;
        b=qSxSGVUk3xRRyKWJlv51ykDB1ROBthKQHBPGrNwEU0wFBNYEz50CBwSS/4ihgdP8dB
         XleCfRD19nOPu4qhATPxJR4zP1pa3Z3XKrb4UPviL8zYY77kwxUPfUyKm5+6H6RXBbqF
         hG9O37gmhTmCCHwmOQ7+oGkzFxo5IYmZli+pImjiZWpQrgyVFvxRAhXNFEV9aajEr+AS
         NO9LguLD5qa/ymD1l/bmLgD09BcimH2zpKf1p/5N4NHs/iR9OdN4tKWqJtinaVAQ2MaH
         i/BnVHCvk5IQ+/6O/HgLckDyJqnay74wqGfUmjnN52quhwD1QPi5i7GhAyS2z/RmhfAZ
         Gczg==
X-Gm-Message-State: AOJu0YxrWF97pTaJE82DqUftW9h0/LdR6CXEIn3EMK/wM3mw6ONsTntT
	NukoJKFAOgPaczDDwENz3k7uhuR/h1Y29d4oKJqYy1u2VCK5ECfitBRvW5uis5uK26h3PVOV4tw
	lUXSpyNd0QbF97I2URPYd4L59TjICdKt9OcRP
X-Received: by 2002:a5d:6da7:0:b0:333:13ce:dc8c with SMTP id u7-20020a5d6da7000000b0033313cedc8cmr399076wrs.13.1701187424797;
        Tue, 28 Nov 2023 08:03:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiOfaV75sGNSINsDpeEEds9KGbjsyagDyEpffjIbzoesRBATKMzILUEn1SQPtaalN7o6I1qQ==
X-Received: by 2002:a5d:6da7:0:b0:333:13ce:dc8c with SMTP id u7-20020a5d6da7000000b0033313cedc8cmr399051wrs.13.1701187424562;
        Tue, 28 Nov 2023 08:03:44 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-163.pool.digikabel.hu. [89.148.117.163])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm14745352wra.84.2023.11.28.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:03:43 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/4] listmount: rip out flags
Date: Tue, 28 Nov 2023 17:03:32 +0100
Message-ID: <20231128160337.29094-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128160337.29094-1-mszeredi@redhat.com>
References: <20231128160337.29094-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

LISTMOUNT_UNREACHABLE will be achieved differently in a following patch.

LISTMOUNT_RECURSIVE becomes the default.  If non-recursive listing turns
out to be needed, it can be added later.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c             | 49 +++++++++++++-------------------------
 include/uapi/linux/mount.h |  4 ----
 2 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cb338ab18db9..9b4cb25c25ed 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5004,18 +5004,13 @@ static struct mount *listmnt_first(struct mount *root)
 	return list_first_entry_or_null(&root->mnt_mounts, struct mount, mnt_child);
 }
 
-static struct mount *listmnt_next(struct mount *curr, struct mount *root, bool recurse)
+static struct mount *listmnt_next(struct mount *curr, struct mount *root)
 {
-	if (recurse)
-		return next_mnt(curr, root);
-	if (!list_is_head(curr->mnt_child.next, &root->mnt_mounts))
-		return list_next_entry(curr, mnt_child);
-	return NULL;
+	return next_mnt(curr, root);
 }
 
 static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
-			    size_t bufsize, const struct path *root,
-			    unsigned int flags)
+			    size_t bufsize, const struct path *root)
 {
 	struct mount *r, *m = real_mount(mnt);
 	struct path rootmnt = {
@@ -5023,26 +5018,17 @@ static ssize_t do_listmount(struct vfsmount *mnt, u64 __user *buf,
 		.dentry = root->mnt->mnt_root
 	};
 	ssize_t ctr;
-	bool reachable_only = true;
-	bool recurse = flags & LISTMOUNT_RECURSIVE;
 	int err;
 
-	if (flags & LISTMOUNT_UNREACHABLE) {
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		reachable_only = false;
-	}
-
-	if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootmnt))
+	if (!is_path_reachable(m, mnt->mnt_root, &rootmnt))
 		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
 
 	err = security_sb_statfs(mnt->mnt_root);
 	if (err)
 		return err;
 
-	for (ctr = 0, r = listmnt_first(m); r; r = listmnt_next(r, m, recurse)) {
-		if (reachable_only &&
-		    !is_path_reachable(r, r->mnt.mnt_root, root))
+	for (ctr = 0, r = listmnt_first(m); r; r = listmnt_next(r, m)) {
+		if (!is_path_reachable(r, r->mnt.mnt_root, root))
 			continue;
 
 		if (ctr >= bufsize)
@@ -5065,7 +5051,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	u64 mnt_id;
 	ssize_t ret;
 
-	if (flags & ~(LISTMOUNT_UNREACHABLE | LISTMOUNT_RECURSIVE))
+	if (flags)
 		return -EINVAL;
 
 	if (copy_from_user(&kreq, req, sizeof(kreq)))
@@ -5075,20 +5061,17 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	mnt_id = kreq.mnt_id;
 
 	down_read(&namespace_sem);
-	if (mnt_id == LSMT_ROOT)
-		mnt = &current->nsproxy->mnt_ns->root->mnt;
-	else
-		mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
-	if (!mnt) {
-		up_read(&namespace_sem);
-		return -ENOENT;
-	}
-
 	get_fs_root(current->fs, &root);
-	/* Skip unreachable for LSMT_ROOT */
-	if (mnt_id == LSMT_ROOT && !(flags & LISTMOUNT_UNREACHABLE))
+	if (mnt_id == LSMT_ROOT) {
 		mnt = root.mnt;
-	ret = do_listmount(mnt, buf, bufsize, &root, flags);
+	} else {
+		ret = -ENOENT;
+		mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
+		if (!mnt)
+			goto err;
+	}
+	ret = do_listmount(mnt, buf, bufsize, &root);
+err:
 	path_put(&root);
 	up_read(&namespace_sem);
 	return ret;
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 7a5bd0b24a62..f6b35a15b7dd 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -191,10 +191,6 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
 #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
 
-/* listmount(2) flags */
-#define LISTMOUNT_UNREACHABLE	0x01U	/* List unreachable mounts too */
-#define LISTMOUNT_RECURSIVE	0x02U	/* List a mount tree */
-
 /*
  * Special @mnt_id values that can be passed to listmount
  */
-- 
2.41.0

