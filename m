Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2395684;
	Thu, 22 Aug 2024 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286691; cv=none; b=j0wKBWJafcKpNqwAHV33kBG2BKBb82C1GeMTWhD6pxwuwOZTMNbb0usjV7Pjc/gAUbzqXD6XmJ67pOJdFsMVWnIuKlcBS7KTfkYMFy8uLjKcOvNNlc6HzCOiWRX/m6vy0m699pjx228TBYVpUDq2jKYWVJ1inTGJA9wokI1JrUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286691; c=relaxed/simple;
	bh=vX4bwbEZCM0DlDwN+mhfhGKNSGmnW50NPHU/sf0V17s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cv7UfvofQRVMgv9HHYuhP9kc6mkw2C3D01zUjHcQLjo9fmJ+aNpR1aQpJpV8J2/sIzWSKinH718JlXQ8pdbPMmUyeafspsFjAm9GMXyjpxXqKxLgGOe3btQCDPNBA0tvXEioKz8FIWDR3QoJ6JG2DAjL+KQm+IYYclrSwZjF87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YtnlYIw0; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YtnlYIw0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724286685; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rPVByciwYoPsmWhb4UfB3nuMMi+gPyeSFgobV8z+KoE=;
	b=YtnlYIw02ZrML2oVW/Kfi3UWErrMefWqCg1KQyjChQmYo4KBtbbpPH9EAlnC1E3zzWdb0BjejzKZaX7Wqn9X5V8g1/8PSbiLvTjSnjxTg6HbkTYdIWxFxnvb5Yw4R5CKLtisvjIx7mqUQIt9KXyn7FjmQ19qQ5IY2gsnxbnfvCU=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WDMyqn4_1724286684)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 08:31:25 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: wufan@linux.microsoft.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ipe: Remove duplicated include in ipe.c
Date: Thu, 22 Aug 2024 08:31:23 +0800
Message-Id: <20240822003123.118140-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files eval.h is included twice in ipe.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9796
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/ipe/ipe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index e19a18078cf3..4317134cb0da 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -7,7 +7,6 @@
 #include "ipe.h"
 #include "eval.h"
 #include "hooks.h"
-#include "eval.h"
 
 extern const char *const ipe_boot_policy;
 bool ipe_enabled;
-- 
2.32.0.3.g01195cf9f

