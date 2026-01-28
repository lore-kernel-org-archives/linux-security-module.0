Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF332C92B;
	Wed, 28 Jan 2026 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570303; cv=none; b=ITUXE43Z7fF2CGiC9/4w1A0D9XNaVwfnmEUXvOCNp+sKhAfDbamt33qfvhAgv9g+fnen1hMr0XM8xGc/Rp6RNtyvo+sgqLSSzuJXGex/PAKjFBX9fBWZK1PcwRaT/17REcqN4QlSHSeutgOkokzaZXuXhhL+x7Stnmu2rhKM0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570303; c=relaxed/simple;
	bh=Qf/2TS2of/nkAOMks3tpncweSRTTuD/9x6Pk744h8R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R18oWqozJ6IDSc/a3RtJrkoHrOd1J7fz3U6SkxyePbZ3nzjZQalHM5uhYkKPzjoNxuGBIPTcIgDQ1gUO0UEaquivhNfwUU/ZEMmo3PtLAZV7U7bEdAnGVs/bR+mgvQbQkSlOvtuu6dtqKFrnu/dwq4RaCTN91PTg/pGMhty123I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P0yw8aIk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P0yw8aIk"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RNEREd566918;
	Wed, 28 Jan 2026 03:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=eUU6O38wzhWbaEouVv0IddK5sWsQH
	PiMCm9vJ0wjp/s=; b=P0yw8aIkGrDC0T21RPjweQw2GDkg4csexiwZe4UKaUlC3
	vY4WvUKWCGvlrINtR/DCQzY6U+Q96BwsklpY3odisO4jPhvshbHwFiaOBgkPJM41
	1oLXSl6c56XgqLhn7qcj3aCyehT1CESVG95sNaUHc1wg64/hC+ObeRnZSUAdTqvY
	vL9iz/I7UzphOkBiTj6SCM7rR9CGdP7QeFadbRV2G1/m4hgwCqGN+ZQb4YytdhEz
	UTIkUQPG5lzbpt1/28DJO0Oqe2cxTsg001ZKQH00zhi9KAsGT/0+UC6v0bQlHUcN
	DfT8YbGHAWkg0Kk6uyLhmNvIOBv4NNsTRzuMVey1w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5b68c6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 03:18:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S14apB032693;
	Wed, 28 Jan 2026 03:18:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhab27m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 03:18:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60S3F1jr004661;
	Wed, 28 Jan 2026 03:18:15 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhab27f-1;
	Wed, 28 Jan 2026 03:18:15 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: gnoack@google.com, mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        samasth.norway.ananda@oracle.com
Subject: [PATCH v3 0/3] landlock: documentation improvements
Date: Tue, 27 Jan 2026 19:18:09 -0800
Message-ID: <20260128031814.2945394-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=963
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280023
X-Proofpoint-GUID: mkaYQO0N_nYA3Bfc18YythK7WyY8Oodm
X-Authority-Analysis: v=2.4 cv=OLQqHCaB c=1 sm=1 tr=0 ts=69797ff8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=b_9QdsMtNgtwmMDE4PsA:9
X-Proofpoint-ORIG-GUID: mkaYQO0N_nYA3Bfc18YythK7WyY8Oodm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyMiBTYWx0ZWRfX/HN43D4AwFuP
 f7Mo2U3CpwBpo3vjPgH0gsXqGfuajUhkvkN40XlB1bDB7iGwKxhUHA+sA4ZETfvrQo2/dhin3IH
 LcJaSh/UEg3OiuMikkJsOVitXTbqNSZtdB2V64udIw0eLJvV7fnl0M8rZhzpg1e/DM10cVFIASt
 ohkB0D5uZo2lRQZnVqdgMf0Q49vChQnP2lkVI2FLPN21KcKdlWTa16WA8W3QH3vUGhKXZfzAocO
 b8I1LgdHRQSu8rXkFggFPEBUYDodrfCaaHvyoou2w58LBJ8DrSgUGbXwyYj48Nu06XeiY9fiaDv
 kybImzv/RktpSRKfwWLLoa7AG4+6ZIKnMnsMipJmYfvBbVKAhTj2PAFrMwH7i4rIL7FdgA9sONP
 hlC9zfZ/RsWqfyv34MniihYhIQPu7wxzia2IsNZe58JWXAf99S1RvWSBMkkaIYUnBo8litBKJ02
 wvljouTJYbOT/V5F+Bg==

This patch series improves Landlock documentation by addressing gaps in
ABI compatibility examples, adding errata documentation, and documenting
the audit blockers field format.

Changes since v2:
=================

Patch 1/3:
- Handle restrict_flags in a separate code block, not in the switch
- Clear all three ABI v7 logging flags for a generic example
- Reference sys_landlock_restrict_self() for available flags
- Use restrict_flags in landlock_restrict_self()

Patch 2/3:
- Use kernel-doc directives to include errata from header files
- Move rephrased ABI version text before errata section

Patch 3/3:
- No changes

Changes since v1:
=================

Patch 1/3:
- Add backwards compatibility section for restrict flags
- Fix /usr rule description

Patch 2/3:
- Enhance existing DOC sections with Impact descriptions
- Add errata usage documentation

Patch 3/3:
- Document audit blocker field format

Samasth Norway Ananda (3):
  landlock: add backwards compatibility for restrict flags
  landlock: add errata documentation section
  landlock: document audit blockers field format

 Documentation/admin-guide/LSM/landlock.rst | 20 ++++-
 Documentation/userspace-api/landlock.rst   | 97 +++++++++++++++++++---
 security/landlock/errata/abi-1.h           |  8 ++
 security/landlock/errata/abi-4.h           |  7 ++
 security/landlock/errata/abi-6.h           | 10 +++
 security/landlock/syscalls.c               |  4 +-
 6 files changed, 131 insertions(+), 15 deletions(-)

-- 
2.50.1

