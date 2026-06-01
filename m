Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38323FCC
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272061; cv=none; b=V4FbFRFPTSkvc7XRTai/LDhcOj8BiPRvtyajsz+43BBIvDwgvcn7i2pppJ/DbUD0G2jIo4g4SbYDFcoh4vsMg9kJaxmJjvvyp7QIzjYnq7DjOy/tHt6LmFhPPob1io+BjaXzmqZlhoJ4UQBABVmWhJ009+d7XVi8+X1WqmwHXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272061; c=relaxed/simple;
	bh=Y4WlzZiFjGWM4jJJe8GBgnjDffQH8FHHkO3k+LL+/lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myFCxyny+R2nvVSpDq6M1GvRxxmihu5LF0RTvETYj8dZS0RHptHjqcmatxvEC04j4Daks/SuUbvTpwOCJk1j4lOzq9n1IihJrtyFnUCy5DVXn+cgqG2240baHJvIBcKbfAs0IHiO1JpArTgrsBYbquOrCv2NbKnUl6Q7IKgk5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=yvL4fLKF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=it5L0dPq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="yvL4fLKF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="it5L0dPq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2EC6A1D000BE;
	Sun, 31 May 2026 20:00:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 31 May 2026 20:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780272059;
	 x=1780358459; bh=KbvZWcvi4fH0RlKMoc1od1aJY18x/Z9peZtoJt09fxI=; b=
	yvL4fLKFRk35Ciy0Th3Dfgun4JwMVC6vL4J0JApBuVQWjfY0OpnSlwwgIzdLmFst
	uPrCWGU8DAxGknyLsGihQjNW8qsELQibklVutVn7RFjYA1kgZP3BHMjn4D+zjAMp
	3QhhCxtGyKXMjkUA/iU5f0UPOXlQl1nhuijEChjPIoqcdv6PTYJKWmVmUGEwcFjf
	G8AEHPsq0qzvoIafKxulZ1dOq10LyAYDciyudsmNf2FNcDXA5Y7FCVDUbw9Zhy0B
	h6Hjyjw5RuNiDNu+gZLegMD7pj5rk/EyJTTnyHYrndFNQtfcejg57EWxIEjtGtgm
	P8XVrNVo059v7ViExQjf0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780272059; x=
	1780358459; bh=KbvZWcvi4fH0RlKMoc1od1aJY18x/Z9peZtoJt09fxI=; b=i
	t5L0dPqx6tS3D7z0yKI9kCXf+KYQrAHtm5dgck9PB6TcwsV2EIKcsbWh1t5LLXBY
	+FEZEVngoYdm4Qr6Yj9jmkLxcjuh4FoTrZt7R5cDwna0U28/fmfMCLVW7jyTBSFr
	GFso5lCtlDAok3AEHH/r69mlEaRh6NzxyjCzFJYfSlhZsbx0TRRwpeyWw+aNDiJW
	RG7bN1CU7hFDoM9U6oP9X1XJEnvTyTON9xQMtf3LzeQtmMIih1qEnSd9DSZCFrPE
	ovLQ8R1bAwx0+tPpBiwHsTveXDsqOjzHy8BCaAyYpbZvLKrya0tdm4E1NXvTXSxu
	a0jW26xf8VP8xn53SGZLg==
X-ME-Sender: <xms:usscakeseuYArd3lK0vDChF9s-X2uzhfFuUHTxONKyqvGW8qdMPmcQ>
    <xme:usscaocoRbs-FggJhhScFZB5e50j7EXHb6F5anj4T37O1slyiP3LFwqqdxNS5nt7z
    qba_kijw_DrHAhYHGlDCSyoSNVZ-Y9GJIif8rYOREMy8YHgocF4lZO6>
