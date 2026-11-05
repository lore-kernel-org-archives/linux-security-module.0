Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914974;
	b=EkiIMOEwMhwQARY4/RSw3B5r11YFdaq4eDgLc4QxOOlh6QSFzAPyrwZAXLELljbtkmNW
	 EZPSPITtw2oCwSUqEkN0nOAx2SVVowSI7lEGpGP+5Ij0rBuri/k83yqWsmJH5Ftqulq1K
	 yi+TbIKzb6OewNp7L1EvM5CX9oUqGzuyAsdQtzFUczS6IENvkrtl9q+/N0oQTtqGdoEHu
	 tTJpj2a/JITqI1hCdOI5h66lBUoIuFg3spX+8Eq/hdxjcHke3Sn06SckaaNxR24UsM3fn
	 O+oL3W9z4RDG2s7S4VtdHc3HBY0dDQdHG7yooMOczeaFJWCwE8bGScyiRhaUBmMVsJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914974;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GA54y8x2BTg+d6MyDylKpNDR5NpP0XULvhnGi2Kmvgk=;
	b=rFkkREu97vTt4ip0DesI8UX8ik/DilBZlrS27gfZ1gTG+kATW8rVYxBd32138E0AdNzp
	 n1oyW0rN2+xtp+SzBoZAy66I4jwCmQU+zdOKJL79h/BPWZklKkC+DOeYGFE5bOdNE3kwr
	 4kmgbgzFlaUiZZKEdnJhC1/3NwFM67xQuzaly43nbY1n0Ko/sZ3cCZ8s22lfORMK7fXYG
	 qWwpvyJkU+YpLszcm1X7G50YxA6M4DVz1ffv5td15MP68TRUdF3z60N7zsmIfozDa2O+U
	 rxjAeZaYQCdFYot8ADIfQ5t7RxIK4Ja4v2tFwjHfMQzkhCdrEx47TsihBDWI5MoMwkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7E2MjRH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A5F606A31B;
	Thu,  5 Nov 2026 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7E2MjRH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37441F0089F;
	Thu,  5 Nov 2026 21:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914974;
	bh=GA54y8x2BTg+d6MyDylKpNDR5NpP0XULvhnGi2Kmvgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h7E2MjRHzsJZkvGDDESAY+UXeh0G4esVLHqk/S+8HNlz9r1WdhHmkvveupL4YV5JH
	 aZ8D0zeTyG1GO2et1ZZ6u7fu2qJO4okJQ2QMOVK75OvR9p1BoNEzK8Wmpt/AF0tYmj
	 YK30XZ8ubTL66486WYg/p8UzNANqefwYaeH+iacd/cjTzlXxNtiUR+abV845fCkbAK
	 D0s3JGwezFQH5M7cEetJOMov/9oI8fwAOmqaCsYRcBEYzrj/X+MqJQDbQs3KpiZBMJ
	 5aVlgGWf2oLFChdGfljLcpKvpYfjhMzvJ2Xk7yrtTFqJtynD7VQ+jV6lUfRGqf2KWt
	 GjVHcorcI2aVQ==
Date: Thu, 5 Nov 2026 22:42:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chen Linxuan <me@black-desk.cn>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	John Johansen <john.johansen@canonical.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 3/3] pidfd: Add task path ioctls
Message-ID: <20261105-gefolge-rosten-neueinstellung-6223a18aae90@brauner>
References: <20261027-pidfd-get-paths-v4-0-e2a6a47e3c95@black-desk.cn>
 <20261027-pidfd-get-paths-v4-3-e2a6a47e3c95@black-desk.cn>
 <20261105-fotokopien-essen-inbegriff-be31e4f3c8a6@brauner>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105-fotokopien-essen-inbegriff-be31e4f3c8a6@brauner>

On Thu, Nov 05, 2026 at 10:16:44PM +0100, Christian Brauner wrote:
> On Tue, Oct 27, 2026 at 04:46:09PM +0800, Chen Linxuan via B4 Relay wrote:
> > +	case PIDFD_GET_EXE:
> > +	case PIDFD_GET_CWD:
> > +	case PIDFD_GET_ROOT:
> > +		error = pidfd_get_task_path(pidfd_pid(file), cmd, arg, &path);
> > +		if (error)
> > +			return error;
> > +
> > +		return FD_ADD(O_CLOEXEC,
> > +			      dentry_open(&path, O_PATH, current_cred()));
> 
> So the path we take from the task is a jump target, just like
> /proc/<pid>/cwd and /proc/<pid>/root are. So complete_walk() runs
> ->d_weak_revalidate() on them. Without that a stale dentry on nfs or
> overlayfs turns into a valid O_PATH fd.
> 
> And failfs relies on ->d_weak_revalidate() to refuse pinning its root. A
> task that fchdir()ed into the failfs root can now hand it out through
> PIDFD_GET_CWD. Which would be breaking a guarantee we give. So we need
> the same check here. I'm just not yet sure how we best do this.

