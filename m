Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286897;
	b=oMbX8gtm/uvWaRcqfUq+mducL9tdXD2NlikWJZ5omNLDDOQzlzvw6woAw3cTMZq9lpQT
	 Aq0oTmJQItV/4Cg04IU/WFvAeYBAggzH7y+vGpXml8I9f61xu8afC+vkm1BfwPYwDSzi2
	 Q97KDfPlpz87HeFDbIK/0YZmTSXG8TG958w6QcQlnkSuWrQLgDQ2yFek0PjYCw9LHmM2n
	 GwV/2E2e4idlHfU3318DZqTgOHpsgjEcNqW7JtMKvwMjMdIRZPSarz/r+0ooh1Un8xU8G
	 bY4LwYU95x1e2D3575URLh3uqrTnuw04dW8BbQB4hvG8m3woVvqCMyfZ2SR7POtjl1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286897;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=INlBdwr30Qwd/ZW9mWBPFDdNB/SB5AAR8pLh0+Ir6vE=;
	b=X34L+uef29azGxE4HkIvJ7Y0hQgLTN/DEUftewNoyuq8ul0ib6XONyxlWH3o4ZkHRqFe
	 LWMExDiw4VouA2LXGKjIRNtEbC/gPrD+psu93Yzw92pM+G7eB5PiDi5xAvNPEuxV6dxVv
	 349KlJ6aTv4Y0P5jhKKERfif3SIpf+dX2qAL56xcE4E2H4QOykDy4Zlyg9rax88hZGNPG
	 JR9hnz0MYIlfs4TWpjgqh+FNNDDpXhCdb6vT52hjTOw7/8ZwCOB7WGny+0j+52IgN79Ng
	 TeahzQnl2eE0SHrQghqxA1Q82vT92juB60eg2HkNY3WCAWZWoZu0jTInZ+a7uild7Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=waldn.net;
	spf=pass smtp.mailfrom=waldn.net;
	dkim=pass header.d=waldn.net header.i=@waldn.net header.a=rsa-sha256 header.s=key1 header.b=P3laPw+V;
	arc=none smtp.remote-ip=91.218.175.101
Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70383606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 15:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70383606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=waldn.net header.i=@waldn.net header.a=rsa-sha256 header.s=key1 header.b=P3laPw+V
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BMK2by3we2n3OThMsL73+dvYMfzKHbYYZK2Fu/Z47yA=;
 c=simple/simple; d=waldn.net;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793286893; v=1; x=1793891693;
 b=P3laPw+V6YYJMok4FBooqwG43XFt8kcJXGILecU0gO6jY0IvOi+0eTBJzQfEOxzmQ7hSxg0S
 WQqbyztQqjLuu4R4I4enla0Ojx7uwW2MOgdpFClU6DXPXTByIznbN6hXSm4xhFAXiBxRLHPifFi
 141REZacnRYgcuH1gKh5T4sQzCaSeYPOMICqPBp9k9ufMFUVir5ZzOs6D1okGm3dLZM1V7+OBFu
 lzyWYEoEBwZGW/g7PxfxVi+Ffg4t02MRx2aqqojlKxeLDrnT1oWNKWiWVVDgAc7GrVSL+1hCxYK
 ytpUCUjOiy7+UenGeGUA0TVV+NuF78j4bd9+ul/oSrkiw==
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e5b99898d28d580c;
	Thu, 29 Oct 2026 15:14:53 +0000
X-Mizu-Trace-ID: e5b99898d28d580c
X-Migadu-Flow: FLOW_OUT
From: Amelia Crate <acrate@waldn.net>
To: Kees Cook <kees@kernel.org>,
	linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amelia Crate <acrate@waldn.net>
Subject: [RFC PATCH v2] loadpin: allow untoggleable enforcement on filesystems which don't appear to be read-only
Date: Thu, 29 Oct 2026 10:13:45 -0500
Message-ID: <20261029151432.27642-1-acrate@waldn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023171508.3460300-1-acrate@waldn.net>
References: <20261023171508.3460300-1-acrate@waldn.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some filesystems, such as composefs created from layers which are entirely
read-only, can't be easily detected as a read-only file system. In addition to
filesystems which are read-only without having a backing read-only block device
I believe this is also useful for cases where immutability of the filesystem is
enforced by the hypervisor or the host, such as 9p shares or virtiofs.

