Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43A274FE3
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246054; cv=none; b=WGJsHLq/agO4MDJ34JoPvpgE8mwe5vf9iAgq1qyB9zx10kZzdUz9EXRnMP9Q8zOQGuxEevv3St5MT0+Ahj49XFUe/vbx0BhYSyqgDz41X/LZ4B+Z8T13h18a3pwsYUv3hlRXZ8q3lplpdsdFFfJQn1CVqnSkzaV3zzqrgKXhys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246054; c=relaxed/simple;
	bh=jlzmzVUZatc66HPQV+KRZVQKntcM2EXkVs5FTJwJSp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkgLkcf1/VzpMvfg0BWj+0NWzG1aGfc5IrW+FQDA84ZhQnPdW3unuh9DQkCXw+xmqphEu6Lws8DFS367X26RgBGlHRTnicvCEaaGarKN9+fN1tgqax33va/ivn4/gbSudkGnqUIDmWOPwMZIc0QzyqNI/8UXd7o+gmmqAMnlpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppf+DIku; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppf+DIku"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ac8a2ac52bso3549547b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 Oct 2026 17:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791246051; x=1791850851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TeNSAJLFPq7jjMeEaP2RymD5KGPr8j5TQzJn1I+wbQ4=;
        b=ppf+DIkuzcwF/DSvKYymITFgXHUOkLm5RteZj/beYEKhbNjFg77e+WTtI/K5Y0duk8
         mZmk25NL6+gf+umOtSIczNFOBlQExc+Zv6vqTS3tDJDegtAOYnK/dOtHifBFgs0vxpne
         INwC21+Byf4Gw4dJq8PRipaWywe+m1Clfgd5qiOoFuj2kvBiZIpA9U8HL5T7Hjl/LtNn
         ZqSymt+3DECkagQb4z7IAgvwk/Pb4d1oRjsJ5uyZGNbC4q9r1Z9Lyb+VBHdZTE+2oRVO
         g9QDDEQP0sHA5L4+Sgo0lbiP0wHwavy7bzovjcXA84NWXITnbL75wcTIoW6HwjxDWPPQ
         REHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246051; x=1791850851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TeNSAJLFPq7jjMeEaP2RymD5KGPr8j5TQzJn1I+wbQ4=;
        b=fM5Y26FgumiRHmHe49ilgUN7/LI9g4JDi23AMuV5GiLsAf4BExZbqZAFPeADccibxg
         spGAIk3oXvDgf6VHImNqCWfS6MW1X0fbedFFRXgrVblH9do8eyO+ECx6JKphStQB4thp
         A/fQFYPiiP1dpz7c696Bx/shEG1yym8ZFA8IbNLtYxZMO4VvhnZB4Twe6inAPBOY33e/
         heXAwpSJZW9UMA8R+hwKRlfPIP5yI+TKtlExxjeb/IXvuishInGmwalkSK2o9j7AOpec
         ppJ+9Z/5dfkh4boDHhrwuL9ZjniZcIFWYAeUOPWy4nT8/dpiwwbX6BoaqcOGccMV5j7C
         kl4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxV2w5R8g2+EvX+hGfvA/sgsxiC2EYLWJYcFkE8qSbiUxBe6clU/SbtrINRshZXGFqqVpUymzVcI1A58c3T7vFYX6rgTZ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPVte0WOItiBL/fZqpuCq8T9+lkC0lNK1i4QXtvJcSEp0Ex0lN
	wWzaAT4L+mihWA7tA4INdCnmNyLlPWjB1LMSTcQ0Lqmr2gkLXz3ZF7Zi
X-Gm-Gg: AYBFou0emgkq5rZTpXu/3C8nRXWeggNi/Vbz67djJA4mAiAMCYfdEYanEW9xELHRBY8
	JmB++AuaozRH7SmMFlDnL+jFRAd4BLecmStQBJqImkQhK/OUAWATfD73/V5UzyJYw4BFh0JLKli
	YJbUa/l+nb/MbiU7MCo4yC28M9e8H9yoU/7HrywaeNs2ccMB0INuWB7Dx5fOJweq3kyxI1zkDN6
	isXebIvo5S7cQhJvpB78+Y7BcNOHEtC59liw7l7dVSZqvy4W8/WIvDY85/f0EvUOmMs4thGhLV9
	pBTilcDcK23D0wsQkEIViDqoRfPYxL0bDXgOK6l9ueHL5cNJGv3thKjOh9rjoHW7avGMYV6DBE3
	UWM6za8nETBynhI1szNx3WpSYnTV9QB1UY5vlfTO3Ek1tZVM2WmDyU4KlIekqf4vZQzeCAWOFB4
	7+2iNcaQ769vA0p5DSveO1OAE64zPtj8yIxMUkdiBA+5kq2kRhzzS4DrsnvNMMBR2u7k0PIdL2k
	g==
X-Received: by 2002:a05:690c:ec9:b0:8a8:4d6:22ec with SMTP id 00721157ae682-8af71ff7827mr5781577b3.7.1791246051523;
        Mon, 05 Oct 2026 17:20:51 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33be0e58sm46636277b3.43.2026.10.05.17.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:20:50 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 08/12] fs: add mnt_undo_legitimize()
