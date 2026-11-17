Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923482;
	b=JzM6XTIlU0YFd6tWr+q07tUsX9WazLy54j2mW76DXXXl3ZE/xW8yWIghnMBs4rEPhG65
	 rdiKp7zB75ESQKoHXbZwjTJ4undM+l56mvwhVBZWv5bYb4rcLVdmM7SviPiZpasmR6X+X
	 mhSt4mNlk83BTvYtn4CKXx7dMJH3emdIRQlZGaUmmxEyXMep+0o+mmKxAyCUuwiTQMsRS
	 A5sq26F0LRxqFBftx7CSUnK7CueCDp86ngQOcBSZsqrVe+R/+5aa8qdNvQOayG+S4SPkr
	 2TkC7+Oi8nq0n2lmVcSN1sLUSiSI8C/65X7wA8vTb9QFh0Nq7okLy54FkYoCdXkZXVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923482;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X+PQhHRT/4yvc79R8QvXcm1DaZOF5+iy/1/TEpoty4k=;
	b=emevuEbSPMMWGEQk07iMb2v0C4IddNKX7U4R+OY4NtgQGdrK2cW0k8ez/jSsivIn3/8K
	 eRG1qp9mTORQS8F1H/L7RKTrxXDGMq7G6exX2keXCf2Zea6qbQRnZ6oerD8dDSXsbXKfI
	 8J5r9trPtHMT6ZsJ9jSxN+cHPGx0n3Pj1CsUmUJbdQq0LakggtMoGL1ixL83IBJefhZaC
	 6giSZyD0VOLWy2nSDP1H/x/8tK8U71rvS5G0kDUjpf5jJU56HFL1zVLVtffNTdYUSf6jd
	 e+adxvp+v/jrIwRfD1nGCrZB/EyJSUBGs4j3epQ8fQBuS9OIk4KMBpUH5L3bqKI4v+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=nwlsHeLu;
	arc=none smtp.remote-ip=185.125.188.120
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DC606A323
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E19DC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=nwlsHeLu
Received: from sec-questing-amd64 (lfbn-idf3-1-218-1.w90-22.abo.wanadoo.fr [90.22.217.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D75F742CD4;
	Tue, 17 Nov 2026 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1794923474;
	bh=X+PQhHRT/4yvc79R8QvXcm1DaZOF5+iy/1/TEpoty4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=nwlsHeLubsFjeq/mJ5cb0f+Xoz2biSDXIEs+VqMRRQ0Aw1s4k22WSOo+1KjJpbLQe
	 +zTTVyb9pPCxTD5FP4fHMJcKKkOvq91AvbRhuiDgPaZPCr2Jb989pLT4UVU9NIRzw6
	 r4ToE69LpwaYohoxak5H1Nju+b+MXZuPgQ9KkafEFLDH0ViGjcsv8ekujt5t3b57CS
	 oE+9bf5Oj+i6knXi7EOmSXUOeHRRxwlth/L53HI4WaoXppts+QeArrFn8wnyA/Izfo
	 /gkySHw41oBcUJoBS00unHseYz7xG5aRftaq5Zht+DCUy3MqJlG/7F6Tc+B+6HRBkJ
	 CipMcSuZR4oqVlXbEoAaQeOknbuwsWgcMPWL61M4CID5TmOht389uEuKuarn3MyqIM
	 RqlOf52R45R6o9zdM9KJR6gmCqpV9MLNzohmP5OyrFM4EYCkeuWYES7lKIE++A8+wU
	 gNtASvXp0DSZqLcFYoSrmMC8Eb0DAXOy1cnL7XrQIy//759NCgd5zK+8oyqKWyRGpr
	 xbPidIBGuJiW+c9I4ZEgdkDrrul1dLWSJKuk33d3Whs0nXX6NkO0ODglvOKCUnMkE6
	 6b8TgEwBL9qkZAwvLWkE99t2IrhbtrxzGa7z7HvsB6H6drRLdhpbqh/aoMMEP0At8Y
	 0qgQiEwj7lqBKzTC4cbryydY=
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH 1/4] apparmor: move the feature tables to a header
Date: Tue, 17 Nov 2026 14:50:07 +0100
Message-ID: <20261117135042.78238-2-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261117135042.78238-1-maxime.belair@canonical.com>
References: <20261117135042.78238-1-maxime.belair@canonical.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The tables that describe the securityfs features directory are spread
over apparmorfs.c, capability.c, net.c and resource.c. Move them to
include/features.h, so that a later patch can also build them into a
host program, which writes the feature set to a file when the kernel
is built.

Three of the tables use a generated mask. Collect the masks in
feature_masks.h, apart from the name tables they are generated with.

The entries are moved as they are, and the content of the features
directory does not change.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/apparmor/.gitignore           |   1 +
 security/apparmor/Makefile             |  10 +-
 security/apparmor/apparmorfs.c         | 124 +------------------
 security/apparmor/capability.c         |   6 -
 security/apparmor/include/capability.h |   2 -
 security/apparmor/include/features.h   | 165 +++++++++++++++++++++++++
 security/apparmor/include/net.h        |   3 -
 security/apparmor/include/resource.h   |   2 -
 security/apparmor/net.c                |  15 ---
 security/apparmor/resource.c           |   5 -
 10 files changed, 178 insertions(+), 155 deletions(-)
 create mode 100644 security/apparmor/include/features.h

diff --git a/security/apparmor/.gitignore b/security/apparmor/.gitignore
index 6d1eb1c15c18..921cc7c3e835 100644
--- a/security/apparmor/.gitignore
+++ b/security/apparmor/.gitignore
@@ -2,3 +2,4 @@
 net_names.h
 capability_names.h
 rlim_names.h
+feature_masks.h
diff --git a/security/apparmor/Makefile b/security/apparmor/Makefile
index 8aed0d7ed6f5..7d20a09cb116 100644
--- a/security/apparmor/Makefile
+++ b/security/apparmor/Makefile
@@ -12,7 +12,7 @@ apparmor-$(CONFIG_SECURITY_APPARMOR_HASH) += crypto.o
 obj-$(CONFIG_SECURITY_APPARMOR_KUNIT_TEST) += apparmor_policy_unpack_test.o
 apparmor_policy_unpack_test-objs += policy_unpack_test.o
 
-clean-files := capability_names.h rlim_names.h net_names.h
+clean-files := capability_names.h rlim_names.h net_names.h feature_masks.h
 
 # Build a lower case string table of address family names
 # Transform lines from
@@ -98,6 +98,11 @@ cmd_make-rlim = echo "static const char *const rlim_names[RLIM_NLIMITS] = {" \
 	sed -r -n 's/^\# ?define[ \t]+RLIMIT_([A-Z0-9_]+).*/\L\1/p' $< | \
 	    tr '\n' ' ' | sed -e 's/ $$/"\n/' >> $@
 
+# Collect the feature masks, without the name tables they are generated with
+quiet_cmd_make-masks = GEN     $@
+cmd_make-masks = grep -h '^\#define AA_SFS_' $(filter %.h,$^) > $@
+
+$(obj)/apparmorfs.o : $(obj)/feature_masks.h
 $(obj)/capability.o : $(obj)/capability_names.h
 $(obj)/net.o : $(obj)/net_names.h
 $(obj)/resource.o : $(obj)/rlim_names.h
@@ -112,3 +117,6 @@ $(obj)/net_names.h : $(srctree)/include/linux/socket.h \
 		     $(src)/Makefile
 	$(call cmd,make-af)
 	$(call cmd,make-sock)
+$(obj)/feature_masks.h : $(obj)/capability_names.h $(obj)/net_names.h \
+			 $(obj)/rlim_names.h $(src)/Makefile
+	$(call cmd,make-masks)
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index a99366467217..9fbe72c4bee7 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2577,128 +2577,10 @@ static const struct file_operations aa_sfs_profiles_fops = {
 
 
 /** Base file system setup **/
-static struct aa_sfs_entry aa_sfs_entry_file[] = {
-	AA_SFS_FILE_STRING("mask",
-			   "create read write exec append mmap_exec link lock"),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_ptrace[] = {
-	AA_SFS_FILE_STRING("mask", "read trace"),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_signal[] = {
-	AA_SFS_FILE_STRING("mask", AA_SFS_SIG_MASK),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_attach[] = {
-	AA_SFS_FILE_BOOLEAN("xattr", 1),
-	{ }
-};
-static struct aa_sfs_entry aa_sfs_entry_domain[] = {
-	AA_SFS_FILE_BOOLEAN("change_hat",	1),
-	AA_SFS_FILE_BOOLEAN("change_hatv",	1),
-	AA_SFS_FILE_BOOLEAN("unconfined_allowed_children",	1),
-	AA_SFS_FILE_BOOLEAN("change_onexec",	1),
-	AA_SFS_FILE_BOOLEAN("change_profile",	1),
-	AA_SFS_FILE_BOOLEAN("stack",		1),
-	AA_SFS_FILE_BOOLEAN("fix_binfmt_elf_mmap",	1),
-	AA_SFS_FILE_BOOLEAN("post_nnp_subset",	1),
-	AA_SFS_FILE_BOOLEAN("computed_longest_left",	1),
-	AA_SFS_DIR("attach_conditions",		aa_sfs_entry_attach),
-	AA_SFS_FILE_BOOLEAN("disconnected.path",            1),
-	AA_SFS_FILE_BOOLEAN("kill.signal",		1),
-	AA_SFS_FILE_STRING("version", "1.2"),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_unconfined[] = {
-	AA_SFS_FILE_BOOLEAN("change_profile", 1),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_versions[] = {
-	AA_SFS_FILE_BOOLEAN("v5",	1),
-	AA_SFS_FILE_BOOLEAN("v6",	1),
-	AA_SFS_FILE_BOOLEAN("v7",	1),
-	AA_SFS_FILE_BOOLEAN("v8",	1),
-	AA_SFS_FILE_BOOLEAN("v9",	1),
-	{ }
-};
-
-#define PERMS32STR "allow deny subtree cond kill complain prompt audit quiet hide xindex tag label"
-static struct aa_sfs_entry aa_sfs_entry_policy[] = {
-	AA_SFS_DIR("versions",			aa_sfs_entry_versions),
-	AA_SFS_FILE_BOOLEAN("set_load",		1),
-	AA_SFS_FILE_BOOLEAN("diff-encode",		1),
-	/* number of out of band transitions supported */
-	AA_SFS_FILE_U64("outofband",		MAX_OOB_SUPPORTED),
-	AA_SFS_FILE_U64("permstable32_version",	3),
-	AA_SFS_FILE_STRING("permstable32", PERMS32STR),
-	AA_SFS_FILE_U64("state32",	1),
-	AA_SFS_DIR("unconfined_restrictions",   aa_sfs_entry_unconfined),
-#ifdef CONFIG_SECURITY_APPARMOR_COMPRESSED_POLICY
-	AA_SFS_FILE_BOOLEAN("compressed_load",	1),
-	AA_SFS_FILE_BOOLEAN("extended_policy_header",	1),
-#endif
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_mount[] = {
-	AA_SFS_FILE_STRING("mask", "mount umount pivot_root"),
-	AA_SFS_FILE_STRING("move_mount", "detached"),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_ns[] = {
-	AA_SFS_FILE_BOOLEAN("profile",		1),
-	AA_SFS_FILE_BOOLEAN("pivot_root",	0),
-	AA_SFS_FILE_STRING("mask", "userns_create"),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_dbus[] = {
-	AA_SFS_FILE_STRING("mask", "acquire send receive"),
-	{ }
-};
 
-static struct aa_sfs_entry aa_sfs_entry_query_label[] = {
-	AA_SFS_FILE_STRING("perms", "allow deny audit quiet"),
-	AA_SFS_FILE_BOOLEAN("data",		1),
-	AA_SFS_FILE_BOOLEAN("multi_transaction",	1),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_query[] = {
-	AA_SFS_DIR("label",			aa_sfs_entry_query_label),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_io_uring[] = {
-	AA_SFS_FILE_STRING("mask", "sqpoll override_creds"),
-	{ }
-};
-
-static struct aa_sfs_entry aa_sfs_entry_features[] = {
-	AA_SFS_DIR("policy",			aa_sfs_entry_policy),
-	AA_SFS_DIR("domain",			aa_sfs_entry_domain),
-	AA_SFS_DIR("file",			aa_sfs_entry_file),
-	AA_SFS_DIR("network_v8",		aa_sfs_entry_network),
-	AA_SFS_DIR("network_v9",		aa_sfs_entry_networkv9),
-	AA_SFS_DIR("mount",			aa_sfs_entry_mount),
-	AA_SFS_DIR("namespaces",		aa_sfs_entry_ns),
-	AA_SFS_FILE_U64("capability",		VFS_CAP_FLAGS_MASK),
-	AA_SFS_DIR("rlimit",			aa_sfs_entry_rlimit),
-	AA_SFS_DIR("caps",			aa_sfs_entry_caps),
-	AA_SFS_DIR("ptrace",			aa_sfs_entry_ptrace),
-	AA_SFS_DIR("signal",			aa_sfs_entry_signal),
-	AA_SFS_DIR("dbus",			aa_sfs_entry_dbus),
-	AA_SFS_DIR("query",			aa_sfs_entry_query),
-	AA_SFS_DIR("io_uring",			aa_sfs_entry_io_uring),
-	{ }
-};
+/* the tables of the features directory */
+#include "feature_masks.h"
+#include "include/features.h"
 
 static struct aa_sfs_entry aa_sfs_entry_apparmor[] = {
 	AA_SFS_FILE_FOPS(".access", 0666, &aa_sfs_access),
diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index 2f3c6c84358d..7e238043c12a 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -25,12 +25,6 @@
  */
 #include "capability_names.h"
 
-struct aa_sfs_entry aa_sfs_entry_caps[] = {
-	AA_SFS_FILE_STRING("mask", AA_SFS_CAPS_MASK),
-	AA_SFS_FILE_BOOLEAN("extended", 1),
-	{ }
-};
-
 struct audit_cache {
 	const struct cred *ad_subj_cred;
 	/* Capabilities go from 0 to CAP_LAST_CAP */
diff --git a/security/apparmor/include/capability.h b/security/apparmor/include/capability.h
index 89a9c75d8f44..e0956eab6c6e 100644
--- a/security/apparmor/include/capability.h
+++ b/security/apparmor/include/capability.h
@@ -35,8 +35,6 @@ struct aa_caps {
 	kernel_cap_t extended;
 };
 
-extern struct aa_sfs_entry aa_sfs_entry_caps[];
-
 kernel_cap_t aa_profile_capget(const struct aa_profile *profile);
 int aa_capable(const struct cred *subj_cred, struct aa_label *label,
 	       int cap, unsigned int opts);
diff --git a/security/apparmor/include/features.h b/security/apparmor/include/features.h
new file mode 100644
index 000000000000..97fb3c6acbd4
--- /dev/null
+++ b/security/apparmor/include/features.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AppArmor security module
+ *
+ * This file contains the tables behind the securityfs features directory,
+ * /sys/kernel/security/apparmor/features. It defines them, so it is for
+ * apparmorfs.c alone.
+ *
+ * Copyright (C) 1998-2008 Novell/SUSE
+ * Copyright 2009-2026 Canonical Ltd.
+ */
+
+#ifndef __AA_FEATURES_H
+#define __AA_FEATURES_H
+
+static struct aa_sfs_entry aa_sfs_entry_file[] = {
+	AA_SFS_FILE_STRING("mask",
+			   "create read write exec append mmap_exec link lock"),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_ptrace[] = {
+	AA_SFS_FILE_STRING("mask", "read trace"),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_signal[] = {
+	AA_SFS_FILE_STRING("mask", AA_SFS_SIG_MASK),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_attach[] = {
+	AA_SFS_FILE_BOOLEAN("xattr", 1),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_domain[] = {
+	AA_SFS_FILE_BOOLEAN("change_hat",	1),
+	AA_SFS_FILE_BOOLEAN("change_hatv",	1),
+	AA_SFS_FILE_BOOLEAN("unconfined_allowed_children",	1),
+	AA_SFS_FILE_BOOLEAN("change_onexec",	1),
+	AA_SFS_FILE_BOOLEAN("change_profile",	1),
+	AA_SFS_FILE_BOOLEAN("stack",		1),
+	AA_SFS_FILE_BOOLEAN("fix_binfmt_elf_mmap",	1),
+	AA_SFS_FILE_BOOLEAN("post_nnp_subset",	1),
+	AA_SFS_FILE_BOOLEAN("computed_longest_left",	1),
+	AA_SFS_DIR("attach_conditions",		aa_sfs_entry_attach),
+	AA_SFS_FILE_BOOLEAN("disconnected.path",            1),
+	AA_SFS_FILE_BOOLEAN("kill.signal",		1),
+	AA_SFS_FILE_STRING("version", "1.2"),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_unconfined[] = {
+	AA_SFS_FILE_BOOLEAN("change_profile", 1),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_versions[] = {
+	AA_SFS_FILE_BOOLEAN("v5",	1),
+	AA_SFS_FILE_BOOLEAN("v6",	1),
+	AA_SFS_FILE_BOOLEAN("v7",	1),
+	AA_SFS_FILE_BOOLEAN("v8",	1),
+	AA_SFS_FILE_BOOLEAN("v9",	1),
+	{ }
+};
+
+#define PERMS32STR "allow deny subtree cond kill complain prompt audit quiet hide xindex tag label"
+static struct aa_sfs_entry aa_sfs_entry_policy[] = {
+	AA_SFS_DIR("versions",			aa_sfs_entry_versions),
+	AA_SFS_FILE_BOOLEAN("set_load",		1),
+	AA_SFS_FILE_BOOLEAN("diff-encode",		1),
+	/* number of out of band transitions supported */
+	AA_SFS_FILE_U64("outofband",		MAX_OOB_SUPPORTED),
+	AA_SFS_FILE_U64("permstable32_version",	3),
+	AA_SFS_FILE_STRING("permstable32", PERMS32STR),
+	AA_SFS_FILE_U64("state32",	1),
+	AA_SFS_DIR("unconfined_restrictions",   aa_sfs_entry_unconfined),
+#ifdef CONFIG_SECURITY_APPARMOR_COMPRESSED_POLICY
+	AA_SFS_FILE_BOOLEAN("compressed_load",	1),
+	AA_SFS_FILE_BOOLEAN("extended_policy_header",	1),
+#endif
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_mount[] = {
+	AA_SFS_FILE_STRING("mask", "mount umount pivot_root"),
+	AA_SFS_FILE_STRING("move_mount", "detached"),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_ns[] = {
+	AA_SFS_FILE_BOOLEAN("profile",		1),
+	AA_SFS_FILE_BOOLEAN("pivot_root",	0),
+	AA_SFS_FILE_STRING("mask", "userns_create"),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_dbus[] = {
+	AA_SFS_FILE_STRING("mask", "acquire send receive"),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_query_label[] = {
+	AA_SFS_FILE_STRING("perms", "allow deny audit quiet"),
+	AA_SFS_FILE_BOOLEAN("data",		1),
+	AA_SFS_FILE_BOOLEAN("multi_transaction",	1),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_query[] = {
+	AA_SFS_DIR("label",			aa_sfs_entry_query_label),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_io_uring[] = {
+	AA_SFS_FILE_STRING("mask", "sqpoll override_creds"),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_caps[] = {
+	AA_SFS_FILE_STRING("mask", AA_SFS_CAPS_MASK),
+	AA_SFS_FILE_BOOLEAN("extended", 1),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_network[] = {
+	AA_SFS_FILE_STRING("af_mask",	AA_SFS_AF_MASK),
+	AA_SFS_FILE_BOOLEAN("tcp-fast-open",		1),
+	AA_SFS_FILE_BOOLEAN("sctp",		1),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_networkv9[] = {
+	AA_SFS_FILE_STRING("af_mask",	AA_SFS_AF_MASK),
+	AA_SFS_FILE_BOOLEAN("af_unix",	1),
+	AA_SFS_FILE_BOOLEAN("tcp-fast-open",		1),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_rlimit[] = {
+	AA_SFS_FILE_STRING("mask", AA_SFS_RLIMIT_MASK),
+	{ }
+};
+
+static struct aa_sfs_entry aa_sfs_entry_features[] = {
+	AA_SFS_DIR("policy",			aa_sfs_entry_policy),
+	AA_SFS_DIR("domain",			aa_sfs_entry_domain),
+	AA_SFS_DIR("file",			aa_sfs_entry_file),
+	AA_SFS_DIR("network_v8",		aa_sfs_entry_network),
+	AA_SFS_DIR("network_v9",		aa_sfs_entry_networkv9),
+	AA_SFS_DIR("mount",			aa_sfs_entry_mount),
+	AA_SFS_DIR("namespaces",		aa_sfs_entry_ns),
+	AA_SFS_FILE_U64("capability",		VFS_CAP_FLAGS_MASK),
+	AA_SFS_DIR("rlimit",			aa_sfs_entry_rlimit),
+	AA_SFS_DIR("caps",			aa_sfs_entry_caps),
+	AA_SFS_DIR("ptrace",			aa_sfs_entry_ptrace),
+	AA_SFS_DIR("signal",			aa_sfs_entry_signal),
+	AA_SFS_DIR("dbus",			aa_sfs_entry_dbus),
+	AA_SFS_DIR("query",			aa_sfs_entry_query),
+	AA_SFS_DIR("io_uring",			aa_sfs_entry_io_uring),
+	{ }
+};
+
+#endif /* __AA_FEATURES_H */
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index 375341929cb6..1e958721e98c 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -82,9 +82,6 @@ struct aa_secmark {
 	char *label;
 };
 
-extern struct aa_sfs_entry aa_sfs_entry_network[];
-extern struct aa_sfs_entry aa_sfs_entry_networkv9[];
-
 int aa_do_perms(struct aa_profile *profile, struct aa_policydb *policy,
 		aa_state_t state, u32 request, const struct aa_perms *p,
 		struct apparmor_audit_data *ad);
diff --git a/security/apparmor/include/resource.h b/security/apparmor/include/resource.h
index ad2c0da8e64f..ac9d8917b15e 100644
--- a/security/apparmor/include/resource.h
+++ b/security/apparmor/include/resource.h
@@ -30,8 +30,6 @@ struct aa_rlimit {
 	struct rlimit limits[RLIM_NLIMITS];
 };
 
-extern struct aa_sfs_entry aa_sfs_entry_rlimit[];
-
 int aa_map_resource(int resource);
 int aa_task_setrlimit(const struct cred *subj_cred, struct aa_label *label,
 		      struct task_struct *task,
diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index 136d14226b97..dd5186b976a6 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -20,21 +20,6 @@
 
 #include "net_names.h"
 
-
-struct aa_sfs_entry aa_sfs_entry_network[] = {
-	AA_SFS_FILE_STRING("af_mask",	AA_SFS_AF_MASK),
-	AA_SFS_FILE_BOOLEAN("tcp-fast-open",		1),
-	AA_SFS_FILE_BOOLEAN("sctp",		1),
-	{ }
-};
-
-struct aa_sfs_entry aa_sfs_entry_networkv9[] = {
-	AA_SFS_FILE_STRING("af_mask",	AA_SFS_AF_MASK),
-	AA_SFS_FILE_BOOLEAN("af_unix",	1),
-	AA_SFS_FILE_BOOLEAN("tcp-fast-open",		1),
-	{ }
-};
-
 static const char * const net_mask_names[] = {
 	"unknown",
 	"send",
diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index 64212b39ba4b..700833199b09 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -21,11 +21,6 @@
  */
 #include "rlim_names.h"
 
-struct aa_sfs_entry aa_sfs_entry_rlimit[] = {
-	AA_SFS_FILE_STRING("mask", AA_SFS_RLIMIT_MASK),
-	{ }
-};
-
 /* audit callback for resource specific fields */
 static void audit_cb(struct audit_buffer *ab, void *va)
 {
-- 
2.51.0

