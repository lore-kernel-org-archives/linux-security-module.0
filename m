Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BD1ADC77
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661280; cv=none; b=N4ymLEuaSgQIQULX5a/Loxrt4rAMz/qUjJPDn8vXlbuAYGLj5W2EUdd5ganeT6divwlAYRPhLip/2fGf0uD4A3jXG2TSPk/O4r2V90TnSZDh/Y4sw9pQZqnqD3KnaaWoTiEOvErOrrMAv4eRvahHgm267cxc3CHguhm9s6DA/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661280; c=relaxed/simple;
	bh=GIF+fk9IobFSfNhuFhApJTMzkrK12SVgNFfAKA+iy3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=B9LieCl2BpNHudISQ5x2rR2VFoBaOASB7l8mjffuNhYRPWHw9fVEbQHT+7CCfyQ5YBTFfx3rGVTj3H4AAChPlrjiQyi8SZ8t9IXkajC6GNjgSnK7e2a4jEyDpusDAsR/QU72dk2J9HpmwHkFhEfB8iam8oN0ZjsMg1d4OPk0Lew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ao0g4cmf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ao0g4cmf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737661277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V+IxkaybUSMW2r1YO28wGSsGSHInaXvUKJ337QNsU4=;
	b=ao0g4cmfD115ZEl+DWrVxUZisDK5FEe7TbRWBtAPXrrEkEkNrWCyphU9LbooTzlsIKjQiZ
	1oTq+PLjDbx6M56Rp6e19vwUu1Zp/uWutSD+rkZNAdENUHpeUapXbQXF77OZgA+SMUM4Sm
	o9a6YB+NLmU0hjYoqEHPpHoVe0K20uc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-2k4cmDUyN8aD4G5nESB2Fg-1; Thu, 23 Jan 2025 14:41:16 -0500
X-MC-Unique: 2k4cmDUyN8aD4G5nESB2Fg-1
X-Mimecast-MFC-AGG-ID: 2k4cmDUyN8aD4G5nESB2Fg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862f3ccf4fso531682f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 11:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661275; x=1738266075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V+IxkaybUSMW2r1YO28wGSsGSHInaXvUKJ337QNsU4=;
        b=OSgl0Vh6Hmk16OM4q+Vos0F3WTVS/kQyrWow5T+ktczpcdZMKuZFBB3ujf+Kuq83EL
         juFSSx/sZXpVN5TsMbgHxEaJekkfbYkRiqezTgG0Xyu9mmj08Q/39V85VT3L5vImWdfV
         CEtlCV6lXjq7y+mTrd7e4W66/NC98t7bQUocwz85hPW5kElrCsWFBuSu+1/13emb1Glu
         fIsYZDwU/m5rxbIvyij4NT6rbQyRYS38awlChgIDdaDzUWWSny5HhKkSuDcfiPDOul9V
         PSCpnYFgKmd12NJwEWzs3BqszD5o5I808x3J/NqKTQ+0Wm/t8xfg2VVamvERxhmeFISs
         5d6w==
X-Forwarded-Encrypted: i=1; AJvYcCXeu04ij6JpcYh5OzuaL9XeF/RHQ3Z4pWmaoMEIeUByQz2b67ZQJY7apLPfHd8JVulKLqMu57PnHCEBAqy/7URZfZ5L6vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqH5FvOL10mOr0T7HtNcstI96NYcDKuGbS3sQ3O2hMhUU2AhxX
	aBHuaZ8xXTcJnbpQoMJJm75SDIuJNpcnfhazz960f6HKcdj825gN1+gPdKAAZ1uJJqaEcKdd/NR
	+PYXy0kPCZukXtc57hHl586EQ7IVomxER3XFpO323C9oVHzgeVyFUzhYMIKtmriNLf6QF13Do/Q
	==
X-Gm-Gg: ASbGncvONi+QEDYfdU92gczAC5MN3isKErHz6vNoPBCXzxi9s02O0YITt6cVhvR1vTW
	Fhc1S+HqQRHYQvM1vCaIfCIpY6d9Ey6e821IJiTpGbtrysIF6nYomE0NFYmLQnididYuGlUXhjM
	smLeqFTpw8izYCWhXxaKiyXKrenbiFJqhFJwarus6DVY/fb/MGqEkmVIfsHjkQ7SP+LER5z5GZ2
	BBqbrkh4AdvxW+fMSeklnBlKH20uuhtTJoHlNjI4CnVbCHQliKFw/OHmMTpEu7VLyEIPHKEwtaa
	qXg/sKovHgThMAsV0NErxvcJvS1mR/cfSvhpzT3SbiJ2Kg==
X-Received: by 2002:a5d:5f54:0:b0:38a:4184:151a with SMTP id ffacd0b85a97d-38bf57a662bmr23000428f8f.37.1737661274810;
        Thu, 23 Jan 2025 11:41:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6bvb2a3XGHOGcH/RcOdmYEOAisg6ahNrkQ9wKfU4H2gSMzXslaNmQdhwD6k+hdMTBdlXNDw==
X-Received: by 2002:a5d:5f54:0:b0:38a:4184:151a with SMTP id ffacd0b85a97d-38bf57a662bmr23000397f8f.37.1737661274407;
        Thu, 23 Jan 2025 11:41:14 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e46sm1687245e9.21.2025.01.23.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:41:14 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v4 3/4] vfs: add notifications for mount attach and detach
Date: Thu, 23 Jan 2025 20:41:06 +0100
Message-ID: <20250123194108.1025273-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123194108.1025273-1-mszeredi@redhat.com>
References: <20250123194108.1025273-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CLk8IkDxgsy7wQoOdKDokAKOVgF5uQE5d-NjbduNyzA_1737661275
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add notifications for attaching and detaching mounts to fs/namespace.c

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h     | 20 +++++++++++++
 fs/namespace.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/pnode.c     |  4 ++-
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 9689e7bf4501..7dd22a226a6e 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -5,6 +5,8 @@
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
 
