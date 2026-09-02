Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6884A8A2E;
	Wed,  2 Sep 2026 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363113; cv=none; b=DkvBaH4cVulIZoq3yd/H60Hvkc6s164mBQHaordQ3SAc3qAiVRdeFlsI4S9dLrdpHgPDq4+SkGZYGjrTDK7QxfAwOtiCgdncsMGpwBf6qjf/mYQvL5etLo5l+QApMWKU0mwhLaRBtHfztH98Md4P5ajN0II16hoq+90HZpFNk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363113; c=relaxed/simple;
	bh=Rq9sKEDoRg3H6dC7gETSpO8+0hysTO5oe4Trrc1hhN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLG0SZdR05vjEfPDW9po9riSXJAn9bEZCjU+CrvPhv3GE2MxshtBf4DXHSSfftl6ehn07JOQfBPRtr70tG+nZTTOEDDuFRDFx8scQXlekHpxaStdtySbU8YgMFJfcfWAvXQ0+cld5aMwNNCcqnN3uAd4fjDOMc0rmsuIw+VdbPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=I2yAKBD9; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TmbIq2+Q; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I2yAKBD9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TmbIq2+Q"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hZmtD6bNszKmV7;
	Wed, 02 Sep 2026 17:31:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788363108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bvsM39KczBLIjGuxVSHxraQicZUkMaj+LEuLvdGR7hc=;
	b=I2yAKBD9VYJwkFWzfeknxXtS1GO/qL8CF+nZM4v+lV99LKFBb0Ha+2azSKvjVHWxVNbaIZ
	MtnGi4xSS4YJAIYSiuygcEl3NmAHtK5KZ1PEHm6aAbIq78tftHpjyVM3MctOguAbAFnwny
	Y43dtrv7sJnaJd1eBxpJQ6L3u4xMLCv/vWMoDLy0pGNXoKQW1n4MBHJnW6e/O8QL0Pf2Z5
	uaQCkmwlVE1GONrR6gawo8s3XMG+wZ8MtTRUYJvNsOAZX8t0X47WJTUCUS/0YhiN5C6Auk
	M5tMv0lKtfnkjI8IG6IYKe/giYD1RvXE5+sU0beB9GpmbDHHrob2z7lnPmNp3Q==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788363107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bvsM39KczBLIjGuxVSHxraQicZUkMaj+LEuLvdGR7hc=;
	b=TmbIq2+QD4dCaHvC3hOo8CFUVpM05uRyrPZj/TN9GVRPn6p2h6qbtwmEe+AkaC1CYjunxz
	NZbVn4O8N6mkqgHCJn/n9WfJ0c0Q0ECGiRrihbb/gbO9rEfmEMeQzfi5NE3el+IMnj8UNi
	zeOMvcNf+nR7SQ+T7WihRXjjnSEes0gOXefqT+cSckaxNk2TJNDOir3WPc4x6Q7ozzAlSG
	bB5rSGlV6gvHTAVIXB5cFPi4z/q9HwjEiU5jeLiOOzB07rT4aT94CFPpP3kD8wsp6XGtOf
	BrR3HOmxm7zqCYxmRn0cDi81Wf7PFykq3NqdaLXFwB2oUEMHRsbD3CGk0N29ig==
To: Fan Wu <wufan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Paul Moore <paul@paul-moore.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
	Fan Wu <wufan@linux.microsoft.com>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ipe: fix invalid sgid value in audit event documentation
Date: Wed,  2 Sep 2026 17:29:10 +0200
Message-ID: <20260902152910.708743-3-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 657zaatswpaz3q38ky71cysykop6d7zu
X-MBO-RS-ID: e79fe7bcf32eeddbfba

From: Manuel Ebner <manuelebner@mailbox.org>

The audit event example in the IPE documentation contains 'sgid=)',
which is not a valid Set Group ID value. Fix it to use 'sgid=0'.

Fixes: ac6731870ed9 ("documentation: add IPE documentation")
Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
[v3]
 Really fix commit message.
 
[v2]
 Add Fixes tag.
 Fix commit message

Thanks for the help Fan Wu.
---
 Documentation/admin-guide/LSM/ipe.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index a756d8158531..bebf14fc2411 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -502,11 +502,11 @@ The following table lists the error codes that may appear in the errno field whi
 Event Examples::
 
    type=1404 audit(1653425689.008:55): enforcing=0 old_enforcing=1 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=ipe res=1
-   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=)
+   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
    type=1327 audit(1653425689.008:55): proctitle="-bash"
 
    type=1404 audit(1653425689.008:55): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=ipe res=1
-   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=)
+   type=1300 audit(1653425689.008:55): arch=c000003e syscall=1 success=yes exit=2 a0=1 a1=55c1065e5c60 a2=2 a3=0 items=0 ppid=405 pid=441 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
    type=1327 audit(1653425689.008:55): proctitle="-bash"
 
 This record will always be emitted in conjunction with a ``AUDITSYSCALL`` record for the ``write`` syscall.
-- 
2.54.0

