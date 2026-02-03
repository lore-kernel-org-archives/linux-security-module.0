Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE657E792
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160395; cv=none; b=hZdClZtyfcqKGSEMDYs9eAI5jM/fwSJiSfOVDFTkOUDTiMKekBYcN/eSrJ+4MWnRDQGv9Zbrnw9c2uhWx3bLkBaEBOOLOBsAd01sZnTOpxE9g4mSQG381u1rcxeU/lr+1dFhv8Bb30k4Oe0MgMT0smxI9eiG7Wgug4cl1uU6OmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160395; c=relaxed/simple;
	bh=caV1ngCaOmkj52fSyu8v/equGF2ClMI3Tp8BzicRA94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiSku4s5yzD0oMGeQIzBhP1hAWzXWa0uj/ieNonV/Hs20qgkOMY52bxNr9ZOXHf3iGwhWh3XSkdwDmTFpYfuOpbMf5ZrHGVYqcGeF1mXi2Fwc5sfLFaz1EjW06veOc4MaGzkBsuZoX5cza40CuGwwrcWj3Lc7oXIzusJt5QfutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=i3+jcxYU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pG3EcAXB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="i3+jcxYU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pG3EcAXB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3968414000C9;
	Tue,  3 Feb 2026 18:13:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 18:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770160392;
	 x=1770246792; bh=AtF4+tpFZo3h/ZwS3eNUbfWZ3iWvkggC+OgBsVZnPlM=; b=
	i3+jcxYUHNH+ExQaZJqSFoeI9wYyD+kWQl9m8fHr0UAyQ8wACnrD6W9QXTAXWEoz
	a9KL5PH/O3wdLpJxxZSqSqus71k3G3TZhzax6tpuSQMVcaaQjTa+WBzRiJLhdeAz
	uPWcmkyyAV96wp/VM4ngHauRv19bi3UBsRP5BuzE3yTF2ktUNoTpbZ+6VlGkQbv6
	F3DEJLJpOM7qpK+fz5oCIyZpwPezep1xL0nHzRm2SuitlohVJfWzcyiKa7Sp0e23
	3gFVGw1vky1M9jFZWeGHJZaLLo0D4Izmu5fTksGtxwDu+8VE4Rat5TWUW/KiuxJP
	GyDPbT0n+BHCl/+gF8UdQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770160392; x=
	1770246792; bh=AtF4+tpFZo3h/ZwS3eNUbfWZ3iWvkggC+OgBsVZnPlM=; b=p
	G3EcAXB3+hrJuIlzEQdR3BmhZKkXyudsVIklxn4BrXySYzxHGXfNcpm5G8r0V2bq
	3sT03tSW2Z0ugdp9nrjtesyAQAfs3Cci3S5mCJEHi8L0WNniP/Vdc52TfMQk/SAS
	kkQ0VZ4YJEsATXQ8wc9bH9GO67FJDnuXflg3zCSJ/9rij/1/DHvyW0pQl0Z34ufR
	a60LvCROVSRfYvE9f7hIjBeQXn/b/ZZ1zSsC+3mnB/9dv3vSqswpqsn0nHBF1gd5
	OEaJEHCtuBqtE/LMpCYbbjSixCOhl7hiJ7n17FUqEX1UXc4oXbywawWLyEs3NdbO
	3ZQuHghd6lGnJ82S20M3w==
X-ME-Sender: <xms:B4GCaf4gJbxrJnX5eoqGWEZqwzPWY5BVZZV6vTeTk4qCUZmgBun6Zg>
    <xme:B4GCaXcgT1iMeQ0qdhXIPHyCUsYvqzJ6WpbX9_ZlDCX7pQuBfKfNnqKwi6_nUBBA8
    W5XtsAoBvMAPbz0DIilj_1bj9mvDpIy5raLRBwDFfprKvL3UeO5isM>
X-ME-Received: <xmr:B4GCaaGRrVcP-R8DcQV0km-ExaMlLmtKfESfvbF1Fwe1eyZ8C6Xs-ITMYXdlwxRae-R1SD8igI1Rl6LQ-D_YIfEXr_lC1ZFW4-Z0t-3IObsrzLxmoOCcLMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnefuuh
    gsshhtuchvrghrshculdehtddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeer
    tdertdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdroh
    hrgheqnecuggftrfgrthhtvghrnhepjeffkeejudfgteffueeihfevtddvfeehgeehffff
    hfekveejgfekieffhfehffdunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofiht
    mhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdr
    ohhrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epuggvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehhihesrghl
    hihsshgrrdhishdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehu
    thhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CIGCaQRdtjHS1c9-jBctMYG8gojmgFACOY-oQhimyJc6QWfWHU2aSQ>
    <xmx:CIGCaYZiZ7ukv6CvaaToXD2M5ntzmexGEQ6YUQSLbty-lKJfZXRtsw>
    <xmx:CIGCaT0Ns8YKswj2gJsrj1uVyzt509W66_7NEMMWMOFBvgLDq3K2pw>
    <xmx:CIGCaTptZFtC0ByJJoAmdnnn3upkMPr2Z7zKV3MFlhs94Buo25nBDQ>
    <xmx:CIGCad2cl0BounomrNSyg8vTRPTkvPCT-mg8Hd_x2Hk6v5AHD3DuP66d>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 18:13:10 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 1/6] landlock: Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET scope bit to uAPI
