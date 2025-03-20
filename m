Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F1221573
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497658; cv=none; b=C169sW9r5ww2WXo+xHIynwfb8GZUigVVv385CyHXo3bByJIcxFE+xYWG/bXeQ2LjSA+8KTs7rBxyT5PH0NG6kbaHYQKe5FpVDRsSa6Nlb1kbjwM695RwvtKOk3DePJpdYn3iQpFbbzpT+eNkDdw8XR2bTzvllGFclFkegg6KSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497658; c=relaxed/simple;
	bh=4APA0yd3c+w7p33UrZkR+u3PdFp86U0HE/ww9K2v2Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NE9cUJ0kL+rUGmyaikriwuKZbRvZDgk7vIEoaHmG4SNF0ojmLst2YzlYlu0hyh7tbOh6WZ0NmzZg2S7WL3rqOaQjEAK+CVBrYYKZ2nSKD/ffiBMHPBjhkIf5ya5FwFzMmdiedEpVXUlqwfDxY/6JGStOZKJOXyTGJ+8kNfwHV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=t8sb4QrQ; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="t8sb4QrQ"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZp56XQFzwgX;
	Thu, 20 Mar 2025 20:07:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497645;
	bh=zr5gmFSYD1tD7fpfRv2XYUIy9g8rF8FEdaY+2pUts9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8sb4QrQAnScemqm3VR/dsDjqAgP/joYvY+9TJHKGKtYbZCjNsHrg7R248bPi4WXU
	 2+B5vOcKw3ss65jdzQ1Dl3VinBLjcpwF9oezlD+gHjL8w837FUkGICFhWi+Ir7lcBt
	 RSkx/AdBz/HUbsbnq3A40ZAU2ENEBxROhHzNz4o0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZp46cCTzPnK;
	Thu, 20 Mar 2025 20:07:24 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 01/28] lsm: Add audit_log_lsm_data() helper
Date: Thu, 20 Mar 2025 20:06:50 +0100
Message-ID: <20250320190717.2287696-2-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Extract code from dump_common_audit_data() into the audit_log_lsm_data()
helper. This helps reuse common LSM audit data while not abusing
AUDIT_AVC records because of the common_lsm_audit() helper.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Depends-on: 7ccbe076d987 ("lsm: Only build lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT are set")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v4:
- Add Depends-on tag.

Changes since v3:
- Rebase on top of the v6.13's get_task_comm() fix.
- Add Acked-by Paul.

Changes since v1:
- Fix commit message (spotted by Paul).
- Constify dump_common_audit_data()'s and audit_log_lsm_data()'s "a"
  argument.
- Fix build without CONFIG_NET: see previous patch.
---
 include/linux/lsm_audit.h |  8 ++++++++
 security/lsm_audit.c      | 27 ++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index e13d2f947b51..bddd694f7c4c 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -132,6 +132,9 @@ void common_lsm_audit(struct common_audit_data *a,
 	void (*pre_audit)(struct audit_buffer *, void *),
 	void (*post_audit)(struct audit_buffer *, void *));
 
+void audit_log_lsm_data(struct audit_buffer *ab,
+			const struct common_audit_data *a);
+
 #else /* CONFIG_AUDIT */
 
 static inline void common_lsm_audit(struct common_audit_data *a,
@@ -140,6 +143,11 @@ static inline void common_lsm_audit(struct common_audit_data *a,
 {
 }
 
+static inline void audit_log_lsm_data(struct audit_buffer *ab,
+			const struct common_audit_data *a)
+{
+}
+
 #endif /* CONFIG_AUDIT */
 
 #endif
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 52db886dbba8..a61c7ebdb6a7 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -189,16 +189,13 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
 }
 
 /**
- * dump_common_audit_data - helper to dump common audit data
+ * audit_log_lsm_data - helper to log common LSM audit data
  * @ab : the audit buffer
  * @a : common audit data
- *
  */
-static void dump_common_audit_data(struct audit_buffer *ab,
-				   struct common_audit_data *a)
+void audit_log_lsm_data(struct audit_buffer *ab,
+			const struct common_audit_data *a)
 {
-	char comm[sizeof(current->comm)];
-
 	/*
 	 * To keep stack sizes in check force programmers to notice if they
 	 * start making this union too large!  See struct lsm_network_audit
@@ -206,9 +203,6 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	 */
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
-	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
-	audit_log_untrustedstring(ab, get_task_comm(comm, current));
-
 	switch (a->type) {
 	case LSM_AUDIT_DATA_NONE:
 		return;
@@ -431,6 +425,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	} /* switch (a->type) */
 }
 
+/**
+ * dump_common_audit_data - helper to dump common audit data
+ * @ab : the audit buffer
+ * @a : common audit data
+ */
+static void dump_common_audit_data(struct audit_buffer *ab,
+				   const struct common_audit_data *a)
+{
+	char comm[sizeof(current->comm)];
+
+	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
+	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	audit_log_lsm_data(ab, a);
+}
+
 /**
  * common_lsm_audit - generic LSM auditing function
  * @a:  auxiliary audit data
-- 
2.49.0

