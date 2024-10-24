Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C414831C;
	Thu, 24 Oct 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767259; cv=none; b=rdAzDXI1IfDm6HldyHol3amaNy0jkVkiRhRQ7hnpCIpDEiVQ5svyTOE6etBqQAroRldir/Oop9PCtEihxvTYbC1AUgJOQQvwqGaQmKwhFO0qmI6h0t5lViujEDKK4oVwTiNdHap9II6zBmAPQ3NSD+9qGjo89wq6udmCKYL2L+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767259; c=relaxed/simple;
	bh=yGIhl8mYevvDwyWw0FFi2f+T/poFxSeXxHfTIzF4olA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNgRv93/NRRkI2N3qPMpG8wPdJqaGwuscz343Y/f2wYfY4gijofdsv9Urq4pX00MKY7b4uymB1OBZb7E1gPQkJ5zjtn556GWetoMMThnnMYi/HQpnfjUdkhqxxeQUeiN/ppSc6ullyohM4mjQA+0Z3Brb31x+O9VJKuxB0aOzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=yVPt70Ay; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="yVPt70Ay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1729767255; x=1730372055; i=linux@jordanrome.com;
	bh=oJqlOpA89ifM9UfzkwxEnEOmCn8Ap7GuPAMpz+Oz/kk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=yVPt70AyWB5HYKSf/5Xr3eF7oS5J1Yh/LZ85KvlmGJcizowMLvHfUMNMR/dImE/w
	 c7Fmwpiv+l25dhBuIBrbdzGw5KqkFYPLv0Y1JNBh/eFYIuPNZs4M3lsO2U1XAu4It
	 KEFOG1kk31EgzxgrRVWBR2fHoTy3hKyjZofLNyu0JGgqX6ITncBtHAS+4jhIgbOuK
	 aeLGUwRJqB35cJtHhqbBbH30j7fkCHOibRUzcU4fGnxmGnOIQ1OPLVlirOyt/nmKl
	 ClOiDFNHwf0mxGHqD2iaSdVb5eB6DYx6QaspyO+suA5KqbG5BEayY0f0ZBp9t4+ZU
	 Pv2V2ap8/nN/BH9q3Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.3]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MgdCj-1tI2263BkV-00QPIJ; Thu, 24 Oct
 2024 12:40:29 +0200
From: Jordan Rome <linux@jordanrome.com>
To: linux-security-module@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Serge Hallyn <serge@hallyn.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [v1] security: add trace event for cap_capable
Date: Thu, 24 Oct 2024 03:40:12 -0700
Message-ID: <20241024104012.1815022-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TVLmjv9MGLQr2eBCQ37lyn4wW2quWy1IpY9KEsq7D1rmN4JXD0N
 vVc8FcYlq5By0D2QXlZetNCFrJVTSUI+qx73ky1b1JhUewG9xqzS7QgvCJwVUo/LajQWVuh
 rSSx6rgZpnN2PyIcOo7VvfMn1Cbm7NdJT8AV7zZ8DwHJjb6u5u440p5nqHYob6dpVUEdZZd
 qPHv99tjWF322v5FRvNtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8uJ27nw4f44=;aKSKps/DGaGxF+uMKLQPLJTFIlH
 +BRb3dGAi4khsG1Xg0td5apFwTEjXfZBFYIdaUevRcmwwJgN07hqVWaMr6E943Uh8QsGpuIqn
 6AA1yYi+Pd6qB+2hBlEq5TUA/YBE4jnYIiOowCCELWpf6E20ZDGtnRjMYzaGMnc9NY5XlXPu2
 svwIfu38SBNXeZPy1hSlG+R/g7vJAEc0vHlwYnAxFUpkutZ2DDOP/jyt97PHoIyU2ocsn+h4T
 ol5Zfk+uySBOlwL0lvexcauC9y2gSIHvforw7BQO0rJh6pROFu36rPgeGko5nxXLzKqlUYbjj
 3ypmzbwI6WKiwrwejRsaj8MeW4cWUN24/xd7zw8B6r4+GvjFsjGTrCBFfXNIdr1rT0tpsYWoG
 5G8hu1HO99fau+AHwKYTakUIMAH93YIddSeDQnGZQS2Bh7u9oO8kH9H2OBIkkCKhCtZMO1MjB
 up5zWtpjDOUS2FP6ciLFR3cQMrMIhpvvuZ0evsJbsoSSCpj0UR2OP47/v36erztZwSg/VggCa
 6OTyzTMcyTinPJv+he4imqvQbqqtXtRymiYE4/NpnO7MbCNe5OusGs5Ce88tPrR86WgP+8PEq
 PS0Wzi+TKd7Z7UJmgofRPPE5SNzOioi+1aobUAFkssWv8srIhoXwwYJg1LdpbJW/I00BxL5OY
 KlCzjuGSSqfkbiInvIRmfEhPc5zEdeT0zNc+F/Ii14iPfZzLeLTCADOFRN9CZjbNWIPglE+2h
 T5BdrHK342ND0b8hyrsncMyXWV+wK3EYg==

