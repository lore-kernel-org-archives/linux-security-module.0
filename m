Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C240756E;
	Wed, 14 Oct 2026 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996949; cv=none; b=opoZP/fIrrODnH4+bTIo2olZLhJJzebVNIyu6+VNtBfXJrSOwVflkwrSahinzC5YjuDEt+BeWQWHIQTBezK3L1gF0S9J/uYoHzR8ri5ukP1u6b8Yu7aD0Q3bzXPtR1yuvK+YWzxCF+D2Fwh5lrGKO7v+xRY/xNhtNKW9Iek2hS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996949; c=relaxed/simple;
	bh=wTKLipM8xeIdSA9MdPSVvaI/V0OdVyUDl1hYCAz7Tz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqU3VK88PHmy4SPVW+jX/NGimDuGKLD9crqTJDzbRG6w8TVAsqoFw8pggMHgKk8L60qkJ4G63K8DBiE+E0JgEWcfPgp+NJfXgrWy+rvNejDPyfcAyCVMH3m9AOaquIVVQ2oFF5Ud95qQnLoOlE4zZsS9Xm0WT/2N9qJN80x2VgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhSMDPE3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhSMDPE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9831F000C4;
	Wed, 14 Oct 2026 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996947;
	bh=31b2X0FPZIBQ+GNF89xj0PZSE/JSd2cUeeyvVx/8+oY=;
	h=From:To:Cc:Subject:Date;
	b=UhSMDPE3suPh7JvgUvThDId5qlFc7KaIH0LZ4Sx1n4xIw9rDTwAdPGRWD2mI2avRO
	 ggFIfCoRZxGw5L4wh3tf/3gyMFO171KPUUQlIOYdl2XlDn9pWKb+BquGuMpppk+p8g
	 zR5CgAGXXCNm7pFx4GH49r9RO8vy+qvxSJKQmkHhcAImU2KCPtVOhG57XDnhVLmlfz
	 yz6CfM7tQdA59mEDFI/3FgXKMofMnlZJkRoQGJn/TMQ6k19+mwsANZv93xadlXntXJ
	 pAXLk0UfFfUPr0wKhYIYQ9E3s4DJUdh2I8lup2xTkrAdkloS+jhp3Be/Rm17KHnmVe
	 yyPAzCu00b4+A==
From: Thorsten Blum <blum@kernel.org>
To: Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tomoyo: Use isdigit() in tomoyo_numscan()
Date: Wed, 14 Oct 2026 18:55:32 +0200
Message-ID: <20261014165532.329933-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=blum@kernel.org; h=from:subject; bh=wTKLipM8xeIdSA9MdPSVvaI/V0OdVyUDl1hYCAz7Tz8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnnt7A8u/yOxTVt45pQjwOZF65+PhFePnH+28ldTWrHf 5sE7Vyl11HKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATUT7CyPDj0hFfhqdN87Qi ArSjomN/uzIdPhJSwHnAmTVMe8pKUVOG//WiG0SaH6Xwxsfdlnmxyav25BNBNtGLtdK3Ii67crz 6zQ4A
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use isdigit() to replace the open-coded implementation.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 security/tomoyo/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index fdaeaff01fc1..031c643ce22c 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2005-2011  NTT DATA CORPORATION
  */
 
+#include <linux/ctype.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/security.h>
@@ -2030,7 +2031,7 @@ static bool tomoyo_numscan(const char *str, const char *head, int *width, const
 
 	if (!strncmp(str, head, n)) {
 		cp = str + n;
-		while (*cp && *cp >= '0' && *cp <= '9')
+		while (*cp && isdigit(*cp))
 			cp++;
 		if (*cp == tail || !tail) {
 			*width = cp - (str + n);
