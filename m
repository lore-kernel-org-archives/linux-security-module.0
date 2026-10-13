Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213851EDE7
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910104; cv=none; b=esXzpWmEx1xE7SsyR1uj+Mf8QYeUgrWGZ2mIZDr58VCIAtoxQsWJcRWjEb0EWF5fgX2M0MgzEA+MxHjP1kyoybCRVRPo6dVBpzSsuSdWmRN9LJyI4lMlCzEvLjZRQm2+zqb596df8ot/pDn8b0cWGu78B33JMwAB1Xdh6/nUzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910104; c=relaxed/simple;
	bh=9JjUYHYRrywinpEdY5iw3CqE6VCjmo76V0jstCXCwS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRGui/gwgMRk1TB6Qh611d8u3AShyH7/V+Wa6nMQfRiPi1yBFtRd989ms1duwn4jUOLWZeoom0AP8nb51tJXSmXKSIfTkpfX4huxzwoIX20VhVDhyqcCCecD+kx27H+3qZH1yRKmyRhuIPj47Uk1EUQSsDoLYIegPTJPaHsNQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbwCGCJ2; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbwCGCJ2"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6768403e9bbso2668082d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910101; x=1792514901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRYrGC16XxhpyEhg63tIO972e5kAiFs1OtDRCUKC8kk=;
        b=AbwCGCJ2oCdUheSdSr+wVmW6cvBx8q2BASbQaDEnfO44kqG4mkoUSTFHN5UAiRgpmW
         GAMDPro5DKxotk2CAZPyLsBbKU6kEAJfxkEqYA1vAduBlMaGDXRaA6KonDvvhOsUmpEM
         JyUVTw1UslSShUE6ZoRtMciG8YkaYRwf2nP+Lc1PEzx/v++4PLDeMWBUlSpMk10NXqnW
         1zmGGw339mIi6ZRdFDp2jvXk/cSCj1p50oP0UC6LiN/Tkbp3CsYKn8qZFOldcdhXZywd
         Y4QQfkSXxA69iTTvAHBPaP2xBAfBcVtGC5Mz7Ff5JO93Ljqw6Serz28dmuhgrwFrV/8c
         RXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910101; x=1792514901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRYrGC16XxhpyEhg63tIO972e5kAiFs1OtDRCUKC8kk=;
        b=G3stOnTIN08FFaVdyx/6z1VAMybAdQUIJOD2q6JnmGn7nm8we32qqjMSjOXshqtdcs
         QhcVTJpmDFOxKbnAXt0QvYPSeH4XTaKexbAJbpKvA7D/rIbTRvjtgv1GdKYy79LBraZJ
         sfHJhna/N3itVl+LcqjCLowsXAwqcQg3ZvPPS19nCqY95dVwoBbkn4s90MS2qRQ1FcNM
         VtOODZuNr8oHkZ2yWrQkj4dnEuc/VdVquMcbVtToqlNz43z86yf7boCzbi9v+HDS2YUI
         8x/qFPcDmQpFiEamDQ8VRmKOm5/biAuXLk5Qff6UDrL5EkcyIaXBy7jkU2hCGEz9eU2u
         trdA==
X-Forwarded-Encrypted: i=1; AKwUvBzznYhpEVLqMqFbpMUe+sdxSXKM2NYjd9yvMM96FjbeWAfLTiZAoFFH4gDYLRxKs7zvLpAXeo7CDuQjBSva352PSVg6Hjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdiV7F89f3EUtmJZUL6PXpHYpe3ts1p7gOFdFVbJ/fQqp+dDYJ
	gp+abXmzsBR6LiCaf344exlMo7neMzmI4Ho659+TwBmL1R05h6AvTHhH
X-Gm-Gg: AYBFou2/2MMnFOSBJZz4geLWMOa1zBTsbC09H/B6O/0Hg3j7YYfSEsnah71flbz3xXS
	mFhiGuL8terXULBf1HS/imscrozcmzxlTmHkoGr8FGK9XGzLaeJBN7pTkHou9Wg9AefhPgK8YAk
	7YhK/5/PXHHjoSAekckzhYekahgvzeBM4TNBy7n5xegMdc1LmocBi4W+18RxEksxU2e1KeEU7Wf
	pq+TIw4kbEn0nnU17yI0sa36Ruiqsr9Eql1s10KvSc03SLyc9Sb5tpTQe1MW0QpD6pYfpOjkfY+
	rQiN2RZYSpC1tRWvzipu6xQMoeXYydD4pTMvMokL52dCpmiuM6FlG2ZsFXgh98B+fQc+8Ix0UyO
	tYHN+4EeplITZ3VVNN+6UAMKFXXqa93PZfk6KZEWWkKSXOWYvJVnPfwB7KYpDeNY+nEJhbe4Bew
	Sp5AZq23JP09LDVVI/TeXpWZHKcZurPT8U0aUatOWB/aCwzM9EwF5rgVpYKM5LFglwUZV9LcdwF
	A==
X-Received: by 2002:a53:da43:0:b0:677:dc7e:48c5 with SMTP id 956f58d0204a3-67936769395mr3239253d50.10.1791910101212;
        Tue, 13 Oct 2026 09:48:21 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 02/11] namei: add vfs_walk_ancestors()
