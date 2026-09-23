Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546E38A725;
	Wed, 23 Sep 2026 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142447; cv=none; b=UWlB2rfHUxTiO1/c632kKqHPDRuUvbCvd4XDkSSPNoPYGEuOPhyzoT7ss8inGaqeOy0Ysdam3y2nMTtRQRBRNZwz/cuQF+2b6aN/N3Vjv2hjWGDZNbYoU/1j8RjhD/r/aSkuleTadYRnJJ92xbjcpBNptM0bKFcGz32oIJaH8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142447; c=relaxed/simple;
	bh=Jh4McRuX8VGkuoqjbR/Q7ARz9onvjFUEMsOtQRDshdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdMogqvrX3t761W/a4Ieb+TO3GZMI67mTs5HI85HdDASnhJvj6kw3mdrfN6+6Lxq+7NwKXRS4mswUDhQVe1F3Ldu7LEaUFvKQdr6tsq5Tf7+mcxhuBfPMnSXnaUKFicxqPyfK7QCT/kAbgAnhUHkI8v5uDduliPR6Dsz/qYlOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DS3ZbV/I; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DS3ZbV/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=LO
	G6wlR4WrEhwbx34Joq7X3VgPhzJyeuVOuxLeR/59M=; b=DS3ZbV/IAKVUTPuN4D
	zSsQ4rBHtUz1KsL9260COp7+0ZXp9bFu6iOhen4KMaxlbfONdcO3DnQyA4gMr6aB
	OgxtpK1qJeTVpXbCXSJug4KMv+nHVOqGQ/QGm26j4L4mBRYPWBkw3pwOndjEqxpy
	H7sYTWhsZbJAtfEmnl8B5TH3I=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3n62xZ7NqskLCAw--.9596S2;
	Wed, 23 Sep 2026 13:46:26 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: ryan.lee@canonical.com,
	cengiz.can@canonical.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH security v1] apparmor: fix a use-after-free in aa_lookupn_ns()
Date: Wed, 23 Sep 2026 13:46:23 +0800
Message-ID: <20260923054623.247634-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC3n62xZ7NqskLCAw--.9596S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1DKw4xuF47KF45GF1DAwb_yoW5tr48pF
	4fK345CrWkGFy7Zr47W3W3Wr1Y9ayrWr13t393WF4YvFW3Wr48Cr1UtF129ry5CF97AFy0
	qa12gw4rZFyDXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRW5lnUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3xKNcWqzZ7KqAwAA3U

aa_lookupn_ns() takes a reference on the namespace it finds with
aa_get_ns(),which is kref_get() on the reference count that the
namespace is released through, without checking whether the namespace
is still in use.  A concurrent removal of a ":"-prefixed namespace
looks the same namespace up and only then takes the parent lock to
remove it, so the last reference can be dropped between the lookup and
the aa_get_ns() call: the reference count then reports the increment on
a zero count and the kernel classifies the following use of the object
as a use-after-free.  A user with CAP_MAC_ADMIN can trigger this by
writing a ":<name>" removal and a ":<name>/<profile>" removal to
/sys/kernel/security/apparmor/.remove concurrently.

refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xc0/0xe0, CPU#6
Call Trace:
 <TASK>
 aa_lookupn_ns+0xa9/0xc0
 aa_remove_profiles+0x4fb/0x730
 ? __kvmalloc_node_noprof+0x219/0x5c0
 ? __pfx_aa_remove_profiles+0x10/0x10
 ? aa_loaddata_alloc+0x65/0x1f0
 ? _copy_from_user+0x2d/0x80
 ? aa_loaddata_alloc+0x111/0x1f0
 profile_remove+0x2ee/0x4a0
 vfs_write+0x21e/0xcf0
 ? rcu_core+0x29c/0x1740
 ? timerqueue_linked_add+0x1f4/0x3d0
 ? __pfx_vfs_write+0x10/0x10
 ? mutex_lock+0x81/0xe0
 ? __pfx_mutex_lock+0x10/0x10
 ? __pfx_rcu_core+0x10/0x10
 ? __pfx_hrtimer_update_next_event+0x10/0x10
 ? mutex_unlock+0x7b/0xd0
 ? fdget_pos+0x24d/0x4b0
 ksys_write+0xf7/0x1c0
 ? __pfx_ksys_write+0x10/0x10
 ? restore_fpregs_from_fpstate+0x37/0xc0
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Fix by rejecting a namespace whose reference count.

Fixes: 3664268f19ea0 ("apparmor: add namespace lookup fns()")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 security/apparmor/include/policy_ns.h | 16 ++++++++++++++++
 security/apparmor/policy_ns.c         |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/include/policy_ns.h
index cc6e84151812..4f8359875476 100644
--- a/security/apparmor/include/policy_ns.h
+++ b/security/apparmor/include/policy_ns.h
@@ -117,6 +117,22 @@ static inline struct aa_ns *aa_get_ns(struct aa_ns *ns)
 	return ns;
 }
 
+/**
+ * aa_get_ns_not0 - increment references count on @ns found via lookup
+ * @ns: namespace to increment reference count of (MAYBE NULL)
+ *
+ * Returns: pointer to @ns, if @ns is NULL returns NULL,
+ *          NULL if @ns is being freed
+ * Requires: @ns must be held with valid refcount when called
+ */
+static inline struct aa_ns *aa_get_ns_not0(struct aa_ns *ns)
+{
+	if (ns && aa_get_profile_not0(ns->unconfined))
+		return ns;
+
+	return NULL;
+}
+
 /**
  * aa_put_ns - decrement refcount on @ns
  * @ns: namespace to put reference of
diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 5a907a875d8f..ae9168c1a85e 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -207,7 +207,7 @@ struct aa_ns *aa_lookupn_ns(struct aa_ns *view, const char *name, size_t n)
 	struct aa_ns *ns = NULL;
 
 	rcu_read_lock();
-	ns = aa_get_ns(__aa_lookupn_ns(view, name, n));
+	ns = aa_get_ns_not0(__aa_lookupn_ns(view, name, n));
 	rcu_read_unlock();
 
 	return ns;
-- 
2.43.0