X-ME-Received: <xmr:usscanxnkzgRIAlLHHfJvqbz-p0QSQm2alf7AFB6fDZp5-JV-Pw_IcJPSbTnMPut5jc>
X-ME-Proxy-Cause: dmFkZTGkBm9sr6+DCfHy9f3RJEQ3hpYMN05iR23PKb1wNfiMhTc3kSn4gRx5AmXgLkuGym
    /6nh4uk0mCG5uxZUBdLBmCT5SN8oyHt9f0O/0nCjmEYuaV68afDagjgp8dmPrWr+niFW4T
    oTdgLBiOQ0KMAB482/UUrMIF5HLHMf95oAxpJJTLcrFwP6YXEj6803cwItliuO8wwbf8ez
    r4G3rg2IlTD2e0OjSpDnjphmyc73esQhC7ybforyVHDbIEuUylvX3UMxNoTFdZN/8jHTnT
    ZwwGKhUPFBsWIu8YhaGHDOUnh1ixj+ywL11hQzMTaVq6TvGnXgcKvcK4MHo6hesSCKJ3lH
    1o8wuM3effpOpiea/m0QzBgPwZCpZ2yli182I1nDUfkQVH++piehRMgQk2VKg60xCsOOYQ
    Gflv4eLwMaPdCLHLTEMM7XwpOMzvNCI4eh5udbbzkq9k0BuNSf+0V2hJ95sCgSO4eeBnYr
    0eRxElXaFwVuShEOnScR1GzLDeFez4pIqcjNd4QwFwt3sY31yfuLD6J4iZDJ6xPCtvkbzl
    ll0JJvJy+By5aiXadgxXwIVJNVHkRflNdpzpe8njHWjs2+UwXTjKv4Z+5F9TNmBLVI1oyj
    e4TJflpyCcP03UszLi8yxmfZhyzI7HDqlx6vsuXUR0515Ltmbqwnzf1eRUvA
X-ME-Proxy: <xmx:usscav_luwK6bdCffp7FUGbFwNB8pLPPYUGFmgZ3j2xnxSNqhKrPPw>
    <xmx:usscavjbbGv73djE1Bio76vYKPYm395aHZGSRzS-0_36Yf9ZEzOUMQ>
    <xmx:usscamHY57UEoER42Xq4FF4_MbucTtit3Lluah7wWc7iHe2XIpBAxA>
    <xmx:usscau-iZMsyz77o4jMLYUgCFheMfLtQ5KqxEmV1OAR0Z-_nAU2oXg>
    <xmx:u8scanpQyirlqp4vtsrmWPMTanZJLL3AUUY_dAi_VkmjbExO7ulpZTvN>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:00:57 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v10 2/9] landlock: Add API support and docs for the quiet flags
Date: Mon,  1 Jun 2026 01:00:36 +0100
Message-ID: <3f622c8e06638383d3dbf00b7bc78c61bfd584dd.1780272022.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780272022.git.m@maowtm.org>
References: <cover.1780272022.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds the UAPI for the quiet flags feature (but not the implementation
yet).

Even though currently LANDLOCK_ADD_RULE_QUIET only affects audit
logging, in the future this can also be used as part of a supervisor
mechanism, where it will also suppress denial notifications on a
per-object basis.  Thus the name is deliberately generic, as opposed to
e.g. LANDLOCK_ADD_RULE_LOG_QUIET.

According to pahole, even after adding the struct access_masks quiet_masks
in struct landlock_hierarchy, the u32 log_* bitfield still only has a size
of 2 bytes, so there's minimal wasted space.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v9:
- Move a mistakenly included hunk into patch 1
- Doc change for sys_landlock_create_ruleset to add missing
  "quiet_scoped | scoped == scoped" requirement.
- Doc changes for struct landlock_ruleset_attr, and re-wrap added bits
  wider to stay consistent with the existing block.
- Other style changes from suggestions
- Added mention of this flag in the audit section of
  Documentation/admin-guide/LSM/landlock.rst
- Added a block for this new flag to the "Previous limitations" section
  in Documentation/userspace-api/landlock.rst

