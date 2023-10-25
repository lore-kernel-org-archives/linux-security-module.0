Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD6C07545
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Oct 2023 14:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjJYODv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Oct 2023 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbjJYODt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 10:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9409D196
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698242538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4bwGq/C+5APOsCqFrwpf0XoGoPuUJR4+QLSXHx9atCw=;
        b=ANm5HIuOwutKA/F9LPiuruZNASgU58yzWIWFVJBEXvAVuFLeR598cyj5HY4zDlDmKyb7Ei
        UUKpN/VAr7kzXghJsnRGx5Qxz8uVluT5ec/APGcbnZ2H0H46hkbQ+B+L66J4RvB+0Azi5G
        jU3+/x1wniv3wlbtt6wPNf+kUkHHFr8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-1EUrFm1ePZ-pB0fN2WjvcQ-1; Wed, 25 Oct 2023 10:02:16 -0400
X-MC-Unique: 1EUrFm1ePZ-pB0fN2WjvcQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c797b497e8so308377266b.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 07:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242535; x=1698847335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bwGq/C+5APOsCqFrwpf0XoGoPuUJR4+QLSXHx9atCw=;
        b=h7PyzQ8ptHveItm7rjV10Tkp7xCVHUd/qGg9b9ZrUZVcu+TzPEB9AMCZvS8QzsQJYW
         9rihwkUmtY5IA5zSLQ3viTDSQHhwBLyTv/gammOZMoJKUr7Jew3rB93lS+Gxfiv2brf/
         Wj3jOlkBSxSEs0YUgCKEj2ej9/cYPq32RuyQq5BcPSyZlvV47Tuvuo9fKbJs62gSFmT/
         zIWh+XuVyC4UaJkMYJ5qzStFO9NSsgveZXQutMB6Vhot7l2WLqbWTsuPv7S5C54JDzXk
         yaDfGzigqOpKF7Iki3snQpSMHP7UBEWfhKC03EC25dRz9+xdTjKdOO2D++y/R3w5OVpS
         VeGg==
X-Gm-Message-State: AOJu0YxCvUJ0Wk3pldtvzDyMOdXKDNiff/rxdHIgsBo4Z0aUjUVszi/n
        +0PFYdqdBXzrwugkNG9aFsSdTpoHIUUFJvI7dfykm1EcU4rLvirHcnAXaGQD4ybB3wvXdlAjn4Y
        X7ZQn+xVpyiXKU+9gvbw2bA8mzuBSj3HHgW1u
X-Received: by 2002:a17:906:3e54:b0:9c3:bb0e:d4c7 with SMTP id t20-20020a1709063e5400b009c3bb0ed4c7mr9498288eji.28.1698242535390;
        Wed, 25 Oct 2023 07:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP25qBhJxT4qXiqjdZQb/HVco5wkgj/lhRNtDMYF4zMn2TOmKwTlFkjQyOsrNX64rUB3w+YQ==
X-Received: by 2002:a17:906:3e54:b0:9c3:bb0e:d4c7 with SMTP id t20-20020a1709063e5400b009c3bb0ed4c7mr9498262eji.28.1698242534928;
        Wed, 25 Oct 2023 07:02:14 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:13 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 5/6] add listmount(2) syscall
Date:   Wed, 25 Oct 2023 16:02:03 +0200
Message-ID: <20231025140205.3586473-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add way to query the children of a particular mount.  This is a more
flexible way to iterate the mount tree than having to parse the complete
/proc/self/mountinfo.

Allow listing either

 - immediate child mounts only, or

 - recursively all descendant mounts (depth first).

Lookup the mount by the new 64bit mount ID.  If a mount needs to be queried
based on path, then statx(2) can be used to first query the mount ID
belonging to the path.

Return an array of new (64bit) mount ID's.  Without privileges only mounts
are listed which are reachable from the task's root.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c             | 93 ++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h   |  3 ++
 include/uapi/linux/mount.h |  9 ++++
 3 files changed, 105 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index a980c250a3a6..0afe2344bba6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4958,6 +4958,99 @@ SYSCALL_DEFINE4(statmount, const struct __mount_arg __user *, req,
 	return ret;
 }
 
