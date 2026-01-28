Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2E32E129;
	Wed, 28 Jan 2026 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570304; cv=none; b=p9jomOGXdFHdQxhM/h/TSrZc3I62tfFMymYqheC/8XI1qh2qSitGzn3wGqVVe/HQTro9Ucx/KZMPrSlN4iEGA6wKuZ6HJOL6M+jENeVUgOKlE2o54+02C3bhbBDiSJFQvirUhhi57DLqQoXnc1cewGNYx0673rA44iprcNBAs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570304; c=relaxed/simple;
	bh=BJBTtEmDH5Is5f1exGtK32VTQNxla9HDwjoIgh7VGos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAsPcjqDHd5ZFinnpEuGimq0K6SOGGL/LsRLV+1jUSJCSF1PYfS/At0DO2YKCSbY02/qq0BD1UOCHT+k1N+UpKMG+EyI9X9qQ4N+TCVV/QSpNISHFzk2qliQ3LTkXt49oXevn1emvmmXexADM9zhtWFBK93wiHunKJsY0QVf8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WWghH+SS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WWghH+SS"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RNEoq4308995;
	Wed, 28 Jan 2026 03:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O26qnPhMOZvHOcUWSHJWxWpofuwSWhB89WQw8vRcgnA=; b=
	WWghH+SSuvpom4z9k5p2+VWSg9bRRwGdpIwQN62851Blvl2ExzeMWdE6W7Mns3Zl
	QWV7kDZ7ITQaiPsQKqZc5kVKgroVeWL/XLBfyU4cAl4w8VUJRca2nRKs5upySRN/
	LesJQ4yU/MtWJY4XjQGS+tvsMfX3Lcll8RA2k7rZV9HT+PNqpPTU+umcBwWOPSip
	69zRaRlidG65EIbuYIdSNAFRtqMIfTjQQRbF74tEc8x4AvzszlQZh4Qj7u1F59At
	7caqeolUor4OZPY3xnjV4RurYtDSBPon4Wx8d0XSHhMtFQHTjCIUI9qZPyD2M87q
	upSU+T1O53h8isWrGqaBgA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by39r8nu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 03:18:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S20Wha035394;
	Wed, 28 Jan 2026 03:18:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhab27u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 03:18:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60S3F1jv004661;
	Wed, 28 Jan 2026 03:18:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhab27f-3;
	Wed, 28 Jan 2026 03:18:16 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: gnoack@google.com, mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        samasth.norway.ananda@oracle.com
Subject: [PATCH v3 2/3] landlock: add errata documentation section
Date: Tue, 27 Jan 2026 19:18:11 -0800
Message-ID: <20260128031814.2945394-3-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260128031814.2945394-1-samasth.norway.ananda@oracle.com>
References: <20260128031814.2945394-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280023
X-Authority-Analysis: v=2.4 cv=LaoxKzfi c=1 sm=1 tr=0 ts=69797ffa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=qf4gfuq51q0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Zjv7b4BI8D8f_-Xx94EA:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-GUID: jfiLHnB1QjY8dwcXZ9siSDcPf_VF2msa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyMiBTYWx0ZWRfX3wlWXAEiYbUq
 JlD5RU5QH9GUqlqI9RLp/as1P/siGv5/YtsiDRLIoZSCdVQ+aJ1neQEgDsa8NzX8nbxw0J80uS6
 +NpNetN0yhYomh8rZUJZVTPLKwrAtV4F2Jn8DdEXHOr1YGQrmMdRBgLl6x2q0rvQ2h59RlutcVk
 zQqOK/wpHfZYSmXKW6H2Pkma/ROAaXrb94P3i4IwcpnQ/qm3eiTIIJEyPp4k+9gNJMrCeNbwgkd
 p1qbLwSx3BbCue/zg6SNd3MRx9knFZQJsVanj07VHpBYsmhfdDEgzN2aKEWkGqWKUygp1yVqxt4
 OR0ZvrCDeDjcET7QMK8iKCppETQuH16G9GBRsUVwd6AjP7ZGB6koHIO4LEK8Q/mnx9RjYDsQ8oi
 WqPAEiUuXkCoDQlqdPjCT48+Pp6XoBqf9iTQyz2X8hBxNm2o7hS1ExzhsRdoclLgxWbYItpXow3
 KCv1umv/TAE6KsNi/hw==
