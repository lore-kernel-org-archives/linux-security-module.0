Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AB2459C5
	for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761527977; cv=none; b=FXWVO9ugE0EhweaJwTH+0l45oapLWtQoln7kfPd4HLFcFV0sNP8GHcFXFuXBgEPDMMC2ud6d405x3JnlmOWc5iE1FMM5vX6hrgpDOvo1iFEXs1blNNTP2iP5SU4dx/cfYVE5zuOZJC6KC6OEphLUW7ECVe4/gGCXtOajKN/7VT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761527977; c=relaxed/simple;
	bh=3U4S37G+UzXiT3unBnSQhKX0x/F/M6H0rbOa+EHHWCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JocXvnDw5bsWZ9+iPRaD9t06Ihn0dChb3jJvoIYklZ3bT18IoSo70DD1lZT6K2mKpHuEk244IaClZPssgz0z1iMGQ4zoE3SZ9aGh2ntHvdD8rLVBUPAu0s481/gDD0IoLqigYksu+0ujHVAmWhrjrhAcuTj+Qd7AGBlePbFfmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=U9AVF2sA; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="U9AVF2sA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1761527629; bh=3U4S37G+UzXiT3unBnSQhKX0x/F/M6H0rbOa+EHHWCA=;
	h=From:To:Cc:Subject:Date:From;
	b=U9AVF2sAF5G4az1oQb5Kv3UG2MeHNm02O6/HwvqWLfxbtnVKmxeIALFdDRTqWLXSe
	 RLeVdETywzDPhEAN6JZqngHUzlIe121P+FKGEr081vzp3AqMyy0NLF1Mm8kpPBIUWk
	 ovHQ/gb7i1msMUyd6Gtc1ehSecBaFys8+59FsTcCzVoOw1puWGeacrCNbJVOeAQJfl
	 gXsq+yOQybq+sCcqdhhMPZSyfrHPqJflkvDNrHqEgJcG1wHKZDU+JGqjlQccFK8jpp
	 jxF+pQlTx0oWqY6zj9YHKmFyVOfHRThdA35oIEO2xBJ37SM1J3tBqXlnhn61UcJRk1
	 qtTka5RCFhjLg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 06B9C125406;
	Mon, 27 Oct 2025 02:13:49 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH] selftests/landlock: Fix makefile header list
Date: Mon, 27 Oct 2025 02:14:40 +0100
Message-Id: <20251027011440.1838514-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make all headers part of make's dependencies computations.
Otherwise, updating audit.h, common.h, scoped_base_variants.h,
scoped_common.h, scoped_multiple_domain_variants.h, or wrappers.h,
re-running make and running selftests could lead to testing stale headers.

Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Fixes: fefcf0f7cf47 ("selftests/landlock: Test abstract UNIX socket scoping")
Fixes: 5147779d5e1b ("selftests/landlock: Add wrappers.h")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
I was troubleshooting why some auditing selftests kept failing at random
(recvfrom() sometimes returning EAGAIN in audit_recv()). I did not
troubleshoot it yet, but I did find this first step while trying to edit
audit.h in vain:

 tools/testing/selftests/landlock/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index a3f449914bf9..044b83bde16e 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -4,7 +4,7 @@
 
 CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
 
-LOCAL_HDRS += common.h
+LOCAL_HDRS += $(wildcard *.h)
 
 src_test := $(wildcard *_test.c)
 

base-commit: 6dde339a3df80a57ac3d780d8cfc14d9262e2acd
-- 
2.47.2