Changes in v8:
- The new Landlock ABI version is now v10 as a result of rebase.
- Allocate a rule_flags in hook_unix_find() and pass to
  is_access_to_paths_allowed().

Changes in v6:
- Fix typo in doc

Changes in v5:
- Doc fixes.
- Fix build failure without CONFIG_AUDIT / CONFIG_INET (reported by Justin
  Suess)

Changes in v4:
- Minor update to this commit message.
- Fix minor formatting

Changes in v3:
- Updated docs from Mickaël's suggestions.

Changes in v2:
- Per suggestion, added support for quieting only certain access bits,
  controlled by extra quiet_access_* fields in the ruleset_attr.
- Added docs for the extra fields and made updates to doc changes in v1.
  In particular, call out that the effect of LANDLOCK_ADD_RULE_QUIET is
  independent from the access bits passed in rule_attr
- landlock_add_rule will return -EINVAL when LANDLOCK_ADD_RULE_QUIET is
  used but the ruleset does not have any quiet access bits set for the
  given rule type.
- ABI version bump to v8
- Syntactic and comment changes per suggestion.

 Documentation/admin-guide/LSM/landlock.rst   |  9 ++-
 Documentation/userspace-api/landlock.rst     | 11 +++
 include/uapi/linux/landlock.h                | 61 +++++++++++++++++
 security/landlock/domain.h                   |  5 ++
 security/landlock/fs.c                       |  4 +-
 security/landlock/fs.h                       |  2 +-
 security/landlock/net.c                      |  5 +-
 security/landlock/net.h                      |  5 +-
 security/landlock/ruleset.c                  | 12 +++-
 security/landlock/ruleset.h                  | 12 +++-
 security/landlock/syscalls.c                 | 71 +++++++++++++++-----
 tools/testing/selftests/landlock/base_test.c |  2 +-
 12 files changed, 168 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 9923874e2156..ccc32dad1d1c 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -19,8 +19,10 @@ Audit
 Denied access requests are logged by default for a sandboxed program if `audit`
 is enabled.  This default behavior can be changed with the
 sys_landlock_restrict_self() flags (cf.
-Documentation/userspace-api/landlock.rst).  Landlock logs can also be masked
-thanks to audit rules.  Landlock can generate 2 audit record types.
+Documentation/userspace-api/landlock.rst), or suppressed on a per-object
+basis by using ``LANDLOCK_ADD_RULE_QUIET`` (ABI 10+).  Landlock logs can
+also be masked thanks to audit rules.  Landlock can generate 2 audit
+record types.
 
 Record types
 ------------
@@ -172,7 +174,8 @@ If you get spammed with audit logs related to Landlock, this is either an
 attack attempt or a bug in the security policy.  We can put in place some
 filters to limit noise with two complementary ways:
 
-- with sys_landlock_restrict_self()'s flags if we can fix the sandboxed
+- with sys_landlock_restrict_self()'s flags, or
+  ``LANDLOCK_ADD_RULE_QUIET`` (ABI 10+) if we can fix the sandboxed
   programs,
 - or with audit rules (see :manpage:`auditctl(8)`).
 
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 45861fa75685..138d504cb498 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -722,6 +722,17 @@ Starting with the Landlock ABI version 9, it is possible to restrict
 connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
 the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
 
+Quiet rule flag (ABI < 10)
+-----------------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to selectively
+suppress audit logs for specific denied accesses on a per-object basis with
+the ``LANDLOCK_ADD_RULE_QUIET`` flag of sys_landlock_add_rule(), in
+combination with the ``quiet_access_fs`` and ``quiet_access_net`` fields of
+struct landlock_ruleset_attr.  It is also now possible to suppress audit logs
+for scope accesses via the ``quiet_scoped`` field of struct
+landlock_ruleset_attr.
+
 .. _kernel_support:
 
 Kernel support
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b147223efc97..90a0752b61bf 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -32,6 +32,19 @@
  * *handle* a wide range or all access rights that they know about at build time
  * (and that they have tested with a kernel that supported them all).
  *
