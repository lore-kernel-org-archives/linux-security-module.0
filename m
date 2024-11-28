Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40561BD017;
	Thu, 28 Nov 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808271; cv=none; b=aIVXTt/67YCi4o0TKsWqe+Fzyi3xj5W6hHGxMKlwS16BrIGffVokItZCnjaxX+EsZm5TDeh8E78GCqBj9+VzBGjCB/RiER+mzI1neamh0QUqESjNleWFzz1+WxgCpQBrw80IQRzquDfcu2Ln780AndX1bI29RVPl3WVpv8QfLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808271; c=relaxed/simple;
	bh=FBllIi69NT12UHooDWyXLkb67zAZxcMdq7SEz33g3EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFBLEdDLb7quhh79mzWrx9ZYYDO9XammqmwMzeIsMFcqNQf58pvRa19GmvGjYeOlOzQTimxlI4+3lRVz4RNXGOrWbe+zoilOjjcP2oh0515K1UaXl3PnRA8alBUznmdDiaGa3URpTBFecuCt/xg4v1rrKhno83UkNg30vYlx0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=GMueBuk7; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="GMueBuk7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1732808260; x=1733413060; i=linux@jordanrome.com;
	bh=kqfp/A5sdg6kMn0UfLS5keOWlilq95cyPF7zwaLZYCc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GMueBuk70BJ7eYEIH47h8YRph/ueLC77L0bPSW5mCn3uN+3AXr5SePBlD1nfIShL
	 CKhbZtOFYswsR/2BwyKqzZOGNCH49/5rtHoZwr3MpfKmD5OVcKRT8I/UxrigKFZ/o
	 iZpEE6CHZrS/7EfPWjVB7GTYE5SYfInEmGtmhT6OmcD5uHxGMxzyNhfagNR0Yy8sp
	 FmoJs5+M6ov/85mtqoM/3nfmhgIf8QMlBBAi8hle3sXyNuwnyxxMe2uXFlIJ7iOzn
	 U2zbDFllZUn4cEzNKOpWsHhKycEtOJcToonxtQvuiIfbYmKfwQj/BhAQb5ts3q7vt
	 I5HVCaEItZnnjblohw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.115]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M8Ouq-1tdBHl3XYg-00zCGl; Thu, 28 Nov
 2024 16:37:40 +0100
From: Jordan Rome <linux@jordanrome.com>
To: linux-security-module@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Serge Hallyn <sergeh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [v7] security: add trace event for cap_capable
Date: Thu, 28 Nov 2024 07:37:33 -0800
Message-ID: <20241128153733.1542817-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EGQgsmwo7BJzNqWN+47s4eU70hMaM8bBHGjUC1+FcEF7LXvulFp
 pq7dlLDapNPUDWYMq85uWC9n8RMJ4De6PRqBt/fNKwiiUBHaS9h68GpWS0pK7pwGqGYf1k9
 1DSA+J6SxT9TJ52H/3tlwNWfVcxiE8EF9MV5R25JrtDk0X+G+VSNKbhU5WU8WO3HuLnmZd3
 b8Y/2Hx7It9Xcww3HfGjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RR03HkHHJ9I=;lHcUpJMZCqqo+F6DtsW3L2A96zG
 A238PNNf9o14SO5laBWgcXhJcFgzhzV2vUmYOzMvKTPXTzQKbzfniV6QYFX0xSGx6Ve/6o2PS
 3k/DbASKoY65CjasL4rYhBqTGsEYmSptXzbsHKQTW8y5JqRW8+qjk7eSZGkZI4etvyD8iTZ/p
 is5Lp1AXHT0lwVE1d30Z+Ozaynm7/A3bOakrrg7LHxPyLU2EwghjG9X7KpONpYN9qjicuNef2
 ijs2IrMVlXBMzswPo3DYUTF9/CVbj3iyj4aAynZYVVE315F9nTj2Uq9quW4BU9J8fl/4Z7CWa
 +5YCLa623yE9bw/cd79MexXO8QQeUjEP0AUkbefG0aqf/dfIOZImOzAIUKs+jnodgIq3T4YS5
 jMO35uhHyOsJZ/spSbxFSNseEs3nkhxRSeYMetoW3H82wDG+xTyoI5nFHKQtR8AgbN0kmm8Mv
 IfcEW/mc7bIewuOVOw7tHDyJZ7J8TKHNaYNjXe1Tkdqwla/wwLT2O3JQLehsP5HSj7EJpsrQU
 6HD6wnqF5ufivSAkUxvb/S54n2V7Rl5lgATFV7YfRWLeaV4PyjFTKu1CSNOdXKe5cIwvqxVQn
 3FOI1Xb6MvdOhOcwkWiXtBvAaphGm2/kn8YG0cGHaCHoMVP+ZQELZ3sUSJNO4xlF14nOZdmV0
 Y/85aHrKjzE3r26ekFXLQTtdjscq2d7vhStESlRFNkzY+e4zWm8XUZl55mruy1/HTelcbVvYq
 ml2oduqBTwi2YOEa66svxaaAebFNvySZ6u2qjn+ktsZLknJzhtBM8NyfwisR2xsHJTRnI3Svv
 mLMf3VycpeVQiWgj7V2bcKcudyCKi4SchZXF1eJThNPnAG/URLZktFXbtvq+hWAx9U5ZGR2QL
 7hcsukmswXCDRUUoMNTqL8EvQUihgyVIifAAoFjItyFfDLb5HW3z0Uob/yJf14azZ8TuhjasI
 NSN43mtZe9Po+jCrx+hXUfRbdpge1TYs2oClEL1pkSRDL+ix7ioyIwhkSWuKcn+QeurDpc7DX
 mZ3CyQJo+oRB+AHo0d0Bk1OiVU04txJMrikaoJk

