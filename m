Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711620468D
	for <linux-security-module@vger.kernel.org>; Wed, 16 Apr 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818859; cv=none; b=Ui4UPVyr+IoDAIu0G1Pi9ffqVzVo3j8XA4ZWYVd2RvfW38qCUQnyRDkuXpzOWlYUgrob0e8zZVp7kHtMMwe4NPlbsvMJ5qBTsLn4IddjHEAwHK2xdJ79yl7RraAFumqmNd/Kgwn6z3ZFlSkIJhkFQ7akNesTQAVrEc2HycvBU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818859; c=relaxed/simple;
	bh=SPaowd3M9aDqKiZKIBNnytaz2NDh9ecsBk9EiQI6dBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DtL2fRzp8VDuDjtGkzvfk9dT7mnAW6Xzw7eNq0WljQ3DjYPDj+d03EgeOXoAq8XFk0cQrb8ASV+9MdWIVBtdAtCSOmEgMc3RzWkbq76/sEjb424Xj/7OaO2UjiqyJ0DVpBMFEsXQJyOf6rQvfqnJLwetKmVdkBq1BL7DKkFr/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wgwhIN+O; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wgwhIN+O"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zd54t2pwdz4qL;
	Wed, 16 Apr 2025 17:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1744818446;
	bh=1IakuJWFboristJ2VRu+w4JaTAaJExvweOFRahrjCIc=;
	h=From:To:Cc:Subject:Date:From;
	b=wgwhIN+OO4VHCeiAphfE5zWHH3mQGy0liyRaOcvVTU1QWZcLIWgMn5sLJngUWsSXD
	 9dLWMaWK91RNnrn8bl9T6yT2l/tGSrTKlhcmPZqVM3gY/6C9DwUeeuxMQpNdfIe0ii
	 xv1THFE1J3O+YBZ7xgIPbNdSVRg969raQTeO2B14=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zd54s6DH1zQXK;
	Wed, 16 Apr 2025 17:47:25 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v1 1/3] landlock: Fix documentation for landlock_create_ruleset(2)
Date: Wed, 16 Apr 2025 17:47:11 +0200
Message-ID: <20250416154716.1799902-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Move and fix the flags documentation, and improve formatting.

It makes more sense and it eases maintenance to document syscall flags
in landlock.h, where they are defined.  This is already the case for
landlock_restrict_self(2)'s flags.

The flags are now rendered like the syscall's parameters and
description.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/uapi/linux/landlock.h | 14 +++++++++-----
 security/landlock/syscalls.c  | 15 +++++++--------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index d9d0cb827117..9a4b64be9869 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -53,12 +53,16 @@ struct landlock_ruleset_attr {
 	__u64 scoped;
 };
 
-/*
- * sys_landlock_create_ruleset() flags:
+/**
+ * DOC: landlock_create_ruleset_flags
+ *
+ * **Flags**
+ *
+ * %LANDLOCK_CREATE_RULESET_VERSION
+ *     Get the highest supported Landlock ABI version (starting at 1).
  *
- * - %LANDLOCK_CREATE_RULESET_VERSION: Get the highest supported Landlock ABI
- *   version.
- * - %LANDLOCK_CREATE_RULESET_ERRATA: Get a bitmask of fixed issues.
+ * %LANDLOCK_CREATE_RULESET_ERRATA
+ *     Get a bitmask of fixed issues for the current Landlock ABI version.
  */
 /* clang-format off */
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 54a9f29e6ebb..9515dc92b99f 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -169,20 +169,16 @@ const int landlock_abi_version = 7;
  *        the new ruleset.
  * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
  *        backward and forward compatibility).
- * @flags: Supported value:
+ * @flags: Supported values:
+ *
  *         - %LANDLOCK_CREATE_RULESET_VERSION
  *         - %LANDLOCK_CREATE_RULESET_ERRATA
  *
  * This system call enables to create a new Landlock ruleset, and returns the
  * related file descriptor on success.
  *
- * If @flags is %LANDLOCK_CREATE_RULESET_VERSION and @attr is NULL and @size is
- * 0, then the returned value is the highest supported Landlock ABI version
- * (starting at 1).
- *
- * If @flags is %LANDLOCK_CREATE_RULESET_ERRATA and @attr is NULL and @size is
- * 0, then the returned value is a bitmask of fixed issues for the current
- * Landlock ABI version.
+ * If %LANDLOCK_CREATE_RULESET_VERSION or %LANDLOCK_CREATE_RULESET_ERRATA is
+ * set, then @attr must be NULL and @size must be 0.
  *
  * Possible returned errors are:
  *
@@ -191,6 +187,9 @@ const int landlock_abi_version = 7;
  * - %E2BIG: @attr or @size inconsistencies;
  * - %EFAULT: @attr or @size inconsistencies;
  * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
+ *
+ * .. kernel-doc:: include/uapi/linux/landlock.h
+ *     :identifiers: landlock_create_ruleset_flags
  */
 SYSCALL_DEFINE3(landlock_create_ruleset,
 		const struct landlock_ruleset_attr __user *const, attr,
-- 
2.49.0

