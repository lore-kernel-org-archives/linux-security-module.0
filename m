Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FF1DFE06
	for <linux-security-module@vger.kernel.org>; Wed, 29 Jan 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169894; cv=none; b=ADuwrP1QE9Sw9pMVxi02cO99n3bzcW3irVPHN0o8pWXgUqYoE6PPZRSkNJn4jwcPkD8k7BFDtN59LnCn5UHwxEFYOiofY9T2iTx9YoEOgpGtu3WyQA4z2NG7geBFw/6ygxHuxKlKLxyhyh2q+vrfcjpr5qirFzyIg1xPpADSjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169894; c=relaxed/simple;
	bh=8e2TjtANaHTeoe8sl6kPmDjkwKIWob2Bs6CtDcqCCoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QQkLVyBovHwmns26mit5i8pkEzfOIuV1Cr6L6qSO3bjmJZAeUydRtH9Wm01zUg9ydl20hgNCxs0cY3fThY4aCN3SyMlj5A5w6cbZsec7GHZnn1jkFWWvSKpKLPUdFVCpr9MYmoeyVT2uNV+AoD9U7VBf47jkjhxsWfHFyqj7ZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4Ec9eze; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4Ec9eze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738169892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Fdn0qVB2hlx40tb+VqKQl/vuZgZHZvo8cVflZosk3s=;
	b=H4Ec9ezetkXiAJubdfdNKQkrcFu21HMfPXD/QcIgKkvvpyYiQwTBZ7T4VLJJRm/qhnLozJ
	Q8HZt9ny9dtIvj9YkT10eD5cJZm3WHcnsY6wBH1OoglEvTxqaIYNf8sLMtACgGVhzINywd
	DBXScvDQdfjfTxcrQkyngfTKWcmL+gs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-RPxR7WWxPvC7b2icVwsIVw-1; Wed, 29 Jan 2025 11:58:11 -0500
X-MC-Unique: RPxR7WWxPvC7b2icVwsIVw-1
X-Mimecast-MFC-AGG-ID: RPxR7WWxPvC7b2icVwsIVw
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d0b5036394so8801494a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jan 2025 08:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169890; x=1738774690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Fdn0qVB2hlx40tb+VqKQl/vuZgZHZvo8cVflZosk3s=;
        b=uN4gkTBAwqzzx/nIJwPgc0YFyxrU+Bp4AO2YffDZ6GCzWO4d5/J+txKvZm2yi89Y4w
         jTZUGGweIATU4+vUCPnTBcV652oZ4cmxKudhra9eE06BPT30PUGSNmyNpnRRy0sWVCGu
         n7ynOH3+v6kSvWyNnrRuxZiT6a4gWc2Hcv3mSU/7Ohgr7UhCXc9H7qedk8DNY7JW5IVI
         ekjXUVAcko9hXheKciApnFRhKi/91Ou2vRo8du70AiJWUmtJS4ZYA7vDYW30xo5ARTt8
         tFThVp3UU9TFaehM6JvNbpD79VPmq7ADfPIMOAPk23vxvngq7CsW46VlFzCBfzzeXuIO
         rQOg==
X-Forwarded-Encrypted: i=1; AJvYcCWVAp82f5dWtzMZDO/Vx6ackKWyxZskgytfdDHVLnLzlqCphVaA8RtPe4lqwSQ602DxiZ9vEdGSDXMVYvPs5sw7+6Tr01I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDH1Vp8BMs2LIwX0lAdMQHqSZjuobYHR0P+dRbdRg5zGyF+/QF
	UwosSSFLPNiI79IifJmHAAo+YTGH6iV531QAHoymreLuVNo12/W1e82F+U2kpIi8WDdY6nI8chO
	SZ1rAahi6YleQxvAUa/Y57pAQ/U22LXrNh2lk4lEQyOfHZqDPbspC1HL6zfKBYrNUXj//2aq5Jw
	==
