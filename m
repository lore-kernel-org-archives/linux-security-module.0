Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05D768FD;
	Wed,  4 Dec 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327994; cv=none; b=VHii7p7ZxDtaE5prlgrywllBx8asPyRFJCZ4T9hdvFyqoxTC4eVhGh6S1LD7ljsnz6SgohkxYmaQnFtnR7z4788wwuSyPl93481oLZ8vdVh3ukcIA9CcIFq2G4s6ChoppMARkMqSXhTDxAtyemlOn5benJKHk5TSRRSIn88AyMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327994; c=relaxed/simple;
	bh=zIA3TxiOmbKF3e5A5//COwVad3MJeBPLDUKpu1l/bAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAznz1A9EPpbgYNqE19tXR1ZECyHDJg/TDBq7crDW/pF2aH8n8mSEyXebjmm3BYP6t28UB99sI8bMq6KlSOtm7kgeY3EFa97D8iiBP8rT4QxTf8nIIN08TpreRtTrHtcW5C+HDJj9AWCyuKoaP/GaQI+UnwLyRqufwpSx/9oVIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=m42WVFSO; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="m42WVFSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1733327966; x=1733932766; i=linux@jordanrome.com;
	bh=XCB4W2BOQL/tfAWKczjPzz6aeIxJEWr6go/9V2esXIA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m42WVFSOPdtT+ZtaDLyusIRVRFW3Z7uRQK49gJiw7GFdFo5r7Ow1/2Y91gMPqkRc
	 5KnABkeYF8tGIAxXJMyCH/HicQczbacL5FiR3/Vw2h8qfuwyle9fNPWDJiUF+AmQ0
	 vkyuNhV/jeX8l6uNIzKAdjJMamMjPxBmdvqZni38kx6XbH2AOsdBWD7c/0+TLQ2W3
	 Dd6/QhBmbg8OezCb/m3WhON25QGPlT3eYOFr5RvWbwwoFys3RCZ0vP6BCWBr84srD
	 VXfI81YeftUjdBtawlvmG+OPeUO1kU0WY+Wawie1F8aLiDEAZ1XjDYlLspNY6w6CO
	 UP0yZ8c/VzhYslb8Fg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.10]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M3ys8-1tb5QN3E2c-00vkaj; Wed, 04 Dec
 2024 16:59:25 +0100
From: Jordan Rome <linux@jordanrome.com>
To: linux-security-module@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Serge Hallyn <sergeh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [v9] security: add trace event for cap_capable
Date: Wed,  4 Dec 2024 07:59:11 -0800
Message-ID: <20241204155911.1817092-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:odD+DbWcBiLdvjgyb6kV1nV8SSLfSTVh3V9QgDd6PdI/8V1QWCf
 1ChVJE9aO5Kq+8lcqkv5nxlpTLC93cOYHZTi8CG+LROVX/1xIZrkUlbBfI9yoC9ePTEP5XL
 6vgz7wslKSTYMJY0/LfaRpADtwoBma64PFZfnACY0lpQ+Zhq/LRrnGl1GG0MVYFLVtmryHF
 6oNi9Pw9SCyXSSs2DXfFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8Io9GytoiZA=;H9/g7EShbkNVVycaoITdPwvUp0V
 GzR+Bx1Q/RN5rff6GUPDjlX9ry/JKJGaXFt0U9jHqtg1COYwQ0H69Y/UcmrnKifuPUdpKz6Uh
 RffIrk1Q43heMmEURThvVAT2S0BCUq2Cmm3eFvDbLFIA3ch9bnFmx3VojpM/V1B2kpfKn/PmM
 BUwVvHKfADSUECcJ5WaWuXN5XUZzc0IykJVQyCROO/afQ9Z9uPuCLOQXg8gWeolPGEUJKE1ZF
 Kuc9gSXzH9hru6BMUBG0N9rN+Uii3bBN7wtlg9vSy7BIVEBC2QOJKC1P35wrZ9Sp+sLr6lrA7
 me52DbrzeKr43z6mtQJBIwObqD8E4dUJC4O5KtK0kijfTcdl8RjwAXFC2MHOozQkoSPr0Pyby
 qNyIwtD4+DzSLpeTLSBjZ2tYYtTAOeDeqzHAwMHRMQx1pYHa9f+OMAhYI4tN/wjmOYVds9F/D
 uJneYmVsSNJdgRT+WpT9Lwes7fftX9hUfnjqLgFjzNb6QNxJtJsclB5d9rgff8vi9eaCHpQw1
 3ggHklJULftmlgOLFujat0yvLeCsLTt1XnzEVyErJkGqcRpKtI5Sl7BWQjVMce66g0p764a4c
 Kd/7l1ogk+sU0kSj+ma6woVKSoObFmKStjq+uFy8NJL43hB+P5OhvQrYkiR2JcmFrCbb6S8i8
 1Yrp2chVghh7rEXEufGE0aTVgEL3UhCUpsLxhr92pMnXp7SMIZRaxh4iHXPH3qelwNo90LLqE
 ggdo+4yBU5JklCxCGG14GIady+2inIrUZyPkdr9BHwC/Y+xZ71rpar9rEkZiiUDG33R3ZiRqI
 Jb55HdvuYHBvgkoSQSZm8MCyMOV9hqEXJV6OdEdZYsAKlKt2+7izyvi6GTJGEmX7e1045xe95
 eHPtpiBo5Kyw0SYpAwRQ1MmYLuLtmiYvHR3FE9kjg/AWpvbbAzB8B7JQReU7vL5yw4lbNbcEU
 GJE7Km8neU1n8rCHwUmMpYsv4CPccyrQPZ/t2nQPYHVlsN8Z0QPEWrJT9BU6nuVwqKUQit/HC
 uy8DkTSir4djeq/cUvtJqSKvt9T+4VEwIp5eRfl

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
 security/commoncap.c              | 54 ++++++++++++++++++++++-------
 3 files changed, 99 insertions(+), 13 deletions(-)
 create mode 100644 include/trace/events/capability.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..33fde7f660d0 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5147,6 +5147,7 @@ M:	Serge Hallyn <serge@hallyn.com>
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
index cefad323a0b1..7b6984b27127 100644
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
@@ -50,24 +53,24 @@ static void warn_setuid_and_fcaps_mixed(const char *fn=
ame)
 }

 /**
- * cap_capable - Determine whether a task has a particular effective capa=
bility
+ * cap_capable_helper - Determine whether a task has a particular effecti=
ve
+ * capability.
  * @cred: The credentials to use
- * @targ_ns:  The user namespace in which we need the capability
+ * @target_ns:  The user namespace of the resource being accessed
+ * @cred_ns:  The user namespace of the credentials
  * @cap: The capability to check for
- * @opts: Bitmask of options defined in include/linux/security.h
  *
  * Determine whether the nominated task has the specified capability amon=
gst
  * its effective set, returning 0 if it does, -ve if it does not.
  *
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
@@ -75,21 +78,21 @@ int cap_capable(const struct cred *cred, struct user_n=
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
@@ -102,6 +105,31 @@ int cap_capable(const struct cred *cred, struct user_=
namespace *targ_ns,
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

