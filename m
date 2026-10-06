Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146C123F40D
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246050; cv=none; b=Y7+lzEq9XIBifLkjVriWXgN6KNsGPUCLpsGpKq4IDNIGj3aIiJB/Po9+2jWmbjH+T4xxefEGh9KQr8rmN1BJ9Jg28Vww5pt3pNfGD1ydDxj3yS3e5qsM1zJlggaR6FPmsHFkpRIu2P+50UJVsqx/TI1G5MseEcgO1m3KqjlOX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246050; c=relaxed/simple;
	bh=a5Jp6mfGJES740Kmwe2Qgg3Yx3hK7KxstFQORZMCuIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHkcRmI3aJkUwfGUhjFbsg8l5alPDp2iqb8axsLMB0LuiEKBtzWVG4mF4lsVU5c8xkgOu9/s2H6Ykok/re0qiQIpP6w7iKHdLEW2vl1wdmIAnVS2UFPRmTeuylV1afDXEd/LibeX5lOtv1Wy/tTSKlbDXbbCdab7WmyDAMcr1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUZw86qE; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUZw86qE"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895353e9051so20717797b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 Oct 2026 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246044; x=1791850844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pRRpMaF9ko2Srw6Ys7I3I2bnCyLXgS9/T6nITSERbCI=;
        b=cUZw86qEAWbfTcp1EXXRx2EuJzsgKq9UP/QnpRO5F1TwG3l3svVt+l1mDVAgebqlts
         kuM94OVh2CmyeoLi1+W5t3dyINNp2Ck0y/UZD1p78uc6GoZRIY2W0d6bIEt9CVLQJX7U
         KxN9T8uTf1bKm2gs+VsWdGXo9XyPDLy3ibMsxeQ64BJIjc3NvE9qeiDHofVj08K2PR54
         8u3iFREvi+WmnJ14wha25aRobxIwg10zFgnjimzQrO637fwpWAuaptPG2cVc1Px4n6yK
         EKRTX9jvLNUPrVOPVXcCMXzgQxShy55WLTrNbJZoAy3QgmhtcDe0Ki741irvNngKMk2x
         IOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246044; x=1791850844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pRRpMaF9ko2Srw6Ys7I3I2bnCyLXgS9/T6nITSERbCI=;
        b=jnwyFP+SAViTr0kAoL35cfoXkLbMs7fcHo0xMnITYORzoh3qiUemBckvaTNQ87YeAe
         WUzxcCMjUkv+oPuwr1irxikoTM10B3eeyJ3C2uIivWM3l4+uSMekZcPr4Piy/WikPuBc
         iy6izeO0uflJj5oVj7yL6NBLLLRQCqjMn8BZukabbsJAfaDQf9QXcq0KEpvP7dqXrTcV
         wDf6QXon1BnCo9UVezOpVXrsLlwNyE2T3W5P5IlWWizY5qUVwalKMTKW3iwr601QvbG9
         bouiLxZndVkz988FQ1zwr7kHEG76UC06HCceC6PeA8BALQGef+V/PmdwxoWl20h7xMN7
         mJWA==
X-Forwarded-Encrypted: i=1; AKwUvBxkvFHe7eU+pjyPafo/p5k4N+qReYdaft+GcEOhkTdEOUbGo3ktkSqnhAD7qDpFMzHKWmdzOOmHF4LhEz2WStsCj4Dxyis=@vger.kernel.org
X-Gm-Message-State: AFq9FYLc3DjTe3jLAxxoq2kkGw8rn4zGXwCr24Nn1gPuLNvC/O2eedNH
	qAXPvUApDxxTLVmiykQ1gntBEUkgHyEWM6esGVEsvCVhQ50agAA6oXvq
X-Gm-Gg: AYBFou2UWEFjoodNDv3NF8p3zun2G6Parss4oWDADS4Vs4GpVJk5dV1tidheZTwf9tk
	b6e7558Bin6YvBi+PAUJ4P0VWRSwBD4dVCidWCX6U1SOo3jF58aLIz8QLPzUvoLGPdLImLyzm0W
	rgWiW1yxSX2i5u0zzMlGRUCTQXbKPC8lboqWWlEoLnuHps9xdkTeZDVax5LrURbqZ7l0bxAhOpK
	O8R14OHuBudvvGhzTj0D3JkXS+Gy7UWXfSFUwHqLTIzhMSi5VzHfoeMTVF9tCu/+9O9rv0JlW9g
	A34b7hfl24nHLp0RaRlbgDsEeZ10rjI7YenZI9YE5XEfIpVTID5lAjttrGRgNrD3X4EihetsCJf
	CFrDOSxPBBsc/ec+UFQeqGml/ctxoZUqu1iUxn5bEC7WwpnrsAhgJjjkx4ZMTGWTGBR/80NDaId
	2u0CBVfShaAjm2BlD0KeDvA3dkxZNTTR6pJw8rI315Tr75nZ4pLBLutPBuLkznE4sQAHTevuxTy
	Q==