In cases where we want a stable way to observe/trace
cap_capable (e.g. protection from inlining and API updates)
add a tracepoint that passes:
- The credentials used
- The user namespace of the resource being accessed
- The user namespace in which the credential provides the
capability to access the targeted resource
- The capability to check for
- Bitmask of options defined in include/linux/security.h
- The return value of the check

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 MAINTAINERS                       |  1 +
 include/trace/events/capability.h | 60 +++++++++++++++++++++++++++++++
 security/commoncap.c              | 57 +++++++++++++++++++----------
 3 files changed, 100 insertions(+), 18 deletions(-)
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
index 000000000000..65311c2652f7
=2D-- /dev/null
+++ b/include/trace/events/capability.h
@@ -0,0 +1,60 @@
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
+ * @opts: Bitmask of options defined in include/linux/security.h
+ * @ret: The return value of the check: 0 if it does, -ve if it does not
+ *
+ * Allows to trace calls to cap_capable in commoncap.c
+ */
+TRACE_EVENT(cap_capable,
+
+	TP_PROTO(const struct cred *cred, struct user_namespace *target_ns,
+		const struct user_namespace *capable_ns, int cap, unsigned int opts, in=
t ret),
+
+	TP_ARGS(cred, target_ns, capable_ns, cap, opts, ret),
+
+	TP_STRUCT__entry(
+		__field(const struct cred *, cred)
+		__field(struct user_namespace *, target_ns)
+		__field(const struct user_namespace *, capable_ns)
+		__field(int, cap)
+		__field(unsigned int, opts)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->cred       =3D cred;
+		__entry->target_ns    =3D target_ns;
+		__entry->capable_ns =3D ret =3D=3D 0 ? capable_ns : NULL;
+		__entry->cap        =3D cap;
+		__entry->opts       =3D opts;
+		__entry->ret        =3D ret;
+	),
+
+	TP_printk("cred %p, target_ns %p, capable_ns %p, cap %d, opts %u, ret %d=
",
+		__entry->cred, __entry->target_ns, __entry->capable_ns, __entry->cap,
+		__entry->opts, __entry->ret)
+);
+
+#endif /* _TRACE_CAPABILITY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/security/commoncap.c b/security/commoncap.c
index cefad323a0b1..9fa9aba3961d 100644
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
+ * @opts: Bitmask of options defined in include/linux/security.h
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
+	trace_cap_capable(cred, target_ns, cred_ns, cap, opts, ret);
+	return ret;
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system=
 clock
  * @ts: The time to set
=2D-
2.43.5

