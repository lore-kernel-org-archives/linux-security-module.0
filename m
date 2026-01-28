Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7B32D42D;
	Wed, 28 Jan 2026 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570304; cv=none; b=WxSb8/CYMq9qMQWuLRy7k6hmFFVg1acfJN0WrMJ3za8uqNcFsKMVvDIzczdwYjRlmAMVsWG0w6NEbSqPZiNxYDU9LV432LdH5I+yX4+cRvkpzVLNr1e35axJ4yBYEViTpYHPrTdzy/6Wa6DdnFb494poYovTg39B5digijzspfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570304; c=relaxed/simple;
	bh=ArNQ7xWxxyfndThgsOC/SX1TDqoYXpfKdJWur/YeasM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4FIgzneHMajLs5k0gMKmGpBFItZBuAq6BbcuvBqKgYhNko5szbR3fYUBAk5FRz+rG1DcAlP3iCdo23sprpHJ7rEkYPhkb5YOhrDX52i5b2cKTFPlSDcdMNZQPAlvYCDiBcqikCYrGYfSZuweKP8k0wgkZ6QhZuqmg6B9pf6u0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GH0gnOqG; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GH0gnOqG"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RNEVP2566922;
	Wed, 28 Jan 2026 03:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=S3K0P/IeiwkJc87WUfd1MgK9QAIu1qpNhTVoiwouDgQ=; b=
	GH0gnOqGPqtzWJN9Cyv3Knfdyem7Dzk8bnIpp2V4VmkLDP49BkMwydUlxbTDrIcm
	7k7MAeff0tGY4eMEE1CMouMucRNXTJ/S8EBke1gibZLmpXJnBe31LW0n6qDmIsEK
	2ryplerMYLwxmNjRSvw9xnCaiP2Ws//3fsB2wwByg/tZNJjy/vzkQclWWj9pkN0X
	pSM3+fWNXSktPJAnng3Dol/y2FsnnUeFdJYPd+AxM4viRYXKc1qK/rOia9LdD0lQ
	qrsc91ItxKa8jm/dEFXYLp/SgVgnoJLbOwD3v6ac7L0rs0j4JzkhR6s+ElUXFW9E
	kC8XzfwIa7KvIU5cJBZ3xA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5b68c6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 03:18:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S0dLKB035109;
	Wed, 28 Jan 2026 03:18:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhab27x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 03:18:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60S3F1jx004661;
	Wed, 28 Jan 2026 03:18:17 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhab27f-4;
	Wed, 28 Jan 2026 03:18:17 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: gnoack@google.com, mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        samasth.norway.ananda@oracle.com
Subject: [PATCH v3 3/3] landlock: Document audit blocker field format
Date: Tue, 27 Jan 2026 19:18:12 -0800
Message-ID: <20260128031814.2945394-4-samasth.norway.ananda@oracle.com>
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
X-Proofpoint-GUID: KjmpNnUvX5zkMTkVX973rG-ec1hVknfS
X-Authority-Analysis: v=2.4 cv=OLQqHCaB c=1 sm=1 tr=0 ts=69797ffa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=qf4gfuq51q0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=NzHwe94iyh8aUTu8du8A:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-ORIG-GUID: KjmpNnUvX5zkMTkVX973rG-ec1hVknfS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyMiBTYWx0ZWRfX9vpLyRxo6Mn9
 Cn/IoTxscOCj5GInswQm5hZGON1WSrQD8X7Z2Z7sgHUywPkYVjjeGHyVOoJAbTx3tqa3n9Te5F0
 eZYuds9n0nG8HOFK3SQIPyGfF10po6bv5zQd5khiSj2v7bCgNHiiEHvbTOTf7es5qyccprxBJxg
 pzikc1R/U6aerxDtmcceuzOvT1nxRgopUlBNTDpVJvpFRLQpRtVX1KGsWvPGZrSU5rZLRAu2lA/
 iMymHPrOSp/5dptefn/dGluVQje9p71SdKbK8PjN0VKplpYumWF4moBh6wJ1wLpwTe8IVwbh2Lw
 qXUKNlEC8f779XbMOB+/xMJtiwsQeDzKpJj7MrPA6oaII+73xEs/sWCY+q8WXYJFI5Z1tx8ko9b
 tk5Azr/d1sEQZ5ThtvuOwm8HTBtCVKrdodtYAuSDrMNfpUjE9dfRMw/xpl2wrnwDdjTMyiugbhu
 L6EQi95j7C7NwcsFWMQ==

Add comprehensive documentation for the ``blockers`` field format
in AUDIT_LANDLOCK_ACCESS records, including all possible prefixes
(fs., net., scope.) and their meanings.

Also fix a typo and update the documentation date to reflect these
changes.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 Documentation/admin-guide/LSM/landlock.rst | 35 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 9e61607def08..9923874e2156 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -6,7 +6,7 @@ Landlock: system-wide management
 ================================
 
 :Author: Mickaël Salaün
-:Date: March 2025
+:Date: January 2026
 
 Landlock can leverage the audit framework to log events.
 
@@ -38,6 +38,37 @@ AUDIT_LANDLOCK_ACCESS
         domain=195ba459b blockers=fs.refer path="/usr/bin" dev="vda2" ino=351
         domain=195ba459b blockers=fs.make_reg,fs.refer path="/usr/local" dev="vda2" ino=365
 
+
+    The ``blockers`` field uses dot-separated prefixes to indicate the type of
+    restriction that caused the denial:
+
+    **fs.*** - Filesystem access rights (ABI 1+):
+        - fs.execute, fs.write_file, fs.read_file, fs.read_dir
+        - fs.remove_dir, fs.remove_file
+        - fs.make_char, fs.make_dir, fs.make_reg, fs.make_sock
+        - fs.make_fifo, fs.make_block, fs.make_sym
+        - fs.refer (ABI 2+)
+        - fs.truncate (ABI 3+)
+        - fs.ioctl_dev (ABI 5+)
+
+    **net.*** - Network access rights (ABI 4+):
+        - net.bind_tcp - TCP port binding was denied
+        - net.connect_tcp - TCP connection was denied
+
+    **scope.*** - IPC scoping restrictions (ABI 6+):
+        - scope.abstract_unix_socket - Abstract UNIX socket connection denied
+        - scope.signal - Signal sending denied
+
+    Multiple blockers can appear in a single event (comma-separated) when
+    multiple access rights are missing. For example, creating a regular file
+    in a directory that lacks both ``make_reg`` and ``refer`` rights would show
+    ``blockers=fs.make_reg,fs.refer``.
+
+    The object identification fields (path, dev, ino for filesystem; opid,
+    ocomm for signals) depend on the type of access being blocked and provide
+    context about what resource was involved in the denial.
+
+
 AUDIT_LANDLOCK_DOMAIN
     This record type describes the status of a Landlock domain.  The ``status``
     field can be either ``allocated`` or ``deallocated``.
@@ -86,7 +117,7 @@ This command generates two events, each identified with a unique serial
 number following a timestamp (``msg=audit(1729738800.268:30)``).  The first
 event (serial ``30``) contains 4 records.  The first record
 (``type=LANDLOCK_ACCESS``) shows an access denied by the domain `1a6fdc66f`.
-The cause of this denial is signal scopping restriction
+The cause of this denial is signal scoping restriction
 (``blockers=scope.signal``).  The process that would have receive this signal
 is the init process (``opid=1 ocomm="systemd"``).
 
-- 
2.50.1

