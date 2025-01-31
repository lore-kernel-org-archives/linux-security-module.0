Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F71E47A6
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341082; cv=none; b=BP8g0Da3FEo5+XokCouxaLDiATpvWVCJ+iczMpsIbJbaHDDpSsGmfeJyMKhbtMT8XnqUfRZSfNYVFSw1AmHC4xt3BpHgPjJHAU0WEtzQXraQ8BROfn/1j1LswU4/3q7tmMzrpN/AwISq0Oprl65z2WgexASxFwkI2cXNQXnqtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341082; c=relaxed/simple;
	bh=i9pEwHrisGVJyzI0TZDy/pJ6SOmGJ7CQO4jXIqZPDxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtv0IZd8gncY86bq5rk76R+FuGjBTKY+iA6t5irQOeLCrJHihQ+IaCmvXhEbKrtY1eqbJa0yWMoqFt235h/Eo+jG3vNoOsHGhhpzK7gWdNl2Iy3JkKI9vJx/5a2DdVqbhiI9LEujSEeXGE/SjEKMVB8QunreB9tlBzvt8gzKdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1aUfZBd/; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1aUfZBd/"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1bz2cJpzLyL;
	Fri, 31 Jan 2025 17:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341071;
	bh=8PBz5hunFNoJQ+sQTBYKyBSNUYyD/33RuKhb2i7LYWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1aUfZBd/PI9jwsnJmpRM0wdUoyPltRSZZhNZJKQIqarO8kS/uAR8zqnkgk68F6Szs
	 jbNk5kZcsHzgPX55Ee+2WL9BeeG/f2iYU/NSszLgaxpVccrQZkdbTc9mV1da2ABQgb
	 G0ZC0F9go1Kr1MrohNw17YqlFDXpDBnkLUhO6R38=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1by1KRtzdKm;
	Fri, 31 Jan 2025 17:31:10 +0100 (CET)
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
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 01/24] lsm: Add audit_log_lsm_data() helper
Date: Fri, 31 Jan 2025 17:30:36 +0100
Message-ID: <20250131163059.1139617-2-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250131163059.1139617-2-mic@digikod.net
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
2.48.1