+static struct mount *listmnt_first(struct mount *root)
+{
+	return list_first_entry_or_null(&root->mnt_mounts, struct mount, mnt_child);
+}
+
+static struct mount *listmnt_next(struct mount *curr, struct mount *root, bool recurse)
+{
+	if (recurse)
+		return next_mnt(curr, root);
+	if (!list_is_head(curr->mnt_child.next, &root->mnt_mounts))
+		return list_next_entry(curr, mnt_child);
+	return NULL;
+}
+
+static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
+			 const struct path *root, unsigned int flags)
+{
+	struct mount *r, *m = real_mount(mnt);
+	struct path rootmnt = {
+		.mnt = root->mnt,
+		.dentry = root->mnt->mnt_root
+	};
+	long ctr = 0;
+	bool reachable_only = true;
+	bool recurse = flags & LISTMOUNT_RECURSIVE;
+	int err;
+
+	err = security_sb_statfs(mnt->mnt_root);
+	if (err)
+		return err;
+
+	if (flags & LISTMOUNT_UNREACHABLE) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		reachable_only = false;
+	}
+
+	if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootmnt))
+		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
+
+	for (r = listmnt_first(m); r; r = listmnt_next(r, m, recurse)) {
+		if (reachable_only &&
+		    !is_path_reachable(r, r->mnt.mnt_root, root))
+			continue;
+
+		if (ctr >= bufsize)
+			return -EOVERFLOW;
+		if (put_user(r->mnt_id_unique, buf + ctr))
+			return -EFAULT;
+		ctr++;
+		if (ctr < 0)
+			return -ERANGE;
+	}
+	return ctr;
+}
+
+SYSCALL_DEFINE4(listmount, const struct __mount_arg __user *, req,
+		u64 __user *, buf, size_t, bufsize, unsigned int, flags)
+{
+	struct __mount_arg kreq;
+	struct vfsmount *mnt;
+	struct path root;
+	u64 mnt_id;
+	long err;
+
+	if (flags & ~(LISTMOUNT_UNREACHABLE | LISTMOUNT_RECURSIVE))
+		return -EINVAL;
+
+	if (copy_from_user(&kreq, req, sizeof(kreq)))
+		return -EFAULT;
+	mnt_id = kreq.mnt_id;
+
+	down_read(&namespace_sem);
+	if (mnt_id == LSMT_ROOT)
+		mnt = &current->nsproxy->mnt_ns->root->mnt;
+	else
+		mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
+
+	err = -ENOENT;
+	if (mnt) {
+		get_fs_root(current->fs, &root);
+		/* Skip unreachable for LSMT_ROOT */
+		if (mnt_id == LSMT_ROOT && !(flags & LISTMOUNT_UNREACHABLE))
+			mnt = root.mnt;
+		err = do_listmount(mnt, buf, bufsize, &root, flags);
+		path_put(&root);
+	}
+	up_read(&namespace_sem);
+
+	return err;
+}
+
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index ba371024d902..38f3da7e04d1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -413,6 +413,9 @@ asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 asmlinkage long sys_statmount(const struct __mount_arg __user *req,
 			      struct statmnt __user *buf, size_t bufsize,
 			      unsigned int flags);
+asmlinkage long sys_listmount(const struct __mount_arg __user *req,
+			      u64 __user *buf, size_t bufsize,
+			      unsigned int flags);
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index d2c988ab526b..704c408cc662 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -194,4 +194,13 @@ struct __mount_arg {
 #define STMT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
 #define STMT_FS_TYPE		0x00000020U	/* Want/got fs_type */
 
+/* listmount(2) flags */
+#define LISTMOUNT_UNREACHABLE	0x01	/* List unreachable mounts too */
+#define LISTMOUNT_RECURSIVE	0x02	/* List a mount tree */
+
+/*
+ * Special @mnt_id values that can be passed to listmount
+ */
+#define LSMT_ROOT		0xffffffffffffffff	/* root mount */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.41.0

