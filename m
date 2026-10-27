Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793090777;
	b=bCtwF8eKrw0tqq2CYe+kiWNVT0T6aDvfudbSDXu0sNwKy2s0iaEnbxFbhIfMfpfEpSi6
	 YDHzJIyT0Z5L4N3j9XRDycX8PJVDF61kHod19GEFjSN7HwV9/FAipG03igB5DMLYSOJ2q
	 CmNr+AoI2Tht93jaNifxK2ywUnhbGbZlbYEEk46JuKsqVUW5lEfT5R5zEG236rd3mLgFp
	 +7GOtr6ykeCiwrt7cTbVkH95V3t4n08lPmsZKUsPp10osZ5EchtfRKrrr6e1gxfIWqBSr
	 wfwiqwfdmwh/hZ1jAtZDA0aWe6X7yHA/+WknfNdg4HeW+YeycMSj6rthIdYwrSxsf5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090777;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/EZf7zIhRQcKHC+3YSCdz86f3cuf1Y8jPy7QcqQhb3Y=;
	b=wFL8lyQTwk3F2F309HBGOV4GhWVXQuKq2dA0EAQMYOTvkMRaHsRJu0FLzev38IHCqt7d
	 k8yJRRCUJ5o/JG9FO7g9TekgL0v+FySiJkcWaCSxpVqDloOuOyQm2ffl59UG7eDAT4xdA
	 gxQhJvEWojHMN1cUbEKV67gj7rn81hR0njpjin07xz00xYd8Z5i+Z2ysfFjSCSFevKJkT
	 vafEhyURz0OWl38WeZYQMSC0G2Roh0s/Byz5druSGXs83zVCWmWfL7kEcgA+C9G1BbaLe
	 bnMxK6OC1WNE8HSpygy18lCLyCMA0SOqPrIS7gKU/tVUzD+xRWyQVTdfC44ao26MU7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esxreAKB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022B606A32A;
	Tue, 27 Oct 2026 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esxreAKB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793090777;
	b=fgnXDKCVPHYqvMb29Mk8mOPSyIBzQppVXzD/4CChXhY1Pxfwaq3lZXqphptyxfkmu+2F
	 aVuifTImP/ObYjgjZUqSslfqK3fdqbVLB8fh/hZdz/zDEWI2VD6sV4vVgIZziASPpBm22
	 XmjUOheXqTg686o107x/8HHJorfJBK2zXnGGXBri6RJ+eOmk3nMwto4czYkvHvil3ombW
	 DmDBLuUXZGtVfC/A65IR6CR2feRIsjAjxZn0UDVDdK6gyfTp7WTwXRgpktDqsVZyMZbMT
	 J4AP8amhW84YCSiT6I6BCZqCVfKmDxOtD6Y4kI4R1oZeJ5im7z6EikdxQtQVqQH+n+Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793090777;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/EZf7zIhRQcKHC+3YSCdz86f3cuf1Y8jPy7QcqQhb3Y=;
	b=bKlQB6nMM/IBwBPlq+HqBJyLsgXyIRvPKCwdads02dUqqyF+0fTZZaMWO0LM4/B0+78X
	 BpsQcjpVrDa3UygOEbNI+yuAE6StDsmbs/vJXwC+2PwaLpzoDt9IFEiraP3qmmdS/lrBc
	 MX7USoqz3UmZp50JCadhaTv6spfxic6k2fJN52I0/PJPuJZfCoF9l2+8+ubFtCdyqf395
	 atEY/foKrzXxYOwYfxaKXGVc02BwOwTmXHeTbM2HJiJ8VUWrJYewdBqKFDWthWPSYguKD
	 hvO4mn/YEr9CYQRzjOZlz/8cF6JmVdsnVhKP4FezfYG1gN8vaNx3GOxp0CUa+3L1Kew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D26191F031E2;
	Tue, 27 Oct 2026 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793090777;
	bh=/EZf7zIhRQcKHC+3YSCdz86f3cuf1Y8jPy7QcqQhb3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=esxreAKB+KfM5Ev0FldwKnk3e+YhE+IAYbzhO5BdFJ0uTK5VYTt8gx/u6OV9Tl0+V
	 4SxpYv59ir06pBaPcC714Cqy+K/5KZd5M0QJaI9znSeXLK94jQbznM5gzZzEg1CHG5
	 YhQ3cYLb9kAXRJJnQcd5B/WAPkjkLSqpel3W/DSByW0cMXsEqkCednWxXh6lF5aFBi
	 pximaOKUW8QyTPWliulG9qOlF3vjTPM3KT7jamiLYRFf5GJbRLjKwHNgp1Lmho121z
	 yIoMXGS8nsT5EYgjKcFB91MUhU8y38MYOdUbXgRT37t5PfYacfFYKpBcZus16odVke
	 FkJxHO0tH2klQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5A23345055;
	Tue, 27 Oct 2026 08:46:15 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Tue, 27 Oct 2026 16:46:09 +0800