In cases where we want a stable way to observe/trace
cap_capable (e.g. protection from inlining and API updates)
add a tracepoint that passes:
- The credentials used
- The user namespace which needs the capability
- The user namespace that actually has the capability (if one exists)
- The capability to check for
- Bitmask of options defined in include/linux/security.h
- The return value of the check

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 MAINTAINERS                       |  1 +
 include/trace/events/capability.h | 58 +++++++++++++++++++++++++++++++
 security/commoncap.c              | 21 +++++++----
 3 files changed, 74 insertions(+), 6 deletions(-)
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
index 000000000000..092b8e77063a
=2D-- /dev/null
+++ b/include/trace/events/capability.h
@@ -0,0 +1,58 @@
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
+ * capable - called after it's determined if a task has a particular
+ * effective capability
+ *
+ * @cred: The credentials used
+ * @targ_ns:  The user namespace which needs the capability
+ * @capable_ns:  The user namespace that actually has the capability
+ *               if ret is 0 otherwise this will be NULL
+ * @cap: The capability to check for
+ * @opts: Bitmask of options defined in include/linux/security.h
+ * @ret: The return value of the check: 0 if it does, -ve if it does not
+ *
+ * Allows to trace calls to cap_capable in commoncap.c
+ */
+TRACE_EVENT(capable,
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
+	TP_printk("cap %d, opts %u, ret %d",
+		__entry->cap, __entry->opts, __entry->ret)
+);
+
+#endif /* _TRACE_CAPABILITY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/security/commoncap.c b/security/commoncap.c
index 162d96b3a676..675d40fbaa77 100644
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
@@ -68,6 +71,7 @@ int cap_capable(const struct cred *cred, struct user_nam=
espace *targ_ns,
 		int cap, unsigned int opts)
 {
 	struct user_namespace *ns =3D targ_ns;
+	int ret =3D 0;

 	/* See if cred has the capability in the target user namespace
 	 * by examining the target user namespace and all of the target
@@ -75,22 +79,26 @@ int cap_capable(const struct cred *cred, struct user_n=
amespace *targ_ns,
 	 */
 	for (;;) {
 		/* Do we have the necessary capabilities? */
-		if (ns =3D=3D cred->user_ns)
-			return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
+		if (ns =3D=3D cred->user_ns) {
+			ret =3D cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
+			break;
+		}

 		/*
 		 * If we're already at a lower level than we're looking for,
 		 * we're done searching.
 		 */
-		if (ns->level <=3D cred->user_ns->level)
-			return -EPERM;
+		if (ns->level <=3D cred->user_ns->level) {
+			ret =3D -EPERM;
+			break;
+		}

 		/*
 		 * The owner of the user namespace in the parent of the
 		 * user namespace has all caps.
 		 */
 		if ((ns->parent =3D=3D cred->user_ns) && uid_eq(ns->owner, cred->euid))
-			return 0;
+			break;

 		/*
 		 * If you have a capability in a parent user ns, then you have
@@ -99,7 +107,8 @@ int cap_capable(const struct cred *cred, struct user_na=
mespace *targ_ns,
 		ns =3D ns->parent;
 	}

-	/* We never get here */
+	trace_capable(cred, targ_ns, ret =3D=3D 0 ? ns : NULL, cap, opts, ret);
+	return ret;
 }

 /**
=2D-
2.43.5

