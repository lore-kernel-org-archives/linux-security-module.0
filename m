Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177825;
	b=oxgZVzUzs1bqJszZCVYZOr7sIA/IOa4yrR+8sS8uGWd0UjaqpYwXNSu5ArroOI5c9Lod
	 +OpaHGWgW9daiLsMJ72YobJmPwVhAtfIEJqGacm4O7uBZRerMRU+UzrLx1t2AOpBQ9ICJ
	 t/GC+vMjk/HXLKJAdxYXhP0DN0Mqua72z6AQ3ZJfZVLSwDvzialWtVWugL1elzF5Evoyz
	 u5Oq9RFnve8uNtGhlwlQ0kyKCxfXsfcqmmlWLVQRyuRi/TpfQC1cito3MX0Z67qqYgzrp
	 LqfsORL42KtZgNxqHQ79H5mHwehIEY9/CnnITbNgOV1MbHYQLPrXUJ+LEzPoVXHMFnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177825;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Gx1n+U2+62ZGO/tCkqNlE96APS5Eqr7wuQE3cJg+neY=;
	b=EM1RnUaQ214Lokkx3AHZpdsvQWAVCTeSAl9TjfVer/WfpEyUXrd1ruRdOTCiIf0BLiyI
	 JDKx35b/mCUZbUFsalW5zP61e8UWWTS6AijLCRBGGgsdsq1ULuSUfjdKvnxmdsudsKNVB
	 BRYx86SVtRAjcwLJhRkOXIXrlTQR80fgC57WoJMxN39w4kAfxPDbTHiaL98YzRJdGPvoM
	 yu6hsp169kwZ5ocwZfv6q4jAwHzFFpT69M43qC1lcuat+AaPVIb7Dg9hQLDSoAX807+g4
	 u7SEmWFFBCj3UEANEMLNpqi3B8UPkmxesse8Z1R71s4gdPjsiXOB9z90UDewgzGN9pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYFDAAQn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338C606A334;
	Fri, 20 Nov 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYFDAAQn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D7F1F000D3;
	Fri, 20 Nov 2026 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177824;
	bh=Gx1n+U2+62ZGO/tCkqNlE96APS5Eqr7wuQE3cJg+neY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SYFDAAQnSgqckbMBMoCL5Ij2R1hH2WpUuW6oANwIaCb7ZG08S7QJ++k1htnkghIdf
	 F8XuQohZUVoCie7zcDd3Tzgnv3vnuKTfwiUzLfXGWFBPP07VG4NFmB5fdYIPR+Qc6m
	 lkVxhOkxL6FcuAihmcXtLtwvWPWi4YCA4jbsFBAF3yzvg0YbtFqsiVYIpFp9GxXxzW
	 Z2FWH5QbK6kBAho8gFefksTKHZACPg26kS2vL1Faiu7j98vC4uUpNw6NVPa59RzFt2
	 zxtu+Ud+spOQ5yOxe/5mHv9jqiIkjm5WR3NXLEGNPwEiHkFObw3DR1MiiEh30ykHmp
	 Kf673oLxZ5iYg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Nov 2026 13:29:58 +0100
Subject: [PATCH 1/2] mount: pass flags to alloc_mnt_ns()
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-work-ns-mount_subtree-v1-1-06337377f94a@kernel.org>
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
In-Reply-To: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 bpf@vger.kernel.org, Zhiqi Zhang <zhiqizhangg@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0pOZKkdJG8yPffhGzGvWVICHnrRKIWDIo4PU2IoSj3c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQz2IY7TzQ5zCi6uCD988aKa2WKEcuXMZy/Ot8k8m1wx
 uWitK3TOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyzobhN2tKXMoy5h9Su29E
 7b2x9Lrv956Vmw70L39UmnRu8xy2P02MDE8FhH0y1fJlTUtelbA9+ddkyL/RvufYm39Pp3owLe5
 jZwUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Turn the anon argument of alloc_mnt_ns() into a flags argument. The
next patch needs to pass another property of the new mount namespace
and two booleans in a row would make the callers unreadable.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index aecd05ac01705..756f9011cbf1d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2353,7 +2353,12 @@ void drop_collected_paths(const struct path *paths, const struct path *prealloc)
 		kfree(paths);
 }
 
-static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
+enum mnt_ns_flags_t {
+	MNT_NS_ANON	= (1 << 0),
+};
+
+static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *,
+					  enum mnt_ns_flags_t);
 
 /* Consumes the caller's reference to @mnt. */
 void dissolve_on_fput(struct vfsmount *mnt)
@@ -3149,7 +3154,7 @@ static struct mnt_namespace *get_detached_copy(const struct path *path, unsigned
 	struct user_namespace *user_ns = mnt_ns->user_ns;
 	struct mount *mnt, *p;
 
-	ns = alloc_mnt_ns(user_ns, true);
+	ns = alloc_mnt_ns(user_ns, MNT_NS_ANON);
 	if (IS_ERR(ns))
 		return ns;
 
@@ -3230,7 +3235,7 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	if (foreign)
 		copy_flags |= CL_SLAVE | CL_COPY_UNBINDABLE;
 
-	new_ns = alloc_mnt_ns(user_ns, false);
+	new_ns = alloc_mnt_ns(user_ns, 0);
 	if (IS_ERR(new_ns))
 		return ERR_CAST(new_ns);
 
@@ -4369,7 +4374,8 @@ static void free_mnt_ns(struct mnt_namespace *ns)
 	mnt_ns_tree_remove(ns);
 }
 
-static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool anon)
+static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns,
+					  enum mnt_ns_flags_t flags)
 {
 	struct mnt_namespace *new_ns;
 	struct ucounts *ucounts;
@@ -4385,7 +4391,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (anon)
+	if (flags & MNT_NS_ANON)
 		ret = ns_common_init_inum(new_ns, MNT_NS_ANON_INO);
 	else
 		ret = ns_common_init(new_ns);
@@ -4394,7 +4400,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		dec_mnt_namespaces(ucounts);
 		return ERR_PTR(ret);
 	}
-	new_ns->is_anon = anon;
+	new_ns->is_anon = flags & MNT_NS_ANON;
 	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
 	init_waitqueue_head(&new_ns->poll);
@@ -4422,7 +4428,7 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 
 	old = ns->root;
 
-	new_ns = alloc_mnt_ns(user_ns, false);
+	new_ns = alloc_mnt_ns(user_ns, 0);
 	if (IS_ERR(new_ns))
 		return new_ns;
 
@@ -4509,7 +4515,7 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
 	struct path path;
 	int err;
 
-	ns = alloc_mnt_ns(&init_user_ns, true);
+	ns = alloc_mnt_ns(&init_user_ns, MNT_NS_ANON);
 	if (IS_ERR(ns)) {
 		mntput(m);
 		return ERR_CAST(ns);
@@ -4699,7 +4705,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		return FD_ADD((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
 			      open_new_namespace(&new_path, MOUNT_COPY_NEW));
 
-	ns = alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
+	ns = alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, MNT_NS_ANON);
 	if (IS_ERR(ns))
 		return PTR_ERR(ns);
 	mnt = real_mount(new_path.mnt);

-- 
2.53.0

