Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFC1FDE2C
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351039; cv=none; b=FwHNF/CtwyEdT2+uDb4b1AKVh+gkQ5pZnZ18eLNNwXmvCKrUB/XkELGilzOdlF2V8k2l4sUqCn7+qKkFW+IAgyl7ZrpGK0e1KfvcE1IoyPzE5lk+hEuU+xF1zJJJjcWUASrttuKBfvkeFUwBW3EgYRmVawRh3kJYTyjON1wmVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351039; c=relaxed/simple;
	bh=g63Ro45o8hhUGW9H6URxmblZAnLGikpsoa9gZvjVE44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQLCq9QAqRHWKjU1tDLS6hzqDUUXtwEJVQ2L3OnGhsHPAcRtS0Q01xeD+fvOYzYIu8rasTBqj3+w2wEqGHwgFOnbc8D3ypFr+Qo21z3uoBe3JhLxjsusoGBVH8/Zaa6sW4K8/3oCFVtvyzpblwe7yIfAG2UC3EWgeCDzzEk+DRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q3iF1KUd; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q3iF1KUd"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsdv5PFBz2Qs;
	Wed,  8 Jan 2025 16:43:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351027;
	bh=f5Hn5KV22WRjWqDiJSZ/dgncmazJcOwKRibL+A+zwmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3iF1KUdqZG0Cygurl6JmKCgzshc2u+o9vEQAKYaYrnovyXbspRSRXciv/UAl8Gqm
	 xBJHlcw0R14/02fnl/RvXmwV9C6fwMCBQApYTfA/i2EL9HmhuL90IWXIjaWPXudj2p
	 kNTOiW5te95uFqsjeF6dXbS8XuIGLDvGRwtb6i5g=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsdt6G7BzLZp;
	Wed,  8 Jan 2025 16:43:46 +0100 (CET)
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
Subject: [PATCH v4 01/30] lsm: Only build lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT are set
Date: Wed,  8 Jan 2025 16:43:09 +0100
Message-ID: <20250108154338.1129069-2-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

When CONFIG_AUDIT is set, its CONFIG_NET dependency is also set, and the
dev_get_by_index and init_net symbols (used by dump_common_audit_data)
are found by the linker.  dump_common_audit_data() should then failed to
build when CONFIG_NET is not set. However, because the compiler is
smart, it knows that audit_log_start() always return NULL when
!CONFIG_AUDIT, and it doesn't build the body of common_lsm_audit().  As
a side effect, dump_common_audit_data() is not built and the linker
doesn't error out because of missing symbols.

Let's only build lsm_audit.o when CONFIG_SECURITY and CONFIG_AUDIT are
both set, which is checked with the new CONFIG_HAS_SECURITY_AUDIT.

ipv4_skb_to_auditdata() and ipv6_skb_to_auditdata() are only used by
Smack if CONFIG_AUDIT is set, so they don't need fake implementations.

Because common_lsm_audit() is used in multiple places without
CONFIG_AUDIT checks, add a fake implementation.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-2-mic@digikod.net
---

Merged in the LSM's next tree.  It will be part of Linux v6.13:
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/commit/?h=next&id=7ccbe076d987598b04b4b9c9b61f042291f9cc77

Changes since v2:
- Add CONFIG_HAS_SECURITY_AUDIT to fix the build with AUDIT &&
  !SECURITY, reported by Guenter Roeck.
---
 include/linux/lsm_audit.h | 14 ++++++++++++++
 security/Kconfig          |  5 +++++
 security/Makefile         |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 97a8b21eb033..c2b01380262c 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -116,14 +116,28 @@ struct common_audit_data {
 #define v4info fam.v4
 #define v6info fam.v6
 
+#ifdef CONFIG_AUDIT
+
 int ipv4_skb_to_auditdata(struct sk_buff *skb,
 		struct common_audit_data *ad, u8 *proto);
 
+#if IS_ENABLED(CONFIG_IPV6)
 int ipv6_skb_to_auditdata(struct sk_buff *skb,
 		struct common_audit_data *ad, u8 *proto);
+#endif /* IS_ENABLED(CONFIG_IPV6) */
 
 void common_lsm_audit(struct common_audit_data *a,
 	void (*pre_audit)(struct audit_buffer *, void *),
 	void (*post_audit)(struct audit_buffer *, void *));
 
+#else /* CONFIG_AUDIT */
+
+static inline void common_lsm_audit(struct common_audit_data *a,
+	void (*pre_audit)(struct audit_buffer *, void *),
+	void (*post_audit)(struct audit_buffer *, void *))
+{
+}
+
+#endif /* CONFIG_AUDIT */
+
 #endif
diff --git a/security/Kconfig b/security/Kconfig
index 28e685f53bd1..f10dbf15c294 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -64,6 +64,11 @@ config SECURITY
 
 	  If you are unsure how to answer this question, answer N.
 
+config HAS_SECURITY_AUDIT
+	def_bool y
+	depends on AUDIT
+	depends on SECURITY
+
 config SECURITYFS
 	bool "Enable the securityfs filesystem"
 	help
diff --git a/security/Makefile b/security/Makefile
index cc0982214b84..22ff4c8bd8ce 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_SECURITY)			+= security.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
-obj-$(CONFIG_SECURITY)			+= lsm_audit.o
+obj-$(CONFIG_HAS_SECURITY_AUDIT)	+= lsm_audit.o
 obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/
 obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
-- 
2.47.1

