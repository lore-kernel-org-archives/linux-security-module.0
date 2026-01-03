Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6B207A38;
	Sat,  3 Jan 2026 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767400051; cv=none; b=Z2UALHSrK2a1ec0aB5aPWFlT8YVxC8VQyNe9QnY9JapCQOmOAi7hSRZjdCgxUm9cxGZo6w3rl7a5Blk+h+btRVZUIIz1F0GRUuDt5ARB0PrY0Dv8p61IoJ84q+zXT7M2tizncGQ4wVIJyK3cml+L3f+r7LxbjIAF+M/X8csZkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767400051; c=relaxed/simple;
	bh=y7DQhzPzVn9fdb6TNEl14YBGTOKcNNLeae7MfbCfxrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdLRic1TNTcMfmz3OruXozamqxjnzcIaqqT6h6X07icwNSqxTwPg2bLRvu9cQl7IT5kgHAVjRS4DghAxPuI6KcY4EWgvmBbJsbKcbVnGleyFgwQ+g1jdbghQoEq73sY9LZO6vpZ18KXnvyA6zM0uN+G51yYDvH3PWc2wOacjOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dp9WesjU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dp9WesjU"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602LwSSp4013264;
	Sat, 3 Jan 2026 00:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7/3myKbvVaaLYBLjLcMHyHrBev4z1oPl70FY3e29wpE=; b=
	Dp9WesjUTUUBg+A7TYIc2DEbhGdwj8ONBMerRharQyjYHy8VPo6qoymsvzEcDrmp
	iHxqscqujofPW0x2zaWxBWWuf5LiDw0FWL54dRSMSTW3AMNycdLdARnAsI6Vl7/O
	kqAAzuwk8hsJ/nJox/EmcGfVcrP2dtugzFf2g5cUxFOUpyi4Dh/Vlnciys4SVjze
	IKsq2EVEjfuKtPR1RUypP77n60zSDC3ByRCUexGsyOFjMTPz4EZHbPy/1JtRggkO
	C/+yiklpmbTI+sIM5SxE9kwnSy+NWs1GRlbzyPyYHnb1p5b9MFGnV3T5ZRTovEkG
	uKkoEvhho0GHKYyyF66rEg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba72qnja7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 00:27:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602LDRa4038159;
	Sat, 3 Jan 2026 00:27:25 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wehv77-3;
	Sat, 03 Jan 2026 00:27:25 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: mic@digikod.net, gnoack@google.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] landlock: Add comprehensive errata documentation
Date: Fri,  2 Jan 2026 16:27:14 -0800
Message-ID: <20260103002722.1465371-3-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260103002722.1465371-1-samasth.norway.ananda@oracle.com>
References: <20260103002722.1465371-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601030002
X-Proofpoint-GUID: LhRW_b77lNakRwKWoVPBvKMR_r8Z-Kek
X-Authority-Analysis: v=2.4 cv=MqBfKmae c=1 sm=1 tr=0 ts=6958626e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=qf4gfuq51q0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Zjv7b4BI8D8f_-Xx94EA:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: LhRW_b77lNakRwKWoVPBvKMR_r8Z-Kek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDAwMiBTYWx0ZWRfX1BxTwvwhh5zr
 6YKDZqWZBptWOk9obHqSlZG7ZRxwpsKpNAeJERM271PCxvFgxr5eLvtySbxjYXhcoWwxm8nQD0U
 OOMNWM9rD96Lwez1lnfU8uBzlndcRF0EhqkZB0WDbWfgh8q1AWwdJLUf8tSiDw9jihzuEboGB/Z
 X/EKvVOrziZUPtB/Qc1t5XtbT6FHLUfxVyG2Y2yep51zH1NVDFQduBOCrUvI1YwDK4+KOa5dS5Y
 UUiGft/9CsOxOu2dgKC4GCVbP/0ibIi3X17vWanRGBD9IeAhsc3bpSsMI1X3RlCAqaVlGUVgioE
 KjxvwdQzs2ev+v3hjhoT67LrYcYBeRtjstFU/EXBPRWSjAH8vyAKV7+K9QQLSzj0K7G1xqRbHbu
 H/zEmF+lYX66siAR+dfXILjv2t3V2Uu1Jv5KDgseWmKd5KpLh0Itpz1mQwx33fKiXmIe8EVl4hL
 nWJ7QDVPKjH5MnfTU34q6eCUPfQrdUXWaRWiRjx0=

Add comprehensive documentation for the Landlock errata mechanism,
including how to query errata using LANDLOCK_CREATE_RULESET_ERRATA
and links to enhanced detailed descriptions in the kernel source.

Also enhance existing DOC sections in security/landlock/errata/abi-*.h
files with Impact sections, and update the code comment in syscalls.c
to remind developers to update errata documentation when applicable.

This addresses the gap where the kernel implements errata tracking
but provides no user-facing documentation on how to use it, while
improving the existing technical documentation in-place rather than
duplicating it.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 Documentation/userspace-api/landlock.rst | 60 +++++++++++++++++++++++-
 security/landlock/errata/abi-1.h         |  8 ++++
 security/landlock/errata/abi-4.h         |  7 +++
 security/landlock/errata/abi-6.h         | 10 ++++
 security/landlock/syscalls.c             |  4 +-
 5 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 650c7b368561..930723fd7c1a 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: March 2025
+:Date: January 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -458,6 +458,64 @@ system call:
         printf("Landlock supports LANDLOCK_ACCESS_FS_REFER.\n");
     }
 