X-Received: by 2002:a05:690c:c4e3:b0:8a7:d419:e275 with SMTP id 00721157ae682-8ae399a88cdmr51525987b3.26.1791246043690;
        Mon, 05 Oct 2026 17:20:43 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:43 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH bpf-next 05/12] namei: make vfs_walk_ancestors() stepwise
Date: Mon,  5 Oct 2026 20:20:12 -0400
Message-ID: <20261006002020.2890858-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006002020.2890858-1-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restructure the walk into a stepwise engine - vfs_walk_start(),
vfs_walk_next(), vfs_walk_end() - private to fs/, so an iterating
consumer (BPF) can drive it with every step and invariant staying in
namei.c.  vfs_walk_ancestors() becomes a loop over it, preserving the
callback contract.

The position's flags move into the walk state, where the next step
needs them anyway: stepping off a disconnected position resumes at the
root of its mount.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/internal.h |  15 ++++++
 fs/namei.c    | 141 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 117 insertions(+), 39 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..3ce2220ff57f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -71,6 +71,21 @@ struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
 			   unsigned int lookup_flags);
 int lookup_noperm_common(struct qstr *qname, struct dentry *base);
 
+/*
+ * The stepwise engine under vfs_walk_ancestors(); fs-internal so iterating
+ * consumers (BPF) can drive it, with the walk invariants staying in namei.c.
+ */
+struct vfs_ancestor_walk {
+	struct path pos;
+	unsigned int pos_flags;	/* VFS_WALK_POS_* describing pos */
+	unsigned int flags;	/* VFS_WALK_* */
+};
+
+void vfs_walk_start(struct vfs_ancestor_walk *aw, const struct path *path,
+		    unsigned int flags);
+int vfs_walk_next(struct vfs_ancestor_walk *aw);
+void vfs_walk_end(struct vfs_ancestor_walk *aw);
+
 void __init filename_init(void);
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 2e6ea19714b2..73f25152d917 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2229,6 +2229,97 @@ static struct dentry *__path_walk_parent(struct path *path, const struct path *r
 	return dget(path->dentry);
 }
 
