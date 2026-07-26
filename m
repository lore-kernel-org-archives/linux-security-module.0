Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306B3CAA51
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082473; cv=none; b=cpC4STzQl+Huo+lhknkyZdyR8eHZ2/w9P9b2ziHdh01Ru3kB4g+QosmsRt+CPcxb4N87YTBSCKrELV22aAWwF9waUCM0x9k6HM3Gdn6fVD6JlcQ+b2bYBm+h7dtaU9QpY2ZWyeBShGItsmf473vsw8VHZiFOjZQ4hV0ZuHF5GtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082473; c=relaxed/simple;
	bh=wmqCr4VjRSUDgMe6NsvFPxf4USd8ZTQxev5QLlJCEm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azMSbu8PmURXisTu4DOuEYuYrIg6FuXp77CqbN6E3lh3nwlFnq1gyIEC7RBtSX80AGq5NEQXc6iIJAzj31blQdFV68tSiavOliYeccqj0N6fQlTLSrFnCUg3zV9PlUnQiRSSOMAIF2tGMIJQfOb84PInMDOuOjinBsClNzcWvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LghPWA8e; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LghPWA8e"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h7Rcj5SRlzhbX;
	Sun, 26 Jul 2026 18:14:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785082453;
	bh=zJBc61cC+tx6X8f9E5aGlk5jz3aaYGPw1qfugBAp7v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LghPWA8e7Gxrw8KicterCbHJMEhmYtphgyzG29Ykwfc29/CCbiztYtu6rK0TPXKkh
	 AZnmlEmwVIXAdKUKimdieTXR/j9mR9pQ083DNt7mzSt+T5ThaTOwjcB//oqepUWtS1
	 IynGGZSfwXe5VoyTTEiZlu+XPqIvndyf/G/iW7+o=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h7Rch40vKz9KZ;
	Sun, 26 Jul 2026 18:14:12 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 01/12] ns: Free anonymous mount namespaces via ns_common_free()
Date: Sun, 26 Jul 2026 18:13:46 +0200
Message-ID: <20260726161400.3010511-2-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-1-mic@digikod.net>
References: <20260726161400.3010511-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Christian Brauner <brauner@kernel.org>

free_mnt_ns() skipped ns_common_free() for anonymous mount namespaces
(the "if (!is_anon_ns(ns))" guard) because they carry the reserved inum
MNT_NS_ANON_INO, which proc_free_inum() must never release.

A following change needs ns_common_free() to run for every namespace, to
release per-namespace state attached during __ns_common_init().  Move
the reserved-inum decision into __ns_common_free() and let free_mnt_ns()
call ns_common_free() unconditionally.

__ns_common_free() is shared by all namespace types, so it gates
proc_free_inum() on ns->inum > MNT_NS_INO_SPECIAL_MAX (a new alias for
MNT_NS_ANON_INO) rather than the mount-specific is_anon_ns().  The
reserved inums (MNT_NS_ANON_INO and the *_NS_INIT_INO values just above
it) belong to namespaces that are never freed, except the anonymous
mount namespace; dynamically allocated inums are >= PROC_DYNAMIC_FIRST.
So the comparison frees every dynamic inum and skips exactly the
anonymous mount namespace, matching the previous guard.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Co-developed-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
- New patch, split from "security: add LSM blob and hooks for
  namespaces" (suggested by Paul Moore).
---
 fs/namespace.c            | 3 +--
 include/uapi/linux/nsfs.h | 1 +
 kernel/nscommon.c         | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3d5cd5bf3b05..0602f133f3a0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4186,8 +4186,7 @@ static void dec_mnt_namespaces(struct ucounts *ucounts)
 
 static void free_mnt_ns(struct mnt_namespace *ns)
 {
-	if (!is_anon_ns(ns))
-		ns_common_free(ns);
+	ns_common_free(ns);
 	dec_mnt_namespaces(ns->ucounts);
 	mnt_ns_tree_remove(ns);
 }
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index a25e38d1c874..ea0f0267d90f 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -55,6 +55,7 @@ enum init_ns_ino {
 	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
 #ifdef __KERNEL__
 	MNT_NS_ANON_INO		= 0xEFFFFFF7U,
+	MNT_NS_INO_SPECIAL_MAX	= MNT_NS_ANON_INO,
 #endif
 };
 
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 3166c1fd844a..e6f623e1bc37 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -91,7 +91,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 
 void __ns_common_free(struct ns_common *ns)
 {
-	proc_free_inum(ns->inum);
+	if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
+		proc_free_inum(ns->inum);
 }
 
 struct ns_common *__must_check ns_owner(struct ns_common *ns)
-- 
2.54.0

