Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2022424C;
	Sat,  3 Jan 2026 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767400053; cv=none; b=K1F9m0440HaABs/rTZKGVyGJziYnM8O+Hbd+T6l+0FEGwcEentKsmG9bvnAVAhVZzAdq66PPaBFXYuJ94mSb7SXQrO79R735c96fCYQtgBot7/OSfdpiLOAofQA91m1wBLZkQ8NT0B8l/0dN3G9/wv8jvwPgA/ZJabzWmprBlbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767400053; c=relaxed/simple;
	bh=ArNQ7xWxxyfndThgsOC/SX1TDqoYXpfKdJWur/YeasM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8XHCD3lOE1MCJKKF7M9OhiUpCau2QgL8Y5B/xTjacvvTOhssAB0n6xtNQRcehMvMp9Ls0KfBtgVHXOcK76YrTcXMQIB3LFaO3RSlcjD+D5QwNct/S2ICOEkzmShqlyqL+VMTk6y2G5d5tqhuaJAwZ8GzgyUjQQ9IrhNBvXppGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LdDaW1v3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LdDaW1v3"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602Nn02J4061240;
	Sat, 3 Jan 2026 00:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=S3K0P/IeiwkJc87WUfd1MgK9QAIu1qpNhTVoiwouDgQ=; b=
	LdDaW1v3e8slPh3Mmj9JHz19dvnewGCZ2VXlTVlccJkBD7nShkKjNC5eBpNOTMzq
	oL8DYokNHPUrI9/46Net3HxAy+q2iShtGe5Eu9znQ7H6TLNdTS7ScqiE5oEplhX9
	luH4CBVM8YYiAL+zsyV0M7W7DVgFZ1BbYS99VhJBDg0VKtXGP723cTSkayYSFXlw
	JZn4enJVNZlQgyVEpFnNyyTfUEJDxQwV/rt0laf/FksgWYzEmOya8dDkLeNs+o8Z
	1k7KCEIgcK9INIc4PgfhxsvYUs6rsHr5Swu/KFJ/PwtZ3iWKQNbs8kEQPQenCAe/
	5eYik2SVf1xeM9ePwSyYbw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba6c8wnp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 00:27:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602LDRa5038159;
	Sat, 3 Jan 2026 00:27:26 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wehv77-4;
	Sat, 03 Jan 2026 00:27:25 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: mic@digikod.net, gnoack@google.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] landlock: Document audit blocker field format
Date: Fri,  2 Jan 2026 16:27:15 -0800
Message-ID: <20260103002722.1465371-4-samasth.norway.ananda@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=a4E9NESF c=1 sm=1 tr=0 ts=6958626f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=qf4gfuq51q0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=NzHwe94iyh8aUTu8du8A:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
 cc=ntf awl=host:12110
X-Proofpoint-GUID: 4TRFHbXHuXCs6yyeFoEtBw1hdk08EHYV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDAwMSBTYWx0ZWRfX4ofGgIrOam1N
 CLyxCUABgHS4x1i/F7X+jbX4GwTKuekRvVp0B4hJ/WxS/JtFRxDrj0DCaRIQMfTwRgPDWOBQP+U
 eJh0W8DUytlUUtul0ZjINsFGkd2WMSeljXGQz4HgaM+4D1/BLhUL/6FmIYhxKgchvfKVqru61Jn
 Sjy1IbcY+ArIT0lmI39v+Rqz8IzhWCUNEhpOH3DpeKI76ROe+eOFOh4r4x0tWtIwTfwKwBHB155
 W55Hlg9aAryELjtpNBq28lbZv7aHa9YWWimjXWP3PB6QeXKQDAqqQLhXxmiUedrUMGSi0EulzBH
 is/+zn8hwwZOOgux7/jpsSjFzUywGNFd9X63ql8cJ8g08OOJhVgrqN7vm1xPk3LJHpyzWWEMohH
 EI7GM95tF5Fdqm6ulpx2WoSKNg5iHegZoCouBTj2CurPzGxt1sUeKKI44rT11hmH8enff4biT7D
 Ud5JpMzVwgTYf2svSegKN0UwUYqoCPxyWyYJL82c=
X-Proofpoint-ORIG-GUID: 4TRFHbXHuXCs6yyeFoEtBw1hdk08EHYV

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

