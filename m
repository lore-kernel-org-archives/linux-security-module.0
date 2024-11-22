Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DD1DEFEE
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286065; cv=none; b=LKe6ZfhMbUF7ks2haBEfl4FuoZ8A6o1mk+8XqvF1ypjXwQ+WEQLwPsYLcD1OypK9bcvDeh1KRG3059UOZplWg08WIuN/YEz7ryzd1lqFEolGviQ7yYzKITKEvoqa0Tn7bwnut8xXoXQ2GtG/P1xceqKUn94tW/5MGWo6mxSV+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286065; c=relaxed/simple;
	bh=oA5h+lIhIMGHdMq3GlqkFyWUv2dO2b0FhZB7G/chb0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUqJ4DRbCMLpsC4fQjcDz3VWC385FnqmFhPaBKw0CgPG4umIleSKDR0GhWoGlEtK3IUhC31W5lwSbHZiyR2k5baDjCYiwph4x3UnAFyvfTZl2iY9qBdTXt5CbyZ1RnXOHg7Q+X49fCeVaVb/PXPOjcCuq+KZ64ViZ+0H6fHsPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JWzgivDs; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JWzgivDs"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKM0JPgzjT6;
	Fri, 22 Nov 2024 15:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286054;
	bh=1sr0WCuh3QxUACqP8dYROb6HbctHZuOp4t4pm8z1faM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWzgivDsxbicKpp6/jeidUMoxCaM87H0dcpCfAXfXbYXRuB1R6g12hzW26BtQH6Yq
	 vvG9cbTvUbgW0pCJHhPlapUrQtozAIJTx+S0xXNKmePgjfssojBIhhYOyIy/Nhim56
	 2HAn0wEymjIeBxgVVWfDm4yyY36ijJTY2G0d7xGQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKK5y5jzlKK;
	Fri, 22 Nov 2024 15:34:13 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 09/23] audit: Add a new audit_get_ctime() helper
Date: Fri, 22 Nov 2024 15:33:39 +0100
Message-ID: <20241122143353.59367-10-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

It may be useful to synchronize with the audit's timestamp e.g., to
identify asynchronous events as being created with a previous audit
record (see next commit).

auditsc_get_stamp() does more than just getting a timestamp, so add a
new helper instead of exposing it and risking side effects.

It should be noted that we cannot reliably expose event's serial numbers
because there may not be any related event, which would then create
holes in the sequence of serial numbers.

Cc: Eric Paris <eparis@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-10-mic@digikod.net
---

Changes since v2:
- New patch.
---
 include/linux/audit.h |  8 ++++++++
 kernel/auditsc.c      | 21 ++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..cff07525c6ae 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <linux/audit_arch.h>
+#include <linux/time64.h>
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 #include <uapi/linux/fanotify.h>
@@ -408,6 +409,7 @@ extern int __audit_socketcall(int nargs, unsigned long *args);
 extern int __audit_sockaddr(int len, void *addr);
 extern void __audit_fd_pair(int fd1, int fd2);
 extern void __audit_mq_open(int oflag, umode_t mode, struct mq_attr *attr);
+extern struct timespec64 audit_get_ctime(const struct audit_context *ctx);
 extern void __audit_mq_sendrecv(mqd_t mqdes, size_t msg_len, unsigned int msg_prio, const struct timespec64 *abs_timeout);
 extern void __audit_mq_notify(mqd_t mqdes, const struct sigevent *notification);
 extern void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat);
@@ -653,6 +655,12 @@ static inline int audit_sockaddr(int len, void *addr)
 }
 static inline void audit_mq_open(int oflag, umode_t mode, struct mq_attr *attr)
 { }
+static inline struct timespec64 audit_get_ctime(const struct audit_context *ctx)
+{
+	struct timespec64 t = {};
+
+	return t;
+}
 static inline void audit_mq_sendrecv(mqd_t mqdes, size_t msg_len,
 				     unsigned int msg_prio,
 				     const struct timespec64 *abs_timeout)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cd57053b4a69..3b7dcb47f5af 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2511,6 +2511,22 @@ void __audit_inode_child(struct inode *parent,
 }
 EXPORT_SYMBOL_GPL(__audit_inode_child);
 
+/**
+ * audit_get_ctime - get creation time of audit_context
+ *
+ * @ctx: audit_context for the task
+ *
+ * Returns an empty timespec64 if ctx is NULL.
+ */
+struct timespec64 audit_get_ctime(const struct audit_context *ctx)
+{
+	struct timespec64 t = {};
+
+	if (ctx)
+		return ctx->ctime;
+	return t;
+}
+
 /**
  * auditsc_get_stamp - get local copies of audit_context values
  * @ctx: audit_context for the task
@@ -2526,9 +2542,8 @@ int auditsc_get_stamp(struct audit_context *ctx,
 		return 0;
 	if (!ctx->serial)
 		ctx->serial = audit_serial();
-	t->tv_sec  = ctx->ctime.tv_sec;
-	t->tv_nsec = ctx->ctime.tv_nsec;
-	*serial    = ctx->serial;
+	*t = audit_get_ctime(ctx);
+	*serial = ctx->serial;
 	if (!ctx->prio) {
 		ctx->prio = 1;
 		ctx->current_state = AUDIT_STATE_RECORD;
-- 
2.47.0

