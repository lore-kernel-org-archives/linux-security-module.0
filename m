Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887C2FE560
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766925967; cv=none; b=pjdKdbFk9zftRQgjC8s0zRWk+nOTrGNvjp6NhmCz2K1+UyGRJ0IR4h1HFxfdjSVpsTbBJyGqMeNoa/jlxXjrxk8Y8WtHD+g341rxfTKxKMVu9WvDI1RLi8BVyC5E4B0sqm26f5uHi2IZHf/McaTXEgc4OPBqBRQ4sUxNnFMMD9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766925967; c=relaxed/simple;
	bh=jP4Q0VyFLXmOJvVYkXEdq+QTSO7mwIqrzG28msqnhCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARFM6H1RAv3LDPnRkZAklkDeGDuhNvp2Dq5C8Vj8a3TJDqH+TXtS4urnYKb8UG2NGH84MuTMNTokrvft25Nf106cngcwNZm0YL836sA9HZyG9ox2+365b+1qD134UdASZIw1VFLLIv5Hj5bS4nTjSBmBcfKsVvZlxn/sYOZ4ONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=c0J+IC4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbBQnJwl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="c0J+IC4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbBQnJwl"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98A577A0376;
	Sun, 28 Dec 2025 07:46:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 28 Dec 2025 07:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766925963; x=
	1767012363; bh=DuHCGKZSTa2um1EJv9hldbbGzcQhYGHsiAd6wBEzk+M=; b=c
	0J+IC4UMVSwxh21BAy1tdcLX3VGdbdMvR7vVfpcb7nZbuNd0Rpt3WhgO8xNECpJ9
	mIdDuZBX17GeSlpQlkylolNNWU576pAm8EvT40u5ifOuJW9tkv/44McN/Gz06QuP
	R9xZ8QHDpt8rG0O3BFYMNuvNJgMvZN0LJBRTkFksyHw7alDRhru12g6/lioexO38
	WW5uTdSGVI4s+okny5YgdBInABIstxzdyb4+6Mp6U2BSl5rsY9ncpoFIXzMZcvkJ
	KRLBE97pGXKbrBsWJXNn9NprQORZy0qkD7COn60aKngrFtkUNC8Tm4HlFUl9exp5
	YSOReuXYZOwkQp6gTikcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1766925963; x=1767012363; bh=D
	uHCGKZSTa2um1EJv9hldbbGzcQhYGHsiAd6wBEzk+M=; b=UbBQnJwl/pbxTENon
	4rRrt6QLxdAl27owYdUp+EKIY9q4cot5rO8lzMkg5L22ux5sBZktaybWMkmVin+0
	NXIaHt14QdKBWfUxyq39AdMtw//8sGWATorbFBFFEC5qMFXrY3izip+3on/oHk3h
	G7jY+YTzSc4XfoV9M1+J5mZQ+RYa6zz6jgXzDHO2wB1roMJpYL3b/kH04hVG97K7
	ZMzjRHq6hbQZ+T2mkyGqGPvZ7rrEQBWfSJqcpcyNSGyoNjg/36RMD/7gAoZy/xaF
	JUR+7fs7T2Bg7alfGPjH/ihiGfqaG6+hVDGRTbiqLGIRqgb8qvqblhaBVlNWCu0f
	9QcdQ==
X-ME-Sender: <xms:iyZRaVCp8ExNnXqudTMU1q1CalNGRNVndiEZ_h4mco_fpvCNMmnUbg>
    <xme:iyZRaSnyvv5CBXHhIvRG8-859bj1SD2dtv4lmDY3OIqBEp3o26OF86e5rr2ZerC_q
    jsRSVPFuY7rZLxfyK8B0MLigGeuNjoS9t7dBDiWcpqOkt6FQ08Ufw>
X-ME-Received: <xmr:iyZRaWyvNmS51rHsDiGtsFtyvtpCcvrWum-LkScixWiPh96KjzjR9I7IPqK8JXWLcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenufhusg
    hsthcuvhgrrhhsucdlhedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepuedutdehhfehhfdvjeetvedvvdetfeffgeetteeugeeu
    leejfeeukeejteeiueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtg
    hpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohho
    ghhlvgdrtghomhdprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohephhhisegrlhihshhsrgdrihhspdhrtghpthhtohepjhgrnhhnhhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvges
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iyZRacTWXKF0zlknjCSlfI4SqeK5sEkATpGGMXEMDmZuTVU20wgl0w>
    <xmx:iyZRae8Xajozs9S6vwMWxaGOq6UUB4eMAbJix4lDDp9ERWyUqMtaRQ>
    <xmx:iyZRaavouGMc2Fqhm8EeGFVossMjAOdTlfy_rWs2OFNfX-hGXbUwSw>
    <xmx:iyZRaWMDLOE5KGRV7g_beUCj8Qf_enkT2uWTJflZ4rxavKPo7YfoIw>
    <xmx:iyZRaadtY4uwiaj8CRRbr72r2kOIewOSV5XXKhJD9gYSIETMC02AbVyF>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 07:46:02 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/6] landlock: Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET scope bit to uAPI
Date: Sun, 28 Dec 2025 12:45:40 +0000
Message-ID: <46a726ce3770b7de44534566c34dcd4d09971271.1766925301.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766925301.git.m@maowtm.org>
References: <cover.1766925301.git.m@maowtm.org>
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
 Documentation/userspace-api/landlock.rst      | 37 ++++++++++++++++---
 include/uapi/linux/landlock.h                 |  8 +++-
 security/landlock/limits.h                    |  2 +-
 security/landlock/syscalls.c                  |  2 +-
 tools/testing/selftests/landlock/base_test.c  |  2 +-
 .../testing/selftests/landlock/scoped_test.c  |  2 +-
 6 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 903d2ad11852..8f4cad332b63 100644
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
@@ -133,6 +134,10 @@ version, and only use the available subset of access rights:
         supported_restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
                                       LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
                                       LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
+        __attribute__((fallthrough));
+    case 7:
+        /* Removes LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET for ABI < 8 */
+        ruleset_attr.scoped &= ~LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -334,10 +339,15 @@ The operations which can be scoped are:
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
@@ -610,6 +620,23 @@ Landlock audit events with the ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``,
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
+under the same user.  These services typically assumes that any process
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