+Landlock Errata
+---------------
+
+In addition to ABI versions, Landlock provides an errata mechanism to track
+fixes for issues that may affect backwards compatibility or require userspace
+awareness. The errata bitmask can be queried using:
+
+.. code-block:: c
+
+    int errata;
+
+    errata = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_ERRATA);
+    if (errata < 0) {
+        /* Landlock not available or disabled */
+        return 0;
+    }
+
+The returned value is a bitmask where each bit represents a specific erratum.
+If bit N is set (``errata & (1 << (N - 1))``), then erratum N has been fixed
+in the running kernel.
+
+.. warning::
+
+   **Most applications should NOT check errata.** In 99.9% of cases, checking
+   errata is unnecessary, increases code complexity, and can potentially
+   decrease protection if misused. For example, disabling the sandbox when an
+   erratum is not fixed could leave the system less secure than using
+   Landlock's best-effort protection. When in doubt, ignore errata.
+
+For detailed technical descriptions of each erratum, including their impact
+and when they affect applications, see the DOC sections in the kernel source:
+
+- **Erratum 1: TCP socket identification (ABI 4)** - See ``erratum_1`` in ``security/landlock/errata/abi-4.h``
+- **Erratum 2: Scoped signal handling (ABI 6)** - See ``erratum_2`` in ``security/landlock/errata/abi-6.h``
+- **Erratum 3: Disconnected directory handling (ABI 1)** - See ``erratum_3`` in ``security/landlock/errata/abi-1.h``
+
+How to Check for Errata
+~~~~~~~~~~~~~~~~~~~~~~~
+
+If you determine that your application needs to check for specific errata,
+use this pattern:
+
+.. code-block:: c
+
+    int errata = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_ERRATA);
+    if (errata >= 0) {
+        /* Check for specific erratum (1-indexed) */
+        if (errata & (1 << (erratum_number - 1))) {
+            /* Erratum N is fixed in this kernel */
+        } else {
+            /* Erratum N is NOT fixed - consider implications for your use case */
+        }
+    }
+
+**Important:** Only check errata if your application specifically relies on
+behavior that changed due to the fix. The fixes generally make Landlock less
+restrictive or more correct, not more restrictive.
+
 The following kernel interfaces are implicitly supported by the first ABI
 version.  Features only supported from a specific version are explicitly marked
 as such.
diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
index e8a2bff2e5b6..ba9895bf8ce1 100644
--- a/security/landlock/errata/abi-1.h
+++ b/security/landlock/errata/abi-1.h
@@ -12,5 +12,13 @@
  * hierarchy down to its filesystem root and those from the related mount point
  * hierarchy.  This prevents access right widening through rename or link
  * actions.
+ *
+ * Impact:
+ *
+ * Without this fix, it was possible to widen access rights through rename or
+ * link actions involving disconnected directories, potentially bypassing
+ * ``LANDLOCK_ACCESS_FS_REFER`` restrictions. This could allow privilege
+ * escalation in complex mount scenarios where directories become disconnected
+ * from their original mount points.
  */
 LANDLOCK_ERRATUM(3)
diff --git a/security/landlock/errata/abi-4.h b/security/landlock/errata/abi-4.h
index c052ee54f89f..59574759dc1e 100644
--- a/security/landlock/errata/abi-4.h
+++ b/security/landlock/errata/abi-4.h
@@ -11,5 +11,12 @@
  * :manpage:`bind(2)` and :manpage:`connect(2)` operations. This change ensures
  * that only TCP sockets are subject to TCP access rights, allowing other
  * protocols to operate without unnecessary restrictions.
+ *
+ * Impact:
+ *
+ * In kernels without this fix, using ``LANDLOCK_ACCESS_NET_BIND_TCP`` or
+ * ``LANDLOCK_ACCESS_NET_CONNECT_TCP`` would incorrectly restrict non-TCP
+ * stream protocols (SMC, MPTCP, SCTP), potentially breaking applications
+ * that rely on these protocols while using Landlock network restrictions.
  */
 LANDLOCK_ERRATUM(1)
diff --git a/security/landlock/errata/abi-6.h b/security/landlock/errata/abi-6.h
index df7bc0e1fdf4..a3a48b2bf2db 100644
--- a/security/landlock/errata/abi-6.h
+++ b/security/landlock/errata/abi-6.h
@@ -15,5 +15,15 @@
  * interaction between threads of the same process should always be allowed.
  * This change ensures that any thread is allowed to send signals to any other
  * thread within the same process, regardless of their domain.
+ *
+ * Impact:
+ *
+ * This problem only manifests when the userspace process is itself using
+ * :manpage:`libpsx(3)` or an equivalent mechanism to enforce a Landlock policy
+ * on multiple already-running threads at once. Programs which enforce a
+ * Landlock policy at startup time and only then become multithreaded are not
+ * affected. Without this fix, signal scoping could break multi-threaded
+ * applications that expect threads within the same process to freely signal
+ * each other.
  */
 LANDLOCK_ERRATUM(2)
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0116e9f93ffe..cf5ba7715916 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -157,9 +157,11 @@ static const struct file_operations ruleset_fops = {
 /*
  * The Landlock ABI version should be incremented for each new Landlock-related
  * user space visible change (e.g. Landlock syscalls).  This version should
- * only be incremented once per Linux release, and the date in
+ * only be incremented once per Linux release. When incrementing, the date in
  * Documentation/userspace-api/landlock.rst should be updated to reflect the
  * UAPI change.
+ * If the change involves a fix that requires userspace awareness, also update
+ * the errata documentation in Documentation/userspace-api/landlock.rst.
  */
 const int landlock_abi_version = 7;
 
-- 
2.50.1