Date: Mon,  5 Oct 2026 20:20:15 -0400
Message-ID: <20261006002020.2890858-9-utilityemal77@gmail.com>
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

A failed __legitimize_mnt() can oblige its caller to mntput() the
mount, which may be the final put and so may sleep: legitimize_mnt()
leaves the RCU read-side critical section it ran under to do it.  A
caller that cannot leave its critical section - a BPF program driving
a lockless walk, which only the verifier ends - needs that put to be
callable from inside it.

Add mnt_undo_legitimize(), which drops the count and, when the count
turns out to be the mount's last, keeps it and hands the mount to
delayed_mntput() for the sleepable final put.  delayed_mntput() then
tells the two queue populations apart by MNT_DOOMED rather than by an
unlocked mnt_get_count() read, which a concurrent failed
__legitimize_mnt() could transiently inflate.  legitimize_mnt()
switches to it as well, retiring its
rcu_read_unlock/mntput/rcu_read_lock dance.

Unlike mntput(), mnt_expiry_mark is left alone: a walker that failed
to legitimize a mount never used it.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/mount.h     |  1 +
 fs/namespace.c | 63 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 94fcc306d21e..e714040f8e8f 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -140,6 +140,7 @@ static inline int is_mounted(struct vfsmount *mnt)
 extern struct mount *__lookup_mnt(struct vfsmount *, struct dentry *);
 
 extern int __legitimize_mnt(struct vfsmount *, unsigned);
+void mnt_undo_legitimize(struct mount *mnt);
 
 static inline bool __path_is_mountpoint(const struct path *path)
 {
diff --git a/fs/namespace.c b/fs/namespace.c
index 580877e46b1a..920b8a85f9fa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -767,11 +767,8 @@ static bool legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	int res = __legitimize_mnt(bastard, seq);
 	if (likely(!res))
 		return true;
-	if (unlikely(res < 0)) {
-		rcu_read_unlock();
-		mntput(bastard);
-		rcu_read_lock();
-	}
+	if (unlikely(res < 0))
+		mnt_undo_legitimize(real_mount(bastard));
 	return false;
 }
 
@@ -1330,8 +1327,19 @@ static void delayed_mntput(struct work_struct *unused)
 	struct llist_node *node = llist_del_all(&delayed_mntput_list);
 	struct mount *m, *t;
 
-	llist_for_each_entry_safe(m, t, node, mnt_llist)
-		cleanup_mnt(m);
+	llist_for_each_entry_safe(m, t, node, mnt_llist) {
+		/*
+		 * MNT_DOOMED is only ever set on the mounts
+		 * mntput_no_expire_slowpath() queues here, never on the
+		 * kept-count ones mnt_undo_legitimize() queues.  Route on it
+		 * rather than on mnt_get_count(), which a concurrent failed
+		 * __legitimize_mnt() can transiently inflate.
+		 */
+		if (m->mnt.mnt_flags & MNT_DOOMED)
+			cleanup_mnt(m);
+		else
+			mntput(&m->mnt);	/* kept by mnt_undo_legitimize() */
+	}
 }
 static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
 
@@ -1423,6 +1431,47 @@ void mntput(struct vfsmount *mnt)
 }
 EXPORT_SYMBOL(mntput);
 
+/**
+ * mnt_undo_legitimize - drop a count __legitimize_mnt() asked us to put
+ * @mnt: the mount __legitimize_mnt() failed on
+ *
+ * Like the mntput() that a failed __legitimize_mnt() normally obliges,
+ * but callable from the RCU read-side critical section the legitimization
+ * ran under: when the count turns out to be the mount's last, it is kept
+ * and the mount handed to delayed_mntput() for the sleepable final put.
+ * Unlike mntput(), mnt_expiry_mark is left alone: a walker that failed
+ * to legitimize the mount never used it.
+ */
+void mnt_undo_legitimize(struct mount *mnt)
+{
+	if (likely(READ_ONCE(mnt->mnt_ns))) {
+		/* Not the final count, as in mntput_no_expire(). */
+		mnt_add_count(mnt, -1);
+		return;
+	}
+	lock_mount_hash();
+	/*
+	 * As in mntput_no_expire(): make sure that if a concurrent
+	 * __legitimize_mnt() has not seen us grab mount_lock, we'll see
+	 * its refcount increment here.
+	 */
+	smp_mb();
+	if (likely(mnt_get_count(mnt) > 1)) {
+		mnt_add_count(mnt, -1);
+		unlock_mount_hash();
+		return;
+	}
+	unlock_mount_hash();
+	/*
+	 * Ours is the last count: nothing else can reach the mount any
+	 * more, which makes its mnt_llist ours to use.  delayed_mntput()
+	 * tells our kept-count mount from the doomed ones by MNT_DOOMED.
+	 */
+	WARN_ON_ONCE(mnt->mnt.mnt_flags & MNT_DOOMED);
+	if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
+		schedule_delayed_work(&delayed_mntput_work, 1);
+}
+
 struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
-- 
2.55.0

