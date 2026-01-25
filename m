Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73E22A1D5
	for <linux-security-module@vger.kernel.org>; Sun, 25 Jan 2026 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769374878; cv=none; b=oVIHeORUFH9A7FIdrvaDm0KtDXtvaFzgdK+ONu3WspDZNwEgZ1uVwmp6n+AXATFyQSeJMsKD4o6o6z8jOCXAxNeo52RFe9d+tjAGJgdlxADQUyHRqsfeCPEtmP64zLQc3Z2CX8NHZRMj4oqdNrvBBAD1/zohZINswrd1azqsdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769374878; c=relaxed/simple;
	bh=KXzDsKBIBH7/Smgvq/uYgr7TFTUeTxZZkSerZHus/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXV6lpnp893McPxmrX1GdLNi5KoneVtu2HyRsqPyIlryie+7RkaygtQ6PykNDCiSdefuN3FPsw+33PpdxhxUI3+2GQBtiTPmDufCZd/N7kwDC8p9Veis0hiw18goNEznvYNxwJSG/qfSezKV1TZT8lGs6GwgciPHjPuvh9aRYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hp7w1qwh; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hp7w1qwh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769374865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AVVBNyZnoHuDoXjzcBcG8Nf+V8gmFPYyn44o12zOuzc=;
	b=Hp7w1qwhAvwM4pNqkz0uoI5hqJMnVSB6pV371kBkrBTMRHuF+8cw/l3xhWXQvh7dOItXCH
	rVAzH7qPxNk83EdndNCJEWpLKaRhc5bCIhUTf4j8wNDAlbsYhJW5/6FCLumPFRNrF3A3i0
	5ZChAGFlEwZvumuQmbhvm1ywhgM6/T8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Replace memcpy + NUL termination with kmemdup_nul in do_setattr
Date: Sun, 25 Jan 2026 22:00:15 +0100
Message-ID: <20260125210014.154432-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use kmemdup_nul() to copy 'value' instead of using memcpy() followed by
a manual NUL termination.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/lsm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index a87cd60ed206..98b92af5890e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -866,12 +866,9 @@ static int do_setattr(u64 attr, void *value, size_t size)
 
 	/* AppArmor requires that the buffer must be null terminated atm */
 	if (args[size - 1] != '\0') {
-		/* null terminate */
-		largs = args = kmalloc(size + 1, GFP_KERNEL);
+		largs = args = kmemdup_nul(value, size, GFP_KERNEL);
 		if (!args)
 			return -ENOMEM;
-		memcpy(args, value, size);
-		args[size] = '\0';
 	}
 
 	error = -EINVAL;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

