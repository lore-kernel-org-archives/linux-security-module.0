Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FCD22129B;
	Sat,  3 Jan 2026 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767400052; cv=none; b=byOXG4UGNvYUYVpzmZGaGh31xZbVjmLqj33TvmTB7nzIiSfNkw8tXAL+KR/ABP2/BD2xp2E/c3+TcdCin0D//mrCh4PqCIBSLiU5R2daX8gvG5tZ+uUKBqpQpBeNI2H9EaL8f7z5UYAWrE2eCXsL9ZR2Jhkr6qLqrtiEURJxdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767400052; c=relaxed/simple;
	bh=sm3mq+1RZvaj7ftuG5YIqF2ejCmTPm3XMbIJ+n2Earw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEVRIydnSPn9a2YDMbGST3onlUWeY/9sOFI/N8Ada9GQx4IFSs+SBUXK6X75KvdSLgCgqSbk9nwWIUJKb/FY21x60fF3pRhjsmhStblmk6hSEZi0dRQN+pVEoxBM9twsn3zKprr+HFkhF7qnss0XDhWpIqbI1A9lyIImZjQy8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nYBeZdnd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYBeZdnd"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602LvH4n4011699;
	Sat, 3 Jan 2026 00:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=owDt2
	Q921Zk3j4Ahzru+gwg5Pudv1ZKrTaetQQ+KAaw=; b=nYBeZdnd0oRkCJmYurjDW
	mpNCXM27pnOjvpVmopdDLyDP7/JSsbhgS/S3/5eEokjv9yUDpletRm7j4GSR8Iro
	WaGDkvSvuiWVUrFANDHQHw4p+ih96vZiXSyZstVPzwnaCu+xf885G3/9v81LDyc2
	16dWM3ofr0sHA+ZGpcP/K1mr5t88rP+qlZQryvBzuM2dEtLtzM5AMkY+TdE89LkH
	/Os+ZLxs0wnM827uTLR7K+mrcwJ3ZpjpaVXTv/XpLx18o15PbWlAL07tStD2asyV
	qeUqX7wZmswjZ3osCKoYcGQ/J7mrzRfgjCeWNHVLb4QqN7Sgt/dkxnEXiTJb3rie
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba72qnja2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 00:27:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602LDRa3038159;
	Sat, 3 Jan 2026 00:27:24 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wehv77-2;
	Sat, 03 Jan 2026 00:27:24 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: mic@digikod.net, gnoack@google.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] landlock: Add missing ABI 7 case in documentation example
Date: Fri,  2 Jan 2026 16:27:13 -0800
Message-ID: <20260103002722.1465371-2-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260103002722.1465371-1-samasth.norway.ananda@oracle.com>
References: <20260103002722.1465371-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601030002
X-Proofpoint-GUID: TmiZg1qS2LoMVoH7CRjfvRsQ08D3Cv3b
X-Authority-Analysis: v=2.4 cv=MqBfKmae c=1 sm=1 tr=0 ts=6958626d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ViO5ekZS-PzAqOllsYIA:9 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: TmiZg1qS2LoMVoH7CRjfvRsQ08D3Cv3b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDAwMiBTYWx0ZWRfXyLht/+jbjrxy
 FolrmkOzVNad6J058dQoLYBwKTYLV+pscPbODzv6/mQl3d3ert6AHQnZLU0qYVmhm2GE6RonO30
 heQNk5O6W+B90ytFxAKkcmyibWuvR47AtfCxAvtTV0WqGU9wCAEPGOPQhCgzDiUkVJKpF/GVRxN
 CoVHKgamGvwgqlSpO1iUfEblVxsa8XEghufcJOUKCcfolSXA9Ib/wSX/cTHQ2syCVbHq8BfHuBW
 ZZVTrDm5gJNMHiO+DNJ4kydnmtuthb9JmOl58TuW/iVPvKV1d/sX2lrL3DDgLNoC7G8SIwNWkCx
 yBnAkpL8pafrSM4FD1P9KGDg9kShqCbhn5+iaoV9R4h2Nifn2VvEpMDaxe7bQ3qYNMk+7OvP1Xx
 hWdkV2AG0Kx3HtmFqZPfrKc7ZZNaFvqctmfY/+G0kd+eoAgrurXmCILSCKGt86iXpyvGLgIks8w
 M2jrDFNv5sJ9L1MW/UBvDn3+UMnxDUyqaE/u4HkY=

Add the missing case 6 and case 7 handling in the ABI version
compatibility example to properly handle ABI < 7 kernels.

Add an optional backwards compatibility section for restrict flags
between the case analysis and landlock_restrict_self() call. The main
tutorial example remains unchanged with
landlock_restrict_self(ruleset_fd, 0) to keep it simple for users who
don't need logging flags.

Also fix misleading description of the /usr rule which incorrectly
stated it "only allow[s] reading" when the code actually allows both
reading and executing (LANDLOCK_ACCESS_FS_EXECUTE is included in
allowed_access).

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 Documentation/userspace-api/landlock.rst | 35 +++++++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e..650c7b368561 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -127,6 +127,12 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 6:
+        /* Removes logging flags for ABI < 7 */
+        __attribute__((fallthrough));
+    case 7:
+        break;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -142,8 +148,9 @@ This enables the creation of an inclusive ruleset that will contain our rules.
     }
 
 We can now add a new rule to this ruleset thanks to the returned file
-descriptor referring to this ruleset.  The rule will only allow reading the
-file hierarchy ``/usr``.  Without another rule, write actions would then be
+descriptor referring to this ruleset.  The rule will allow reading and
+executing files in the ``/usr`` hierarchy.  Without another rule, write actions
+and other operations (make_dir, remove_file, etc.) would then be
 denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
 ``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with this file
 descriptor.
@@ -191,10 +198,30 @@ number for a specific action: HTTPS connections.
     err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
                             &net_port, 0);
 
+Backwards compatibility for restrict flags
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, the
+following backwards compatibility check needs to be taken into account:
+
+.. code-block:: c
+
+    /*
+     * Desired restriction flags, see ABI version section above.
+     * This value is only an example and differs by use case.
+     */
+    int restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+    if (abi < 7) {
+        /* Clear logging flags unsupported in ABI < 7 */
+        restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+                           LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
+                           LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
+    }
+
 The next step is to restrict the current thread from gaining more privileges
 (e.g. through a SUID binary).  We now have a ruleset with the first rule
-allowing read access to ``/usr`` while denying all other handled accesses for
-the filesystem, and a second rule allowing HTTPS connections.
+allowing read and execute access to ``/usr`` while denying all other handled
+accesses for the filesystem, and a second rule allowing HTTPS connections.
 
 .. code-block:: c
 
-- 
2.50.1

