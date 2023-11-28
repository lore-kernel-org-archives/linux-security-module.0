Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzWBByG+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBECD4B
	for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 08:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omywh3uYUA+OP9xtT6bY+D59biyAwUJXDod3WOPdRWc=;
	b=EzWBByG+Qm5+9wLIJ/3FpzfxVki8punGEkFsoT029m60Jv5bu/2fl6sRj+OnWtFFp9nhV1
	Rk47pa3dqkAdItPpvY+KIz+xUKAuSmG11G7NpJ/nUKDURnllW59/tI+JNGJY7d7Gav02Tt
	yPEfYdTyQVVj93tuwMrN5uIVe7HWN34=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-wQr1OmesPPavbjYYjmhScg-1; Tue, 28 Nov 2023 11:03:50 -0500
X-MC-Unique: wQr1OmesPPavbjYYjmhScg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b394c381bso28689585e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 08:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187429; x=1701792229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omywh3uYUA+OP9xtT6bY+D59biyAwUJXDod3WOPdRWc=;
        b=aywVC81gWGahP0b8hjyLFgXxTt2w9WuVjRbxeYW8vx+Ma0bbcXroBrwFcaaRkXW4ho
         Ry+IzrYPqwjW3OMjMKCUolqDHDr69sXuSbt+3MxY4DEKLQzmcI1XeYl8CC1L2SBFE4bo
         /aibdu16Sl9QIQ0EU2uxSqarmjkXBmh+skhOdtcqqvktfEnDq9syieCNv72+hMaYT6VU
         o0+6ZlDqNANO7KX5vyllZCTo4/0fFDuAhydceYPNgUTuyqVh5iVoaJh8jc3xbp5wAaIS
         QFN3H9EM90XagFI7D8jhUbWRHwBd0tmbbXWjPpYL1/xNGVzZ2PtlcEcEioTH/7j+EUO+
         29yA==
X-Gm-Message-State: AOJu0YxTCDwQnM9e0Tx0zPKLfD16WJmoQoHXNyxr1Xo2KUsXmhB9lgGd
	XNntAEotoAWBlFTiu/74IpuEKgtVUXdGfqg1IVw4zezSxCdyniRg0VBAkeiMQa6eeofhfLQAeAw
	BPnH5ybZE9fC9M6QfB7wxCWIit1nrZTKK4J1K
X-Received: by 2002:adf:f1c1:0:b0:333:57:52dc with SMTP id z1-20020adff1c1000000b00333005752dcmr6968623wro.28.1701187429404;
        Tue, 28 Nov 2023 08:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjBXrvjTmUnqUbvz6X5Z6wicgMGQwKTpwouHd6eOg+ohVwquafvdjG1qDYQ2HQi5uGrlK3bQ==
X-Received: by 2002:adf:f1c1:0:b0:333:57:52dc with SMTP id z1-20020adff1c1000000b00333005752dcmr6968581wro.28.1701187429027;
        Tue, 28 Nov 2023 08:03:49 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-163.pool.digikabel.hu. [89.148.117.163])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm14745352wra.84.2023.11.28.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:03:47 -0800 (PST)
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
Subject: [PATCH 3/4] listmount: small changes in semantics
Date: Tue, 28 Nov 2023 17:03:34 +0100
Message-ID: <20231128160337.29094-4-mszeredi@redhat.com>
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

1) Make permission checking consistent with statmount(2): fail if mount is
unreachable from current root.  Previously it failed if mount was
unreachable from root->mnt->mnt_root.

2) List all submounts, even if unreachable from current root.  This is
safe, since 1) will prevent listing unreachable mounts for unprivileged
users.

3) LSMT_ROOT is unchaged, it lists mounts under current root.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ad62cf7ee334..10cd651175b5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5004,37 +5004,26 @@ static struct mount *listmnt_next(struct mount *curr)
 	return node_to_mount(rb_next(&curr->mnt_node));
 }
 
-static ssize_t do_listmount(struct mount *first, struct vfsmount *mnt,
+static ssize_t do_listmount(struct mount *first, struct path *orig, u64 mnt_id,
 			    u64 __user *buf, size_t bufsize,
 			    const struct path *root)
 {
-	struct mount *r, *m = real_mount(mnt);
-	struct path rootmnt = {
-		.mnt = root->mnt,
-		.dentry = root->mnt->mnt_root
-	};
-	struct path orig;
+	struct mount *r;
 	ssize_t ctr;
 	int err;
 
-	if (!is_path_reachable(m, mnt->mnt_root, &rootmnt))
-		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
+	if (!capable(CAP_SYS_ADMIN) &&
+	    !is_path_reachable(real_mount(orig->mnt), orig->dentry, root))
+		return -EPERM;
 
-	err = security_sb_statfs(mnt->mnt_root);
+	err = security_sb_statfs(orig->dentry);
 	if (err)
 		return err;
 
-	if (root->mnt == mnt) {
-		orig = *root;
-	} else {
-		orig.mnt = mnt;
-		orig.dentry = mnt->mnt_root;
-	}
-
 	for (ctr = 0, r = first; r; r = listmnt_next(r)) {
-		if (r == m)
+		if (r->mnt_id_unique == mnt_id)
 			continue;
-		if (!is_path_reachable(r, r->mnt.mnt_root, &orig))
+		if (!is_path_reachable(r, r->mnt.mnt_root, orig))
 			continue;
 
 		if (ctr >= bufsize)
@@ -5053,9 +5042,8 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mnt_id_req kreq;
-	struct vfsmount *mnt;
 	struct mount *first;
-	struct path root;
+	struct path root, orig;
 	u64 mnt_id;
 	ssize_t ret;
 
@@ -5071,16 +5059,17 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	down_read(&namespace_sem);
 	get_fs_root(current->fs, &root);
 	if (mnt_id == LSMT_ROOT) {
-		mnt = root.mnt;
+		orig = root;
 	} else {
 		ret = -ENOENT;
-		mnt  = lookup_mnt_in_ns(mnt_id, ns);
-		if (!mnt)
+		orig.mnt  = lookup_mnt_in_ns(mnt_id, ns);
+		if (!orig.mnt)
 			goto err;
+		orig.dentry = orig.mnt->mnt_root;
 	}
 	first = node_to_mount(rb_first(&ns->mounts));
 
-	ret = do_listmount(first, mnt, buf, bufsize, &root);
+	ret = do_listmount(first, &orig, mnt_id, buf, bufsize, &root);
 err:
 	path_put(&root);
 	up_read(&namespace_sem);
-- 
2.41.0