Ok, just saw that Sashiko also reported that. Hm, so I think we need a
dedicated "task open" helper. Something like:

From 59f9a5be6615604ddfbbd6a80f2872ad0c818ae0 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 5 Nov 2026 22:25:55 +0100
Subject: [PATCH] pidfd: revalidate task paths before handing them out

PIDFD_GET_EXE, PIDFD_GET_CWD and PIDFD_GET_ROOT sample the task's path
and open it right away. The path isn't found by a lookup in its parent,
it's jumped to, exactly like /proc/<pid>/{exe,cwd,root} jump to it. But
there complete_walk() runs ->d_weak_revalidate() on the jumped dentry
before the O_PATH open happens and the ioctls don't.

So on nfs, 9p and overlayfs the ioctls hand out a path that
/proc/<pid>/cwd would have refused with ESTALE. And they hand out the
failfs root. The failfs root is only unpinnable because its
->d_weak_revalidate() refuses every jump to it. After
fchdir(FD_FAILFS_ROOT) a task can now simply do

  ioctl(pidfd_open(getpid(), 0), PIDFD_GET_CWD, 0)

and gets an O_PATH file descriptor to it which no path lookup allows,
not even with O_PATH.

So add task_path_open() for opening paths handed out by a task. It
gives the filesystem the same chance to refuse the path that
complete_walk() gives it and then does the O_PATH open. It's called
after the target's exec_update_lock has been dropped so a filesystem
that needs to go on the wire doesn't block the target's exec. There's
no lookup so there are no lookup flags to pass.

Fixes: d53dc95eb961 ("pidfd: Add task path ioctls")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/internal.h |  1 +
 fs/open.c     | 30 ++++++++++++++++++++++++++++++
 fs/pidfs.c    |  3 +--
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 3f2fbac40f8e..e43ebcfd9846 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -205,6 +205,7 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 int chown_common(const struct path *path, uid_t user, gid_t group);
 extern int vfs_open(const struct path *, struct file *);
 int vfs_open_consume(struct path *, struct file *);
+struct file *task_path_open(const struct path *path);
 
 /*
  * inode.c
diff --git a/fs/open.c b/fs/open.c
index e43f02ff64ac..55441ff0525c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1156,6 +1156,36 @@ struct file *dentry_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(dentry_open);
 
+/**
+ * task_path_open - open a path handed out by a task
+ * @path: the task's path
+ *
+ * Open a task's exe, cwd or root for the caller. The path wasn't found by
+ * a lookup, it's handed out directly, the same way a /proc/<pid>/{exe,cwd,root}
+ * jump lands on it. So give the filesystem the chance to refuse it that
+ * complete_walk() gives it for a jumped dentry.
+ *
+ * Only O_PATH opens are supported. Anything else would need the permission
+ * checks a lookup performs before the open.
+ *
+ * Return: An O_PATH file on success, an error pointer on failure.
+ */
+struct file *task_path_open(const struct path *path)
+{
+	struct dentry *dentry = path->dentry;
+
+	if (unlikely(dentry->d_flags & DCACHE_OP_WEAK_REVALIDATE)) {
+		int status = dentry->d_op->d_weak_revalidate(dentry, 0);
+
+		if (status < 0)
+			return ERR_PTR(status);
+		if (!status)
+			return ERR_PTR(-ESTALE);
+	}
+
+	return dentry_open(path, O_PATH, current_cred());
+}
+
 struct file *dentry_open_nonotify(const struct path *path, int flags,
 				  const struct cred *cred)
 {
diff --git a/fs/pidfs.c b/fs/pidfs.c
index f2a113006552..a2a0691cf131 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -775,8 +775,7 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (error)
 			return error;
 
-		return FD_ADD(O_CLOEXEC,
-			      dentry_open(&path, O_PATH, current_cred()));
+		return FD_ADD(O_CLOEXEC, task_path_open(&path));
 	}
 
 	ns_common = pidfd_get_namespace(pidfd_pid(file), cmd, arg);
-- 
2.53.0