Date: Tue,  3 Feb 2026 23:12:28 +0000
Message-ID: <3a973a825c8d545bce6dc19018c245e7db034397.1770160146.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770160146.git.m@maowtm.org>
References: <cover.1770160146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the new scope bit to the uAPI header, add documentation, and bump
ABI version to 8.

This documentation edit specifically calls out the security implications
of not restricting UNIX sockets.

Fix some minor cosmetic issue in landlock.h around the changed lines as
well.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v3:
- Doc edit from review, update date

Changes in v2:
- Fix grammar

Note that in the code block in "Defining and enforcing a security policy"
the switch case currently jumps from 5 to 7.  This should be fixed by
https://lore.kernel.org/all/20251216210248.4150777-1-samasth.norway.ananda@oracle.com/

 Documentation/userspace-api/landlock.rst      | 37 ++++++++++++++++---
 include/uapi/linux/landlock.h                 |  8 +++-
 security/landlock/limits.h                    |  2 +-
 security/landlock/syscalls.c                  |  2 +-
 tools/testing/selftests/landlock/base_test.c  |  2 +-
 .../testing/selftests/landlock/scoped_test.c  |  2 +-
 6 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e..b0d07051633b 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: March 2025
+:Date: December 2025
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -83,7 +83,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
-            LANDLOCK_SCOPE_SIGNAL,
+            LANDLOCK_SCOPE_SIGNAL |
+            LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
     };
 
 Because we may not know which kernel version an application will be executed
@@ -127,6 +128,10 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 7:
+        /* Removes LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET for ABI < 8 */
+        ruleset_attr.scoped &= ~LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -328,10 +333,13 @@ The operations which can be scoped are:
     This limits the sending of signals to target processes which run within the
     same or a nested Landlock domain.
 
-``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
-    This limits the set of abstract :manpage:`unix(7)` sockets to which we can
-    :manpage:`connect(2)` to socket addresses which were created by a process in
-    the same or a nested Landlock domain.
+``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET`` and ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET``
+    This limits the set of :manpage:`unix(7)` sockets to which we can
+    :manpage:`connect(2)` to socket addresses which were created by a
+    process in the same or a nested Landlock domain.
+    ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET`` applies to abstract sockets,
+    and ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` applies to pathname
+    sockets.
 
     A :manpage:`sendto(2)` on a non-connected datagram socket is treated as if
     it were doing an implicit :manpage:`connect(2)` and will be blocked if the
@@ -604,6 +612,23 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
 sys_landlock_restrict_self().  See Documentation/admin-guide/LSM/landlock.rst
 for more details on audit.
 
+Pathname UNIX socket (ABI < 8)
+------------------------------
+
+Starting with the Landlock ABI version 8, it is possible to restrict
+connections to a pathname (non-abstract) :manpage:`unix(7)` socket by
+setting ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` to the ``scoped`` ruleset
+attribute.  This works the same way as the abstract socket scoping.
+
+This allows sandboxing applications using only Landlock to protect against
+bypasses relying on connecting to Unix sockets of other services running
+under the same user.  These services typically assume that any process
+capable of connecting to a local Unix socket, or connecting with the
+expected user credentials, is trusted.  Without this protection, sandbox
+escapes may be possible, especially when running in a standard desktop
+environment, such as by using systemd-run, or sockets exposed by other
+common applications.
+
 .. _kernel_support:
 
 Kernel support
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 75fd7f5e6cc3..7fa0e6c1a931 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -361,10 +361,14 @@ struct landlock_net_port_attr {
  *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
  * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
  *   to another process outside the domain.
+ * - %LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET: Restrict a sandboxed process from
+ *   connecting to a pathname UNIX socket created by a process outside the
+ *   related Landlock domain.
  */
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
-#define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
-/* clang-format on*/
+#define LANDLOCK_SCOPE_SIGNAL				(1ULL << 1)
+#define LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET		(1ULL << 2)
+/* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 65b5ff051674..d653e14dba10 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -27,7 +27,7 @@
 #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
 
-#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SIGNAL
+#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0116e9f93ffe..66fd196be85a 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -161,7 +161,7 @@ static const struct file_operations ruleset_fops = {
  * Documentation/userspace-api/landlock.rst should be updated to reflect the
  * UAPI change.
  */
-const int landlock_abi_version = 7;
+const int landlock_abi_version = 8;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 7b69002239d7..f4b1a275d8d9 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
index b90f76ed0d9c..7f83512a328d 100644
--- a/tools/testing/selftests/landlock/scoped_test.c
+++ b/tools/testing/selftests/landlock/scoped_test.c
@@ -12,7 +12,7 @@
 
 #include "common.h"
 
-#define ACCESS_LAST LANDLOCK_SCOPE_SIGNAL
+#define ACCESS_LAST LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
 
 TEST(ruleset_with_unknown_scope)
 {
-- 
2.52.0
