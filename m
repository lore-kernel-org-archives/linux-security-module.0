Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793090779;
	b=XPQhFHlb0Y6QpyBOfOj8kabUnvWeV0IeXpX0EG/9o51T8LHPHgn53TEpgI96+3ewz9rA
	 O1/II7qXwhznsesx2oT0mFE+/NUvlYtNFcVXiJRuwA4vfJhjZubvDEqxPntNlY25VUAP1
	 ZFkC9SI/SJi/huy3MkGhDc6SwPmvmr+XQbIRtkOMeKn0OuCjNPvpWJca4Jea1HYMPFRdp
	 DnAjHS76PVb5FECsKjKDRUuoofrKhbk6NaHtNiYxYdQv23J+rXGYYLvBqaKswKvRIQ9LF
	 4Xz/peTUvf7tMXKOQ/6fgGJ0JH1m2yYG1q6lzFPjkVDzlWKkElQw3l6BHEdbALf1Zug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090779;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=POBWiouFjcVL/0AJQbsFRft/KQzJa80eb9xN5M5sEJ8=;
	b=w3b2c++++xlSfMYs22XHMxHu9ckeA/Oh2tObwNTjjfrKn35IHPPeG1n5mBqglHoPYmVn
	 b3b1eERZsCr2/QeNb6y+y0QwlnUheOAWHE8LqvJljnWw0KKQ/wUSoPu+4l3y9pQhW2CAY
	 yfptO7vaDcInqB917neIIbjUh+OBQtjHBoqaWFdClLUT6OFM3rHa2C8h2z7jE4kLhOpu0
	 Q3wqZhZ37FrXfJOTWp0ffgWcdPCd9QpBGelgpw95E/1Fy4POBumsR/7vnPGbeKCVDZN9P
	 NZadIdaHe8R7Rhet2qMRl5Ko8FFS0AwK8AFTyzX1SGiNe2rROzt7C0EHQk6lyKvzyog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5ZchX38;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E4606A32E;
	Tue, 27 Oct 2026 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5ZchX38
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793090777;
	b=oFaJh324rkAcE3eQsql5hBOUJVe51R+8iEGztZjUfwurILLyLRf9DelLj5uMRkkAhrh5
	 JfnOnnPU78dSdV8GYIfM+MlYu9AYFUDONfaRA5UhVoEtdVlMpPwPYxTdypiWh11tQzD8x
	 V+pV+JEP1+OFoWFbbiqPx+T3lArTjgSfjmswOFz1OCy5IE/h7Him+ZOOlOzzkom4ZzhiU
	 hNUBqNlMkEKDLxx1gQMnorHSEE1PbOSV2mCfq91K/nz2PT6BdZQT2NdBW4eB1xxEBHV4l
	 AlDd1QbGFIXu5m7daEubwNB3mMTYI7avEgCDmzSwDdYwhCp4OjV3iJ5fX8nAJxjQmNQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793090777;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=POBWiouFjcVL/0AJQbsFRft/KQzJa80eb9xN5M5sEJ8=;
	b=ktDSftT1n1zchHjZy0IX3hClJ86hy4+hTionTCrQgRW7q9PpOA7Z3B6wcqG4eoKiO/kH
	 ldnK4bjjfXc2lsjhHh3RH5W+WER+3Exczyc08jj6bEjKgPNiM7oagipYilHA/9GLNE5NQ
	 /Gzr67oRZUw2mPUm3qdQdwA4q5+GDq1lGDj1VkwGg2D4rxjJrdMTt4QDxz24Bp5rq3Bu8
	 0ZTJVEHbpNKUc4zXI6n769ESoMkbyQ7RreL3CJbN0Ga+COZMFNqN20XF4b5k3IIUyd6JG
	 QQ+Ba8Y7zKAVNyC2/AOY2sDdAaD2dglXNRMBmeO9Zuqe6lW1a1wa2J/jDoNHkZvDbDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CE1A41F01829;
	Tue, 27 Oct 2026 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793090777;
	bh=POBWiouFjcVL/0AJQbsFRft/KQzJa80eb9xN5M5sEJ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W5ZchX38po3lOGVUegKZZxmylL48xPKsRMfC08ksahq/NWISW9MwBmaixJ7j3TaH+
	 MR6Lv1n1W2X4aKf5OaXa3v7wUWnasZDwFVulLV76921aR+YX8dsCAlJUPwUHb0yeSI
	 orGK7wsFmtxufeSnKI8OiNYOUu3EE5vbMfoo4Xnb+1daEuOPGWG+SD7ELHO/F67Exq
	 ntn5qqKM2BkEuje+cUQRMNP8hiyTe8KKl9sXNvwhHZA8SClk0+AzJOlNu/tRVdS6mz
	 tY3u3oaGzCT4IHdJWPPBR1diftedPqj/N1C4rti1xPx0NrMjN+9+AvWmnoDoENQK6p
	 3bbZ3UB5GTUVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4F2C945051;
	Tue, 27 Oct 2026 08:46:15 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Tue, 27 Oct 2026 16:46:08 +0800
