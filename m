Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005DE23EA81;
	Tue, 16 Dec 2025 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918976; cv=none; b=V2z0e+CG3ntFIYjgZx/nTA7IIzrNHaCT8xtKv6OPyzsrylaUYUedoy7LL2qGd1DvRjVG7Rv2Uh1O94UEFVibNrMykgUfwsfa+A5aCL8+7cpxaxFz5TV7Tu5yiTgyAoMOyIxJHK8iBlVP6xx+VapOY/k2p0qTG0JAY3FTtxSnzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918976; c=relaxed/simple;
	bh=LxX1wmbYwZRvV0wdlvIynYNP/DpQcV3JcvMK6EecTZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu0zWPsKCNReSumRbzb3DwvtOh4tIcs4g63oxdCMr3M6RhEDf89Wf/MY424xEH3OzbJiUnu4SLAZTnBWhXGB4sHQl3AyFxDpqrg8b2SoJfaETdKyUWhPZN0gD80SACQRjYrf6dxsn3XXob9a5dv8DUzxoWUAN3HmarCLWQB9aaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bHzmUUWe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bHzmUUWe"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGKRxQN1375274;
	Tue, 16 Dec 2025 21:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zC0QyRWAe/u21F6Zq95wkjqwL9lZCo08N+z39MAM7Dw=; b=
	bHzmUUWe2KkaJ3pkNV6ppNFenwVR6yfIMGYduyH47Em14oeM+Dp6ADceJGeZXhso
	ypa3ezq38vPiU6fG9LpYxZP07Oi4r2tJ12cJCn3HUJOM/pIzCLq0g1Zg7zOZVOcb
	35IRxYqCfBy8/2L45sqTbC6yG+d7JFt7e5K7dtmAaja6LdVxWfMbP19M3bXW2xIj
	gqhWXR9u6OpKQQXOaJIMMOUuZwSAVIFhe5QYEGQtuTNMDIlsSqdNkwoxokUSWe79
	/i8S+r15BtSx+K/mzRw+upKRuNUoVNPv4qLubP4Hes0LwkixsDvesATWufoFQ5EP
	JmD1N+SPGKHXVFpy/6E8kQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106ccqjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 21:02:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGKCen9025167;
	Tue, 16 Dec 2025 21:02:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xkayj9s-2;
	Tue, 16 Dec 2025 21:02:49 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: mic@digikod.net, gnoack@google.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] landlock: Document Landlock errata mechanism
Date: Tue, 16 Dec 2025 13:02:43 -0800
Message-ID: <20251216210248.4150777-2-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251216210248.4150777-1-samasth.norway.ananda@oracle.com>
References: <20251216210248.4150777-1-samasth.norway.ananda@oracle.com>
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
 definitions=2025-12-16_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160178
X-Proofpoint-ORIG-GUID: FniN65pK84lOrdqIq2UkXrZ9Mkxk596W
X-Proofpoint-GUID: FniN65pK84lOrdqIq2UkXrZ9Mkxk596W
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=6941c8fa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=qf4gfuq51q0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=sYs3R0SN0e0JAke5c-wA:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE3OCBTYWx0ZWRfX/7pUjz8v54Ye
 jL24ZElPVqE2MQz96VkymeFqzCBPFX4EM5+WO0M7luIhXPHofIa8Rc4uokNZRP2nMw62OKMdfTT
 7u5T119girEEqgPW9ezwBy2a/fCQACs8xIWNHnj8s8MV+wbTf3s8VQKV4OIn3EW7orubpEbBjsA
 RdzU0ZxgMjZwqmbz6aoasS+ezV9BPzn8u+h5VwcQCKpDq4/g7arWX3Cf8eems884GdQSODPU7Q9
 3wuvEsQ8ge6lCDYtIRKZzzJGGSp7M+nvyWVqu2X5wxUclZgFZY7bJAn4s4RuWK0kSzPnHSjzk3p
 utar7ZBPX8f+KdLHZgBPk+iFKS5m1lTkEfg3xMLiHwWrdI1pZo1AIfs9dIZj+YiMaiv/TPwxnmp
 bIiE3sRTsYz7QYYnT8lXjF+1sW6fAg==

