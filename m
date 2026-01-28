Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B78328B5F;
	Wed, 28 Jan 2026 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570303; cv=none; b=qXyNvK5bkTIvbMUKGozYCaEJY425rKwqpVizmth6g6nU//qE4g+9q9VanL+n10ND53n1mDNt5iCRrnhJ60MibByKRlB7CX/iHo4U7pYV41ZnWUcPlZOMpN1XI2l89X1SUL8wmTmZqd0xYkZT0iT+gDfQ/MP7gxY5G8nthxWu/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570303; c=relaxed/simple;
	bh=sYem6BCmg+O1UrfPj/dfPEXtO1i2FVbWz6SOKuUpx2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DesrpSMWDR4v28leIKKmH/JQv2fbcBXIUZTAxWw3Fvg1vgTWwmDB/JDVKSanhYouBT04KObRDyg8j/Psu465n8wwHasXjOaNxWOyFjrWswnsSjoEdKOG7zd7/ukjpYG8I2EIZn9GxVf7VuPrA5eMEgu4d5247DSZyNTvvzpZipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AOTvT5FL; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AOTvT5FL"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RNEMes1081475;
	Wed, 28 Jan 2026 03:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3b31t
	n2JyTaa0iz9PwKfJ7R/tSTIpb/PUjxbecd50aY=; b=AOTvT5FL15/vD33FJQxHV
	DtYJQqEtgPcvfLVygglwHUD/qgSjjGSTBrjBwzMO0bK3yH6l5bECpHC7WRvVRdKX
	iiU8oYreGMX4KLJY2Rzgiok2uo2Wcg39jNiFjtUqoCKdVxJTpgMNgyH93eDeT7A5
	M5UHQVXf2F8U0kDKz16tMMvaP7VqtbBqlpwje1v/A9P/M4EIbvsiyt2ul5RiATwF
	0kU6QT3BKnd5pU+qnlJci0NpWwug7retyRn+2DB/+skNkJ0H4M0YijYgGO9gAmb2
	+9TVLPDJBLVCqZd/1d1wBvt0gGUFVl8BehLB0/tMCZ2N3BFfUbQmP7zOTAPUqtJ2
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by2vggq4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 03:18:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S13b9a035192;
	Wed, 28 Jan 2026 03:18:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhab27r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 03:18:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60S3F1jt004661;
	Wed, 28 Jan 2026 03:18:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhab27f-2;
	Wed, 28 Jan 2026 03:18:16 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: gnoack@google.com, mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        samasth.norway.ananda@oracle.com
Subject: [PATCH v3 1/3] landlock: add backwards compatibility for restrict flags
Date: Tue, 27 Jan 2026 19:18:10 -0800
Message-ID: <20260128031814.2945394-2-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260128031814.2945394-1-samasth.norway.ananda@oracle.com>
References: <20260128031814.2945394-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280023
X-Proofpoint-GUID: Vn-XL_DVy1CPUw1SEcubJAYJQO7TOVg8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyMiBTYWx0ZWRfX+2dJiHvxRf6X
 oOVN5H1zhENDJhBm64VXYwHyqITQYtML9lfSuOLOT9uvx8ZOTG1ziKmiJ3B8XY5HnrwkiaeM22n
 ddlTkqIK9kTvjrcG37vuqT7QlKs4PlRnFNEG03liyJkMQ1pr56neFKe0njNVGTG6drGr7AIbNzV
 FdAI4c85r8QKdyvJFWR/cZYcg/qMiWrzsxyjenxJGICTQA4qmJx+udMtZ35aOaJteA0jI/EujWa
 2/un4x2YKDxpJRxBLJ6WP/ve+NWXta4HWmHB3+efVlsw0TaGZrqYkfH5lCtNXF+mLnM4CBMcCsj
 /KLjKGvZ0czPGgKyWkv3XR1R1fHk/UZSu99VJc2lQf8BPX2M1wQ/BIXo9F8OZwRPDZwXMfAv+Dx
 zBTIvBFu9u5ufhoCnCU/ZovOHSfz51SKF7IxU5obfjqBhV+Si5VvZYSZbRGtsXZNBA1AaChBjzS
 UXXsTaKrivZJKCzzlEg==
X-Proofpoint-ORIG-GUID: Vn-XL_DVy1CPUw1SEcubJAYJQO7TOVg8
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=69797ff9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=1PNCW3Dr_-8M693FBv4A:9

Add backwards compatibility handling for the restrict flags introduced
in ABI version 7. This is shown as a separate code block (similar to
the ruleset_attr handling in the switch statement) because restrict flags
are passed to landlock_restrict_self() rather than being part of the
ruleset attributes.

Also fix misleading description of the /usr rule which incorrectly
stated it "only allow[s] reading" when the code actually allows both
reading and executing (LANDLOCK_ACCESS_FS_EXECUTE is included in
allowed_access).

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 Documentation/userspace-api/landlock.rst | 30 +++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1ed25af0499f..c8ef1392a0c7 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -157,11 +157,11 @@ This enables the creation of an inclusive ruleset that will contain our rules.
     }
 
 We can now add a new rule to this ruleset thanks to the returned file
-descriptor referring to this ruleset.  The rule will only allow reading the
-file hierarchy ``/usr``.  Without another rule, write actions would then be
-denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
-``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with this file
-descriptor.
+descriptor referring to this ruleset.  The rule will allow reading and
+executing the file hierarchy ``/usr``.  Without another rule, write actions
+would then be denied by the ruleset.  To add ``/usr`` to the ruleset, we open
+it with the ``O_PATH`` flag and fill the &struct landlock_path_beneath_attr with
+this file descriptor.
 
 .. code-block:: c
 
@@ -233,10 +233,24 @@ to effectively block sending UDP datagrams to arbitrary ports.
         err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
                                 &net_port, 0);
 
+When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, a
+similar backwards compatibility check is needed for the restrict flags
+(see sys_landlock_restrict_self() documentation for available flags):
+
+.. code-block:: c
+
+    __u32 restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+    if (abi < 7) {
+        /* Clear logging flags unsupported before ABI 7. */
+        restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+                            LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
+                            LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
+    }
+
 The next step is to restrict the current thread from gaining more privileges
 (e.g. through a SUID binary).  We now have a ruleset with the first rule
-allowing read access to ``/usr`` while denying all other handled accesses for
-the filesystem, and two more rules allowing DNS queries.
+allowing read and execute access to ``/usr`` while denying all other handled
+accesses for the filesystem, and two more rules allowing DNS queries.
 
 .. code-block:: c
 
@@ -250,7 +264,7 @@ The current thread is now ready to sandbox itself with the ruleset.
 
 .. code-block:: c
 
-    if (landlock_restrict_self(ruleset_fd, 0)) {
+    if (landlock_restrict_self(ruleset_fd, restrict_flags)) {
         perror("Failed to enforce ruleset");
         close(ruleset_fd);
         return 1;
-- 
2.50.1