Subject: [PATCH v4 2/3] pidfd: Use scoped cleanup for task access
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
Message-Id: <20261027-pidfd-get-paths-v4-2-e2a6a47e3c95@black-desk.cn>
References: <20261027-pidfd-get-paths-v4-0-e2a6a47e3c95@black-desk.cn>
In-Reply-To: <20261027-pidfd-get-paths-v4-0-e2a6a47e3c95@black-desk.cn>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5558; i=me@black-desk.cn;
 s=20260831; h=from:subject:message-id;
 bh=gzvhhroq0taD08thWsIYRMrkzi7RjkED7WAzCrTTY6w=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBq4GTTq1AmHKjZusegR8P9nHHjSCtmnug2b+9aT
 8eLvb5V5DiJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCauBk0wAKCRB2HuYUOZmu
 iyQDEADYHTpHnbirutXyO9Pkof4XYcj5t298WGhEVy4YGe7vV5nqUzyfb+BecJlkF4qJQ3gJoz5
 WnQmiPN8f3Uum7LESzs46kXOug+XwjrNXO2F4Cagh1bgG0SbPjW8eZLw3f9biM13wIdkoQUvp40
 qzkmBG4Wv9tzr7HSSTM9+TtitKrtudsTWAHsXwGUI5xv9WydDy6yHx8F4G5PEEY5TknFvLRjeGt
 CjJLCRwCIAEtmU82BHf21o0YAcEbbE4KpGxSHsYn9r+HcZhX0wGS3nNxtvAHx9CTi020ouly0Cz
 5sqmkwSFs5Al8RhrCv4Kq85ebXJLReL9NsNmv7q4djiO4dWQgjtVVzGMuEAj+V3Gq4MvTY87tTV
 eHD+ZOpkX667rGpcgz62DTtmwe6liJkzfD/p4bLJ3YGKJncL0ewUJucNywO0HNk0/UQw3EffzOj
 XPhL0c25g4ANeGcsXGYi83e/AOqPUrxoVtbO3btzTHiHF2W/F6VqHgkgw9TUoS9BmgtOWBy3Oi0
 QN75hPbuhgnPiuzQRRSA8genBLRNcBjhQzjsur/4t/DGJ7MQW0yQEB9fWjqS/BlbIlvj6YB1nr+
 3ZY8KL9PdVzdAWtWdbTFlMlyao+AvlSOrcI+FA4T4zk4leohVDGLobJlOSkXkyD5ZWpN8AauioW
 X5oFQRRe8B4OM5Q==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/20260831 with
 auth_id=991
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn
Content-Transfer-Encoding: 7bit

From: Chen Linxuan <me@black-desk.cn>

Split namespace acquisition from namespace fd creation and represent a
privileged target task as a scoped class that owns both the task
reference and exec_update_lock. Use the class for namespace lookups so
ptrace access checks and task state reads remain tied to the same exec
critical section, while open_namespace() stays outside the lock.

Carry the pid namespace visibility check into the helper so that all
users of the class enforce it.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 fs/pidfs.c | 120 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 74 insertions(+), 46 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index cfb93c4ccf23..b70ec50f64da 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -527,70 +527,76 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
 	return false;
 }
 
