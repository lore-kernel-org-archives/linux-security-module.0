Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB036E48E;
	Thu,  2 Jul 2026 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020234; cv=none; b=YuuaMEFkTOqclY1M1/PWXNPq2VLNuzOr71tox03FwlUI35QJwi4YDoRmbZV0QPX2b8qVnNhLiojY51azAwLQFsyMan3JtwpfU27ON6CyhJpM+ZFJ9pyAHv07E2ZUfN4CDGObaO8lUsHJ0ILhnIBbgjWOTy2KzZPSzf9ySsFoKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020234; c=relaxed/simple;
	bh=NaOlLVb8ccFKa3siq+9dgN49B6iDd2ucMSiDWzU+aNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmnmM7BpJibevFU56Wdf7XvL98b3QnyR68adB95xOlarXz6u4ENeGCYy49Tv6CnaNRDyUnF075UbDUo/Bisy0MeyCONI5MEVx9hheiKJi2ycZqQxAG2ekbZbHy3517rZz83APHL/d+1hk/dF6T2/SfiyVpIExtuG62b7KnrFDuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=d7Xcw2pF; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kjgSR+qo; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d7Xcw2pF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kjgSR+qo"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4grmyY2lgcz9tkM;
	Thu,  2 Jul 2026 21:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783020229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TuKGym6AsqNFbQ6Z9d4L6V7q3VOQ/WngH6O2vJCMBpA=;
	b=d7Xcw2pF5ZU2tklEk9Kx9EM/c0bDGXbAx/DE3HS+TKK2Pg2CMgk7hk6yRS6Ks/aFllcZo4
	MTC/TeJdqDJPo73T3Tt+iNpLp+6JdTJoJgrBFS+7Ew10dVIHpJNp4KhcTtX2m3RPKT5J8q
	PI8KSQy1f3IMUYKo8cs5m2M9O+q7XP/lwSHshWlaygkgwZzxHvItvDtpZEspqv2xZbd5z4
	wwnfZ0njap6DN9bub7xpT0reJKkI/qXOYm24VIZC7P5f+dAMIFrVny3rBfBWTVAu3QmH5j
	4RW0MBHgUhpyCQTMZ0Fsyr78ZH+nysSkk+NBxIj76hr3t3mN8A5flwxFleNlqg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kjgSR+qo;
	spf=pass (outgoing_mbo_mout: domain of manuelebner@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=manuelebner@mailbox.org
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783020228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TuKGym6AsqNFbQ6Z9d4L6V7q3VOQ/WngH6O2vJCMBpA=;
	b=kjgSR+qo/19dPaWgPblCf+0DqKLexj450SxhB2D4HXEVxbvmprKd2gt0pTyTKKRaMnbcv3
	Mte2UhqYE3jYpRNqBCqjcR45cyLDWrp8DnUwo/unmhKVJjEaHWU9R9x4iPmN9W5OMsDuXV
	xX3ZhP/UhoG9fazp/BF5wt55oko3+MmVVkokUrtIggdvYj96innNi5n3K2WHEEIRWCYpSC
	OnPy7h8AM9J65zos5TciQvbbiCW56XlCWHPJrhbLEbYavb/FWBxffGyOE1S0CBk8DeWRRq
	yksz8ek/mAM9iZnpCpqjXXK+z1427h+aIJ7yP8I7ZkO++FrvR6JpEM1VnWciQw==
To: Fan Wu <wufan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipe: fix bracket
Date: Thu,  2 Jul 2026 21:22:09 +0200
Message-ID: <20260702192209.211102-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sxt3ere5dp17qi9bwtohsa3xp8jqkey8
X-MBO-RS-ID: 5f1ead8932f21429f8b
X-Rspamd-Queue-Id: 4grmyY2lgcz9tkM

Replace nonsensical ')' with '0'.

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---

I'm not 100% sure this patch is good. Please check if this makes sense.

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