X-Proofpoint-ORIG-GUID: jfiLHnB1QjY8dwcXZ9siSDcPf_VF2msa

Add errata section with code examples for querying errata and a warning
that most applications should not check errata. Use kernel-doc directives
to include errata descriptions from the header files instead of manual
links.

Also enhance existing DOC sections in security/landlock/errata/abi-*.h
files with Impact sections, and update the code comment in syscalls.c
to remind developers to update errata documentation when applicable.

This addresses the gap where the kernel implements errata tracking
but provides no user-facing documentation on how to use it, while
improving the existing technical documentation in-place rather than
duplicating it.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 Documentation/userspace-api/landlock.rst | 67 ++++++++++++++++++++++--
 security/landlock/errata/abi-1.h         |  8 +++
 security/landlock/errata/abi-4.h         |  7 +++
 security/landlock/errata/abi-6.h         | 10 ++++
 security/landlock/syscalls.c             |  4 +-
 5 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index c8ef1392a0c7..405b2d73e699 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: December 2025
+:Date: January 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -492,9 +492,68 @@ system call:
         printf("Landlock supports LANDLOCK_ACCESS_FS_REFER.\n");
     }
 
-The following kernel interfaces are implicitly supported by the first ABI
-version.  Features only supported from a specific version are explicitly marked
-as such.
+All Landlock kernel interfaces are supported by the first ABI version unless
+explicitly noted in their documentation.
+
+Landlock errata
+---------------
+
+In addition to ABI versions, Landlock provides an errata mechanism to track
+fixes for issues that may affect backwards compatibility or require userspace
+awareness.  The errata bitmask can be queried using:
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
+   decrease protection if misused.  For example, disabling the sandbox when an
+   erratum is not fixed could leave the system less secure than using
+   Landlock's best-effort protection.  When in doubt, ignore errata.
+
+.. kernel-doc:: security/landlock/errata/abi-4.h
+    :doc: erratum_1
+
+.. kernel-doc:: security/landlock/errata/abi-6.h
+    :doc: erratum_2
+
+.. kernel-doc:: security/landlock/errata/abi-1.h
+    :doc: erratum_3
+
+How to check for errata
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
+behavior that changed due to the fix.  The fixes generally make Landlock less
+restrictive or more correct, not more restrictive.
 
 Kernel interface
 ================
diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
index e8a2bff2e5b6..3f099555f059 100644
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
+ * ``LANDLOCK_ACCESS_FS_REFER`` restrictions.  This could allow privilege
+ * escalation in complex mount scenarios where directories become disconnected
+ * from their original mount points.
  */
 LANDLOCK_ERRATUM(3)
diff --git a/security/landlock/errata/abi-4.h b/security/landlock/errata/abi-4.h
index c052ee54f89f..fe11ec7d7ddf 100644
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
index 5113a829f87e..5cb1475c7ea8 100644
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
+ * on multiple already-running threads at once.  Programs which enforce a
+ * Landlock policy at startup time and only then become multithreaded are not
+ * affected.  Without this fix, signal scoping could break multi-threaded
+ * applications that expect threads within the same process to freely signal
+ * each other.
  */
 LANDLOCK_ERRATUM(2)
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 8eaec8d35c44..9b7a7f39f26c 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -158,9 +158,11 @@ static const struct file_operations ruleset_fops = {
 /*
  * The Landlock ABI version should be incremented for each new Landlock-related
  * user space visible change (e.g. Landlock syscalls).  This version should
- * only be incremented once per Linux release, and the date in
+ * only be incremented once per Linux release.  When incrementing, the date in
  * Documentation/userspace-api/landlock.rst should be updated to reflect the
  * UAPI change.
+ * If the change involves a fix that requires userspace awareness, also update
+ * the errata documentation in Documentation/userspace-api/landlock.rst.
  */
 const int landlock_abi_version = 9;
 
-- 
2.50.1

