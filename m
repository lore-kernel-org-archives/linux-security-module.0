Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CE15250F;
	Thu, 28 Nov 2024 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732834179; cv=none; b=eNMBOXnP0266iV+UkbqIFPvvwvzX3POFJecjClezoqpcVKpGG6gEwpnS3skFZHAOnCgyziVt+qdTNcB4GADBnm++JMRG/Hj21QLOj3aXW1gaCvfPER3/uS+O1yxFoHE4HSfrzXkUh8C73BprUlYNdrKBayby6esCNbxtSBWoU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732834179; c=relaxed/simple;
	bh=2CLq5AvTfa+uLsdmJdFRiMOmi9FGNuFypfi6aWel7DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSyW5TcZJrNXTo2YIFlSXnKt7AwANOmLD0Fwh8CNZizrtpilg6Rk8eWpgFhNC1kGfLR+1kSQ0t4B071hyOYVFUT5ukXCejfEAXXKvsv4hVD7MnbUbs/TK37UmC7agfFSe05MG+y0WrTgzs6rhx3JbWehkgle1cUD/DMKonCIZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=KCHtb+de; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="KCHtb+de"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1732834138; x=1733438938; i=linux@jordanrome.com;
	bh=zlLtIl9pEgeclkx+VQzLAlgQP/261yb+11wdt+sU1g4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KCHtb+deIvj7P/JR4ynLug2JEcVixcBXANyHYf2qyQqR3UPsq+U3H5sDpwZX7jCj
	 D0LZfdJ86muEqTW6z4nnWPTQIXPENYY4UpI+mFmDC0MP4YsPA3bfIxubkSyAWzRTc
	 oJn/eB1qt5qnZQ8YNyUyjbOHoHK6AnqbXbRgS9NQCBOc/jdA+65jnkj4Tjs3UGoS5
	 GIGHfpgvcAzdRsfDrarssuzR923xMyALKjVtHNuS9JHpIN1akKxadu1krGAZxkL0s
	 fK3rfL5z8hXCjJxX3ic22287xBhufvy1bG+5/xYmbrFw5ipaZp+8Ti2Li1K/Lq71a
	 gdwq7ZmFLDqsTtngCQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.11]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M91Zb-1tOkLP1eu5-00Ab5u; Thu, 28 Nov
 2024 23:48:58 +0100
From: Jordan Rome <linux@jordanrome.com>
To: linux-security-module@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Serge Hallyn <sergeh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [v8] security: add trace event for cap_capable
Date: Thu, 28 Nov 2024 14:48:49 -0800
Message-ID: <20241128224849.3774367-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RMwbQ4Ilj/NG4zsrO3K8nDIDa3RL8Ok6sTNpPFQuiDUbpsh+cx0
 s7+UkdF9KhW9HADc+WdZx+y25Wkzi0euHo9/5Y93RQmjhsh/jl4A/1xWQtaaODcl5VTCKUw
 askxX7JympRA9Ev64vthNE8h6WndkCDHQ4lG1zd7fdNpSQqfqn4VdygvZgWM9cTkyvCFFew
 BajdAgGYnJEwNurbL8t4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MdVQKAfc10w=;b4R7deXdLj9SOLu30u/QTf5Fy28
 uPItoWLyHzr5oshDElIMP/Td6sU8hTLdtB726SJC80a25cpZ51/lWRDdnye096nZTrmTuucIY
 xGLsH+Pwjc8g6xN3GbfFIMgMXaRBk5ALy//9H2ZiFMPI4H4zznUx+iKRVvW8+ElQhP+4eC0pc
 yl2ZcDldVF8iIDfvE8UdAVSN/TytzjRYxVRg/ouizrInt0+dwAU/+OXyRmWXSFFP8U9XmS5r0
 JTTj0A8dArdKlzEmL6vo52LLnOVmza6CQ+yOOrG90PP7RpQGQ+j2RPQOv9BqiCKN6X3hA6XWZ
 3vp4QOVI/Z8uWkIVak/HIKxufKuwSrfaSUb9diRS2VF3jFemCH4Hc3hAse7vS6/EwgZimUUrK
 MdidEfcDCxhj6On9pGsfoRHq2rSXbBDqJDH51DzmTJ7PWQFdfRt3iCAGfyZ9DgShkGDOdjdbw
 QE7YV1BOjuZELP/N5ugmxQniDSxdXGs0zDzXMYTCtFgqZfJX9xJwfycM8mpnmaRd4pmjj2A0b
 myk/ujLtOc/Z485kYWig2nxyrjhe1JglYLqcTyZhwmK5e53kstyJm1NFjKzRKExr6L74TC7il
 sit9MEDUB/RCDWx9+CYNmhh5R9lTdtSNbph92lsUJ1S6zGizzHujav6J3fG8FfkbLUZgubjXG
 SwhqDAD1MBVv10w/PWKEctVaF020CNbZpd3M9azRe1O15sHK9Lnk4lHnxV3lgnonYLIyCl3GL
 4yVffnrphhr6v19oTFmSBEIeFlvIGgbfNoxE7zbTPwWgzBs6r5TtdQVl7H10ETyxCDVlbHhQW
 D2J8ZxZlVa7fnF2Y3Koi9xvbwfcbdCw0S84Kmdm4wM0cHCAm8+IFuIA2sE8S+J3Sl1N5PByPI
 x0oxRZtLzdKn1L+sSSLHieHTyFjTixGqQ2rn9lOYrXbOVQKzDeymMxRMoQakkJMF4OrcrvgO3
 dvln/H/6oDVfz8sQrJiKmuyjozxH7xqbftfd58OOy/i13n0e20dx3pOj8IEEUs6tVttxHs2GH
 +BrwDFV3kLdNuzLPVrtjOS9ljVqcmaXQbYXhb+E