+ * @quiet_access_fs and @quiet_access_net are bitmasks of actions for which a
+ * denial by this layer will not trigger an audit log if the corresponding
+ * object (or its children, for filesystem rules) is marked with the "quiet" bit
+ * via %LANDLOCK_ADD_RULE_QUIET, even if logging would normally take place per
+ * landlock_restrict_self() flags.  @quiet_scoped is similar, except that it
+ * does not require marking any objects as quiet - if the ruleset is created
+ * with any bits set in @quiet_scoped, then denial of such scoped resources will
+ * not trigger any log.  These 3 fields are available since Landlock ABI version
+ * 10.
+ *
+ * @quiet_access_fs, @quiet_access_net and @quiet_scoped must be a subset of
+ * @handled_access_fs, @handled_access_net and @scoped respectively.
+ *
  * This structure can grow in future Landlock versions.
  */
 struct landlock_ruleset_attr {
@@ -51,6 +64,21 @@ struct landlock_ruleset_attr {
 	 * resources (e.g. IPCs).
 	 */
 	__u64 scoped;
+	/**
+	 * @quiet_access_fs: Bitmask of filesystem actions which should not be
+	 * logged if per-object quiet flag is set.
+	 */
+	__u64 quiet_access_fs;
+	/**
+	 * @quiet_access_net: Bitmask of network actions which should not be
+	 * logged if per-object quiet flag is set.
+	 */
+	__u64 quiet_access_net;
+	/**
+	 * @quiet_scoped: Bitmask of scoped actions which should not be
+	 * logged.
+	 */
+	__u64 quiet_scoped;
 };
 
 /**
@@ -69,6 +97,39 @@ struct landlock_ruleset_attr {
 #define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
 /* clang-format on */
 
+/**
+ * DOC: landlock_add_rule_flags
+ *
+ * **Flags**
+ *
+ * %LANDLOCK_ADD_RULE_QUIET
+ *     Together with the quiet_* fields in struct landlock_ruleset_attr,
+ *     this flag controls whether Landlock will log audit messages when
+ *     access to the objects covered by this rule is denied by this layer.
+ *
+ *     If audit logging is enabled, when Landlock denies an access, it will
+ *     suppress the audit log if all of the following are true:
+ *
+ *     - this layer is the innermost layer that denied the access;
+ *     - all accesses denied by this layer are part of the quiet_* fields
+ *       in the related struct landlock_ruleset_attr;
+ *     - the object (or one of its parents, for filesystem rules) is
+ *       marked as "quiet" via %LANDLOCK_ADD_RULE_QUIET.
+ *
+ *     Because logging is only suppressed by a layer if the layer denies
+ *     access, a sandboxed program cannot use this flag to "hide" access
+ *     denials, without denying itself the access in the first place.
+ *
+ *     The effect of this flag does not depend on the value of
+ *     allowed_access in the passed in rule_attr.  When this flag is
+ *     present, the caller is also allowed to pass in an empty
+ *     allowed_access.
+ */
+
+/* clang-format off */
+#define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
+/* clang-format on */
+
 /**
  * DOC: landlock_restrict_self_flags
  *
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index af100a8cd939..9f560f3c3bd1 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -111,6 +111,11 @@ struct landlock_hierarchy {
 		 * %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON.  Set to false by default.
 		 */
 		log_new_exec : 1;
+	/**
+	 * @quiet_masks: Bitmasks of access that should be quieted (i.e. not
+	 * logged) if the related object is marked as quiet.
+	 */
+	struct access_masks quiet_masks;
 #endif /* CONFIG_AUDIT */
 };
 
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f7c1bc64de20..cc0852f77311 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -325,7 +325,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
  */
 int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