Add comprehensive documentation for the Landlock errata mechanism,
including how to query errata using LANDLOCK_CREATE_RULESET_ERRATA
and detailed descriptions of all three existing errata.

Also update the code comment in syscalls.c to remind developers to
update errata documentation when applicable, and update the
documentation date to reflect this new content.

This addresses the gap where the kernel implements errata tracking
but provides no user-facing documentation on how to use it.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 Documentation/userspace-api/landlock.rst | 99 +++++++++++++++++++++++-
 security/landlock/syscalls.c             |  4 +-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index b8caac299056..d1f7dd30395d 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: March 2025
+:Date: December 2025
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -445,6 +445,103 @@ system call:
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
+Known Errata
+~~~~~~~~~~~~
+
+**Erratum 1: TCP socket identification (ABI 4)**
+
+Fixed an issue where IPv4 and IPv6 stream sockets (e.g., SMC, MPTCP, or SCTP)
+were incorrectly restricted by TCP access rights during :manpage:`bind(2)` and
+:manpage:`connect(2)` operations.
+
+*Impact:* In kernels without this fix, using ``LANDLOCK_ACCESS_NET_BIND_TCP``
+or ``LANDLOCK_ACCESS_NET_CONNECT_TCP`` would incorrectly restrict non-TCP
+stream protocols.
+
+*How to check:*
+
+.. code-block:: c
+
+    if (errata & (1 << 0)) {
+        /* Erratum 1 is fixed - TCP restrictions only apply to TCP */
+        /* Safe to use non-TCP stream protocols */
+    }
+
+**Erratum 2: Scoped signal handling (ABI 6)**
+
+Fixed an issue where signal scoping (``LANDLOCK_SCOPE_SIGNAL``) was overly
+restrictive, preventing sandboxed threads from signaling other threads within
+the same process if they belonged to different Landlock domains.
+
+*Impact:* Without this fix, signal scoping could break multi-threaded
+applications that expect threads within the same process to freely signal
+each other, as documented in :manpage:`nptl(7)` and :manpage:`libpsx(3)`.
+
+*How to check:*
+
+.. code-block:: c
+
+    if (errata & (1 << 1)) {
+        /* Erratum 2 is fixed - threads can signal within same process */
+        /* Safe to use LANDLOCK_SCOPE_SIGNAL with multi-threaded apps */
+    }
+
+**Erratum 3: Disconnected directory handling (ABI 1)**
+
+Fixed an issue with disconnected directories that occur when a directory is
+moved outside the scope of a bind mount. The fix ensures that evaluated access
+rights include both those from the disconnected file hierarchy down to its
+filesystem root and those from the related mount point hierarchy.
+
+*Impact:* Without this fix, it was possible to widen access rights through
+rename or link actions involving disconnected directories, potentially
+bypassing ``LANDLOCK_ACCESS_FS_REFER`` restrictions.
+
+*How to check:*
+
+.. code-block:: c
+
+    if (errata & (1 << 2)) {
+        /* Erratum 3 is fixed - disconnected directories handled correctly */
+        /* LANDLOCK_ACCESS_FS_REFER restrictions cannot be bypassed */
+    }
+
+When to Check Errata
+
+Applications should check for specific errata when:
+
+1. Using features that were relaxed or had their behavior changed (like
+   erratum 2 with signal scoping in multi-threaded applications).
+2. Relying on specific security guarantees that may not have been fully
+   enforced in earlier implementations (like erratum 3 with refer restrictions).
+3. Using network restrictions and need to ensure other protocols aren't
+   incorrectly blocked (erratum 1).
+
+Most applications using Landlock's best-effort approach don't need to check
+errata, as the fixes generally make Landlock less restrictive or more correct,
+not more restrictive.
+
 The following kernel interfaces are implicitly supported by the first ABI
 version.  Features only supported from a specific version are explicitly marked
 as such.
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