In cases where we want a stable way to observe/trace
cap_capable (e.g. protection from inlining and API updates)
add a tracepoint that passes:
- The credentials used
- The user namespace of the resource being accessed
- The user namespace in which the credential provides the
capability to access the targeted resource
- The capability to check for
- The return value of the check

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 MAINTAINERS                       |  1 +
 include/trace/events/capability.h | 57 +++++++++++++++++++++++++++++++
 security/commoncap.c              | 57 +++++++++++++++++++++----------
 3 files changed, 97 insertions(+), 18 deletions(-)
 create mode 100644 include/trace/events/capability.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f870842fad9c..b90df58f6030 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5103,6 +5103,7 @@ M:	Serge Hallyn <serge@hallyn.com>
 L:	linux-security-module@vger.kernel.org
 S:	Supported
 F:	include/linux/capability.h
+F:	include/trace/events/capability.h
 F:	include/uapi/linux/capability.h
 F:	kernel/capability.c
 F:	security/commoncap.c
diff --git a/include/trace/events/capability.h b/include/trace/events/capa=
bility.h
new file mode 100644
index 000000000000..17340257946c
=2D-- /dev/null
+++ b/include/trace/events/capability.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM capability
+
+#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CAPABILITY_H
+
+#include <linux/cred.h>
+#include <linux/tracepoint.h>
+#include <linux/user_namespace.h>
+
+/**
+ * cap_capable - called after it's determined if a task has a particular
+ * effective capability
+ *
+ * @cred: The credentials used
+ * @target_ns: The user namespace of the resource being accessed
+ * @capable_ns: The user namespace in which the credential provides the
+ *              capability to access the targeted resource.
+ *              This will be NULL if ret is not 0.
+ * @cap: The capability to check for
+ * @ret: The return value of the check: 0 if it does, -ve if it does not
+ *
+ * Allows to trace calls to cap_capable in commoncap.c
+ */
+TRACE_EVENT(cap_capable,
+
+	TP_PROTO(const struct cred *cred, struct user_namespace *target_ns,
+		const struct user_namespace *capable_ns, int cap, int ret),
+
+	TP_ARGS(cred, target_ns, capable_ns, cap, ret),
+
+	TP_STRUCT__entry(
+		__field(const struct cred *, cred)
+		__field(struct user_namespace *, target_ns)
+		__field(const struct user_namespace *, capable_ns)
+		__field(int, cap)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->cred       =3D cred;
+		__entry->target_ns    =3D target_ns;
+		__entry->capable_ns =3D ret =3D=3D 0 ? capable_ns : NULL;
+		__entry->cap        =3D cap;
+		__entry->ret        =3D ret;
+	),
+
+	TP_printk("cred %p, target_ns %p, capable_ns %p, cap %d, ret %d",
+		__entry->cred, __entry->target_ns, __entry->capable_ns, __entry->cap,
+		__entry->ret)
+);
+
+#endif /* _TRACE_CAPABILITY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/security/commoncap.c b/security/commoncap.c
index cefad323a0b1..6b40f12bda18 100644
=2D-- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -27,6 +27,9 @@
 #include <linux/mnt_idmapping.h>
 #include <uapi/linux/lsm.h>