It is still desirable to enforce LoadPin and disallow toggling enforcement in these cases.
This patch gives system administrators a way to disallow toggling LoadPin enforcement even
when the immutability of a filesystem is unclear.

Signed-off-by: Amelia Crate <acrate@waldn.net>
Assisted-by: Codex:gpt-6
---
Changes in v2:
- Move new kernel parameters to LoadPin.rst
  This is where the existing kernel parameters already were, if its preferred to move everything
  to kernel-parameters.txt I can do that instead.
- Make loadpin.force_enforce select loadpin.enforce
  These are the semantics suggested by Sashiko, I considered this originally but wasn't sure which design
  would be preferred.

v1: https://lore.kernel.org/linux-security-module/20261023171508.3460300-1-acrate@waldn.net/

 Documentation/admin-guide/LSM/LoadPin.rst |  8 +++++++-
 security/loadpin/loadpin.c                | 22 +++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/LoadPin.rst b/Documentation/admin-guide/LSM/LoadPin.rst
index a90fd9dac960..3f6968063559 100644
--- a/Documentation/admin-guide/LSM/LoadPin.rst
+++ b/Documentation/admin-guide/LSM/LoadPin.rst
@@ -16,10 +16,16 @@ boot ("``loadpin.enforce=0``").
 
 LoadPin starts pinning when it sees the first file loaded. If the
 block device backing the filesystem is not read-only, a sysctl is
-created to toggle pinning: ``/proc/sys/kernel/loadpin/enabled``. (Having
+created to toggle pinning: ``/proc/sys/kernel/loadpin/enforce``. (Having
 a mutable filesystem means pinning is mutable too, but having the
 sysctl allows for easy testing on systems with a mutable filesystem.)
 
+Some filesystems may appear to be mutable, but are in fact read-only.
+In this case, ``loadpin.force_enforce=1`` can be set to require enforcement
+of LoadPin on all filesystems. This is disabled by default. When LoadPin is enabled,
+``/proc/sys/kernel/loadpin/force_enforce`` reports the state of this option.
+This option selects ``loadpin.enforce=1``.
+
 It's also possible to exclude specific file types from LoadPin using kernel
 command line option "``loadpin.exclude``". By default, all files are
 included, but they can be excluded using kernel command line option such
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index f71861f98e1a..0014f78799b2 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -45,6 +45,7 @@ static void report_load(const char *origin, struct file *file, char *operation)
 }
 
 static int enforce = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE);
+static bool force_enforce __ro_after_init;
 static char *exclude_read_files[READING_MAX_ID];
 static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
 static struct super_block *pinned_root;
@@ -60,11 +61,19 @@ static bool loadpin_root_writable;
 static int proc_handler_loadpin(const struct ctl_table *table, int dir,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	if (!loadpin_root_writable && SYSCTL_USER_TO_KERN(dir))
+	if ((force_enforce || !loadpin_root_writable) && SYSCTL_USER_TO_KERN(dir))
 		return -EINVAL;
 	return proc_dointvec_minmax(table, dir, buffer, lenp, ppos);
 }
 
+static int proc_handler_force_enforce(const struct ctl_table *table, int dir,
+				      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (SYSCTL_USER_TO_KERN(dir))
+		return -EPERM;
+	return proc_dobool(table, dir, buffer, lenp, ppos);
+}
+
 static const struct ctl_table loadpin_sysctl_table[] = {
 	{
 		.procname       = "enforce",
@@ -75,6 +84,13 @@ static const struct ctl_table loadpin_sysctl_table[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
+	{
+		.procname       = "force_enforce",
+		.data           = &force_enforce,
+		.maxlen         = sizeof(force_enforce),
+		.mode           = 0444,
+		.proc_handler   = proc_handler_force_enforce,
+	},
 };
 #endif
 
@@ -253,6 +269,8 @@ static void __init parse_exclude(void)
 
 static int __init loadpin_init(void)
 {
+	if (force_enforce)
+		enforce = 1;
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
@@ -436,6 +454,8 @@ DEFINE_LSM(loadpin) = {
 };
 
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
+module_param(force_enforce, bool, 0);
+MODULE_PARM_DESC(force_enforce, "Always enforce module/firmware pinning");
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
 module_param_array_named(exclude, exclude_read_files, charp, NULL, 0);
-- 
2.54.0

