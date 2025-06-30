Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AD43AA8;
	Mon, 30 Jun 2025 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315589; cv=none; b=BDnfqkwuyZEgDiABHSbsp0uIToiRGefC9uSUeIUA8SAkzPv5VPCjd/d7x6lSjwsTSPw5jjfhpVZM/jVUI+ixRsaaCycx3dwpMOuQtHISLr3zRJLCDDEJMOMPpgLx/32pGZ63h9CoE0KPouR6QwD/aymcKQPx2Ncu2FB1H1at2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315589; c=relaxed/simple;
	bh=HVSQ29cGGFYsphZoyzUf9wiHea3n+ciW2bojA32ylTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbG24FzMmtlP5O/96bGUBZW7pMX1hbCv5nWqcLtVjLGR8tLSoQlfwrk8Dg1dPMbA84/0Ug5vmZ3g3O7+qH+PlHVzrM7SOthtX1Q9zEVLnVLsJAj2Mtqc7/xHODYEkk1pioQvmInqgN6yIcU97wgpTuayWjwznt5hrVlafuAaNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=eV2wrOnz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="eV2wrOnz"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bWHsj5VYGz9ssD;
	Mon, 30 Jun 2025 22:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1751315577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yfC8TNSgDnuMjBbeHOH4eXZYXEicm1nPMB4+TqFgE8A=;
	b=eV2wrOnz6R+5oePjDP2ATdUO2644+YrD73mfG8eOLWXANiBfoXRt4ODKWbNJToKfvHA/ZS
	pDiLCmoB+p2dRFObI8sg21yEWnXk6nD8F1cUpzKRKikO5MegN9rbtR75avDI5/Yvj8ISdK
	rDyvxGmuNaImlWqsRcHuxNYkg3pWTn8UZD/q6uXlKyN//4qgWdAGwuRzEQUrmpKPkbdo3z
	M5h6EtzGOyTC2ytizorNgyytsHoA36dm8S5CFhXE1J/KPCzrBA46hZx1K09deGwWqFvjm8
	CE0MegHVtwW8KuGvovboLLdbRtCqOACmSdizTxnCsx7h7Nl0ekdUTWejqu1UsA==
From: Brahmajit Das <listout@listout.xyz>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mic@digikod.net,
	gnoack@google.com,
	mic@linux.microsoft.com,
	jamorris@linux.microsoft.com
Subject: [RFC PATCH] samples/landlock: Fix building on musl libc
Date: Tue,  1 Jul 2025 02:02:48 +0530
Message-ID: <20250630203248.16273-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bWHsj5VYGz9ssD

Building with make allyesconfig on musl results in the following

In file included from samples/landlock/sandboxer.c:22:
/usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
   88 | struct prctl_mm_map {
      |        ^~~~~~~~~~~~
In file included from samples/landlock/sandboxer.c:16:
usr/include/linux/prctl.h:134:8: note: originally defined here
  134 | struct prctl_mm_map {
      |        ^~~~~~~~~~~~

This is mainly due to differnece in the sys/prctl.h between glibC and
musl. The struct prctl_mm_map is defined in sys/prctl.h in musl.

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 samples/landlock/sandboxer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 4e2854c6f9a3..3cc990618f5b 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -13,7 +13,9 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
+#if defined(__GLIBC__)
 #include <linux/prctl.h>
+#endif
 #include <linux/socket.h>
 #include <stddef.h>
 #include <stdio.h>
-- 
2.50.0