+#define CREATE_TRACE_POINTS
+#include <trace/events/capability.h>
+
 /*
  * If a non-root user executes a setuid-root binary in
  * !secure(SECURE_NOROOT) mode, then we raise capabilities.
@@ -50,24 +53,17 @@ static void warn_setuid_and_fcaps_mixed(const char *fn=
ame)
 }

 /**
- * cap_capable - Determine whether a task has a particular effective capa=
bility
- * @cred: The credentials to use
- * @targ_ns:  The user namespace in which we need the capability
- * @cap: The capability to check for
- * @opts: Bitmask of options defined in include/linux/security.h
+ * cap_capable_helper - Determine whether a task has a particular effecti=
ve
+ * capability.
  *
- * Determine whether the nominated task has the specified capability amon=
gst
- * its effective set, returning 0 if it does, -ve if it does not.
- *
- * NOTE WELL: cap_has_capability() cannot be used like the kernel's capab=
le()
- * and has_capability() functions.  That is, it has the reverse semantics=
:
- * cap_has_capability() returns 0 when a task has a capability, but the
- * kernel's capable() and has_capability() returns 1 for this case.
+ * See cap_capable for more details.
  */
-int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
-		int cap, unsigned int opts)
+static inline int cap_capable_helper(const struct cred *cred,
+				     struct user_namespace *target_ns,
+				     const struct user_namespace *cred_ns,
+				     int cap)
 {
-	struct user_namespace *ns =3D targ_ns;
+	struct user_namespace *ns =3D target_ns;

 	/* See if cred has the capability in the target user namespace
 	 * by examining the target user namespace and all of the target
@@ -75,21 +71,21 @@ int cap_capable(const struct cred *cred, struct user_n=
amespace *targ_ns,
 	 */
 	for (;;) {
 		/* Do we have the necessary capabilities? */
-		if (ns =3D=3D cred->user_ns)
+		if (likely(ns =3D=3D cred_ns))
 			return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;

 		/*
 		 * If we're already at a lower level than we're looking for,
 		 * we're done searching.
 		 */
-		if (ns->level <=3D cred->user_ns->level)
+		if (ns->level <=3D cred_ns->level)
 			return -EPERM;

 		/*
 		 * The owner of the user namespace in the parent of the
 		 * user namespace has all caps.
 		 */
-		if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner, cred->euid))
+		if ((ns->parent =3D=3D cred_ns) && uid_eq(ns->owner, cred->euid))
 			return 0;

 		/*
@@ -102,6 +98,31 @@ int cap_capable(const struct cred *cred, struct user_n=
amespace *targ_ns,
 	/* We never get here */
 }

+/**
+ * cap_capable - Determine whether a task has a particular effective capa=
bility
+ * @cred: The credentials to use
+ * @target_ns:  The user namespace of the resource being accessed
+ * @cap: The capability to check for
+ * @opts: Bitmask of options defined in include/linux/security.h (unused)
+ *
+ * Determine whether the nominated task has the specified capability amon=
gst
+ * its effective set, returning 0 if it does, -ve if it does not.
+ *
+ * NOTE WELL: cap_has_capability() cannot be used like the kernel's capab=
le()
+ * and has_capability() functions.  That is, it has the reverse semantics=
:
+ * cap_has_capability() returns 0 when a task has a capability, but the
+ * kernel's capable() and has_capability() returns 1 for this case.
+ */
+int cap_capable(const struct cred *cred, struct user_namespace *target_ns=
,
+		int cap, unsigned int opts)
+{
+	const struct user_namespace *cred_ns =3D cred->user_ns;
+	int ret =3D cap_capable_helper(cred, target_ns, cred_ns, cap);
+
+	trace_cap_capable(cred, target_ns, cred_ns, cap, ret);
+	return ret;
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system=
 clock
  * @ts: The time to set
=2D-
2.43.5

