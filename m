Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692295;
	b=t2kCITogx1JILkCLFThDKbmskcxP/sA7Ni4qscuVa3KJ9Q0PF95PtUAGy4mRClyYyfZH
	 H8D65cNkXT3uRHWPFIvco7OiCh6r1dbxlbUpMzbhgCqGJ5QAENwTxK73T6Lc+kQtCyEaM
	 r86mt2mUO4YbR+9OYXta4HqBMh5uY/fD6vZu7rCpjWCPhY8Pli0jOrntChV5FGibEr1xL
	 m2h021LNd4sbGVqqCke80Gs+JjcRSFeBIKLna2djzsr/1PMBsVpypFFc4iHzsE75jZibj
	 BdMJrWVQeq/w4Zl2sSF8jd8Bq1AkmXgLxJw/gXUP4q5PMlTpOZN6OW0dhsQGIRIGMpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692295;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=i4FRcqlBkKrERcX6LVE6bfkkzsZUFWTaKDF/GtJ2zvU=;
	b=A5AH0Zm6AaU8rtyHTfySIJO4XLdYrPqUJEHLuOA1GFbQ+jtP7dd3+F6axeMV6yP7CSjl
	 SSLZzCaYyp2r3bfflIm9bp/qSABTen0MH1H/dXEFferyRAxt5nsEtxdXzohPPvjbUykIJ
	 i76QGwTITYw8bpP2vZIIjJH6sGEoCYiABS0cwYWvUHnG0xnB7k1MnWewKlSEreesUYmzy
	 crNI8c6gNeZMcb6xDro75MyQf/TCIC0rG+kB9lG0Y84hBTDLdWEXn7fTv0ytteXYXGmIa
	 H+N1KxaZZnysx5m2CO8wsquRcVueqtfY51Qke/FBOnFVAuTbZg1netZJHLtsSpPBVmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rpEsjF5Q;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE25606D825;
	Tue,  3 Nov 2026 07:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE25606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rpEsjF5Q
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i4FRcqlBkKrERcX6LVE6bfkkzsZUFWTaKDF/GtJ2zvU=;
	b=rpEsjF5QczRhKBY+ehfn1H9Yzuez1IjYCW/ZZrzhAj7X1nsUoWgsOQlHQD5ekVuQHF/zhZd9T
	p4omz5pjWT/2AFn9ffiVVjrbToXTfxAMMwAisYHew5su0c58wCW4opIqhaW6re2xyvlReZ/cs2o
	5LelcGQa0OlzG69jS4jpVlw=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jJgkK0sqYz1K9X7;
	Tue,  3 Nov 2026 15:51:21 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A69B40561;
	Tue,  3 Nov 2026 15:51:25 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:51:24 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next 8/9] Documentation/ABI: document the lockdown securityfs file
Date: Tue, 3 Nov 2026 16:24:20 +0800
Message-ID: <20261103082421.3033195-9-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261103082421.3033195-1-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100010.china.huawei.com (7.152.184.41)

Describe the /sys/kernel/security/lockdown interface: the levels it
reports, how the active level is marked, when the file is present, and
the write semantics (escalation only, EPERM for the current or a lower
level, EINVAL for an unknown level).

Also add the new ABI file to the LOCKDOWN SECURITY MODULE entry in
MAINTAINERS.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 Documentation/ABI/testing/securityfs-lockdown | 41 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/ABI/testing/securityfs-lockdown

diff --git a/Documentation/ABI/testing/securityfs-lockdown b/Documentation/ABI/testing/securityfs-lockdown
new file mode 100644
index 000000000000..490dc607492c
--- /dev/null
+++ b/Documentation/ABI/testing/securityfs-lockdown
@@ -0,0 +1,41 @@
+What:		/sys/kernel/security/lockdown
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	linux-security-module@vger.kernel.org
+Description:
+		The lockdown securityfs file reports and controls the
+		lockdown state of the running kernel.  It is provided by
+		the lockdown LSM and is located at
+		/sys/kernel/security/lockdown.
+
+		The file is present only when CONFIG_SECURITY_LOCKDOWN_LSM is
+		enabled and the lockdown LSM is active: either
+		CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set, or the LSM is
+		listed in the "lsm=" kernel parameter.  Otherwise the node
+		is absent, and userspace must handle its absence.
+
+		Reading the file returns the supported lockdown levels,
+		with the currently active level enclosed in square
+		brackets.  For example, when the kernel is not locked
+		down::
+
+		  [none] integrity confidentiality
+
+		and when the kernel is in integrity mode::
+
+		  none [integrity] confidentiality
+
+		The file may be written with the name of a level to lock
+		the kernel down further.  Lockdown can only be escalated,
+		never relaxed, so writing the currently active level or a
+		lower level fails with EPERM.  Writing an unrecognized
+		level fails with EINVAL.  Successful writes return the
+		number of bytes written.
+
+		The kernel can also be locked down at boot time with the
+		"lockdown=" kernel parameter, or unconditionally at build
+		time via CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY or
+		CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY.
+
+Users:		fwupd and other userspace tools that query or manage
+		kernel lockdown state
diff --git a/MAINTAINERS b/MAINTAINERS
index aaf2825ac945..38ff3797f2cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15621,6 +15621,7 @@ M:	Xiu Jianfeng <xiujianfeng@huawei.com>
 L:	linux-security-module@vger.kernel.org
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
+F:	Documentation/ABI/testing/securityfs-lockdown
 F:	security/lockdown/
 
 LOCKING PRIMITIVES
-- 
2.18.0.huawei.25

