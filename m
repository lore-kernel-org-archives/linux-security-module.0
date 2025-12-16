Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058513C3F2;
	Tue, 16 Dec 2025 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918976; cv=none; b=X01AtuvPzuvepYXbzEEVnxjucu/pHm4XDv+etTOE4d7rBjd0wgBVcgIwoWDsDr/nkA6OFtOlXT2LH2A2QiASx3JKG764YnVqUvccBKh4yjYKQr5dikWocvZjRndvZh7C5wg7ILy+lqB5tj5ymQt2Hqz1x11WtUqMRpRkKP4Hi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918976; c=relaxed/simple;
	bh=NU0dUyyyvri/zGcynVxQyilRuXyqBMZvGvr9Xu9va0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qi2b0QfbtkUQ0DQruu38+ppwJzFHwnX6RSCdd4KfVaqiRbzfKAAojazYhwhi9XWwwYn32+4028XB/JqcFVEaqGXBh+tlZR+02rzwajCThUmSTJYlfRbTn93IXK9kLc4S3U0QAj2UdOIofi+vLJCII920ynYGwe+fA51KwXmWkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YZ5sJOG/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZ5sJOG/"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGKRC0Q1109634;
	Tue, 16 Dec 2025 21:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7QwOR6XekF9MDF0uP+rWvO8Qyw3p+
	UQ9A/5TFHhuaRM=; b=YZ5sJOG/ShHvFXq+flbYDTg1dLSQ8wX4caaY1elvZRQwG
	Hfn4pRHaq4G+ry6CzcHj8TfdursWW9di1JKXbi/+2KyAdwclTE84jg+GD8kUNcJ/
	yoIERoXwcHoKfn22mm8RXY8EdMwR17nQjKygYA0bBGiozdL1i60IKgrRKvKD5mFo
	8rmd53ZjxIqltZAvlyoTxmjvIE50NluLyFyCnmjLdZqHfT8fqJxgQFMwhrj0MYUz
	oeuZXLZEtE6zl60O7jZAKr0LWsJwuxkYwC5YUj5urY2nf6dPCC1chX4NTBvGbIdq
	z92w/MRIDyAi8BHBHrXwcDhyzMcmJHMyurZRMWrcw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja4qsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 21:02:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGKCen8025167;
	Tue, 16 Dec 2025 21:02:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b0xkayj9s-1;
	Tue, 16 Dec 2025 21:02:49 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: mic@digikod.net, gnoack@google.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] landlock: Add missing ABI 7 case in documentation example
Date: Tue, 16 Dec 2025 13:02:42 -0800
Message-ID: <20251216210248.4150777-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160178
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=6941c8fa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=yIbn_jcH5cSfN58x3OYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE3OCBTYWx0ZWRfXyjds/Ah4XQtc
 5XKOSMfX7tuTKEK9M7fGa1W9bzIvTTRCjQL42BFtqduZGzBSk4ZNHGNcGJsI6qzdKFGB10903ew
 NWv1nPQkgtqOvb/gpywhT3WpiSOaRuHVWTkW5b5azeuMmOVVz2gaL3rAXmxRw1br4Len6qxbeEM
 5elvYavucouccLWSCLS/7d1hVzb62XAsBC5z4H2MN+4UKXplMGDL8tsryGTt89e7EmKMQy6O8+/
 cpSWV7oinQ02249K4F2XPwYuczn0ithuCAxFj7zjtUSOthYxEhYdQqk6ayQTuY6Kp5cD4tUUcGy
 FXUXoUOEkOfDGaqdQl+otaRpIGakq9kGGH4CtctyTo4MJsP/ehwGi18r5qOvTqGspyljLuAbvm9
 bY7Mfqvh3jAsoMNYfzC916dwvH1JrA==
X-Proofpoint-ORIG-GUID: -zhJtapVUJ8SoXil0MR6lU50rl06_-w3
X-Proofpoint-GUID: -zhJtapVUJ8SoXil0MR6lU50rl06_-w3

Add the missing case 6 and case 7 handling in the ABI version
compatibility example to properly handle LANDLOCK_RESTRICT_SELF_LOG_*
flags for kernels with ABI < 7.

This introduces the supported_restrict_flags variable which is
initialized with LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON, removed
in case 6 for ABI < 7, and passed to landlock_restrict_self() to
enable logging on supported kernels.

Also fix misleading description of the /usr rule which incorrectly
stated it "only allow[s] reading" when the code actually allows both
reading and executing (LANDLOCK_ACCESS_FS_EXECUTE is included in
allowed_access).

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 Documentation/userspace-api/landlock.rst | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e..b8caac299056 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -97,6 +97,8 @@ version, and only use the available subset of access rights:
 .. code-block:: c
 
     int abi;
+    /* Tracks which landlock_restrict_self() flags are supported */
+    int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
 
     abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
     if (abi < 0) {
@@ -127,6 +129,17 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 6:
+        /*
+         * Removes LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON for ABI < 7.
+         * Note: This modifies supported_restrict_flags, not ruleset_attr,
+         * because logging flags are passed to landlock_restrict_self().
+         */
+        supported_restrict_flags &= ~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+        __attribute__((fallthrough));
+    case 7:
+        break;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -142,8 +155,9 @@ This enables the creation of an inclusive ruleset that will contain our rules.
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
@@ -193,7 +207,7 @@ number for a specific action: HTTPS connections.
 
 The next step is to restrict the current thread from gaining more privileges
 (e.g. through a SUID binary).  We now have a ruleset with the first rule
-allowing read access to ``/usr`` while denying all other handled accesses for
+allowing read and execute access to ``/usr`` while denying all other handled accesses for
 the filesystem, and a second rule allowing HTTPS connections.
 
 .. code-block:: c
@@ -208,7 +222,7 @@ The current thread is now ready to sandbox itself with the ruleset.
 
 .. code-block:: c
 
-    if (landlock_restrict_self(ruleset_fd, 0)) {
+    if (landlock_restrict_self(ruleset_fd, supported_restrict_flags)) {
         perror("Failed to enforce ruleset");
         close(ruleset_fd);
         return 1;
-- 
2.50.1

