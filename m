Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AB29A307;
	Tue, 16 Dec 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918976; cv=none; b=Pid6G6Y0Obf9pIBtM4vcmzLiSUCmCoA58d7rAuhJinORPdahkjfV/jP7IAVnxJy8X7lpPF92Ydrh57QYAym1GUOGI1JtMbwWzqiv/mek0/MpqYr3wIg6Z1vSXdIeqNMXUr+ig8cOroLUiVlkWoPdZvHIldWVKLkRiRTSdlKmMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918976; c=relaxed/simple;
	bh=71A+NTPgfG1bQBRx+ka8naZ66EiYBKrTAI1lRcq2RXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqbSV9tFqzBLtZoCJUxgAB2zR7oBg0QLNfwPxToPRKRODGlnxxu3WjLPWBeRr+BdE3vJ/uEJxAMOyvF0ZDcKSBR9M/yhQ6rSjq0xRy7cpAGvFkFxWJ9FfDIns+Jm3sV4jft04kcfZyugEStPQuSvalFsKPHUiBKp8RmljYbR67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e7Fz+nDU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e7Fz+nDU"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGKRAZN1172040;
	Tue, 16 Dec 2025 21:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kIHTRKnnIegAuLtqcUcVWp245tdnEB7uULdHZ0HKGGI=; b=
	e7Fz+nDUWonsnI39crkr+JfzGt7etDJnaKjey3ZPw/9CT5fgAIifbyMQGjRoEzJj
	qTMXd7DOkVSQ4RtcLbdUFzNNyNSQ4/SVbiumVXsgGYSkAELDV8kq9vbskP+XSgcb
	q02ZDtzjqa9K0RhQ/sTK3p1m3zcBNlsCtu88Py8FTJo7BgoVco4uwtpUdsyMGkL5
	0MaEY7oFAl86C+I1BSq4orCtqSSP/hfSM/r/aCqF0ErloGFuFfS/3Bj9xZwUMLLq
	raiTqIOMOkrBbj0xZWan/XoIyb0n2zGwlbLGbAvIsPHdyjTGSL3SkVs5s/wZ4TMO
	Z60vC3lGFtmpR8GQI/PuDQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yrumnqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 21:02:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGKCenA025167;
	Tue, 16 Dec 2025 21:02:50 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xkayj9s-3;
	Tue, 16 Dec 2025 21:02:50 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: mic@digikod.net, gnoack@google.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] landlock: Document audit blocker field format
Date: Tue, 16 Dec 2025 13:02:44 -0800
Message-ID: <20251216210248.4150777-3-samasth.norway.ananda@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE3OCBTYWx0ZWRfX9SoisHSTfpIo
 4s9c6AwN88gcCNX15oo/tWeHMcClsOmiVnm7qL0bE83sRwF/RXscVEHcWIhxbQDeVDjAG9LLkOc
 StFmvt7Svw7bJz8x5aMFhlUV9JMgwIFUAwVVSX5YW34IiG4l+Tg0ngRtzcv68OAzEc6LUbwckzd
 m96DG5ZSrXGSA4E3/27crO9cMTQdtaK76ft7u5Gc5IA8M40kkkRNMenKgKviUW2AcW7+MI5BIqF
 8jDaVPHNTmpy59gZG+fjQDKcCCoene0ATXAPXDmczeLe0agEBiuOjIkeAO4kS1dIgYct7lZ17i0
 RGPONf70xAnZUPF9CRf0KNv81NVJErLLgVaobQDziucw7FL/poMcvIlhq+AkYWoNRiI1koqwZDC
 beN3zBNThLq8QYXCZPhxD+wi1W4L6Q==
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=6941c8fb cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=qf4gfuq51q0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=NzHwe94iyh8aUTu8du8A:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-GUID: wOjmz8dTKNquudcJsn5PEIemc1zv1dEK
X-Proofpoint-ORIG-GUID: wOjmz8dTKNquudcJsn5PEIemc1zv1dEK

Add comprehensive documentation for the ``blockers`` field format
in AUDIT_LANDLOCK_ACCESS records, including all possible prefixes
(fs., net., scope.) and their meanings.

Also fix a typo and update the documentation date to reflect these
changes.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 Documentation/admin-guide/LSM/landlock.rst | 34 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 9e61607def08..f1ea67cff9da 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -6,7 +6,7 @@ Landlock: system-wide management
 ================================
 
 :Author: Mickaël Salaün
-:Date: March 2025
+:Date: December 2025
 
 Landlock can leverage the audit framework to log events.
 
@@ -38,6 +38,36 @@ AUDIT_LANDLOCK_ACCESS
         domain=195ba459b blockers=fs.refer path="/usr/bin" dev="vda2" ino=351
         domain=195ba459b blockers=fs.make_reg,fs.refer path="/usr/local" dev="vda2" ino=365
 
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
@@ -86,7 +116,7 @@ This command generates two events, each identified with a unique serial
 number following a timestamp (``msg=audit(1729738800.268:30)``).  The first
 event (serial ``30``) contains 4 records.  The first record
 (``type=LANDLOCK_ACCESS``) shows an access denied by the domain `1a6fdc66f`.
-The cause of this denial is signal scopping restriction
+The cause of this denial is signal scoping restriction
 (``blockers=scope.signal``).  The process that would have receive this signal
 is the init process (``opid=1 ocomm="systemd"``).
 
-- 
2.50.1