-			    access_mask_t access_rights)
+			    access_mask_t access_rights, const int flags)
 {
 	int err;
 	struct landlock_id id = {
@@ -346,7 +346,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights);
+	err = landlock_insert_rule(ruleset, id, access_rights, flags);
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index bf9948941f2f..cb7e654933ac 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -126,6 +126,6 @@ __init void landlock_add_fs_hooks(void);
 
 int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
-			    access_mask_t access_hierarchy);
+			    access_mask_t access_hierarchy, const int flags);
 
 #endif /* _SECURITY_LANDLOCK_FS_H */
diff --git a/security/landlock/net.c b/security/landlock/net.c
index 981a362c24db..71868289748a 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -20,7 +20,8 @@
 #include "ruleset.h"
 
 int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
-			     const u16 port, access_mask_t access_rights)
+			     const u16 port, access_mask_t access_rights,
+			     const int flags)
 {
 	int err;
 	const struct landlock_id id = {
@@ -35,7 +36,7 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 			 ~landlock_get_net_access_mask(ruleset, 0);
 
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights);
+	err = landlock_insert_rule(ruleset, id, access_rights, flags);
 	mutex_unlock(&ruleset->lock);
 
 	return err;
diff --git a/security/landlock/net.h b/security/landlock/net.h
index 09960c237a13..72c47f4d6803 100644
--- a/security/landlock/net.h
+++ b/security/landlock/net.h
@@ -16,7 +16,8 @@
 __init void landlock_add_net_hooks(void);
 
 int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
-			     const u16 port, access_mask_t access_rights);
+			     const u16 port, access_mask_t access_rights,
+			     const int flags);
 #else /* IS_ENABLED(CONFIG_INET) */
 static inline void landlock_add_net_hooks(void)
 {
@@ -24,7 +25,7 @@ static inline void landlock_add_net_hooks(void)
 
 static inline int
 landlock_append_net_rule(struct landlock_ruleset *const ruleset, const u16 port,
-			 access_mask_t access_rights)
+			 access_mask_t access_rights, const int flags)
 {
 	return -EAFNOSUPPORT;
 }
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 91948e406e69..f01c3e14e55d 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>
 
 #include "access.h"
 #include "domain.h"
@@ -255,6 +256,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 			if (WARN_ON_ONCE(this->layers[0].level != 0))
 				return -EINVAL;
 			this->layers[0].access |= (*layers)[0].access;
+			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
 			return 0;
 		}
 
@@ -305,12 +307,15 @@ static void build_check_layer(void)
 /* @ruleset must be locked by the caller. */
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
-			 const access_mask_t access)
+			 const access_mask_t access, const int flags)
 {
 	struct landlock_layer layers[] = { {
 		.access = access,
 		/* When @level is zero, insert_rule() extends @ruleset. */
 		.level = 0,
+		.flags = {
+			.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET),
+		},
 	} };
 
 	build_check_layer();
@@ -351,6 +356,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
 			return -EINVAL;
 
 		layers[0].access = walker_rule->layers[0].access;
+		layers[0].flags = walker_rule->layers[0].flags;
 
 		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
 		if (err)
@@ -581,6 +587,10 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (err)
 		return ERR_PTR(err);
 
