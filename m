Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793949169;
	b=Pb/zafVGbVwUGkCj6W9rOqO5UOYI4kDU5R3YVGHctMl3qsKHb92UBwE2j+3/k6tubAKI
	 pWHpTlkgqP636xs8w+lq/bQwrZhFLw39l9Lp3kjO3TI8LSgvUhO+QbtPZ20qALs87/WJO
	 DTqCIqimoSZ8+Eu/BIkBCm2X2DnpTpnfPvib8MoOKZ8Y1pTnx0/TAP3NxnNdzT94G0tn+
	 ZeeA9q3hSpOJmlbViljN7YVUd8plqVqq4RFtMg8sd2v8Xq0ue9AeYLgM4RzhQAoxLYFLD
	 Q5B3NU7juvE9aKVY6774SCdoxovb3wur7KCSiPbAu9qnP/ZzEPdL19LbsxhLk9EsJGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949169;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=POBWiouFjcVL/0AJQbsFRft/KQzJa80eb9xN5M5sEJ8=;
	b=t6AVFNMZVTYl/FA/pCkOI/M0wBoU0A7lz2Xx0BSDDEge7bIyDKHF/c53BnGgXA1jtZOM
	 7l9k8xdeRqLz8KOqc8OGjBNB9speMtqW932ur3YbNRG8DIlcJDU2NjTRVxARKl+r7NMrY
	 bzzV1SXk9u89HsH/rkx2y5spQPYw9mYQ0Wd4BUnQ/qslb913S5N095/m2R2/tJrbkOXK9
	 vaIujGEzbXgZP9Ff4zNl6alrSnCIHtDcKv+T4tiNm5/3UPMTJajxXpqwzwSs/w7VjWKlH
	 p6sJCld5fdJxVQvG2PBY2SddI1VkCSJ0b/4HPqlfu2C6R2ycvDZfwLrJN6CqinF1v6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmYg4AwQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E9606A333;
	Fri,  6 Nov 2026 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmYg4AwQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793949168;
	b=1W9z/2pmWTHxvidFPyn/kedtExdVG6Gb1UBYkTRzCiIoSIpYhYC120WtSpQWeLY6Bby7
	 RmCXi+6vHkFhFtnT92sY1RN0wiYGhBUW5SbqEBxTHX6jJzAdOPbYKGESJoNUNs7+Ub/9X
	 fkZ5jrBvnc4xroFnv8u/AiGOGmpZPWhIww42SLZQifw1DmbJeYDpDqDCtUYifYnmW3eoF
	 TRyUQzjclYetV0mTcJU8JT0tM1g1YmQWzEFjAV9DM4YWpxpKKdMLko8nY6YsdaazayZUF
	 DfMCPd1u2R4oWBTxgtbkapWlM9sc1pdHhSVTrqY0NQ6rYsCy0SCVCQkNILW9E4TC7nQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793949168;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=POBWiouFjcVL/0AJQbsFRft/KQzJa80eb9xN5M5sEJ8=;
	b=qIvdTXLfTEHQQ4dwxMhee6iOi7TpymcLNjO1oc/w9wDZUsmoYS/mGBycrBa+2XPYP6UL
	 FuZGglo+aWPeF5495w9PVW3/PRv+SZC99s7FpYwAAYBF8fo6iiMwj+3hJONfDpJvIySzg
	 MUmN27mHB75cH1ZLRZue2xN58EIV7M7vws5dCDVQifPVlo691QvDyb95jegr/gTd+ZQ2P
	 NFw22DaFDHKWmEgiCwi+wPn0lVvx4lqx1r0razjM9OsRZR35kubLqyUr1bcqUiMJoF9Kw
	 oJ95PR3f0ye2X+zXjv974q4iDGHU4iBWqoG0JXe+9/uRuh7pdPYltsHGKsocOFcbckQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1E9E81F008A2;
	Fri,  6 Nov 2026 07:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949168;
	bh=POBWiouFjcVL/0AJQbsFRft/KQzJa80eb9xN5M5sEJ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HmYg4AwQaxfiHcS5U06YqGmlN7h/CnbtCsqfpBJvFLWSTe1/jRl0QF5vtpfn+yTl6
	 mOkGaK5HJYN90jPOvHix5w9+E6qOpS3Tg7i5zVplqbQeULQ3zDkBaLKKr/9aiw2Lw3
	 plLN8627Ozn+mqRvaiU0/F9Qwl1jtP6sSPDKyzqaFoWk6pD35l66c7AFtpuFxY7KEp
	 aW1fIhl63KBHm+aEEbMBaPR6u2CrjnhuoTtnqP86U64CtzzUmUGJmibrdKOhKdJjsK
	 yTMYMx5fDojKd9ZEYUetGbH1rDHjt3UuUlBwIHiKb4ezGaXS6qCfmhkbeFtSiA/C5F
	 8dZy0w9Ll3/6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 905F945C37;
	Fri,  6 Nov 2026 07:12:46 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Fri, 06 Nov 2026 15:12:22 +0800
Subject: [PATCH v5 2/3] pidfd: Use scoped cleanup for task access
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
Message-Id: <20261106-pidfd-get-paths-v5-2-3147ce6571cb@black-desk.cn>
References: <20261106-pidfd-get-paths-v5-0-3147ce6571cb@black-desk.cn>
In-Reply-To: <20261106-pidfd-get-paths-v5-0-3147ce6571cb@black-desk.cn>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, 
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
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBq7X3tLqm3ymOk6hzMoNuLWgNObaoSZT+r7/WwK
 QyYPlMwnX6JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCau197QAKCRB2HuYUOZmu
 ixChD/9GjOXUnYx4ahEXEQWkWH+5kRKbSkUOliJ7ApgYYPYKngx/XkW1YnQrybu2MpJuJerZSOD
 oPL2Yz6RbjuZbM6cUXSJT+opBwa1xkfXJ8BcQhQaNu2tQoq0dHwrii0C91OFepi9jpw9FNVxIAT
 zB7RhQu5Yh3hPTOrnXrEbSGOF7MqqvgsTblrFGZoUpEkGmWvuCLnjrsSMe/czzdfWMJZZAm+Eh/
 BJb5h85xXjYUYCV55MOE1vtbHgDhM0LAGsK1YtCbcQ8tjE6aP5ISuVEHMpSJTLNBdt2iVmBZYV3
 uudqPSVK5Z8z55jlzACzJ6RkJtYlv6PIg9SkOCbYPtEGRDCDd4yTCpHlsxR+5ZDLcqhvFuUqOLT
 /zkl32WKxihU0d4V2q6J48SXdRkISQVCUciw5whIS1uoCd9Hsl/bvgwIli8hD6nYJRIjHBOGHyV
 0KoLIr9n7zr4/ij0EBd15ptzbrtpZJAtA/V2UEg14eUlzyzFEryXy2Cj0Cp+7OYV4XW/kahIcY8
 pn9D4WCJHT01pgy229I0IFMPOtyRDJGPmtlQ5o4bB+ODc8yzoLuqYnCV7nxaTr99/S7unl0NHIE
 H5EAb2Sb8tUuTsiQ6PpRMZ44uqBGHxRMpTRReMJBh5guX5v96bIKshK19Kp/bSi2U8BhhgAPKqP
 lNj6OrCoDEZcm2g==
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