+static unsigned int vfs_walk_pos_flags(const struct vfsmount *mnt,
+				       const struct dentry *dentry)
+{
+	if (unlikely(IS_ROOT(dentry) && dentry != mnt->mnt_root))
+		return VFS_WALK_POS_DISCONNECTED;
+	return 0;
+}
+
+/* No boundary: ancestor walks go up to the real root. */
+static const struct path vfs_walk_no_root;
+
+/* Internal walk flag: the starting position has been yielded. */
+#define VFS_WALK_STARTED	BIT(31)
+
+/**
+ * vfs_walk_start - begin a stepwise ancestor walk
+ * @aw: walk state, valid until vfs_walk_end()
+ * @path: position to walk up from; never modified
+ * @flags: %VFS_WALK_* flags; none defined yet, pass 0
+ */
+void vfs_walk_start(struct vfs_ancestor_walk *aw, const struct path *path,
+		    unsigned int flags)
+{
+	aw->pos = *path;
+	aw->flags = flags;
+	aw->pos_flags = 0;
+	path_get(&aw->pos);
+}
+
+static int vfs_walk_step_ref(struct vfs_ancestor_walk *aw)
+{
+	struct dentry *parent;
+
+	if (unlikely(aw->pos_flags & VFS_WALK_POS_DISCONNECTED)) {
+		/* Resume at the root of the disconnected position's mount. */
+		dput(aw->pos.dentry);
+		aw->pos.dentry = dget(aw->pos.mnt->mnt_root);
+		aw->pos_flags = 0;
+		return 0;
+	}
+	parent = __path_walk_parent(&aw->pos, &vfs_walk_no_root,
+				    LOOKUP_BENEATH);
+	if (IS_ERR(parent))
+		/* The real root. */
+		return 1;
+	/*
+	 * A mount crossing can step onto a disconnected root, whose parent
+	 * is itself: only then is the mountpoint itself yielded, flagged.
+	 */
+	aw->pos_flags = parent == aw->pos.dentry ?
+		VFS_WALK_POS_DISCONNECTED | VFS_WALK_POS_MOUNTPOINT :
+		vfs_walk_pos_flags(aw->pos.mnt, parent);
+	dput(aw->pos.dentry);
+	aw->pos.dentry = parent;
+	return 0;
+}
+
+/**
+ * vfs_walk_next - yield the walk's next position in @aw->pos
+ * @aw: the walk
+ *
+ * The first call yields the starting position itself.  @aw->pos_flags
+ * carries the position's %VFS_WALK_POS_* flags, with the semantics
+ * described at vfs_walk_ancestors().
+ *
+ * Returns: 0 with @aw->pos valid, 1 once the walk has passed the real
+ * root.
+ */
+int vfs_walk_next(struct vfs_ancestor_walk *aw)
+{
+	if (aw->flags & VFS_WALK_STARTED) {
+		int err = vfs_walk_step_ref(aw);
+
+		if (err)
+			return err;
+	} else {
+		aw->flags |= VFS_WALK_STARTED;
+		aw->pos_flags = vfs_walk_pos_flags(aw->pos.mnt, aw->pos.dentry);
+	}
+	return 0;
+}
+
+/**
+ * vfs_walk_end - finish a stepwise ancestor walk
+ * @aw: the walk; its positions, including @aw->pos, become invalid
+ */
+void vfs_walk_end(struct vfs_ancestor_walk *aw)
+{
+	path_put(&aw->pos);
+}
+
 /**
  * vfs_walk_ancestors - invoke a callback on a path and each of its ancestors
  * @path: path to walk up from; the caller's path is never modified
@@ -2253,55 +2344,27 @@ int vfs_walk_ancestors(const struct path *path,
 				 unsigned int pos_flags, void *data),
 		       void *data, unsigned int flags)
 {
-	const struct path root = {};
-	struct path walk = *path;
-	unsigned int pos_flags = 0;
+	struct vfs_ancestor_walk aw;
 	int ret;
 
-	path_get(&walk);
-	if (unlikely(IS_ROOT(walk.dentry) &&
-		     walk.dentry != walk.mnt->mnt_root))
-		pos_flags = VFS_WALK_POS_DISCONNECTED;
+	vfs_walk_start(&aw, path, flags);
 	for (;;) {
-		struct dentry *parent;
-
-		ret = cb(&walk, pos_flags, data);
+		ret = vfs_walk_next(&aw);
+		if (ret) {
+			if (ret == 1)
+				/* The real root was reached. */
+				ret = 0;
+			break;
+		}
+		ret = cb(&aw.pos, aw.pos_flags, data);
 		if (ret < 0)
 			break;
 		if (ret == VFS_WALK_STOP) {
 			ret = 1;
 			break;
 		}
-
-		if (unlikely(pos_flags & VFS_WALK_POS_DISCONNECTED)) {
-			dput(walk.dentry);
-			walk.dentry = dget(walk.mnt->mnt_root);
-			pos_flags = 0;
-			continue;
-		}
-		parent = __path_walk_parent(&walk, &root, LOOKUP_BENEATH);
-		if (IS_ERR(parent)) {
-			/* The real root. */
-			ret = 0;
-			break;
-		}
-		/*
-		 * A mount crossing can step onto a disconnected root, whose
-		 * parent is itself: only then is the mountpoint itself
-		 * visited, flagged, next iteration.
-		 */
-		if (unlikely(parent == walk.dentry))
-			pos_flags = VFS_WALK_POS_DISCONNECTED |
-				    VFS_WALK_POS_MOUNTPOINT;
-		else if (unlikely(IS_ROOT(parent) &&
-				  parent != walk.mnt->mnt_root))
-			pos_flags = VFS_WALK_POS_DISCONNECTED;
-		else
-			pos_flags = 0;
-		dput(walk.dentry);
-		walk.dentry = parent;
 	}
-	path_put(&walk);
+	vfs_walk_end(&aw);
 	return ret;
 }
 
-- 
2.55.0

