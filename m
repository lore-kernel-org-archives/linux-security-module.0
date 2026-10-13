Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15851E45F
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910100; cv=none; b=hMLyYebfttgNxhEu0pCWZPBfrn+Eqdy2rfSm8wRgRAH/X7dl1TSmqiTGzg8hDwimPiCoYeg1KBpGmW5T3hzPxyUxJmLzer+aBkt3fntgy/3NJO/ZaVGxxjFKp8a2UpbdHnUgXqY/P6TlwpEfGk1vC8EKAlx0CSAz+Ntd8+qGpoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910100; c=relaxed/simple;
	bh=CrnP/j6cbPUgh+l4ikUyaCHY+R2QqsjDap3IgzAfqBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV2cZWDuQvHsKtK6kKPbJYZlDxpsf05Ft1+HYEPFBlQwReFVczyYmMOHElYXUxhadHnVRxLvx6sg49mD89Jz2bsYpF5P5bZl5NPhzGr2FRrXLtIdgdgcHK/8FS8gT/QyAat0hRJjaZU4DImX+nsgfc4CQ/H/COu9ASUJVU3XorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0VLgG52; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0VLgG52"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67489c8202cso2468139d50.3
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910098; x=1792514898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nd9w4dPTZ+abWi8KVOZVVNdngpKRtmSbi2Eu/1b0iCI=;
        b=G0VLgG52OjWKpAdLzmuQH80aLIwCVuG1I1nJtCY+IWUrOOnRkQqfhpWAzioarCygxk
         +CaTDVXpB9yk+/tDxmMD7psOnSBlFNzQYL+GLIyCtMD3uGFr+B1rIpcD/urYUjIVaDsL
         cjVSty2lQH2eRIr7Uz5ctAv1KsRXkc5OpXR26NIvujiZ+H/vofBXJvEe/j6cbXJaN9n/
         DtJLWSN3efD7r5iVKlovixP5z5dTRFUOBBFp5+/SDkts/D+GVuf3sJ4F7wEtXtqoKXZa
         lF7gJOeNNwXd2/OA1RW2QBf5vrM6ksO5RS0XYIQgJEQsCJAixULRoYgoSC0vQcrMrnSN
         qoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910098; x=1792514898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nd9w4dPTZ+abWi8KVOZVVNdngpKRtmSbi2Eu/1b0iCI=;
        b=JyVjDthlqRAEbHDQIOTOOgxEIxzKsTv7kZZVBLtmZrz22zVpkwIqMsK9Empc0kJS5s
         FZvIqxoGqnPBhz2Zm7bDwcM4SGnpWIQIrD1gET+hwxmPMyRmdNDc5U2L/q1fg/rZLrP9
         6jhUgpcIHhH4R3BqNxobLQN9/dOY7zGk8DyGy+SyNCgF8MqwYrMF/vAickmOKXZLAHyJ
         N0NVUqR92g2/1+FVj4ks1eE+J7vajMOP9FCSE77z1v5YSMH6oEEdyGVXC4iPbIzQ8x/l
         zEdkLg2UQzcTU3PHCbjAxfraU2shUN/JBrzYorFivG73P+JGmgSLWpCUanxNyV0z7+eY
         Miaw==
X-Forwarded-Encrypted: i=1; AKwUvBxLpVK+HPIhYNYNpa5g6p/4jt35ykVH2p0c/XnDGgssJR6zmdVSYKK0+AC8RAFDmDYczAU/mYHN5LsLttHtoDykxRp08gM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKArZYQ7BZecZS88TVu+SZzJuymORlslwKcTkY5CvCs98Es9vBC
	HvgX9YBXXZmBsW9lRLD31mUnswh15FAKvMNT1pW95RSxxGvom3F6aXHi
X-Gm-Gg: AYBFou2A2Q866fcqj7c1LTu3dyyUNBciK1GgCteQnSjRHdD5YctS8sVJBy22JKBwBa+
	jJ9fP8CCCJ7yMi0cfHqZqWXPtAn8RvlgGDxJtVrCIfJP7qb9ODa/M1+3IBlcwiJ94DMzwxUE345
	qdzsrbPXzvzCLtbCQJDyv2EXr1tYaSmq1Ag+lrfTT6jG4d8KfHDxQdppj61vfc/owfWY6lSF0of
	riHJaRDwmmzbkRfNPK2lhCOSIUsY9SPM4blZVEL0egbXLXARkAcPlQg8w/QoxACaTeXF9O+kqFl
	DvU5jpqk6/U+3xt+VTAFV3SCR0XO1LC+l3MPavywuHe8JS3iENl0aqUSWKAkUTplS09Urdh3TY0
	tVhYfGBJncoc+Csakk0g3u3itSwb+Sg+jhoi4jBxG2sHhLb8kgxVKFZFSghquFQuI36r28TwvgA
	XNuYB65oGp6ec80lig6BbYfYhypVw2ab+OH3ikc7oGgoMA1Zg46sbPqtM8qmKoPKQ4EEx03N2c
X-Received: by 2002:a05:690e:480d:b0:675:5d66:765f with SMTP id 956f58d0204a3-67936274256mr3383929d50.28.1791910098167;
        Tue, 13 Oct 2026 09:48:18 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 01/11] namei: introduce __path_walk_parent()
Date: Tue, 13 Oct 2026 12:47:50 -0400
Message-ID: <20261013164800.2906577-2-utilityemal77@gmail.com>
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

