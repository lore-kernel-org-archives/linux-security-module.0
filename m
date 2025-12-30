Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D123EA9D
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115264; cv=none; b=VDNSKJl1vx1Ga6wQ4kGkDgbl5LvDRWh33oYxnxSj68AxyOBryIxLjNSLvMZvU19Hsg+8YtjCE7T/CZZYwrOUUMDu1KLDd8UQV1mCgVku0XDToVYVgzbFcbTvMl2bWdRduBNr1Iu3hbgAA63hiAM/CEijQ0efcg0PrrPr5thbvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115264; c=relaxed/simple;
	bh=ddsYqyliPNt9n2CU++k12TiIParZ71ZDPVkHsjDR5iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSySb51ukC1Ge6gnt9yFmbImA2ZIo/NuX9ysVFceCz0dgH9+0e3FSC8DlqI+unwBSysWn/m4Zd1z+rxdVwBNC5dlvfJYvIzH/mnqUu9jusYzsZ9VyKJMxvuGJuSymKRmCQaxKMFPRCtqkLwYeK+atjG+Bpw02uFGkrSK+pbNT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=PE6tsxla; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rh2VMSKT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="PE6tsxla";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rh2VMSKT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E61CE7A007B;
	Tue, 30 Dec 2025 12:21:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Dec 2025 12:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1767115260; x=
	1767201660; bh=HPLSG/Igxwf2whB9b0hzj+HyHuoyM2ljqRS4nKXfxZk=; b=P
	E6tsxlaC/Q6AnPyy+Tsamz/ZPHVUPgDxDEKCM6XxveLaEYKIaisrTOdJO3VRAyns
	HNFDBExughImaXjoqzwOtllluRPRvf3Hy94WBUpt9MCTTNVzNgC+ILhqkqoHHBq3
	VxDThThd13N4ElLb0dqJa0FZPnkuvEfQpzKwFN5N3LEQK1+yfmZ6pWs+Wx7iGhJv
	IPG7IRJF7p7YCISRN/IMKVBl3HYDdTqi1pzR4nhf0mTL2XFxTvZNuqW+BCLBNnfZ
	rGv3yZa583okVekGDUGKP6gtRReMMSgpOZ5O84dlXfqc1p4BVB3hkrSIBr1bmrSh
	jU4gLEiI0gwM1qRNC6UVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767115260; x=1767201660; bh=H
	PLSG/Igxwf2whB9b0hzj+HyHuoyM2ljqRS4nKXfxZk=; b=Rh2VMSKTLiMc+Saze
	b9sFNjsIf2Q8fp/PfPkbM4XNwxtOk+J9mIN64iiXyesyQ4fGDGC/BzJZFdEVrGGb
	koNgf7J+eps6s8lm8e6Qswsy2lnzGLBwTIHMRSBaGk/SP5V1paFQEiqda7mb+AMl
	pDbxZjs3+fFCVdJNBO2HISQjfGMebmBOSZLniYL6wEOYfhYW7RS0CmnUIcMPP+wb
	vvEzanyuEK9EPS1sMN74rA156CrHn1K+GxNy5zVNiSEpiGpYek7jcOxS7DUzu9ce
	D1oyvES1BYjj0Ks5uwCOAB6C6sFevQaUBTUNGgh/cy/Yb0O1GMmX63s2zB6vc0ne
	CTsRQ==
X-ME-Sender: <xms:_AlUaYtD43uC4FG4BL71xtAqwp4wrPHpV5AZuxcrYXTkIXOkrh2FLw>
    <xme:_AlUaYCESu9KjBraokygakJSI2ttLY9P7BwppftFq__4igWmzCjUfjC_WeEy4MYjY
    H6Rrt354cJHbWWHhaaVR4rjEQrX1F0Z35RVy-zc7lzoVbkndkkrW2Y>
X-ME-Received: <xmr:_AlUaXY_44ItHCDI7zqtT0GMxjW0e2IDxTDBUqnn8P_HjnGGJW3O42ugVOrl1Roy6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenufhusg
    hsthcuvhgrrhhsucdlhedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhephfekheeugedvtdehkefgtdelfffhveeuvdfgvdfhteeh
    hedtjefhveejleffffdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdr
    ohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhr
    ghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepug
    gvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehhihesrghlhihs
    shgrrdhishdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehuthhi
    lhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsh
    gvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_AlUabW-GsiCMtirUyVrf1Ki6s5UyIen5dwCydcu2pnY904OJh_TmQ>
    <xmx:_AlUaeMAFoGb54aWGcKkkdstp4TA3p2-sb15cPyksRORK_RxaBP26g>
    <xmx:_AlUadYIEHi7-YxA_taqA6Tuc8rZae3sJnuZbVPX2xgwSdk-XSuWCg>
    <xmx:_AlUaV8DEwmsWEy66HjadGXkmMmxeYPTUtD1uWmDYR-ypVThgAJpuA>
    <xmx:_AlUaQ7Em_0G3QBLAml5_8YExH98eWWhooWA5hhnWDTXaQPBXzm2emKM>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 12:20:59 -0500 (EST)
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
Subject: [PATCH v2 1/6] landlock: Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET scope bit to uAPI
Date: Tue, 30 Dec 2025 17:20:19 +0000
Message-ID: <88f914eb2024fa1fffe219e34c33a835b31730b8.1767115163.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767115163.git.m@maowtm.org>
References: <cover.1767115163.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the new scope bit to the uAPI header, add documentation, and bump ABI
version to 8.

This documentation edit specifically calls out the security implications of
not restricting sockets.

Fix some minor cosmetic issue in landlock.h around the changed lines as
well.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

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
 6 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e..5620a2be1091 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
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
@@ -328,10 +333,15 @@ The operations which can be scoped are:
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
+    sockets.  Even though pathname sockets are represented in the
+    filesystem, Landlock filesystem rules do not currently control access
+    to them.
 
     A :manpage:`sendto(2)` on a non-connected datagram socket is treated as if
     it were doing an implicit :manpage:`connect(2)` and will be blocked if the
@@ -604,6 +614,23 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
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
index f030adc462ee..590c6d4171a0 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -364,10 +364,14 @@ struct landlock_net_port_attr {
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
