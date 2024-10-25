Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C80170A37;
	Fri, 25 Oct 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869155; cv=none; b=CsdGbq+S4xjspmi40kRAajanhvPg3b5cKdhkUfzlVy6Me45hRaVcFSY8vY7DVbiuUE2TSS2tYjifiFJ0jjT0D0bxnjIvJT+AdyTG9RtRn5rl6em3nr5MHjhGAIW1rcdqIguaCQS9xUsIiYEOXgMnI7rnGJQIhZir2mcxuURXbcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869155; c=relaxed/simple;
	bh=IaVjhsvlq7wTzA+NTP/f66nx9CoUiMNLxWwXhb82Vfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcXjcby0qa0bRgZfvvrXZMj/mqzX6gBXW1sFAYx28SDh9KLUUYq63QVJztz+ask8wM0l8appwq2xYPPuxKrXYgUiZ+WMHCqSO57l0sYX1zrVzPXmrxBu/HW0JjMVuyC8z1YAjs29RhPoFpYk7gub0Uq2jSsWia/dzbqsOaua9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=ihpjlTNL; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="ihpjlTNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1729869102; x=1730473902; i=linux@jordanrome.com;
	bh=yrmiXY1aAioCCKYswK/attSf84hm0Z5ffGHA59q6YXU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ihpjlTNLNWzYR2lHm4NgnQb72IKgcPlu3FIoVekvDkt65TA/sFm2ZJuhhFR2ul1Z
	 ORaX9ogvQk5cuiYt7GHKhgoKLzzfhrR9qVUTCIjaevE1FDwVOQV3dS0xhWdDnXCpv
	 tNw+idtk66PCUJs2VB2wLaXfTPFU7t09vaNPVGqvhwBidlG2EpfhzShCLWqTBLURe
	 +iWMMh3mRmmTjdFTFPd97y+UuKmcMXdDU5YxBwjODO76I/RNYdZ1MJRhzDk0MGwOe
	 qpMAnuf19kYmV9pDCnhcjsCNcUrp7o8BTBlLuODG68BfpWzMoH610znsr9UHFVQ0I
	 PJ6Yi1kjJXUFO7qRNQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.17]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MZjFw-1tKNUG1Kvu-00Qord; Fri, 25 Oct
 2024 17:11:42 +0200
From: Jordan Rome <linux@jordanrome.com>
To: linux-security-module@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Serge Hallyn <serge@hallyn.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [v2] security: add trace event for cap_capable
Date: Fri, 25 Oct 2024 08:11:28 -0700
Message-ID: <20241025151128.1854905-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q46n2CJIB/zeWvyr5DLrkLEMA73iReV7jAUBbZO2HlTIqXMAsBU
 HpiTlfMDsjkM58BGMSgCpkOTY+4Kd1bo5Ez9M4tY39V/31z8zblf+k9Bs5RSe435/fSfomU
 yerIWS9Wd3rkx1qBql7URdffeURjW/0kA0CgD37km2PQvs8du7LEruqK1FZcI0F6OUwDeSc
 OCAX6TSYjGzisTd8Qi9rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R1oXoLQfh68=;ZxheX0qmNemVfywQAu9y+W0tG9H
 ccMKL4bZfn8dVbTe20I2CqeWkBKtiQ5fB1XHwdEa9V/aFoccv4NtfvThVWJq0qrktKPLFKWUC
 c+ua5WZfkjOmrD+KXbjVYfQ99Ys/W8BVYpoom3k5vwNJgf8UUiVsSlTOmQY8gFHKzS8qADweF
 LCpXCTszdSjdcWaOaRumqr1IZB5208f8Tlq+CDF+QwACNfPLmu3qcnl/WjNdSFCtPfe4oxeLR
 KAVmHCHITh491QIc8HCpizGV2Ybhi1KDd4dPEAHlGgW1sa2q326UL8tOlPL1+2qPw2L0M/G6z
 nColAQYkz2dDXoOGUm/7j71LpRcf+I94bfi8QsCmQ3jU/lB3hfjetwxhMs9JvyR9C3v6cyI2g
 glWe06KW3J+JcmhK08yPL3icqmstSXBYd5S2H/b8lMaTo8eHCMhPMTuH0ySURowtQLxJWCxQ0
 VMui/VNbsASB9Cr5KUOTf+mMefbLdTyWLUP4xys6m1VcSPxb02RzTkIF8aoU6OX2aJIGZ/63T
 hZnwbaM4C0Lz2/aFqCTo3vx9XtOmRwDdBzJt9pYZWmMWQ3xZxBeUserrAvzKnIq5BpqcKFP3I
 Dve6LWHsr5+mKjF32NGkTE733h+FkiYLyw//KpDMd77ft4OJCWHUCXEpWYR5bfQCjsX7bWAD2
 4870z7f1o+UoHWKcmMoi64PcFzoSVa0WzzCaCQwEa1RvpdGSG9ZX78eDYHPS6sJHTzKsFF77Z
 yNRwanH8+CcRwHMyMlZ9hMfWIZwy9R4aw==

In cases where we want a stable way to observe/trace
cap_capable (e.g. protection from inlining and API updates)
add a tracepoint that passes:
- The credentials used
- The user namespace of the resource being accessed
- The user namespace that has the capability to access the
targeted resource
- The capability to check for
- Bitmask of options defined in include/linux/security.h
- The return value of the check

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 MAINTAINERS                       |  1 +
 include/trace/events/capability.h | 60 +++++++++++++++++++++++++++++++
 security/commoncap.c              | 31 +++++++++++-----
 3 files changed, 84 insertions(+), 8 deletions(-)
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
index 162d96b3a676..12c3ddfe0d6e 100644
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
@@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct user_nam=
espace *targ_ns,
 		int cap, unsigned int opts)
 {
 	struct user_namespace *ns =3D targ_ns;
+	int ret =3D -EPERM;

 	/* See if cred has the capability in the target user namespace
 	 * by examining the target user namespace and all of the target
@@ -75,22 +79,32 @@ int cap_capable(const struct cred *cred, struct user_n=
amespace *targ_ns,
 	 */
 	for (;;) {
 		/* Do we have the necessary capabilities? */
-		if (ns =3D=3D cred->user_ns)
-			return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
+		if (ns =3D=3D cred->user_ns) {
+			if (cap_raised(cred->cap_effective, cap))
+				ret =3D 0;
+			else
+				ns =3D NULL;
+			break;
+		}

 		/*
 		 * If we're already at a lower level than we're looking for,
 		 * we're done searching.
 		 */
-		if (ns->level <=3D cred->user_ns->level)
-			return -EPERM;
+		if (ns->level <=3D cred->user_ns->level) {
+			ns =3D NULL;
+			break;
+		}

 		/*
 		 * The owner of the user namespace in the parent of the
 		 * user namespace has all caps.
 		 */
-		if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner, cred->euid))
-			return 0;
+		if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner, cred->euid))=
 {
+			ns =3D ns->parent;
+			ret =3D 0;
+			break;
+		}

 		/*
 		 * If you have a capability in a parent user ns, then you have
@@ -99,7 +113,8 @@ int cap_capable(const struct cred *cred, struct user_na=
mespace *targ_ns,
 		ns =3D ns->parent;
 	}

-	/* We never get here */
+	trace_cap_capable(cred, targ_ns, ns, cap, opts, ret);
+	return ret;
 }

 /**
=2D-
2.43.5

