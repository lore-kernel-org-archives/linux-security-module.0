Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA21F560F
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341301; cv=none; b=N4Co+aPvgVt8+EkjbebmuPse7DVd5Z+ZwUqVZylhLPYsUl43WABRGKkz/ooesjMJfEv584KeMRNiLeyFX1MyPI21lhphKIBq/xlfx6ylXX1319hWx6eRsDgTHV+V+wMaIMA2sXVqT+ojYyp+56+Ev5vtoYtOYM2lAZMd1yLFsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341301; c=relaxed/simple;
	bh=M3xYE8SlhylDM+mAearAhaWUgjUUsDjknhDvjQeCk9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkYNE9GoecOsN0+lRyHlEN+nwploMbplpLEVZHdBtuEHo7ybpYhLxKwrOVZpVFrjyhkrwnxO/3fC1VtgSgq/XH/nXwUZDsXmrPDwEl7+TIIJlCGkULQQicLzROFhRXyImnC2Sg17tj39XGKN8v8607UXTVkVRvdxpZ7ylw0GuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OIeF5STx; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OIeF5STx"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1hK1NzPzClY;
	Fri, 31 Jan 2025 17:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341297;
	bh=CpxlXkuvz87N63qJ7t8LlIMfS7wGPmR7iFRhFxMRGL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIeF5STx/b5nhQSik1FOLn/iOsijc0av0KAM+Y7fuhW47qiaoMmXBwqKzuifbDT5/
	 Kti4V19xuGYZWKGn/hbntKCKOP2nOTiKNb/bNeVzNf3hecMAH6iqkw6TBy5uFpQ6at
	 B3gHFPao1GaQEftUgX296nwe40Rm4N21hy7Izr00=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1hJ0qMLzbmv;
	Fri, 31 Jan 2025 17:34:56 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Tyler Hicks <code@tyhicks.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 2/3] pidfd: Extend PIDFD_GET_INFO with PIDFD_INFO_LANDLOCK_*_DOMAIN
Date: Fri, 31 Jan 2025 17:34:46 +0100
Message-ID: <20250131163447.1140564-3-mic@digikod.net>
In-Reply-To: <20250131163447.1140564-1-mic@digikod.net>
References: <20250131163447.1140564-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Because Landlock enables users to create nested sandboxes (i.e.
domains), we might need to identify the domain with all restrictions
(latest), or the domain we created (i.e. closest domain).  Indeed,
because any process can create its own domain, the latest domain may not
be known by the requester.

The PIDFD_INFO_LANDLOCK_LAST_DOMAIN flag enables user space to get the
latest (i.e. most nested) Landlock domain ID related to a sandboxed
task, if any.  The domain ID is set in the pidfd_info's
landlock_last_domain field according to the related mask.

The PIDFD_INFO_LANDLOCK_FIRST_DOMAIN flag enables user space to get the
closest (i.e. first hierarchy relative to the pidfd's credentials)
Landlock domain ID related to a sandboxed task, if any.  The domain ID
is set in the pidfd_info's landlock_first_domain field according to the
related mask.

It is only allowed to get information about a Landlock domain if the
task's domain that created the pidfd is a parent of the PID's domain.
Following the object-capability model, the pidfd's credentials are used
instead of the caller's credentials.  This makes this command
idenmpotent wrt the referenced process's state.

If Landlock is not supported or if access to this information is denied,
then the IOCTL does not set the PIDFD_INFO_LANDLOCK_*_DOMAIN flag in the
returned mask.

If PIDFD_INFO_LANDLOCK_LAST_DOMAIN or PIDFD_INFO_LANDLOCK_FIRST_DOMAIN
is specified but the provided struct pidfd_info is not large enough to
contain the related field, then -EINVAL is returned.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Praveen K Paladugu <prapal@linux.microsoft.com>
Closes: https://github.com/landlock-lsm/linux/issues/26
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163447.1140564-3-mic@digikod.net
---
 fs/pidfs.c                 | 24 ++++++++++++++++++++++--
 include/uapi/linux/pidfd.h |  4 ++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 049352f973de..4ff5b6c776ce 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -20,6 +20,7 @@
 #include <linux/time_namespace.h>
 #include <linux/utsname.h>
 #include <net/net_namespace.h>
+#include <linux/landlock.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -207,7 +208,8 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
-static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
+static long pidfd_info(const struct cred *cred, struct task_struct *task,
+		       unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
 	size_t usize = _IOC_SIZE(cmd);
@@ -227,6 +229,14 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
 		return -EFAULT;
 
+	if ((mask & PIDFD_INFO_LANDLOCK_LAST_DOMAIN) &&
+	    usize < offsetofend(typeof(*uinfo), landlock_last_domain))
+		return -EINVAL;
+
+	if ((mask & PIDFD_INFO_LANDLOCK_FIRST_DOMAIN) &&
+	    usize < offsetofend(typeof(*uinfo), landlock_first_domain))
+		return -EINVAL;
+
 	c = get_task_cred(task);
 	if (!c)
 		return -ESRCH;
@@ -253,6 +263,16 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	rcu_read_unlock();
 #endif
 
+	if ((mask & PIDFD_INFO_LANDLOCK_LAST_DOMAIN) &&
+	    !landlock_read_domain_id(cred, task, true,
+				     &kinfo.landlock_last_domain))
+		kinfo.mask |= PIDFD_INFO_LANDLOCK_LAST_DOMAIN;
+
+	if ((mask & PIDFD_INFO_LANDLOCK_FIRST_DOMAIN) &&
+	    !landlock_read_domain_id(cred, task, false,
+				     &kinfo.landlock_first_domain))
+		kinfo.mask |= PIDFD_INFO_LANDLOCK_FIRST_DOMAIN;
+
 	/*
 	 * Copy pid/tgid last, to reduce the chances the information might be
 	 * stale. Note that it is not possible to ensure it will be valid as the
@@ -328,7 +348,7 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
 	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
-		return pidfd_info(task, cmd, arg);
+		return pidfd_info(file->f_cred, task, cmd, arg);
 
 	if (arg)
 		return -EINVAL;
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 4540f6301b8c..267991bd266c 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -20,6 +20,8 @@
 #define PIDFD_INFO_PID			(1UL << 0) /* Always returned, even if not requested */
 #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
 #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
+#define PIDFD_INFO_LANDLOCK_LAST_DOMAIN	(1UL << 3) /* Only returned if requested */
+#define PIDFD_INFO_LANDLOCK_FIRST_DOMAIN	(1UL << 4) /* Only returned if requested */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
 
@@ -63,6 +65,8 @@ struct pidfd_info {
 	__u32 fsuid;
 	__u32 fsgid;
 	__u32 spare0[1];
+	__u64 landlock_last_domain;
+	__u64 landlock_first_domain;
 };
 
 #define PIDFS_IOCTL_MAGIC 0xFF
-- 
2.48.1

