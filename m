Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD65226BC
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910125; cv=none; b=ogD5tSZq2jIkBywCI2gOtGu0RVaW93UdwQaYIp3t+5xfcHGcBLmLHadc2rabCYj8ZVrduJqQig1iC4TLAL7kHh1yXlQEnYseypE9vooR16rhvsrbnPNGlStM123Njm4t47ERUwo69lzsM6QXHSCBiwxQMOlnBnT+Wmju+CKPp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910125; c=relaxed/simple;
	bh=jUeRlj+ew+SmZby02vQt0jCmV4Je8k6LdyFef1DIkSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVbtThovzARRqi89rYtpWOMOupKwdRRNr2VQyAdv7SBHfhosXVnP3a082+YuUYdb7RrU7ruT4+vGtv7O0FO3/hAsLLr/ZWZVAMmFr5qYmjYRGTDz+75hkRrYzBMtumrOKvDm0aIy6YQciQ243CpbyUCrjS3zX7sxSqvKllKKut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAo45gjO; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAo45gjO"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6790844c9b0so2414846d50.2
        for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910122; x=1792514922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xG+8bN0+5b6zxdbYwoz8FDA0/PXKsDT7U/DsTPyM8nA=;
        b=nAo45gjOAw+Jeobt6nIs6fvdW36RHylxhx8DB44G2AsHrR/KYcpQAPnBEYE3dP+GTh
         9699cYPpDgaQ1TTwPnMbMY3hVqCk186/E62wx3/Ey4+q9+Idwqei39SCph4oJc6nEfzM
         SUTCfniSQlkLFDsudNx+Q05ZQslbhl8invu4+lNFzG+4Xb7pdnOkaIH+hMMa7LPYEe4c
         iHcK4znWK1TR2AzdgqH395VSarpC9fQsp4eFvZciCo4pmZwdvamrawZ2g2XSrExQeJZP
         G5Q6RH2YtdoK9RWEGPVUml4cWH1Sqv9eBnn1SL5oW/dx7CgtfQhM5xSUwlj8qSUa1wSi
         XTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910122; x=1792514922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xG+8bN0+5b6zxdbYwoz8FDA0/PXKsDT7U/DsTPyM8nA=;
        b=DFMMb85zxHW15UQwmnVOE6WcknXFn56IzUx4ddrde5KY0TAj040GW2GHejBB62jOVp
         Zp8TJfj2gGftlc14N6KxUO81xH1oIrslHGx0IVDmTSRMUa0LcLavPdn2c6qiAlHXNaUX
         HB4yJr7j7GviFF83KPk1w6zdNxpUSl0H4mBMfbStLOaTN6y9AHK8FrwN1cPzfT333hxh
         8Ryh8q2dS/cRZi+7r2+smmEhbscfc9Z2BYKKeTtJ817Hrf3QM57x/4KPWqoEpfWjQBhs
         5Bu1cpZ+qfMZ7d9rqifVDFfvtpvsoeZEZSelB4E0xh87kbMHQ+gpK/sjK0K+OCKtBtCO
         l+1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxOHDeHsuYflqSlQ/4ov7kdBqrPzpQegu5zc7uiyzhUM/Lqk3qFw075sFzVmZYN4CtSPvW3JABmO62pIKHw9Imzzhj4pnw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJG2buzTs0YVoPoxja0JiuKf0US7ceWOgf56Yh63k/HRWif5o2w
	sWxkvaLo3fJSYC20nlyEnm1RmFAV/xCRkdkGHXPGgCUk00qwHE6PUecT
X-Gm-Gg: AYBFou0HVVf2XQYfL306+mcYUwtDtQ2IsD7+aMQ6MZOIfjA2c7dzX52O0iPXnu5FLE6
	QvZQ/6y+/3Lqwm1RMEAUjV+PGTbrHwQpKXUlkzTpIl3ZfU36b3tMfUgD7WmXp+NmlkjJXxID396
	yDVIH3wdHey8tZa0k+jVSMP051OYUNgDO1jBoGj3VPIRrHxZSH6Kkr4g2enztUlJzHWlwJXIBbX
	j6D2V8IyjXFUy60jFlAm+7Gvo0JCQPDA1utVrbQ6FMjh7KH6PbhUSXqlf0GTk6Yr7wUN4I1lugE
	cg1AwTXsnFCnZwzWAO3kqpt5HXJOg0uGuhWEvwvsQYKYWSfggeNkj15jURIGxNcMw5Nf9JyGQyl
	pFdMHkh+efD7dkJz+zAl3uKcXVu5GTRMwAYqk4Aj/3yCqlBE/R+hiDHOToeVJoKMsjaWfX4JQJq
	zy3ORNziUTeNdpBVsvsV+bCFfqBSE1WwQAsQY4ZhY5KeGf0EJzm5RMA037LITxe4X26uE5EoOK
X-Received: by 2002:a05:690e:1183:b0:677:da43:28c1 with SMTP id 956f58d0204a3-67936a3d5bfmr5486321d50.61.1791910121977;
        Tue, 13 Oct 2026 09:48:41 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 07/11] fs: add mnt_undo_legitimize()
Date: Tue, 13 Oct 2026 12:47:56 -0400
Message-ID: <20261013164800.2906577-8-utilityemal77@gmail.com>
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
 fs/namespace.c | 65 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 7 deletions(-)

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
index 580877e46b1a..e37c758b3f39 100644
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
 
@@ -1423,6 +1431,49 @@ void mntput(struct vfsmount *mnt)
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
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			 "mnt_undo_legitimize() outside of RCU read-side critical section");
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

