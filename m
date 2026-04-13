Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4266329C48
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059410; cv=none; b=FaNK23l1ZC5ha0xevK/ON2KrduRars+sqiq3mtlCGFjju2CwHobYnjj3EfDvXG1JE700x3/t2n2EclDxRyOzTH0uDoHq/zXI5g5o4KPZb6ffeW2QTloxbjoPv2wTYqH4FxBbzyQ9gkgWX+T+xZuLN0PRLjVSN/TAIiGGHeCFnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059410; c=relaxed/simple;
	bh=+ryDYu86n7TcsZdDUrZQz+c1K+EjkjiGiTyxlnbi0SA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OZMl7Rb5CKmfYXmQO0PrYzu4+V5SdkB6vT7c4j7OqIoiNdjY+Zwvu6JPo4LS4Gt0rTwpdDZ0cahyNeMVd02e9t5RiRlYYFtCJUXrgzNrREQZsbcMVB9EK3FfpOpkhh05cFbm9JSEXLq9y9z4ug84pY7MbUtbFMsdYjtAQXns6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=wSSlHZUn; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="wSSlHZUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=wSSlHZUniE0gf+FHzpDwXmyPU5yLr37iKyHwSpEBJLsW4z7MFUlaLlJaN9UDBR1xSrzUQJZBKdRWQ
	 UR3ZYtoqO4jrzFjRfQWc0qkt0B/GHVThdHyatovqDHYp2iQKWYStCJdwGbyAgM2yBC6HMAA+ctgWh7
	 moIG8k652BCcASHQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-08-12086 (RichMail) with SMTP id 2f3669dc8401e79-00e8f;
	Mon, 13 Apr 2026 13:49:55 +0800 (CST)
X-RM-TRANSID:2f3669dc8401e79-00e8f
From: Li hongliang <1468888505@139.com>
To: massimiliano.pellizzer@canonical.com
Cc: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	qsa@qualys.com,
	carnil@debian.org,
	georgia.garcia@canonical.com,
	cengiz.can@canonical.com
Subject: [PATCH 5.10.y] apparmor: fix memory leak in verify_header
Date: Mon, 13 Apr 2026 13:49:58 +0800
Message-Id: <20260413054958.2244856-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

[ Upstream commit e38c55d9f834e5b848bfed0f5c586aaf45acb825 ]

The function sets `*ns = NULL` on every call, leaking the namespace
string allocated in previous iterations when multiple profiles are
unpacked. This also breaks namespace consistency checking since *ns
is always NULL when the comparison is made.

Remove the incorrect assignment.
The caller (aa_unpack) initializes *ns to NULL once before the loop,
which is sufficient.

Fixes: dd51c8485763 ("apparmor: provide base for multiple profiles to be replaced at once")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 security/apparmor/policy_unpack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 93fcafdaa548..5ea8c14f5eac 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -959,7 +959,6 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
 {
 	int error = -EPROTONOSUPPORT;
 	const char *name = NULL;
-	*ns = NULL;
 
 	/* get the interface version */
 	if (!unpack_u32(e, &e->version, "version")) {
-- 
2.34.1