-static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static inline void pidfd_put_task_locked(struct task_struct *task)
 {
-	struct task_struct *task __free(put_task) = NULL;
-	struct nsproxy *nsp __free(put_nsproxy) = NULL;
-	struct ns_common *ns_common = NULL;
-	int error;
-
-	if (!pidfs_ioctl_valid(cmd))
-		return -ENOIOCTLCMD;
-
-	if (cmd == FS_IOC_GETVERSION) {
-		if (!arg)
-			return -EINVAL;
-
-		__u32 __user *argp = (__u32 __user *)arg;
-		return put_user(file_inode(file)->i_generation, argp);
+	if (!IS_ERR_OR_NULL(task)) {
+		up_read(&task->signal->exec_update_lock);
+		put_task_struct(task);
 	}
+}
 
-	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
-	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
-		return pidfd_info(file, cmd, arg);
+/*
+ * Return @pid's task with @task's exec_update_lock held, or -EREMOTE if the
+ * task is not visible in the caller's pid namespace. The ptrace check and
+ * the callers' task state lookup must be performed while the lock is held
+ * so that they cannot race with a concurrent execve().
+ */
+static struct task_struct *pidfd_get_task_locked(struct pid *pid,
+						 unsigned long arg)
+{
+	struct task_struct *task __free(put_task) =
+		get_pid_task(pid, PIDTYPE_PID);
+	int error;
 
-	task = get_pid_task(pidfd_pid(file), PIDTYPE_PID);
 	if (!task)
-		return -ESRCH;
+		return ERR_PTR(-ESRCH);
 
 	if (arg)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Require the target to be visible in the caller's pid namespace
 	 * for operations that grant access to its resources, mirroring
 	 * procfs and PIDFD_GET_INFO.
 	 */
-	if (!pid_in_current_pidns(pidfd_pid(file)))
-		return -EREMOTE;
+	if (!pid_in_current_pidns(pid))
+		return ERR_PTR(-EREMOTE);
 
-	/*
-	 * We're trying to open a file descriptor to the namespace so perform a
-	 * filesystem cred ptrace check. Hold @task's exec_update_lock for the
-	 * duration of the ptrace check and the namespace lookup so that the
-	 * credentials used for the access decision match those of @task at the
-	 * time its namespace is read, preventing a concurrent execve() from
-	 * swapping the task's credentials in between the check and the use. We
-	 * mirror nsfs behavior.
-	 */
 	error = down_read_killable(&task->signal->exec_update_lock);
 	if (error)
-		return error;
+		return ERR_PTR(error);
 
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
-		error = -EACCES;
-		goto out_unlock;
+		up_read(&task->signal->exec_update_lock);
+		return ERR_PTR(-EACCES);
 	}
 
+	return_ptr(task);
+}
+
+DEFINE_CLASS(pidfd_task_locked, struct task_struct *,
+	     pidfd_put_task_locked(_T),
+	     pidfd_get_task_locked(pid, arg),
+	     struct pid *pid, unsigned long arg)
+
+static struct ns_common *pidfd_get_namespace(struct pid *pid,
+					     unsigned int cmd,
+					     unsigned long arg)
+{
+	struct nsproxy *nsp __free(put_nsproxy) = NULL;
+	struct ns_common *ns_common = NULL;
+
+	CLASS(pidfd_task_locked, task)(pid, arg);
+	if (IS_ERR(task))
+		return ERR_CAST(task);
+
 	scoped_guard(task_lock, task) {
 		nsp = task->nsproxy;
 		if (nsp)
 			get_nsproxy(nsp);
 	}
-	if (!nsp) {
-		error = -ESRCH; /* just pretend it didn't exist */
-		goto out_unlock;
-	}
+	if (!nsp)
+		return ERR_PTR(-ESRCH); /* just pretend it didn't exist */
 
 	switch (cmd) {
 	/* Namespaces that hang of nsproxy. */
@@ -672,16 +678,38 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 #endif
 		break;
 	default:
-		error = -ENOIOCTLCMD;
+		return ERR_PTR(-ENOIOCTLCMD);
 	}
 
-	if (!error && !ns_common)
-		error = -EOPNOTSUPP;
+	if (!ns_common)
+		return ERR_PTR(-EOPNOTSUPP);
 
-out_unlock:
-	up_read(&task->signal->exec_update_lock);
-	if (error)
-		return error;
+	return ns_common;
+}
+
+static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ns_common *ns_common = NULL;
+
+	if (!pidfs_ioctl_valid(cmd))
+		return -ENOIOCTLCMD;
+
+	if (cmd == FS_IOC_GETVERSION) {
+		if (!arg)
+			return -EINVAL;
+
+		__u32 __user *argp = (__u32 __user *)arg;
+
+		return put_user(file_inode(file)->i_generation, argp);
+	}
+
+	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
+	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
+		return pidfd_info(file, cmd, arg);
+
+	ns_common = pidfd_get_namespace(pidfd_pid(file), cmd, arg);
+	if (IS_ERR(ns_common))
+		return PTR_ERR(ns_common);
 
 	/* open_namespace() unconditionally consumes the reference */
 	return open_namespace(ns_common);

-- 
2.56.0