Subject: [PATCH v4 3/3] pidfd: Add task path ioctls
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
Message-Id: <20261027-pidfd-get-paths-v4-3-e2a6a47e3c95@black-desk.cn>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3666; i=me@black-desk.cn;
 s=20260831; h=from:subject:message-id;
 bh=GO9QtsM65CRyK7g1akKw0I2XR97HTxP4qgarbCXi9wo=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBq4GTUwucgCpXdP5YCfu0iifXt21jpn95csGX7K
 pCdrkbJLmKJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCauBk1AAKCRB2HuYUOZmu
 iz6vD/9amvWNr/pBRZSGWKR8+jIrG3T26BdSJwgZ6aXx4zKeWCfabKIJetU1nK7wmQfHZxF7VPh
 WtOAA5lcYGvfT4sUwQmg90fL8jzOBcqjAczg0hqtO4BPRWPqQ0PlGut0VlPqe8MDKX+PKwdAukV
 CWKUZsqgjDaN7sFFSpooiJIf58befMH5NzhIgALR63PyYYgrPrlTOxtyo7PMOm8TSqCAmTHuWWJ
 +cXcWxCukn6LHDmL6M4g/+vAWb5e8RdgHjgqNVwJDKfBrzVU2LoNt5vbHSLnvd/y6R87tdH1OH2
 vWTXAXLHYx5KMiqjkbLSv9hMkEECPYh+dBQ99fIcHrggA0Pz/UqSd4lVe6ct00qDNmgdSUankQt
 jij6S0GyYzCJwJOT0oko1BNuNyeIQ79HUYOVn138NQY6lNerA0DnVLPWYcTH0j6AbOhbI8W4vex
 Jns15ni4Cs8s9TQJ/TspIg8/L0R5z94wXE0FwAwJ3gtebYbUvoYjxJWkNuIuz+cxljrMXa9rNbQ
 0vTZx6yF4lZ9bJLP6MMzHznfeoOVXLmSYew3K5PHGUsOev2vAZMG4ZBjOe+7t92R8rdiW2o23yO
 zAXtZVdZ7oqnM7H6mVhtqnYlXZLjqg4Vda7NFIlw8/+fORavG0hL57KsjCKs/4OKG9hgOGsg3/c
 gVo50EHdI3vEcRA==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/20260831 with
 auth_id=991
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn
Content-Transfer-Encoding: 7bit

From: Chen Linxuan <me@black-desk.cn>

Add PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT to return
close-on-exec O_PATH file descriptors referencing the target task's
executable, working directory, and root directory.

The ioctls acquire the target through the shared task acquisition
helper and are thus subject to the same checks as the namespace
ioctls. The target is sampled while holding exec_update_lock so that
the access check and the path read cannot race with execve().

This allows userspace to obtain stable path references from a pidfd
without requiring procfs.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 fs/pidfs.c                 | 38 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pidfd.h |  7 +++++++
 2 files changed, 45 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index b70ec50f64da..1e5b0dcb9975 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -4,6 +4,7 @@
 #include <linux/exportfs.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/cgroup.h>
 #include <linux/magic.h>
 #include <linux/mount.h>
@@ -510,6 +511,9 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
 	case PIDFD_GET_UTS_NAMESPACE:
 	case PIDFD_GET_USER_NAMESPACE:
 	case PIDFD_GET_PID_NAMESPACE:
+	case PIDFD_GET_EXE:
+	case PIDFD_GET_CWD:
+	case PIDFD_GET_ROOT:
 		return true;
 	}
 
@@ -687,9 +691,31 @@ static struct ns_common *pidfd_get_namespace(struct pid *pid,
 	return ns_common;
 }
 
+static int pidfd_get_task_path(struct pid *pid, unsigned int cmd,
+			       unsigned long arg, struct path *path)
+{
+	CLASS(pidfd_task_locked, task)(pid, arg);
+
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	switch (cmd) {
+	case PIDFD_GET_EXE:
+		return get_task_exe_path(task, path);
+	case PIDFD_GET_CWD:
+		return get_task_pwd(task, path);
+	case PIDFD_GET_ROOT:
+		return get_task_root(task, path);
+	}
+
+	return -EINVAL;
+}
+
 static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ns_common *ns_common = NULL;
+	struct path path __free(path_put) = {};
+	int error;
 
 	if (!pidfs_ioctl_valid(cmd))
 		return -ENOIOCTLCMD;
@@ -707,6 +733,18 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
 		return pidfd_info(file, cmd, arg);
 
+	switch (cmd) {
+	case PIDFD_GET_EXE:
+	case PIDFD_GET_CWD:
+	case PIDFD_GET_ROOT:
+		error = pidfd_get_task_path(pidfd_pid(file), cmd, arg, &path);
+		if (error)
+			return error;
+
+		return FD_ADD(O_CLOEXEC,
+			      dentry_open(&path, O_PATH, current_cred()));
+	}
+
 	ns_common = pidfd_get_namespace(pidfd_pid(file), cmd, arg);
 	if (IS_ERR(ns_common))
 		return PTR_ERR(ns_common);
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 0919246a1611..95ce1819f423 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -121,4 +121,11 @@ struct pidfd_info {
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
 #define PIDFD_GET_INFO                        _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
 
+/* Return an O_PATH file descriptor for the target task's executable. */
+#define PIDFD_GET_EXE                         _IO(PIDFS_IOCTL_MAGIC, 12)
+/* Return an O_PATH file descriptor for the target task's working directory. */
+#define PIDFD_GET_CWD                         _IO(PIDFS_IOCTL_MAGIC, 13)
+/* Return an O_PATH file descriptor for the target task's root directory. */
+#define PIDFD_GET_ROOT                        _IO(PIDFS_IOCTL_MAGIC, 14)
+
 #endif /* _UAPI_LINUX_PIDFD_H */

-- 
2.56.0


