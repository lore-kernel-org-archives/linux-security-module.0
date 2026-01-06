Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C13285C9D;
	Tue,  6 Jan 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719626; cv=none; b=ZlSpq6adrC1Noij5NDGOpse3Sdv5di6CwbhgZAMNuHX6lmVj+AWSAbR/CItoaH+WwuRTczvZ1njUBTomOy0flh4nyMD3YQvUbwV1a5bBTwz5fEVsQbosGi5K93dPxzi9JE47RDLpj73jJ7CkvfeNlWgwD5RmN/fQODHn2ZVvwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719626; c=relaxed/simple;
	bh=jU+0cUnFeX8zgm32wbjWEGkT9Bno4SW9Xo+8tilm8Z0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hYchqadN2leat1aHHk1DdfPh7ASd1SMUZRhCUE1m2BDq+T95w8lna28kLJMnlIVDarXKVUTFehXFvpIUehA+VZe+a80uUvsOsLa0QwjprJyjRCsGQD4Nm7TQHYwCshmXMxp4H23kc7AZnck2l/esADb5i9gzYnQO5TPvBGlUEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=V9TDKVHp; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="V9TDKVHp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=0SBgVsqddYJxKw4r99bmApenfbvbhneyH5EXt+VVkZk=; b=V9TDKVHpADdBLg
	rt3TDFu7yVqPzTLLXb6CEzx9mm6GqPQJ4F6DkLf6DN9fyRVicw/3MzOZcdwt3FQDEm7hTrf1SCBtz
	Kvj2YoOkl+ZtauYtC7WSWJUeTkA4pUoINAN5XVr/o5PenkvKdeYF0ktewu5CrBD0zqvifYvyuvpZm
	TA8zIF6XekVI5szpQCeFsSHoWn+7X1SnKcepYHbu5Vugp0Cc4swb2I+Zd+I1vO69RU9sg3LDpNgbn
	HxrCZ3iEUvTZQZWJCr6Wd4mLkyiRJDQTOJKEEcgFSeZ5Cvv20N40L3aaGqZnDblcogR5KKWd/XQaa
	hxudmGFrM3liVx8h8QfA==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vdAcg-007PzL-QT; Tue, 06 Jan 2026 17:13:34 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vdAcg-00000000I67-1Ton;
	Tue, 06 Jan 2026 17:13:34 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: serge@hallyn.com,
	jmorris@namei.org,
	paul@paul-moore.co,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] lsm: make keys for static branch static
Date: Tue,  6 Jan 2026 17:13:32 +0000
Message-Id: <20260106171332.69558-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The key use for static-branches are not refrenced by name outside
of the security/security.c file, so make them static. This stops
the sparse warnings about "Should it be static?" such as:

security/security.c: note: in included file:
./include/linux/lsm_hook_defs.h:29:1: warning: symbol 'security_hook_active_binder_set_context_mgr_0' was not declared. Should it be static?
./include/linux/lsm_hook_defs.h:29:1: warning: symbol 'security_hook_active_binder_set_context_mgr_1' was not declared. Should it be static?
./include/linux/lsm_hook_defs.h:29:1: warning: symbol 'security_hook_active_binder_set_context_mgr_2' was not declared. Should it be static?
./include/linux/lsm_hook_defs.h:30:1: warning: symbol 'security_hook_active_binder_transaction_0' was not declared. Should it be static?
...

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 31a688650601..67af9228c4e9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -115,7 +115,7 @@ do {						\
 #define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)			\
 	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),		\
 				*((RET(*)(__VA_ARGS__))NULL));		\
-	DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
+	static DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
 	LSM_DEFINE_UNROLL(DEFINE_LSM_STATIC_CALL, NAME, RET, __VA_ARGS__)
-- 
2.37.2.352.g3c44437643

