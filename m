Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DAB261B9E
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246031; cv=none; b=R/UqerpykQu0Xnsd6AZzOy5WvOt68M2q6RuozBos1tLY5SkFdgq4hZDsN62qikUVXyRVH3m9bq0gD7Bx24wGcH72275HaZtU/qIawVX9KxTv1gMzh3ALviNebTrFSO8m9ANB97Nq+haWCqWR+zTyRqsQ+F7hyyYatwdEfgbVs5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246031; c=relaxed/simple;
	bh=CrnP/j6cbPUgh+l4ikUyaCHY+R2QqsjDap3IgzAfqBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te0Joe6y9JHyOwYXUDyTtz4UoAwt6RrylwzW29wO9u6LA9oB9y20Be87vV2QTf7LGkqe7S5wi13x8JLAWA0V7yovNwyI38QyOnAtfhjEK8noCDQc02viiugmxS0G4A0GAjpW6B0iL5XhJvDukoI4YnA4KP8uLp+mZBxqn/OLwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsWjH1B/; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsWjH1B/"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3e848918so15300307b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 Oct 2026 17:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246029; x=1791850829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nd9w4dPTZ+abWi8KVOZVVNdngpKRtmSbi2Eu/1b0iCI=;
        b=fsWjH1B/S9AwS+6+vlsmr8CvOErZ2IOAXdpnetKftnsnmjXfigPwHgIZfi8FMVyYfw
         0C3KLAZQWGyWwbdAOExAu3XeadBWderqzpGottU4WG+qMKYSgCjL6n7BvT7MMUNK3qiI
         khUG/AEK5AmZideyRDECO6t8yUpkxNVIk+Q1wYkbYveYTsGaNfF/8ZMcRNfP/PDTn/i9
         R6EYHESl+xGfQpWvTektSPlWB1o7Gu1ViWYFE184sK5Q7eRytV7D2mlZEDZ/UrPWaooC
         Uzr+vRK8kB48x8PyvaZvZwH10bqWSOXvCciOgs9OQKNBsZukuKopImLen4TTDFwRrKbI
         K0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246029; x=1791850829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nd9w4dPTZ+abWi8KVOZVVNdngpKRtmSbi2Eu/1b0iCI=;
        b=LD2UfnAxQwtsgvMgOTKmSMWHc8Ay6Ku7MZ5TyQlblo7yW/mj3FiythBhsy1gGy5CS8
         JaGqv1sT0zIYn8KVSnq258nGkx2wTDoNTZIVbdOvzpb6zxeh6WVLL6t1F6Q7SDxCWzV8
         VOoVSqH+D4bb5xbjNpNkm0/L9Zlf1XJJlobLqfHh1t1SfGaCeskMcquqKD3zlgAM9Nrs
         kQI0zBq4tYyrg2ieq2VyCJUEV9JH1dye9fpRrHJGbnqqGG+wvkbcNB+RCT5n09UezWfF
         Q6jrLgl0tUBuRchOrYbCDmTVbDElfA6vW4G+/1MxB5RR5tjAoiUSU46vcoQeepbjc+lN
         gDiw==
X-Forwarded-Encrypted: i=1; AKwUvByjgen7q+29vV/o8JCpb+8bHNDvf4ZuItTH6oKhcvfO/vNc9Vf4SukojfcOwmCRAVTiotnAWToYiZ1RLsaHtDEK4sFHR0g=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5m11C6elPMT9KIwiOYv+U6o+Dxd7xrR4hluP4dkYDoD3ui8Vt
	kMd7N1UhkdNvt1gCbDXNLW14TELZEVKF+sKPU8s+eEMAEokQ0Sv8c0af
X-Gm-Gg: AYBFou2h/TXjKl3NoWMGZOK/sWun0W69ApeA7FC9xwUNJV9F1A7grDhjZwog6szpb+3
	DGwQu7eN+OEWD4dDGLzM2NrbGE41uNc14Wj88fldve4bwOeBvm3utFWsbN/MlfLT0A+XG0kb/UA
	4zDr3Op0Xqivmo8tEShw8tlS3Ck1rELL6rweT7OSF21PqkRUl+kD6Zp7jglplgqqF+z+d2iBtqA
	V2WAUDX0thfB/IaVp5fMghsaVcFy0gOxf+KGBw+ackUJlhE4Xqve7bNodIMsmqcgU3fNeiE+jsq
	L0H5k/nu27LN00Qs6xnFCHnqJG1W85MAk880KgyzDThLTVEz1s8Oa2JNEWg/lv1pKRaplzgKubp
	wKykEOki4x70KnbWvogRgedR/cwYfWm3d8fQhJwxcjQAJXG/CPpXhnRQ3kwPbVsVKpFnwgXo/ej
	DiOnBYnZFkO6rxpbU4/cRUuM7SG+rCZkGyahIfsGKo6uv1M2Kcu5dbYgMjsNDZTjYyQCxNcLZ77
	ccauXdoE8Im