+#ifdef CONFIG_AUDIT
+	new_dom->hierarchy->quiet_masks = ruleset->quiet_masks;
+#endif /* CONFIG_AUDIT */
+
 	return no_free_ptr(new_dom);
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index f80ca487d125..d54bdb925e96 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -156,8 +156,8 @@ struct landlock_ruleset {
 		 * @work_free: Enables to free a ruleset within a lockless
 		 * section.  This is only used by
 		 * landlock_put_ruleset_deferred() when @usage reaches zero.
-		 * The fields @lock, @usage, @num_rules, @num_layers and
-		 * @access_masks are then unused.
+		 * The fields @lock, @usage, @num_rules, @num_layers, @quiet_masks
+		 * and @access_masks are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
@@ -183,6 +183,12 @@ struct landlock_ruleset {
 			 * non-merged ruleset (i.e. not a domain).
 			 */
 			u32 num_layers;
+			/**
+			 * @quiet_masks: Stores the quiet flags for an unmerged
+			 * ruleset.  For a merged domain, this is stored in each
+			 * layer's struct landlock_hierarchy instead.
+			 */
+			struct access_masks quiet_masks;
 			/**
 			 * @access_masks: Contains the subset of filesystem and
 			 * network actions that are restricted by a ruleset.
@@ -213,7 +219,7 @@ DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,
-			 const access_mask_t access);
+			 const access_mask_t access, const int flags);
 
 struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index d45469d5d464..08b6045d6926 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -105,8 +105,11 @@ static void build_check_abi(void)
 	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
 	ruleset_size += sizeof(ruleset_attr.handled_access_net);
 	ruleset_size += sizeof(ruleset_attr.scoped);
+	ruleset_size += sizeof(ruleset_attr.quiet_access_fs);
+	ruleset_size += sizeof(ruleset_attr.quiet_access_net);
+	ruleset_size += sizeof(ruleset_attr.quiet_scoped);
 	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
-	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 48);
 
 	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
 	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
@@ -193,6 +196,9 @@ const int landlock_abi_version = 10;
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small
  *   @size;
+ * - %EINVAL: quiet_access_fs, quiet_access_net, or quiet_scoped is not a
+ *   subset of the corresponding handled_access_fs, handled_access_net, or
+ *   scoped;
  * - %E2BIG: @attr or @size inconsistencies;
  * - %EFAULT: @attr or @size inconsistencies;
  * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
@@ -249,6 +255,21 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if ((ruleset_attr.scoped | LANDLOCK_MASK_SCOPE) != LANDLOCK_MASK_SCOPE)
 		return -EINVAL;
 
+	/*
+	 * Check that quiet masks are subsets of the respective handled masks.
+	 * Because of the checks above this is sufficient to also ensure that
+	 * the quiet masks are valid access masks.
+	 */
+	if ((ruleset_attr.quiet_access_fs | ruleset_attr.handled_access_fs) !=
+	    ruleset_attr.handled_access_fs)
+		return -EINVAL;
+	if ((ruleset_attr.quiet_access_net | ruleset_attr.handled_access_net) !=
+	    ruleset_attr.handled_access_net)
+		return -EINVAL;
+	if ((ruleset_attr.quiet_scoped | ruleset_attr.scoped) !=
+	    ruleset_attr.scoped)
+		return -EINVAL;
+
 	/* Checks arguments and transforms to kernel struct. */
 	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
 					  ruleset_attr.handled_access_net,
@@ -256,6 +277,10 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
+	ruleset->quiet_masks.fs = ruleset_attr.quiet_access_fs;
+	ruleset->quiet_masks.net = ruleset_attr.quiet_access_net;
+	ruleset->quiet_masks.scope = ruleset_attr.quiet_scoped;
+
 	/* Creates anonymous FD referring to the ruleset. */
 	ruleset_fd = anon_inode_getfd("[landlock-ruleset]", &ruleset_fops,
 				      ruleset, O_RDWR | O_CLOEXEC);
@@ -320,7 +345,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 }
 
 static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
-				 const void __user *const rule_attr)
+				 const void __user *const rule_attr, int flags)
 {
 	struct landlock_path_beneath_attr path_beneath_attr;
 	struct path path;
@@ -335,9 +360,10 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
-	 * are ignored in path walks.
+	 * are ignored in path walks.  However, the rule is not useless if it
+	 * is there to hold a quiet flag.
 	 */
-	if (!path_beneath_attr.allowed_access)
+	if (!flags && !path_beneath_attr.allowed_access)
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
@@ -345,6 +371,10 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
+	/* Checks for useless quiet flag. */
+	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.fs)
+		return -EINVAL;
+
 	/* Gets and checks the new rule. */
 	err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
 	if (err)
