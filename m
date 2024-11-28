Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AC1BD9F9;
	Thu, 28 Nov 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806592; cv=none; b=MpwM7g95HhZge2vDJ1PFlzhGwrU9wR+LpD5UZfyfxEXJb2Uh6C2zreGpm4JTdJSEd/RG8KvSUQhrcVlIF/BbCkAzM5+iLPgjATXGRlub3xD63x1dfOPEQWFbJOVsKoQyx0xTOEIoUS0xmdn/qBllPdxeSoxvKE+XYPRu7qTPNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806592; c=relaxed/simple;
	bh=OFDNZ4CArynOCJUfVDL4KBORWd/87vPtRmOrJ0iMz80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CS7JN2eKHC4osK3eQOWNuujXVEWudJeBCaDZ52uDLLerhaWKXYx8gI9vAHza76F+njG/AN7BkM5GnP2GksRiOjc3sYA3vwYPtsKPgqf44340R3P06AVbQ0im1BjbHTFDc9IgAzWYD6ZdorbVfPJNZl7eP8Y9Z0WTTTpxNLanl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=kwBshZX7; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="kwBshZX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1732806580; x=1733411380; i=linux@jordanrome.com;
	bh=L4O6Pb3fNrhg8NReFkddqBQXhY9hvdlnI3baYJeIYP8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kwBshZX7iTI0s1VFJD7ZL5q3UWPr7HODZmIrDUpgziAq3fBfe4ncBayG6A+l6u+G
	 TbpZWU+AVn8lS18UYJDA78qQ7GJIHCvjzDls01yOPIu3ViEiMj6atHtV+5ZO8W8Gg
	 6GE1JcJau+4JAk8pl+gWIOeSibt6r9cU0y7Z2dHyGM8bQCg4UP68r/qbKwykRB0LO
	 5aWE4R50F9CR0tMtdxd++aQ6KSI9XGZqo8s0hK8HAoApiTPoHswer9RyebrPhRBF5
	 Iok7W+nfZ+VkkOwzv7f3ajAqyXes0ZEEMgLs5s2VDuoyoHk0YVGQlheCQ0BQZWwrR
	 bGXyJ97h40PVx4A+yA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.116]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MqJRf-1u3oKV1qGB-00pB3P; Thu, 28 Nov
 2024 16:09:40 +0100
From: Jordan Rome <linux@jordanrome.com>
To: linux-security-module@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [v6] security: add trace event for cap_capable
Date: Thu, 28 Nov 2024 07:09:33 -0800
Message-ID: <20241128150933.1414388-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KSvFNfChFec7Tv5gEdXtHhxyrPeGS74m4LZAqN5cM+pzajviI5A
 1i5XHaPTHgGKgBmIg6agrocKSUagmx9a9zfivIcbdjFWHxW76eIBDYPeMWCTBaAJTUlVKc5
 Z69NrKpCYHp05Q0FISYJmTmC7cQEHVGVuq3DtCDcmCej5iApqc92GbVporuL+yNYocRYVhN
 eJmxsjzrPaSeFewTq+QHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fMqZOZzU/rM=;QJcmNwNwOy9X0UDeRSUoRt8/PmU
 V3qQfGdoUKxqJNlIV3JPhPo4JJ3kXOOxLB5bBHfthLgSOFZZby+Wk2gdc4rCs/LuDGTskqq1E
 gB8k+87XYYNOjFvu8OfGrZL7whkLa5MLxsrOWZJ2WIcAWYT+OFKZiVAfpj3Qqye969YB/FNV7
 be16kX8uDt/A4soixDfm3lRDe+hZIp9z/tUiqUrKCEy8gacrE+RaQad/YO3Hynr3BQjG5I+x7
 /Tpk2x/NbYvDTG6diK5gI62LuU+/eV6IC0ppB5mjNmIUaC1g+B8OGVlIWpyCwLMhT4sj2KNoc
 JqzjbnclQGa2S8H3t+C9RD3EnS5fM1OO/bLMAyWdh+aHdGMR2Cj9j7TCI7AodbEbNH594iOrP
 XGTHJwTTa1Wu7pon4h39kqCnG1dZtjHy9rUjLsMkn3ts/bixLkMN8s8OAj7ulLZMur5buAgdP
 yM7JRV+3T3RLc96mGBj9Ld3Wz0op1wAAiRknwTqLQxnyS5/uo/NqlFEQogxoTiM7XocIrNhPb
 oGS4w3CVEzftqqnMTRNQhnoFMp29wKiGo6M1y2NNFyychiukLsONYv5NW+B1XyobF813M2W0i
 xe5xbz5CpfyO3sxNsebd/FBu17TgIwL9vSEe/51E/68OoJM+PPgfB2BnW1R9is4kPMT794Qgi
 r2mKoBF+cUWqz+bMwJtMsG27b/Mhai0y8JBbgz/SqAnRmZU5p9C+JwUBSk4deFVsSEMctFycV
 KRE50IUReLleHQngJEq+/8UHMciMAJc5N7O+2rrbnGeECSBiCySZ7WojmG2nk9LcVIMdZnl29
 7TpDxOuKPMUyUGGzTWnMwSXi+CNMa7vL4Prun6EHKsNHhZbKw6owqnRZhFktbOjSDowq3wbKm
 hms3WwbvW2JMuYMrx9j/qStvPsUeMLOi+c+s5O3cVIAird6uCHo5/6lBETC2Bq+6qtcjV2BmT
 G+NjNmuAHr29xpndDjAc/2ncBt9bQU0XcJS7p9iFeuuw9Z6zvWq072hPT5o0oh+iUz9tz1gRm
 qitPGGgfIhswlkQEtmIcyucvpWOehzzF4Cvs/CS

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
index cefad323a0b1..28096831a2b2 100644
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
+							struct user_namespace *target_ns,
+							const struct user_namespace *cred_ns,
+							int cap)
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

