Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A272D0C72;
	Mon,  6 Jul 2026 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359988; cv=none; b=hjNUoOreGfie9LQxSOvENomPCMzACm7Bx/3dMC2nYuxTKE45VyQpmwVq0esDrdH0wKAf1fwJyLAZ/XdKMCgPQYWC5ISfJIvMJK1Y1WzoHt28cURfrhfJ0zPYlXpBprSwdy4QNuyxKntWDIvGUpF1CoZwlDV9jyy9HgigbKgjsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359988; c=relaxed/simple;
	bh=0TJgHD9oqAQUjhft5MOmemyPRYsLqk/QZa1Z8nWkq3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUC0ak9GGHCFUhlLJ3lL3jbg0ndjEWXOCoELaOp560nuzsc7dDJORwJrnMqjQsKfK325A1xNnNLcZD3OEOG4kcqpGg6xYfp12a3TIUE4v++CgdMBjzkiBgcjF0B1eSJWvudq8+dBCfmAnC70yAXAbKj/JrVRbwyQIGXex/UTHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sc7V1wg3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SvzlE4Cj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sc7V1wg3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SvzlE4Cj"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gvBcH3ZHYz8sYZ;
	Mon, 06 Jul 2026 19:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783359983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xPoRZVT1zHpUfDgFLG3j6zjkzn7bqu/io/JaIfdfRfM=;
	b=sc7V1wg3FCfaIfC59DKq1w2Qs8YofF8mP+O0faveIhsF3ax3lAa5V4Uj4kfADejlrUm/IC
	JqT6rIXLl6jBwezjwRyVWOHkp9FMRV9d2QBvBucan/l4meX7iTXms9jQCCSWqL9Wm0bb07
	tdN66ofPywoIbTqz8lbPJGTPtvTDzIhePuC1hgRZ3KMNHVjoUv6xa2+Dpd3zRnolHjgJZu
	0iGY/hl7a4qtqJ13/ejOYVp/oLJWwMcKxp70JAgQRlGJAvKFp1//Ptudar100BBiPcbW3g
	7Du84EPIGSuIXdd34NPvL85ajjXP3AHNqvSsRaS3X1pkaAhByf9G1Rgy2xcEOA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SvzlE4Cj;
	spf=pass (outgoing_mbo_mout: domain of manuelebner@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=manuelebner@mailbox.org
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783359982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xPoRZVT1zHpUfDgFLG3j6zjkzn7bqu/io/JaIfdfRfM=;
	b=SvzlE4CjeuA4pZWiqljKTxF9CnVEvVcYCsUHFgqHKKOpOShgzOWLg4eXUVm8WaB0hqae5k
	/ahKVQa581mZicGEhhsz9BI8RJ2v1NnJ8t1SVuWqWcDS+5r7/tJf5GtUSpbvfUiLCp+rpp
	DrL6WLaN9E3Hxix4nYcmN1HTKzKlqVXyW4orfnYvxUcq8elXDxnCvzzdvHBSUM3nYHoY0H
	khSxS0Afr5W3u96sd1nmS0RX20oBUWaO9W4Rlu/NAAxtHBBMAsNOtog9rDy/asjh+jYSPy
	rvk8Zp+tQ9eloSNWFlPI7lbzGgvUFSP3Vk6kY6NfA2NcLUzWh7iW+DqoBQnA6g==
To: Fan Wu <wufan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paul Moore <paul@paul-moore.com>,
	Deven Bowers <deven.desai@linux.microsoft.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
	Fan Wu <wufan@linux.microsoft.com>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ipe: fix typo
Date: Mon,  6 Jul 2026 19:44:54 +0200
Message-ID: <20260706174454.261790-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 80eb9e96059feba7153
X-MBO-RS-META: he3nit3ec3xzfjmtw6jjn8ypagupap5j
X-Rspamd-Queue-Id: 4gvBcH3ZHYz8sYZ

Correct Set Group ID to 'sgid=0'

Fixes: ac6731870ed9 ("documentation: add IPE documentation")
Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
[v2]
 Add Fixes tag.
 Fix commit message>>
 I assume it's a typo because on english keyboards [shift] + [0] -> ")"
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

