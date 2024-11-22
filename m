Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE177082B
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286056; cv=none; b=u8sCbInKPp4vElC1AIAZ+K/PCOMBmOgQMMh+7KrfgEoe2I+PRZcRfw4OaAZoTSXN2SEqqCIZ77c9NmtsPPDw1QlAKtl1qd+hsCa46/rVyPKEQRv4D6UipG3i8MO2DUTu0asUczk5ECld4UKSBDIDLCMSa/h7R3eghz554xmKFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286056; c=relaxed/simple;
	bh=oj/6mcirhBGSz78MkVxQZgxWtQyM37QmbXlg51RuIoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrEIQFZQxlS+NCfyIJ8KvnaUmTaMDsf46CZSbOqHa6IkOp7ZBqm507rbaG09IP79cLJ1xeG5FjV7pGQjVTK5uMO9/rJVXXet4fiA43ar8EgU99QXG1JhljkxEwOjWmiWhznCjffWwU8THhYHDN026DOOu8j1b8fYDhKBeFTQS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=L3S9+VSv; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="L3S9+VSv"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyK84CR0zdhH;
	Fri, 22 Nov 2024 15:34:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286044;
	bh=t/jeJLYng7iwFnD7UmSkTCH0JnlFPYPzlVzfF2WGADk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3S9+VSvysJWYQqUlRssyyXMNPfahLvq0LusLrc09cn3ux7e16vB9JTg/p8xgM6aU
	 JX9vqipiE4WEmB4oQYUv8lNxOc0uHQv+2nMu4u8dogJLHB3DgcXxx9bLoVFTNSSKMk
	 SFxlkPdBicP8mKz22XvI1QjMw33tI3gHfgtsGVec=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyK76d31znDH;
	Fri, 22 Nov 2024 15:34:03 +0100 (CET)
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
Subject: [PATCH v3 01/23] lsm: Only build lsm_audit.c if CONFIG_SECURITY and CONFIG_AUDIT are set
Date: Fri, 22 Nov 2024 15:33:31 +0100
Message-ID: <20241122143353.59367-2-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20241122143353.59367-2-mic@digikod.net
---

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
2.47.0