X-Gm-Gg: ASbGncu7Y/LlLRZHSFvMNaFkp+3FTIcNx57TJaR+xnX3uEEwrB/Z7GhmWt9bUm+zeFO
	dAKLzmPKpTJgdj1RGpiMgHujjm63CdpicsRolEW1iMhVSS6MLp6cXAoPqX1ICs8zQRRS687lkRL
	8qWyWd/FGkzNQxR+4TqRczTeC2csiikwM9flbo+WStQxqnFpUd0wjMjfEYHcXQQN2IS2BTTn7oo
	Ba3nbGXV412hrHMa2Qb3b5jgNqJg1R5GcWj8821F2mkmiGzpyuJ57qZIX9rEMcgGba4RXlKfRIc
	KyRC+Z7J3AKrOa6WOpLSABfglHtMOJrR/1PyidqK1SwRDSK2ZwaPF2QI
X-Received: by 2002:a17:907:9691:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-ab6dbd2e39dmr153463566b.35.1738169889691;
        Wed, 29 Jan 2025 08:58:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyc1gmLR/6x+vkL+zqwJDDj0W/YmQwy5Gp0kD+BKGvnFwC6jvJ1Vephop+nOzwGW0bGm75ZQ==
X-Received: by 2002:a17:907:9691:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-ab6dbd2e39dmr153460966b.35.1738169889230;
        Wed, 29 Jan 2025 08:58:09 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e653c6sm1002813366b.64.2025.01.29.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:58:08 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org
Subject: [PATCH v5 3/3] vfs: add notifications for mount attach and detach
Date: Wed, 29 Jan 2025 17:58:01 +0100
Message-ID: <20250129165803.72138-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129165803.72138-1-mszeredi@redhat.com>
References: <20250129165803.72138-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n1bQOIt51NxTUp6g5rhGA70pTcVtGrSMqbHqKwqH-64_1738169890
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
index 5324a931b403..946dc8b792d7 100644
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
@@ -80,6 +82,8 @@ struct mount {
 #ifdef CONFIG_FSNOTIFY
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
+	struct list_head to_notify;	/* need to queue notification */
+	struct mnt_namespace *prev_ns;	/* previous namespace (NULL if none) */
 #endif
 	int mnt_id;			/* mount identifier, reused */
 	u64 mnt_id_unique;		/* mount ID unique until reboot */
@@ -182,4 +186,20 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
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
index d8d70da56e7b..1e964b646509 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -81,6 +81,9 @@ static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static DEFINE_SEQLOCK(mnt_ns_tree_lock);
 
+#ifdef CONFIG_FSNOTIFY
+LIST_HEAD(notify_list); /* protected by namespace_sem */
+#endif
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
 
@@ -163,6 +166,7 @@ static void mnt_ns_release(struct mnt_namespace *ns)
 {
 	/* keep alive for {list,stat}mount() */
 	if (refcount_dec_and_test(&ns->passive)) {
+		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
 	}
@@ -1176,6 +1180,8 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 		ns->mnt_first_node = &mnt->mnt_node;
 	rb_link_node(&mnt->mnt_node, parent, link);
 	rb_insert_color(&mnt->mnt_node, &ns->mounts);
+
+	mnt_notify_add(mnt);
 }
 
 /*
@@ -1723,6 +1729,50 @@ int may_umount(struct vfsmount *mnt)
 
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
@@ -1733,7 +1783,18 @@ static void namespace_unlock(void)
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
 
@@ -1846,6 +1907,19 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
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
 
@@ -2555,6 +2629,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			dest_mp = smp;
 		unhash_mnt(source_mnt);
 		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
+		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
@@ -4476,6 +4551,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	list_del_init(&new_mnt->mnt_expire);
 	put_mountpoint(root_mp);
 	unlock_mount_hash();
+	mnt_notify_add(root_mnt);
+	mnt_notify_add(new_mnt);
 	chroot_fs_refs(&root, &new);
 	error = 0;
 out4:
diff --git a/fs/pnode.c b/fs/pnode.c
index ef048f008bdd..82d809c785ec 100644
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
2.48.1

