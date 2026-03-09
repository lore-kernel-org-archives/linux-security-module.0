Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27837D130
	for <linux-security-module@vger.kernel.org>; Mon,  9 Mar 2026 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096147; cv=none; b=pL6IlPoq47iySRAeBKOK9kH/c9ZwBex1uSc70Y/usK1BuXlOZso3c2YN0wEhNOGzrbQRw9Yoqe04Z7lnMosvxRq7gku4WO1nYpSCHpyNpzUeuuSL/8PA4iqxC0yHgSJ3W+T1342Q7kli0/PM3ULCSbiYpepMOVgGlATGsnCzTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096147; c=relaxed/simple;
	bh=RUhFIUpE3q+j/RzplHM7utqXljK9ejAG8G3w/29/YpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uu4U4J9OWoKpM8HHaJs4Uy2I0Z+knd7OxJPNZ8bRoX2MHv6gAS0i6ttmti7e7nWihCJ3tSbtdy8QuhAoJQmQEqAFkU/FbNwJKBxe4phecWYtPqeIVJFn3Q7ArwRQ9+zQzdYUkbTZxmYz8ElqGqFGwSYXP8Logt+1pGrPzU4OWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Muuy1vri; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Muuy1vri"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773096143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IAPnfvwI82KtySwMtMOUp5GIZTs7KwYrmI4bhGYfZSk=;
	b=Muuy1vrixo8y5QksXCaOfruiWdUAxZA24ZTz586RjMAgE/aYQ2DeENfHqk6CJywQcaqy1y
	+dXS57MOVZ2D+nnu8996TtWlwObLKZZTqDCwiyg7zp4kus/CX3uDsAH3ssBeSS0n+UH1J4
	lUSIVT1vc5DiWCzmJBiZUDMIU28BPfg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Replace memcpy + NUL termination with kmemdup_nul in do_setattr
Date: Mon,  9 Mar 2026 23:41:51 +0100
Message-ID: <20260309224150.84575-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=thorsten.blum@linux.dev; h=from:subject; bh=RUhFIUpE3q+j/RzplHM7utqXljK9ejAG8G3w/29/YpI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnrfdbxOEyNqdm8JfnF5C+VSo2H8lIv/e+5HZgk0Lb4R gwzk4xHRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExE7RLDX8G9Gs19D2ecktmt cr/3lnDM83cnZuzKeBfSI5o1IUZsxSpGhmeBvfFXBJ9IaNzYLFRRLpD7fSnLg6UvlsctL5l64hX zaUYA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use kmemdup_nul() to copy 'value' instead of using memcpy() followed by
a manual NUL termination.  No functional changes.

Reviewed-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/lsm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c1d42fc72fdb..49aa6ad68838 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -858,12 +858,9 @@ static int do_setattr(u64 attr, void *value, size_t size)
 
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