+extern struct list_head notify_list;
+
 struct mnt_namespace {
 	struct ns_common	ns;
 	struct mount *	root;
@@ -72,6 +74,8 @@ struct mount {
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
+	struct list_head to_notify;	/* need to queue notification */
+	struct mnt_namespace *prev_ns;	/* previous namespace (NULL if none) */
 #endif
 	int mnt_id;			/* mount identifier, reused */
 	u64 mnt_id_unique;		/* mount ID unique until reboot */
@@ -175,4 +179,20 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 	return container_of(ns, struct mnt_namespace, ns);
 }
 
+#ifdef CONFIG_FSNOTIFY
+static inline void mnt_notify_add(struct mount *m)
+{
+	/* Optimize the case where there are no watches */
+	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
+	    (m->prev_ns && m->prev_ns->n_fsnotify_marks))
+		list_add_tail(&m->to_notify, &notify_list);
+	else
+		m->prev_ns = m->mnt_ns;
+}
+#else
+static inline void mnt_notify_add(struct mount *m)
+{
+}
+#endif
+
 struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index 4d9072fd1263..948348a37f6c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -79,6 +79,9 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+#ifdef CONFIG_FSNOTIFY
+LIST_HEAD(notify_list); /* protected by namespace_sem */
+#endif
 static DEFINE_RWLOCK(mnt_ns_tree_lock);
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 
@@ -145,6 +148,7 @@ static void mnt_ns_release(struct mnt_namespace *ns)
 
 	/* keep alive for {list,stat}mount() */
 	if (refcount_dec_and_test(&ns->passive)) {
+		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
 	}
@@ -1136,6 +1140,8 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	}
 	rb_link_node(&mnt->mnt_node, parent, link);
 	rb_insert_color(&mnt->mnt_node, &ns->mounts);
+
+	mnt_notify_add(mnt);
 }
 
 /*
@@ -1683,6 +1689,50 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
+#ifdef CONFIG_FSNOTIFY
+static void mnt_notify(struct mount *p)
+{
+	if (!p->prev_ns && p->mnt_ns) {
+		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
+	} else if (p->prev_ns && !p->mnt_ns) {
+		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+	} else if (p->prev_ns == p->mnt_ns) {
+		fsnotify_mnt_move(p->mnt_ns, &p->mnt);
+	} else {
+		fsnotify_mnt_detach(p->prev_ns, &p->mnt);
+		fsnotify_mnt_attach(p->mnt_ns, &p->mnt);
+	}
+	p->prev_ns = p->mnt_ns;
+}
+
+static void notify_mnt_list(void)
+{
+	struct mount *m, *tmp;
+	/*
+	 * Notify about mounts that were added/reparented/detached/remain
+	 * connected after unmount.
+	 */
+	list_for_each_entry_safe(m, tmp, &notify_list, to_notify) {
+		mnt_notify(m);
+		list_del_init(&m->to_notify);
+	}
+}
+
+static bool need_notify_mnt_list(void)
+{
+	return !list_empty(&notify_list);
+}
+#else
+static void notify_mnt_list(void)
+{
+}
+
+static bool need_notify_mnt_list(void)
+{
+	return false;
+}
+#endif
+
 static void namespace_unlock(void)
 {
 	struct hlist_head head;
@@ -1693,7 +1743,18 @@ static void namespace_unlock(void)
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
 
-	up_write(&namespace_sem);
+	if (need_notify_mnt_list()) {
+		/*
+		 * No point blocking out concurrent readers while notifications
+		 * are sent. This will also allow statmount()/listmount() to run
+		 * concurrently.
+		 */
+		downgrade_write(&namespace_sem);
+		notify_mnt_list();
+		up_read(&namespace_sem);
+	} else {
+		up_write(&namespace_sem);
+	}
 
 	shrink_dentry_list(&list);
 
@@ -1806,6 +1867,19 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		change_mnt_propagation(p, MS_PRIVATE);
 		if (disconnect)
 			hlist_add_head(&p->mnt_umount, &unmounted);
+
+		/*
+		 * At this point p->mnt_ns is NULL, notification will be queued
+		 * only if
+		 *
+		 *  - p->prev_ns is non-NULL *and*
+		 *  - p->prev_ns->n_fsnotify_marks is non-NULL
+		 *
+		 * This will preclude queuing the mount if this is a cleanup
+		 * after a failed copy_tree() or destruction of an anonymous
+		 * namespace, etc.
+		 */
+		mnt_notify_add(p);
 	}
 }
 
@@ -2511,6 +2585,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			dest_mp = smp;
 		unhash_mnt(source_mnt);
 		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
+		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -4426,6 +4501,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	list_del_init(&new_mnt->mnt_expire);
 	put_mountpoint(root_mp);
 	unlock_mount_hash();
+	mnt_notify_add(root_mnt);
+	mnt_notify_add(new_mnt);
 	chroot_fs_refs(&root, &new);
 	error = 0;
 out4:
diff --git a/fs/pnode.c b/fs/pnode.c
index a799e0315cc9..d42b71c3567a 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -549,8 +549,10 @@ static void restore_mounts(struct list_head *to_restore)
 			mp = parent->mnt_mp;
 			parent = parent->mnt_parent;
 		}
-		if (parent != mnt->mnt_parent)
+		if (parent != mnt->mnt_parent) {
 			mnt_change_mountpoint(parent, mp, mnt);
+			mnt_notify_add(mnt);
+		}
 	}
 }
 
-- 
2.47.1