X-Received: by 2002:a05:690c:6b12:b0:8af:1c27:9b89 with SMTP id 00721157ae682-8af1c279f0fmr16207967b3.5.1791246029153;
        Mon, 05 Oct 2026 17:20:29 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:28 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 01/12] namei: introduce __path_walk_parent()
Date: Mon,  5 Oct 2026 20:20:08 -0400
Message-ID: <20261006002020.2890858-2-utilityemal77@gmail.com>
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

From: Song Liu <song@kernel.org>

Factor the step-to-parent logic out of follow_dotdot() into
__path_walk_parent(), which walks a plain struct path to its parent,
crossing mount trees via choose_mountpoint().

This will be used by a VFS ancestor walker serving landlock and BPF.

Suggested-by: Neil Brown <neil@brown.name>
Signed-off-by: Song Liu <song@kernel.org>
[justin: rebased, kept the helper static to namei.c, dropped the
 path_walk_parent() wrapper and the namei.h export]
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/namei.c | 62 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 20a6534ea3ef..808fb4bed7c4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2192,36 +2192,62 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
 	return nd->path.dentry;
 }
 
-static struct dentry *follow_dotdot(struct nameidata *nd)
+/**
+ * __path_walk_parent - step towards the parent of the given struct path
+ * @path: position to step up from; if it is the root of a mounted tree, it
+ *        is first updated to the mount point that tree is mounted on
+ * @root: boundary not to be crossed; if zero'ed, walk all the way to the
+ *        global root
+ * @flags: %LOOKUP_NO_XDEV returns -EXDEV once @path was updated to a new
+ *         mount; %LOOKUP_BENEATH returns -EXDEV at @root or at the root of
+ *         an unmounted tree, where @path->dentry itself is returned
+ *         otherwise
+ *
+ * Returns: the parent dentry with its refcount incremented, or an ERR_PTR().
+ */
+static struct dentry *__path_walk_parent(struct path *path, const struct path *root, int flags)
 {
-	struct dentry *parent;
-
-	if (path_equal(&nd->path, &nd->root))
+	if (path_equal(path, root))
 		goto in_root;
-	if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
-		struct path path;
+	if (unlikely(path->dentry == path->mnt->mnt_root)) {
+		struct path new_path;
 
-		if (!choose_mountpoint(real_mount(nd->path.mnt),
-				       &nd->root, &path))
+		if (!choose_mountpoint(real_mount(path->mnt),
+				       root, &new_path))
 			goto in_root;
-		path_put(&nd->path);
-		nd->path = path;
-		nd->inode = path.dentry->d_inode;
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
+		path_put(path);
+		*path = new_path;
+		if (unlikely(flags & LOOKUP_NO_XDEV))
 			return ERR_PTR(-EXDEV);
 	}
 	/* rare case of legitimate dget_parent()... */
-	parent = dget_parent(nd->path.dentry);
+	return dget_parent(path->dentry);
+
+in_root:
+	if (unlikely(flags & LOOKUP_BENEATH))
+		return ERR_PTR(-EXDEV);
+	return dget(path->dentry);
+}
+
+static struct dentry *follow_dotdot(struct nameidata *nd)
+{
+	struct dentry *parent;
+
+	if (path_equal(&nd->path, &nd->root)) {
+		/* nd->root is never path_connected()-checked. */
+		if (unlikely(nd->flags & LOOKUP_BENEATH))
+			return ERR_PTR(-EXDEV);
+		return dget(nd->path.dentry);
+	}
+	parent = __path_walk_parent(&nd->path, &nd->root, nd->flags);
+	nd->inode = nd->path.dentry->d_inode;
+	if (IS_ERR(parent))
+		return parent;
 	if (unlikely(!path_connected(nd->path.mnt, parent))) {
 		dput(parent);
 		return ERR_PTR(-ENOENT);
 	}
 	return parent;
-
-in_root:
-	if (unlikely(nd->flags & LOOKUP_BENEATH))
-		return ERR_PTR(-EXDEV);
-	return dget(nd->path.dentry);
 }
 
 static const char *handle_dots(struct nameidata *nd, enum last_type type)
-- 
2.55.0