@@ -352,13 +382,13 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 
 	/* Imports the new rule. */
 	err = landlock_append_fs_rule(ruleset, &path,
-				      path_beneath_attr.allowed_access);
+				      path_beneath_attr.allowed_access, flags);
 	path_put(&path);
 	return err;
 }
 
 static int add_rule_net_port(struct landlock_ruleset *ruleset,
-			     const void __user *const rule_attr)
+			     const void __user *const rule_attr, int flags)
 {
 	struct landlock_net_port_attr net_port_attr;
 	int res;
@@ -371,9 +401,10 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
-	 * are ignored by network actions.
+	 * are ignored by network actions.  However, the rule is not useless
+	 * if it is there to hold a quiet flag.
 	 */
-	if (!net_port_attr.allowed_access)
+	if (!flags && !net_port_attr.allowed_access)
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
@@ -381,13 +412,17 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 	if ((net_port_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
+	/* Checks for useless quiet flag. */
+	if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_masks.net)
+		return -EINVAL;
+
 	/* Denies inserting a rule with port greater than 65535. */
 	if (net_port_attr.port > U16_MAX)
 		return -EINVAL;
 
 	/* Imports the new rule. */
 	return landlock_append_net_rule(ruleset, net_port_attr.port,
-					net_port_attr.allowed_access);
+					net_port_attr.allowed_access, flags);
 }
 
 /**
@@ -398,7 +433,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * @rule_type: Identify the structure type pointed to by @rule_attr:
  *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
- * @flags: Must be 0.
+ * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
  *
  * This system call enables to define a new rule and add it to an existing
  * ruleset.
@@ -408,20 +443,25 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EAFNOSUPPORT: @rule_type is %LANDLOCK_RULE_NET_PORT but TCP/IP is not
  *   supported by the running kernel;
- * - %EINVAL: @flags is not 0;
+ * - %EINVAL: @flags is not valid;
  * - %EINVAL: The rule accesses are inconsistent (i.e.
  *   &landlock_path_beneath_attr.allowed_access or
  *   &landlock_net_port_attr.allowed_access is not a subset of the ruleset
  *   handled accesses)
  * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
+ * - %EINVAL: LANDLOCK_ADD_RULE_QUIET is passed but the ruleset has no
+ *   quiet access bits set for the corresponding rule type.
  * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access is
- *   0);
+ *   0) and no flags;
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
  *   member of @rule_attr is not a file descriptor as expected;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
  *   @rule_attr is not the expected file descriptor type;
  * - %EPERM: @ruleset_fd has no write access to the underlying ruleset;
  * - %EFAULT: @rule_attr was not a valid address.
+ *
+ * .. kernel-doc:: include/uapi/linux/landlock.h
+ *     :identifiers: landlock_add_rule_flags
  */
 SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		const enum landlock_rule_type, rule_type,
@@ -432,8 +472,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (!is_initialized())
 		return -EOPNOTSUPP;
 
-	/* No flag for now. */
-	if (flags)
+	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
 		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
@@ -443,9 +482,9 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 
 	switch (rule_type) {
 	case LANDLOCK_RULE_PATH_BENEATH:
-		return add_rule_path_beneath(ruleset, rule_attr);
+		return add_rule_path_beneath(ruleset, rule_attr, flags);
 	case LANDLOCK_RULE_NET_PORT:
-		return add_rule_net_port(ruleset, rule_attr);
+		return add_rule_net_port(ruleset, rule_attr, flags);
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 6c8113c2ded1..84e91fcaa1b2 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -201,7 +201,7 @@ TEST(add_rule_checks_ordering)
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Checks invalid flags. */
-	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 1));
+	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 100));
 	ASSERT_EQ(EINVAL, errno);
 
 	/* Checks invalid ruleset FD. */
-- 
2.54.0