Date: Tue, 13 Oct 2026 12:47:51 -0400
Message-ID: <20261013164800.2906577-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013164800.2906577-1-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a callback-based walk over a path and its ancestors, built on
__path_walk_parent(): the kernel owns the loop and the callback must
not sleep, so an rcu-walk engine can be added later without changing
the API.

Internally the walk is a stepwise engine - vfs_walk_start(),
vfs_walk_next(), vfs_walk_end(), static to namei.c for now, with the
walk state declared in fs/internal.h - and vfs_walk_ancestors() is a
loop over it.  The position's flags live in the walk state, where the
next step needs them anyway: stepping off a disconnected position
resumes at the root of its mount.  A later patch exposes the engine so
an iterating consumer can drive it, with every step and invariant
staying in namei.c.

Disconnected root dentries are reported to the callback instead of
terminating the walk.  A disconnected mountpoint landed on by a mount
crossing - the one position this walk visits that a
dget_parent()/follow_up() loop never does - is additionally flagged
VFS_WALK_POS_MOUNTPOINT, so security callers can reproduce their
pre-conversion evaluation sequence exactly.

Suggested-by: NeilBrown <neil@brown.name>
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/internal.h         |  10 +++
 fs/namei.c            | 140 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  14 +++++
 3 files changed, 164 insertions(+)

diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..bfe62c9bdfc9 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -71,6 +71,16 @@ struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
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
 void __init filename_init(void);
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 808fb4bed7c4..6d5b4b214334 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2229,6 +2229,146 @@ static struct dentry *__path_walk_parent(struct path *path, const struct path *r
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
+static void vfs_walk_start(struct vfs_ancestor_walk *aw,
+			   const struct path *path, unsigned int flags)
+{
+	if (WARN_ON_ONCE(flags))
+		flags = 0;
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
+static int vfs_walk_next(struct vfs_ancestor_walk *aw)
+{
+	if (aw->flags & VFS_WALK_STARTED) {
+		int err = vfs_walk_step_ref(aw);
+
+		if (err)
+			return err;
+	} else {
+		aw->flags |= VFS_WALK_STARTED;
+		aw->pos_flags |= vfs_walk_pos_flags(aw->pos.mnt, aw->pos.dentry);
+	}
+	return 0;
+}
+
+/**
+ * vfs_walk_end - finish a stepwise ancestor walk
+ * @aw: the walk; its positions, including @aw->pos, become invalid
+ */
+static void vfs_walk_end(struct vfs_ancestor_walk *aw)
+{
+	path_put(&aw->pos);
+}
+
+/**
+ * vfs_walk_ancestors - invoke a callback on a path and each of its ancestors
+ * @path: path to walk up from; the caller's path is never modified
+ * @cb: callback invoked on @path, then on each ancestor up to the real
+ *      root, crossing mount boundaries.  @cb must not sleep and returns
+ *      %VFS_WALK_CONTINUE, %VFS_WALK_STOP or a negative errno to abort the
+ *      walk.  @ancestor is only valid during the invocation; @cb must take
+ *      its own references to keep a position.
+ *      A position whose dentry is a disconnected root is flagged with
+ *      %VFS_WALK_POS_DISCONNECTED (plus %VFS_WALK_POS_MOUNTPOINT when it
+ *      is a mountpoint a mount crossing landed on rather than a parent);
+ *      if @cb continues over it, the walk resumes at the root of that
+ *      position's mount.
+ * @data: opaque argument passed to @cb
+ * @flags: %VFS_WALK_* flags; none defined yet, pass 0
+ *
+ * Returns: 0 once the real root was reached, 1 if @cb stopped the walk, or
+ * the negative errno @cb aborted with.
+ */
+int vfs_walk_ancestors(const struct path *path,
+		       int (*cb)(const struct path *ancestor,
+				 unsigned int pos_flags, void *data),
+		       void *data, unsigned int flags)
+{
+	struct vfs_ancestor_walk aw;
+	int ret;
+
+	vfs_walk_start(&aw, path, flags);
+	for (;;) {
+		ret = vfs_walk_next(&aw);
+		if (ret) {
+			if (ret == 1)
+				ret = 0;
+			break;
+		}
+		ret = cb(&aw.pos, aw.pos_flags, data);
+		if (ret < 0)
+			break;
+		if (ret == VFS_WALK_STOP) {
+			ret = 1;
+			break;
+		}
+	}
+	vfs_walk_end(&aw);
+	return ret;
+}
+
 static struct dentry *follow_dotdot(struct nameidata *nd)
 {
 	struct dentry *parent;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 86d657b24fc6..3e198de7a0d3 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -162,6 +162,20 @@ extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
+/* per-position flags passed to the vfs_walk_ancestors() callback */
+#define VFS_WALK_POS_DISCONNECTED	BIT(0)
+/* the position is a mountpoint landed on by a mount crossing */
+#define VFS_WALK_POS_MOUNTPOINT		BIT(1)
+
+/* vfs_walk_ancestors() callback verdicts; negative values abort the walk */
+#define VFS_WALK_STOP		0
+#define VFS_WALK_CONTINUE	1
+
+int vfs_walk_ancestors(const struct path *path,
+		       int (*cb)(const struct path *ancestor,
+				 unsigned int pos_flags, void *data),
+		       void *data, unsigned int flags);
+
 int start_renaming(struct renamedata *rd, int lookup_flags,
 		   struct qstr *old_last, struct qstr *new_last);
 int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
-- 
2.55.0

