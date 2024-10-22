Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4B19F131
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613427; cv=none; b=SfploScw6iI2T1kMRL06z/5EyK1t8Vx5/tCTNXv9x61WdGHjTwFNcggA8Hy6cNzTXhMYGp4OPVuS61Tu3/ODdOKQ8s2y9n12l+H+LvchRzjb+lFIVf6gFL46xE7yDMx9AdmuyIv7YpgKdWZPgvF3sGBrg5KUW8K799+eRAto1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613427; c=relaxed/simple;
	bh=mSQ320Nro1SXr6po+P+08DdJ0QOAdXNmOSt/9xSLizM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEnb4Vmyfdy39jNYLmf8gl8fKJeYcxlgi2KlFrwS9tncq9Xx/dBHECDLEsX9dK1IN41v1ESSLKmxtHsZC4kTplZ+ERT7yiZIpHCQhdCPn/hY+0bb/PiA+uxCsTz8rKdD58ka4GhARbGlC7XkxlBfIJTPfqahTszCO5/8bSB61S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vEIWbj8w; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vEIWbj8w"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxwX42zVzch;
	Tue, 22 Oct 2024 18:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613420;
	bh=SWikEePu4raer4R/O/pborxitl0IvwK4QnF5ARNKRnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEIWbj8wvv1mFVv1pPJXCwB26LVHPhj87K8drS7t9HHj+FA4mqtQBSIvf7sxFz8eo
	 6zLAM1GlZSl5CDeIKfg86fm2iXNzeE0aVc+z+CmVZdO0pxtUnUoGb38sN/DO4IIhxP
	 GDOgP8WrgLlOZUJHcHaV7pTf+xgz6ODJskX5TWpg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxwW3q6QzwRq;
	Tue, 22 Oct 2024 18:10:19 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v2 01/14] lsm: Only build lsm_audit.c if CONFIG_AUDIT is set
Date: Tue, 22 Oct 2024 18:09:56 +0200
Message-ID: <20241022161009.982584-2-mic@digikod.net>
In-Reply-To: <20241022161009.982584-1-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
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

Let's only build lsm_audit.o when CONFIG_AUDIT is set.

ipv4_skb_to_auditdata() and ipv6_skb_to_auditdata() are only used by
Smack if CONFIG_AUDIT is set, so they don't need fake implementations.

Because common_lsm_audit() is used in multiple places without
CONFIG_AUDIT checks, add a fake implementation.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241022161009.982584-2-mic@digikod.net
---
 include/linux/lsm_audit.h | 14 ++++++++++++++
 security/Makefile         |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

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
diff --git a/security/Makefile b/security/Makefile
index cc0982214b84..e25da79f55d3 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_SECURITY)			+= security.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
-obj-$(CONFIG_SECURITY)			+= lsm_audit.o
+obj-$(CONFIG_AUDIT)			+= lsm_audit.o
 obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/
 obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
-- 
2.47.0

