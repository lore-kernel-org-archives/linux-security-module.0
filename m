Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40DBE46;
	Wed, 30 Oct 2024 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252045; cv=none; b=iwUpWSpvYul51oTzqOBxlS+TpadSCKDWvYjDQnJKCpwNTahEj1tqFoUYtduVhKbPqqfOJpwsyAPC1c8zL3U17+B3RY/+8+UCXEaBLOQuje7V8aYdalA/Rl8PEYnj13GMUCTDGlXhyqCliCgNl+GkWqFridETChBStFR9gdxwa8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252045; c=relaxed/simple;
	bh=xuv/qa+XtFR3T0xCtXs2kBRhf8nyqdnrtq291acbDIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUr4PHlmavJ0vtOF5a/cT+uD61hw4LhGTWjBJISMGBUGz+B62ZpQX9UDitkrn3A1KKP5bZRduGiEQqCHNEvXFx+Yjsab3cTvgt/8xAR/jc5UeIrwU0/UWadA41fw0UN+FpDdEWEu+GMoXLVFOdwvWQCcQiXCQWU+ZGRqRUcaRSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=HlTbuMFC; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="HlTbuMFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1730252005; x=1730856805; i=linux@jordanrome.com;
	bh=aEwKZ1iydmdmyI3mEPOkwX6hyct+//kwH/Nma7dvPxA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HlTbuMFCxAd9umbLyqrIwoebifkJ97iDbfzBE1QEoV3zIzBBYoPXBqigqGQEdzTq
	 9gTDrceZtvaWe94zoG4wUQKALsoivYZ1nGcO4hfuLbCgwcpWBprjui/QTLmPvRJgx
	 xauOEaSXdj8FDiuDMPxf0rPxYs5D7Bx5K8zFqNNybLR1red137hSssDhj3QASG1+9
	 SYO5qqsOvh9YqhPvBQru/UhbDn4m4Zmo+6o+O1rRPZyD2SlvXInrp9T1Xc1GUzddt
	 lpzYd3YMTk7ChNhk9fHQiEixkHFQrIEEwGMWK6yggFge3I+vEy7ZizzfMwAi6fELg
	 x621KTxDN2U2fysdiw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.116]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MKpCY-1t5xaP0Z60-00FDir; Wed, 30 Oct
 2024 02:33:25 +0100
