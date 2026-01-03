Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5292236F2;
	Sat,  3 Jan 2026 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767400053; cv=none; b=eWPwuap9nqK0yzk8ltJdJC4U71aZWIGptPLWC/jX0yTRuotXviFs+o5NqYTDzrczIn3UICCjaMHoSqUE/PzcfDXjFfHJdUsiOK3cncSKnKICjEwElknpcH+TywqKt8Vx1X/UI1V9PQcEg7vkocHYIKkLsK1AzMPPJocjk9pl1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767400053; c=relaxed/simple;
	bh=QNqPWnRO7HxSe4Mj3rDx/0Yy4sa+s45bs5JGqgDhlpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucn0Wv6VYWsvSsE5w9kzAGbDqYCTDg/bCdAGb/p/QePgW/+YYPX5+0INNetk5URPQaW6llqnon3BddmiYoE1eNfRS4bNrvdLakr10az5EoX1vTAq+jy2fLGLUg8/tSv9GoxmZ6pI7d/eIWlEJp2TqiGMzaPHN5OYeyl7u+MCLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eWBrLYHn; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWBrLYHn"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602M7KOD4025268;
	Sat, 3 Jan 2026 00:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=r2dTL1Ro6XhvD0XXAjztsY1m44w4i
	KxF2EiSUhRl6NM=; b=eWBrLYHnnWnypdwEjhxunBGv+r+a3qC24X6EzuR2O/QjK
	q6UG1nGdPMj0DjtOQbGk2lsZGazIamuEEY+0AdD8n3V8XYnBQKyvq87MzR/xje0F
	AbhyzKSmMMbjMAL8yNKbeechgcwnKi9eUOBGyblQ/W1j9i0GB8Kxyu5igWvn8FKX
	c+6A7lZgpcvq+EX8hqmj6lQ7Xyah7V+UcGaM7s7vKN1xbJlW9GmMm10RSoZLpi45
	xgxHEaS3dOI9FtzaGBNNhldfRPOfAWwB5Mu87i+jfvzJyBKPgKV7w5c8M3Lue10V
	u8QP+IjbnA+wBOsBUykG9zKeCj3Fn+nci5UR6mLxQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba7b5nk94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Jan 2026 00:27:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602LDRa2038159;
	Sat, 3 Jan 2026 00:27:23 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wehv77-1;
	Sat, 03 Jan 2026 00:27:23 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: mic@digikod.net, gnoack@google.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] landlock: Documentation improvements
Date: Fri,  2 Jan 2026 16:27:12 -0800
Message-ID: <20260103002722.1465371-1-samasth.norway.ananda@oracle.com>
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
 definitions=2026-01-02_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=727 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601030002
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAzMDAwMiBTYWx0ZWRfX/bOo5PdC5KcF
 e9Mlmq+pa5e+jlB6ChVnrFjwUhNGOvMLdk1suvfP+5tXeeWiv8+HCS64UHRLrK52KQykKMtLdq6
 5xxsYs/0fdAOn1AVUupUa6fd36y72G/WY7vKOtalc5H+IQVKSVI4sZbx6o39eRK7ffQScSaqnsW
 dutZZFBK7GDOSOSIlMMhu7R2fWVnWupuM5qNGu48UyIS+RuXWm4qlZnx/2ZrgNMrjyJSe3NPOUd
 GN6DEJ376JjZjsilaPCnEM9wAPLHResEQhxxwS4IT8atcTMb1AlfLnPxMiS4w2WXTqaLYoLZjjW
 hd/pH1A8wrYKNJI22axMcLAcWFZCdi8UVLdGHDJBW6uW2KyxwUZP31esob79y1YIYbLW2Ul617T
 610UU2y55I0RFVLjtzVVVxXQUvHMwKW07W0/NYFqC99Z65tiAzELa/ORoblwEtVkF3d70edGqMe
 aLWyXXQFQRQzYKosSqLVdo+/n+PZVbPmK3P/UfEI=
X-Proofpoint-GUID: 6-CiwY0cJKFPHt_NvDh3-Vu7FeVq409Y
X-Authority-Analysis: v=2.4 cv=ccjfb3DM c=1 sm=1 tr=0 ts=6958626c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=y6hInx5jj_STmL3gDEIA:9
 a=ZXulRonScM0A:10 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: 6-CiwY0cJKFPHt_NvDh3-Vu7FeVq409Y

This series improves Landlock documentation to address gaps in ABI
compatibility handling, errata documentation, and audit field formats.

Changes since v1:
Patch 1: Add backwards compatibility section for restrict flags, fix
         /usr rule description.
Patch 2: Enhance existing DOC sections with Impact descriptions, add
         errata usage documentation.
Patch 3: Document audit blocker field format.

Samasth Norway Ananda (3):
  landlock: Add missing ABI 7 case in documentation example
  landlock: Add comprehensive errata documentation
  landlock: Document audit blocker field format

 Documentation/admin-guide/LSM/landlock.rst | 35 +++++++-
 Documentation/userspace-api/landlock.rst   | 95 ++++++++++++++++++++--
 security/landlock/errata/abi-1.h           |  8 ++
 security/landlock/errata/abi-4.h           |  7 ++
 security/landlock/errata/abi-6.h           | 10 +++
 security/landlock/syscalls.c               |  4 +-
 6 files changed, 151 insertions(+), 8 deletions(-)

-- 
2.50.1

