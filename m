Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65A2D6E67
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766173151; cv=none; b=W6pUiGCzcCtHdhXKJOMIUkL5NAJ59RfDdi+0iKLtnNIUgzl5fWGtOSjvLL73+VMe2Z4JTWK3PIKoNGaBwT1U8plUT1kCmQsvpR41UUUZPRo/a1nmeASdFSchR/59z8DqEEW0W6IX8P2xds+lhIX26bNNz0injrQgJyq870YiDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766173151; c=relaxed/simple;
	bh=BQP6MlRJBV2puyxuCDp011SbtTLZWqNuKZ+xZl/GJaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yd4YNdxM7oIqgFYy2Ym/g7EF6ZvHoVLTkXJz1355m5nm56gPCgVj8qmBemZUkH7zPDT8CAM88wg2vT0PZyNHiFwjkhuf1GNDBlywRClmIz25nX65RPlT7bI3aDbxLb9ZJbm56hNa/Icbj9ELKVxcGz/bPVznQy2J2V9McrHXRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CZY0+Xw5; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CZY0+Xw5"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dXyX56FpTzjgh;
	Fri, 19 Dec 2025 20:39:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766173141;
	bh=ANz2owkuKp+ouYsBm/4JJ2ouCTSFoJfoyeuioWonIhc=;
	h=From:To:Cc:Subject:Date:From;
	b=CZY0+Xw5Yq0ftQYH7mcJzeruD/p0kW/JnutOKoh3qeDdd8vpm53Rqw4qKxIRT/8nL
	 uYwR5zgM2MvWd81isLKWo6f9Q/so2POvMahxjKwh5sbLM5tAP2RqDatL7/hu9AIQBO
	 aOMp/SfYZslxJM1+bt4HqJyRyhdTVObBHQ7fyBW0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dXyX52TpwzLGD;
	Fri, 19 Dec 2025 20:39:01 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: 
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [PATCH v1 1/5] landlock: Remove useless include
Date: Fri, 19 Dec 2025 20:38:47 +0100
Message-ID: <20251219193855.825889-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Remove useless audit.h include.

Cc: Günther Noack <gnoack@google.com>
Fixes: 33e65b0d3add ("landlock: Add AUDIT_LANDLOCK_ACCESS and log ptrace denials")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/ruleset.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index dfcdc19ea268..0a5b0c76b3f7 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -23,7 +23,6 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
-#include "audit.h"
 #include "domain.h"
 #include "limits.h"
 #include "object.h"
-- 
2.52.0

