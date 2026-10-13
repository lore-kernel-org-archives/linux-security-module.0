Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131D51E43E
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910113; cv=none; b=lhdbpxmQVZOcLKER0fpeoJG8IIZwVVzrjVU3MwwqsL7jDdnIXCSrIYGx/tH+dEdrq70c/HfWqCoW0QFXJ9XHPlN3XWCiQl0m09DYRg4Q8TDls6j1oNVZuxtT0/U+hnvPqr9CneY+cMoZvUIbxz/+sTa3V9Il6RMAfg7jCkj5Txk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910113; c=relaxed/simple;
	bh=K6RB3zG/56k22YI3NmNQcP41aWDJsiJH7Kgzt82dYec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgACtIcpXj7GrGS1VXMGxmcwLoxF+WlbyIf/Au8/5bz48o35SOGe+M88SNVZJzDhqurxGmVSjzSdv10/fzjUuuLDDzYgZdg9xR8/45Eh6UBJgOR8iVk/CrMjuodVVFI9Yv00YtVFu5WFRhfgmpgdg2X+Da4IDm/jX5wxQIWNM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrUaiLvC; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrUaiLvC"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66fca0709caso2587096d50.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910110; x=1792514910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/dvtBEldp5k/dyI1GCMlCiiP1Mw5D+YND/XHmJTYxQ=;
        b=WrUaiLvCbLZuplWS4/6pNj3dd22buHgUjEBc4nN5pgn/Vdi58E7mIp/7pU4Ul3U8/F
         jprHLi4dYLWvoWLZ8rtHDyaoIdmqGERsyoCx+0RTpw0IBvBbbU7woPXPLzuYedxGEWXu
         VsV5E9QzQzfCQ9bIvKQrYO+CVxVpdw0/cQ41tfOWHPQrP8ht9+hQAWydlknXsWYSZDdt
         BPof+81uKgfEpJZCSYgJXQev+dHQluBr4VLH+FP1DpWjFwEqqic2FSXqQQsfnxeNDJU1
         Qg8AzrObofAeWhYmd75MvZbFej+pejlFLMHgyhkFokUrmjVf6qPUaQMx8HkCn3hs4+VJ
         zz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910110; x=1792514910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M/dvtBEldp5k/dyI1GCMlCiiP1Mw5D+YND/XHmJTYxQ=;
        b=BB7962sJk35hOlb/KHtn4yAxL5x0sXiTdMK1K2fsnH3QBmXqQUv9iBeTZKPRvkFjZ5
         crQVF7ln0Fnf4kocAAMponXFNFeQX2WkOAWfwa/GDqo5R6IkYdJ9eduV5z+14wyjqa9T
         myIHUiC5V7uHhqAq00WTtZecu8/7Q+iSvYYbzKnR0kl7yghTwWvehkZkNO3RuaJlsPaP
         76ZF+JnBxCFEvYbXP52SsUatiX4CxPgrqVcCwA0aucLfkNkc6u0JnbM/o7Xb3zQn8nIG
         kUPAKM2QD6q2nEFfV+aEmS4usj43v5oxuZQWbNHATy4E15BkTNLPbeAk3+1+j9QoVYlB
         25KQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWT6a8V7DwM1hrNhGocYrXRCh3h4yGPJyzYIK/iRGVDfHmMthpvoIIesXCCjtplAtCP3wStVYDdIZFq4qRKFbpYkN1h+g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtd8Sw2+FS4KzTZ5zZWdmH0SckJwxhV30XQgsmTNmSdYRddKnp
	nk7Lhsc+j5VO/sscRB2QHQAi/Hj8xbWOTqKk8TSHpDQ8TACAN4YdoJl4
