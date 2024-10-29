Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA520403E;
	Tue, 29 Oct 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200877; cv=none; b=a3XVrAVMH17uBl4qxvowWQptoS4s2TUKE/bcQIhy79U+lQVMUkwzrw+gwsGdRFvKjPdcNFecSVTEYbto+qkebqBm+nCsXeymitidR07hq4kqmeHMJR2IP5LvlmbTQbnMKOrQgduHWEYIAefXkNti04z4zHo95PcvzGtIDOPQElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200877; c=relaxed/simple;
	bh=pY5BTmvixJSnUXFdrCBOHwyLwnNYeJ3eAVoRCFLpiv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbWYKaqbYHK+Nk1KJvnWFbnch6ahv7ov4Wqu7x575zSbZfW4mXE+zse2qWJw6u8yq4ejKG5+Z4fqF8z5RzFSg3uNx7cCztsIox4Lmlo7++ag9q8YB3tOFT04WrO1PlYeVxeRBkmpHGzOmrnNAi8lQg6+cNXycv+OoEc13ZD63ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=bVyi3rKI; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="bVyi3rKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1730200843; x=1730805643; i=linux@jordanrome.com;
	bh=oUD262rHnLFVaLqePc2SP62T5dCJwI2MdM2J9YroiRg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bVyi3rKIerkYb1mCkMGI+nvIp7waqnUO9q4sUDdh6RyboEerkSs2C3DutdqMaVXt
	 CEUJLM4n0JQwo8WR8s78VABXg3W6ALBt1HE99Zs2G4pylPbNci0IYpg9K1+mpv/ZH
	 HKqdDMjt+t6zxdG7XCMf7sW/gYWJGpRnq0vW9rqvexXfFJqCvmHpxGI+qQP+y0D/W
	 DtPoP480LWMSGqUCSXEgD527rkMGJAT0rdnkSxW8ciIj+JV/X8tY7fCY4XRMJuxKs
	 YFREiT2zqOBbkyqmlaAZUBkSSDmN/B3atmNxkfthl+aM4T2WN8O6BvF3YJpLA+D6H
	 hV2H370xrc8f7jbVSw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.25]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MGCIr-1t3JqW0gdT-006s3g; Tue, 29 Oct
 2024 12:20:43 +0100
From: Jordan Rome <linux@jordanrome.com>
To: linux-security-module@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Serge Hallyn <serge@hallyn.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [v3] security: add trace event for cap_capable
Date: Tue, 29 Oct 2024 04:20:38 -0700
Message-ID: <20241029112038.1225847-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:so5afXzKmBlfk/Fla5DEnSFEXWwvjB6LXJN9H/kdO6/VWsH8zuw
 oZjS70VVcN83wiYcM6nQZEo+1VF7iKg3rF5aYVOnr0HZsUNwN+47iHVTjW+7ijxpBz0828M
 FqC9rgwzBxCGzE1FNChiguqbETyRGwKkHM4PTP4R58zAdd9O2GRrGBQ2AnhNpimXT/oQwGj
 Ti0HqdU2DD/wMaiATBs3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yCBtADiG8us=;FYm8KI1y4def561+doMrOoZrJG6
 jQ4OwIw0ObqGPdvnVEQcRRX0TMUzfHfZ3iFQ0jkPonvcHWl+rBWqtVgZjYDPHqZzDh6pf60Wa
 2+QRxF3iiNiBAZr398c6efag/esbz2MaARbpV9LlKO8mnFX0XX+lDFIrFMfg1WJveOHNZ8Ug9
 U4gPg0q8w8IpoYyfvnyphL4UOXUkJZ9Kk/Y+UeNL1L6fSPbb3icEue2hq71UcLzvZGvPU5FYm
 Nmd4Xa+3xg30kcUop2lgCTzYFs2riLxPo6Od2mRwqPazlxXodo7aSDgco2l1HOBIjzbyXVTyN
 6jeRIZuKkN/HYssQe2HMIONjRCeDr39PbPnzJj0lCI/LEfHCWolMr3g/rTqVkIIyzQtXXtOgo
 AmvTAZ+rkJMk0644DxMcsCe27GequkBEy4/yNvQoiFElrhRkVsaR8K4gBFEvcDBR59ycS0lOW
 wTLwBs34ViIsXjYEbr4Zkt2CqdWw2qPfmHZlE/pq5R2FrF2+gf7CbymumypQpkcYWO1nS/Xq2
 5yx33Kx0FvqZjrp6zYQ3N+4R95EocjpX2AOx75PSbcH/kMo5J8CoVGW8c6mf++Zg/qht5m/Jh
 Fb2maeU15/ktPgvX7J+7ZMVb3MaAmTP9XwNBABkeBr3XZEgCnikU3czEctRDMvnkkhwD230x5
 q6Q7VBEDh4QrYQ43UOLfycc6Cm/zSL/TWRd2mWXC4VjKnKP6GKBP8qYRF4II8Dnf3AL+DosBd
 sW0o7Qu3qiNCBTbFgp1uZahuGHqCwDUfA==

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
 security/commoncap.c              | 32 ++++++++++++-----
 3 files changed, 85 insertions(+), 8 deletions(-)
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
index 162d96b3a676..7287feee0683 100644
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
@@ -67,7 +70,11 @@ static void warn_setuid_and_fcaps_mixed(const char *fna=
me)
 int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
 		int cap, unsigned int opts)
 {
-	struct user_namespace *ns =3D targ_ns;
+	int ret =3D -EPERM;
+	struct user_namespace *capable_ns, *ns;
+
+	capable_ns =3D NULL;
+	ns =3D targ_ns;

 	/* See if cred has the capability in the target user namespace
 	 * by examining the target user namespace and all of the target
@@ -75,22 +82,30 @@ int cap_capable(const struct cred *cred, struct user_n=
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
@@ -99,7 +114,8 @@ int cap_capable(const struct cred *cred, struct user_na=
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

