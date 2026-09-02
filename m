Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242D64;
	Wed,  2 Sep 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353320; cv=none; b=szDHzvHB9/FG8tzjZYDsKviVmBvAHgyzt5Xf1WtHDGjkuRzrMl4uLtrMuUYrDrrcZ0rZGTFqu0Pv7Pp2epKSMAPfb4b7MLF9U1WinaGmOKV0Ggdx5y88Zw8LoVK+fs3JWtHeqiXJLUi2uUDobTeXtc9ZAIGuG0b0JrmcHxUC3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353320; c=relaxed/simple;
	bh=tLWMNpYEIUF38MHyZ/AyfUsu0oAUZPUHBydAGRlaAnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FO2JkoSuZWt27ffLAoVdD8lBHFQqOJ5nsuOPplKKR8KmD3UuoTD2yyeL4BtmUqtfKqUOT/cVjjn9gfal4GRXuo3PaZbpG1bisaNohA5Dmh8Wx4oqLNlL1T1i7JbAqA5Qk1Bed8W+UNoN8aTp1/xCmI1YnD5VJD41oSg8ghFstoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aewTPnYk; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AF8jxorU; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aewTPnYk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AF8jxorU"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hZjFt5GlqzKw1m;
	Wed, 02 Sep 2026 14:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788353314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=45J3Rns/aAsiFCJKIoSY79iu0NXb4XfXdTxcGKFXLgc=;
	b=aewTPnYkjGd9UHJMRYcZkFyh3ZUHvOfcaQeih6LpHqdpmNS8Y/tAt41lxsSKu5UY4F/5WR
	S7BwNPThUz1O8bmCbIhkcZy3pWLxdVhg6rH7cp0/mDd8pkX6jZGRN+KVD0ubupKBgXVHKw
	ZO3Emi1iKESdruG/UMb+85k84WF7v78aPDmzPEiIa7WCqXGRtGzLJS8LNeL6cK5FRwL+0z
	LsIlbXv3Q4TbTvir8CVw9lyiApC13MBpqFXDJ0QamM8sEyFXRQqvzQLvZzxFElhiea11f0
	1yAtPnc1Xzo3b0Unc83vYi8z9R9gVZdUu2DxlNLbiUPjdBndwDgzkafaLMzkmg==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788353313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=45J3Rns/aAsiFCJKIoSY79iu0NXb4XfXdTxcGKFXLgc=;
	b=AF8jxorUd+H7c1wyd1rjFIrR+LwpAgN4CAOUQuCSWBx7HEdlh0yqSWDZSODhBefge4yMD3
	Hmv3s9aPQYMbbJZAU9Hujq53FW3j+anTXtcTqGM6XjJR7wrDQVpHThm63/gRG3llW/vfD5
	49BT3N2pwyEktMZZJJSWFhxwtQW83v9+6ybIYAasGQxIbjKr4Ttz7JBNg90m03Q5d2V/+a
	//khHakTowN7NnNHLCECCqxd+PnyJNPZPD03aGknKeHajTr6vwIBVm2W39cgIHXwe0Wy4G
	z437M8gKNruj1F+RHEEV2qZYELkFJQQ0lfRmgBprlxRqi6QOU8qP1XBUP6ftcQ==
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
Subject: [Resend PATCH v2] ipe: fix typo
Date: Wed,  2 Sep 2026 14:46:24 +0200
Message-ID: <20260902124623.695928-3-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ustyp33cgwairx9b3mh67kaszokpjbsc
X-MBO-RS-ID: d68ba48a5cce7911db8

From: Manuel Ebner <manuelebner@mailbox.org>

Correct Set Group ID from 'sgid=)' to 'sgid=0'

Fixes: ac6731870ed9 ("documentation: add IPE documentation")
Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
[v2]
 Add Fixes tag.
 Fix commit message
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