X-Gm-Gg: AYBFou0gsarBIwFtZdgaFvU72fny8c+KGbP/a709QqFKTY7J+K52bSlrwg8iK1n1XsR
	8qcS6Pue4YzDjSou41DuXWtNAv7rRqL9PHxKMxDbCNEgUBo4CnnWcPGD5W61Ws4xu/Z87iql8VW
	Me+BMomqqQRWG+QOwhFHKood4HcwzCMm1xXmxpjDFAlHC2c0BW8lj8hGsAPSztmAtAwylWEvek+
	uZiUzw96TLaqog8Am6+Pfj5ngqsHwe1dqIOmQvYHVIlxg57AU9mGYwj1vG4DHihlepVrjHn8FXa
	OCt7BS8ziLq+asLkDfM5ZPo2sA1R1KDu56RoO7Qx+xwDf/uppXsBU2w0dW2aYFqlf6NJkH4v8N5
	7eNCu5e1WoZq6ZXWZOkVUfsXS2rk2Pc+XI1sezCo6JAvpMX9wXkJ2f7rN3QGgf1uhJ/EFE8Cmzk
	yYAO7G/E8xeab8bM5nUSrP0DEWg/HwS0ZiZJynv13GBepaS1wpepyi6NYAqJbt1jsbiiIF+4RS
X-Received: by 2002:a05:690e:138d:b0:677:b589:d002 with SMTP id 956f58d0204a3-679362f3616mr5451286d50.78.1791910110471;
        Tue, 13 Oct 2026 09:48:30 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 04/11] namei: expose the stepwise ancestor walk to fs/
Date: Tue, 13 Oct 2026 12:47:53 -0400
Message-ID: <20261013164800.2906577-5-utilityemal77@gmail.com>
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

Make vfs_walk_start(), vfs_walk_next() and vfs_walk_end() non-static
and declare them in fs/internal.h next to the walk state, so an
iterating consumer (BPF) can drive the walk with every step and
invariant staying in namei.c.  vfs_walk_ancestors() and its callback
contract are unchanged.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/internal.h | 5 +++++
 fs/namei.c    | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index bfe62c9bdfc9..3ce2220ff57f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -81,6 +81,11 @@ struct vfs_ancestor_walk {
 	unsigned int flags;	/* VFS_WALK_* */
 };
 
+void vfs_walk_start(struct vfs_ancestor_walk *aw, const struct path *path,
+		    unsigned int flags);
+int vfs_walk_next(struct vfs_ancestor_walk *aw);
+void vfs_walk_end(struct vfs_ancestor_walk *aw);
+
 void __init filename_init(void);
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 6d5b4b214334..d6151fa27844 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2249,8 +2249,8 @@ static const struct path vfs_walk_no_root;
  * @path: position to walk up from; never modified
  * @flags: %VFS_WALK_* flags; none defined yet, pass 0
  */
-static void vfs_walk_start(struct vfs_ancestor_walk *aw,
-			   const struct path *path, unsigned int flags)
+void vfs_walk_start(struct vfs_ancestor_walk *aw, const struct path *path,
+		    unsigned int flags)
 {
 	if (WARN_ON_ONCE(flags))
 		flags = 0;
@@ -2299,7 +2299,7 @@ static int vfs_walk_step_ref(struct vfs_ancestor_walk *aw)
  * Returns: 0 with @aw->pos valid, 1 once the walk has passed the real
  * root.
  */
-static int vfs_walk_next(struct vfs_ancestor_walk *aw)
+int vfs_walk_next(struct vfs_ancestor_walk *aw)
 {
 	if (aw->flags & VFS_WALK_STARTED) {
 		int err = vfs_walk_step_ref(aw);
@@ -2317,7 +2317,7 @@ static int vfs_walk_next(struct vfs_ancestor_walk *aw)
  * vfs_walk_end - finish a stepwise ancestor walk
  * @aw: the walk; its positions, including @aw->pos, become invalid
  */
-static void vfs_walk_end(struct vfs_ancestor_walk *aw)
+void vfs_walk_end(struct vfs_ancestor_walk *aw)
 {
 	path_put(&aw->pos);
 }
-- 
2.55.0

