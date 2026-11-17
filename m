Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923483;
	b=fnitXc0J2SZZkQERoeD398YCqMYwlYGf8b9MZYQ0WxaIoZYQJbo6cgnYd/JcPK4bzqx0
	 KeuI7YDesy/5aSXE7Sk/IvinydsczQ+4P2J3a+emKG0BbHMViE6atMFvAI4xtD81D/ozO
	 QzMCikWDDibpkBpVy+QXWt4xDQ6ETa3GdSuBc8HmkKvdnAty3Tvbfu+sxvICg5lhcMpyC
	 OFSXK0ARfmr+6goJHnsve3vGttSthTsoIyCY+dFeg/DG5JTguEdQ9YqNihZxieUC/iPya
	 vexZnaeZGkqK5b+m0XOo8VeurN6zhHMUHbgFPDEIdTqJhW3xZs8xFT9ncM1N1gplmwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923483;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JvBpc0TKcgtWM/rHOCgSRJ7MZRX1s79bILlVRC78NHA=;
	b=gUcsuWMhnOfhF7ONZwXGzLV0QGeA8KWhBKq63tYiNISR6UTg4uqP45PxiRMA3jQtJymK
	 3GcLgSGMDgqwgXPFcramaka5CSsd9k+8az9dcnfQPxpvfHvUYS+E0HQsC4Q2tfkO4/isW
	 DpEoa9WoRcRt18Vz7Z5sbtXWaYnAr/jWVytLPZ2u7EvWD5cVpGpDDsL4Odavn7E7d+ofB
	 fFgBcGnWW83Wt4OqA7tSXagpajNi+AWBdCekKxNx160+j6DfG60OfIAYjaSm4fwybIpTQ
	 7BVyCRqWVN4iEKh2ONCiG/WkqK7FCsdlHTE0ucOygmBSJssBIP678gT/gOIxN9d8dPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=iE2WVj7v;
	arc=none smtp.remote-ip=185.125.188.120
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46697606A323
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46697606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=iE2WVj7v
Received: from sec-questing-amd64 (lfbn-idf3-1-218-1.w90-22.abo.wanadoo.fr [90.22.217.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2700E42CDE;
	Tue, 17 Nov 2026 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1794923476;
	bh=JvBpc0TKcgtWM/rHOCgSRJ7MZRX1s79bILlVRC78NHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=iE2WVj7v+QN3GRWTX5B6deqc4H2R2Vpa/oBrE/iw1/OgP8Ocis0E2vZ6GPQonZFze
	 eCj3YoK9+3NPWSe41FxD7rp0EK4riCoWLg9kgExbgyhiDCu2rEdgd1WwZDk+Q8/1vS
	 6WOGkY6QT1UnpzG1dIDUI6hI6i6bkwEKDaTVS2mrhIj09suxd5D3nYzligdBzQJi48
	 LKvIf5+C0CmIY8z0P4nyuBgehcL2/LuIkIG6nuIifgdYy5676enypJf9D4gFIiQSM8
	 wdhOWTP5jojq3Avh3bRb+MgBYDX1CVznIwa41OpNoiI8KvCn9uleePsN/Q4CRVQMsS
	 x5J0+lKxPjf2pwKaSrEiEDXRv2YdgG1vXPDhfxY9/tTc6AVrSZLWz/ro8/MN3LhelN
	 pSPbFGvAor9ub6YGMcl6iHRIpkOO5RHwOQVmJVWWvoFe1BHVN6M+FLrvX0lxVLN2+T
	 hVTuIrj1N/lD1HPcIMj108AAcKRqF+BUQdYF2T6tVRBJIE69s5N2zUofgg/eNDfrBk
	 +Nn3HSsPdPBi5oPSHMfCpdM3E0/jUYYAlQ4JqgbXpkN9n6fHEXW23vhHVamoGbs30M
	 CUxq01DyfhjlOsjwYYs7wf99edlN6ofcjqOiiTtYHwEEd5g1r3+hn3xMCNwFJ1Af3+
	 VW8yuLpWDxpf9vp3sZIUr1y8=
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH 2/4] apparmor: make the feature tables build without kernel headers
Date: Tue, 17 Nov 2026 14:50:08 +0100
Message-ID: <20261117135042.78238-3-maxime.belair@canonical.com>
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

The feature tables are about to be built into a host program, and a
host program cannot include kernel headers, see commit 541b57e31368
("selinux: do not include <linux/*.h> headers from host programs").

Move AA_SFS_SIG_MASK next to the signal table, and give the tables
copies of MAX_OOB_SUPPORTED and VFS_CAP_FLAGS_MASK, which apparmorfs.c
checks against the originals with static_assert().

The content of the features directory does not change.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/apparmor/apparmorfs.c       |  4 ++++
 security/apparmor/include/features.h | 11 +++++++++--
 security/apparmor/include/task.h     |  4 ----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 9fbe72c4bee7..4ca449b108df 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2582,6 +2582,10 @@ static const struct file_operations aa_sfs_profiles_fops = {
 #include "feature_masks.h"
 #include "include/features.h"
 
+/* features.h cannot include the headers that define these */
+static_assert(AA_SFS_MAX_OOB_SUPPORTED == MAX_OOB_SUPPORTED);
+static_assert(AA_SFS_VFS_CAP_FLAGS_MASK == VFS_CAP_FLAGS_MASK);
+
 static struct aa_sfs_entry aa_sfs_entry_apparmor[] = {
 	AA_SFS_FILE_FOPS(".access", 0666, &aa_sfs_access),
 	AA_SFS_FILE_FOPS(".stacked", 0444, &seq_ns_stacked_fops),
diff --git a/security/apparmor/include/features.h b/security/apparmor/include/features.h
index 97fb3c6acbd4..dc38f54abec6 100644
--- a/security/apparmor/include/features.h
+++ b/security/apparmor/include/features.h
@@ -13,6 +13,10 @@
 #ifndef __AA_FEATURES_H
 #define __AA_FEATURES_H
 
+/* Copies of kernel header values, apparmorfs.c checks that they match */
+#define AA_SFS_MAX_OOB_SUPPORTED	1
+#define AA_SFS_VFS_CAP_FLAGS_MASK	0x00ffffff
+
 static struct aa_sfs_entry aa_sfs_entry_file[] = {
 	AA_SFS_FILE_STRING("mask",
 			   "create read write exec append mmap_exec link lock"),
@@ -24,6 +28,9 @@ static struct aa_sfs_entry aa_sfs_entry_ptrace[] = {
 	{ }
 };
 
+#define AA_SFS_SIG_MASK "hup int quit ill trap abrt bus fpe kill usr1 " \
+	"segv usr2 pipe alrm term stkflt chld cont stop stp ttin ttou urg " \
+	"xcpu xfsz vtalrm prof winch io pwr sys emt lost"
 static struct aa_sfs_entry aa_sfs_entry_signal[] = {
 	AA_SFS_FILE_STRING("mask", AA_SFS_SIG_MASK),
 	{ }
@@ -71,7 +78,7 @@ static struct aa_sfs_entry aa_sfs_entry_policy[] = {
 	AA_SFS_FILE_BOOLEAN("set_load",		1),
 	AA_SFS_FILE_BOOLEAN("diff-encode",		1),
 	/* number of out of band transitions supported */
-	AA_SFS_FILE_U64("outofband",		MAX_OOB_SUPPORTED),
+	AA_SFS_FILE_U64("outofband",		AA_SFS_MAX_OOB_SUPPORTED),
 	AA_SFS_FILE_U64("permstable32_version",	3),
 	AA_SFS_FILE_STRING("permstable32", PERMS32STR),
 	AA_SFS_FILE_U64("state32",	1),
@@ -151,7 +158,7 @@ static struct aa_sfs_entry aa_sfs_entry_features[] = {
 	AA_SFS_DIR("network_v9",		aa_sfs_entry_networkv9),
 	AA_SFS_DIR("mount",			aa_sfs_entry_mount),
 	AA_SFS_DIR("namespaces",		aa_sfs_entry_ns),
-	AA_SFS_FILE_U64("capability",		VFS_CAP_FLAGS_MASK),
+	AA_SFS_FILE_U64("capability",		AA_SFS_VFS_CAP_FLAGS_MASK),
 	AA_SFS_DIR("rlimit",			aa_sfs_entry_rlimit),
 	AA_SFS_DIR("caps",			aa_sfs_entry_caps),
 	AA_SFS_DIR("ptrace",			aa_sfs_entry_ptrace),
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index a8030ed78ff2..0d984724383b 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -99,10 +99,6 @@ static inline void aa_clear_task_ctx_trans(struct aa_task_ctx *ctx)
 			     AA_MAY_BE_READ | AA_MAY_BE_TRACED)
 #define AA_SIGNAL_PERM_MASK (MAY_READ | MAY_WRITE)
 
-#define AA_SFS_SIG_MASK "hup int quit ill trap abrt bus fpe kill usr1 " \
-	"segv usr2 pipe alrm term stkflt chld cont stop stp ttin ttou urg " \
-	"xcpu xfsz vtalrm prof winch io pwr sys emt lost"
-
 int aa_may_ptrace(const struct cred *tracer_cred, struct aa_label *tracer,
 		  const struct cred *tracee_cred, struct aa_label *tracee,
 		  u32 request);
-- 
2.51.0