From: Jordan Rome <linux@jordanrome.com>
To: linux-security-module@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Serge Hallyn <serge@hallyn.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [v4] security: add trace event for cap_capable
Date: Tue, 29 Oct 2024 18:33:14 -0700
Message-ID: <20241030013314.2188163-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1UYDUZOfplsFUotvYnTA4iMKn+/Ak0jJHOhPGyV8V7rOcbj6N/x
 CgM83buls49bIAdk9UXf/fJ1aWV6HqHM72tFqRyRRPapNrSMXiQZtti3yLvOlR4XbQiMdww
 EgH1u4rizRJBF0ZZfgEHcoRko87reKoOw56GoHy9J+iXqsCcham7J8TRVAua2vHfwgk572B
 4pyLw2VkpuZV/W9uYPK1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aTxEpAd42b8=;v84bSkeqsgygOMOBKAVi3lLmrb6
 YECwjj9bURukzABB2xk4ZUYwytlGjH0ks+UhwfNtTZQctQz99BcSNjdd018/xBbFiXgKo5yKt
 gORnI5vPpFNrlp37Tt5Okn5c+//qfFhxkhqT94GFdZutASPTTM+UTFhDdvEo4JNxtuJcGrOkR
 hQOt8KzNl7HkqWI3PdXbXTshd/YDRO1/v87Rd1uUn+oLKhwizVSPzu+xTCeG9Xciyp5Y9akle
 rIQyEV4O0IAgJfwZqFjTsoJ3EiD7XlF1hNIxttbhYbND7VgqX9FnEqTvYRB+I7wg38LgFgkIS
 iamjz/vdEVaCc+PbzMv6aEiPklBpHK/GqITRNqKLMlfWE2ECTkCedyUBT5xtnAvOgceUIINLW
 u0O5LzmH3jAY4yrzy5jebphb+X0v8+jdOJqLgCpmUSAWrgd5ZE5zX3lg9RJyEKx0/aUhBMU8T
 GyaaMGX/GUl4xKlzNhGXv9ozjTvY+PkXfkimx1seWk2wkKq3uF0UCEhI/0YqfdTygCtb+kiYg
 8v+A1txlOyi5UNCRLL/rxTGc+oJ9PJB3XCnjjeVD6G8EpBL75g/E1Vu33TPN+voLG1CPe65J7
 UayletCDt1sQG9g7TzEerQ6UncCm3Oy/F07oa96J3+qWLHW/TCxKfnXN1Gol8DIVlj5qNxd8U
 QDhpHf/9TVrQfAboxQRaVGrMpm5oQW3T6ZOfdWnZ2RGhZbvECG0jQ0EwOF3an2wvlsO7UIGCd
 iNT4bSTwLltlwQvkAnvtfUR1qmquL6sHA==

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
 security/commoncap.c              | 30 +++++++++++-----
 3 files changed, 83 insertions(+), 8 deletions(-)
 create mode 100644 include/trace/events/capability.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cc40a9d9b8cd..210e9076c858 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4994,6 +4994,7 @@ M:	Serge Hallyn <serge@hallyn.com>
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
index 000000000000..e706ce690c38
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
+ * @targ_ns: The user namespace of the resource being accessed
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
+	TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
+		struct user_namespace *capable_ns, int cap, unsigned int opts, int ret)=
,
+
+	TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
+
+	TP_STRUCT__entry(
+		__field(const struct cred *, cred)
+		__field(struct user_namespace *, targ_ns)
+		__field(struct user_namespace *, capable_ns)
+		__field(int, cap)
+		__field(unsigned int, opts)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->cred       =3D cred;
+		__entry->targ_ns    =3D targ_ns;
+		__entry->capable_ns =3D capable_ns;
+		__entry->cap        =3D cap;
+		__entry->opts       =3D opts;
+		__entry->ret        =3D ret;
+	),
+
+	TP_printk("cred %p, targ_ns %p, capable_ns %p, cap %d, opts %u, ret %d",
+		__entry->cred, __entry->targ_ns, __entry->capable_ns, __entry->cap,
+		__entry->opts, __entry->ret)
+);
+
+#endif /* _TRACE_CAPABILITY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/security/commoncap.c b/security/commoncap.c
index 162d96b3a676..7a74eb27eebf 100644
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
@@ -52,7 +55,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fnam=
e)
 /**
  * cap_capable - Determine whether a task has a particular effective capa=
bility
  * @cred: The credentials to use
- * @targ_ns:  The user namespace in which we need the capability
+ * @targ_ns:  The user namespace of the resource being accessed
  * @cap: The capability to check for
  * @opts: Bitmask of options defined in include/linux/security.h
  *
@@ -67,7 +70,9 @@ static void warn_setuid_and_fcaps_mixed(const char *fnam=
e)
 int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
 		int cap, unsigned int opts)
 {
-	struct user_namespace *ns =3D targ_ns;
+	int ret =3D -EPERM;
+	struct user_namespace *capable_ns =3D NULL,
+		*ns =3D targ_ns;

 	/* See if cred has the capability in the target user namespace
 	 * by examining the target user namespace and all of the target
@@ -75,22 +80,30 @@ int cap_capable(const struct cred *cred, struct user_n=
amespace *targ_ns,
 	 */
 	for (;;) {
 		/* Do we have the necessary capabilities? */
-		if (ns =3D=3D cred->user_ns)
-			return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
+		if (ns =3D=3D cred->user_ns) {
+			if (cap_raised(cred->cap_effective, cap)) {
+				capable_ns =3D ns;
+				ret =3D 0;
+			}
+			break;
+		}

 		/*
 		 * If we're already at a lower level than we're looking for,
 		 * we're done searching.
 		 */
 		if (ns->level <=3D cred->user_ns->level)
-			return -EPERM;
+			break;

 		/*
 		 * The owner of the user namespace in the parent of the
 		 * user namespace has all caps.
 		 */
-		if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner, cred->euid))
-			return 0;
+		if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner, cred->euid))=
 {
+			capable_ns =3D ns->parent;
+			ret =3D 0;
+			break;
+		}

 		/*
 		 * If you have a capability in a parent user ns, then you have
@@ -99,7 +112,8 @@ int cap_capable(const struct cred *cred, struct user_na=
mespace *targ_ns,
 		ns =3D ns->parent;
 	}

-	/* We never get here */
+	trace_cap_capable(cred, targ_ns, capable_ns, cap, opts, ret);
+	return ret;
 }

 /**
=2D-
2.43.5

