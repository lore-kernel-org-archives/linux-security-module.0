Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C208509F05
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797808; cv=none; b=a5Jtn4COcTI0jtCZkaIGsgArXXT16x6c7bxZIbkjSOCJLglOHK0CUZ17+PA0AzM4vFkkYMnfJ9/XwtZoRv4+EDpUoKkm+4YxmYudIiduvGUCXKdUFCy0XRg8T59IUVOoQluTF3WHUPc8C2Yg0LzKQXD/h5xqt1fB4qMAIQydUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797808; c=relaxed/simple;
	bh=N9MoI07z70skB747pkjf6LfDifXCXFClL8qnEE0hvnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5UOLyTuMXg6li9yJW5BlmcvemzGcGPrjnZxOK0CY8unS08xPOLpfVbZrAUh0H332pCnHLuTHXXvQ2ZrWzKKo3jDtP//k7AHA0XUUcI8hdP8hdU7bGCNg4ppe2X+frjm0Eojzlspot48ZRUkNtQRHCEqShttnBljdBbceHZhvr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TRReacGI; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TRReacGI"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hdsQr6s36zjHD
	for <linux-security-module@vger.kernel.org>; Mon,  7 Sep 2026 18:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1788797236;
	bh=qpvkixeHk2jJcKkTQUt0jt9vQrfg2kFEnD8nTwzRWac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRReacGI1d6uFTL4Ve/4cyxvTRTT64JxteXtOFp7b4bIkH77gAf+2klpBtym/hUmi
	 koQ19D4AMVcXUss3NQp/2FH7okGjfkITopTtCmYCizggYc830K75BwZJSE3qdI2Mo9
	 +T/SpR3uugyB9EJM4XQXlt0fI82lNdv9P7Ff5y0U=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hdsQr3fFJzBC6;
	Mon,  7 Sep 2026 18:07:16 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/landlock: Fix disconnected variant formatting
Date: Mon,  7 Sep 2026 18:07:07 +0200
Message-ID: <20260907160710.126525-2-mic@digikod.net>
In-Reply-To: <20260907160710.126525-1-mic@digikod.net>
References: <20260907160710.126525-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The s3d1_s4d1_disconnected_rename_even variant is missing the formatting
guard used by its neighbors.  This leaves its opening brace attached to
the FIXTURE_VARIANT_ADD() invocation and its clang-format enable marker
unmatched.

Restore the per-variant guard.  End it after the macro header so the
initializer remains managed by clang-format.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 18dbdb99aeba..d0be84e572f5 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -5958,8 +5958,9 @@ FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s3d1_s4d1_new_parent_create) {
 	.expected_exchange_result = EXDEV,
 };
 
+/* clang-format off */
 FIXTURE_VARIANT_ADD(layout4_disconnected_leafs,
-		    s3d1_s4d1_disconnected_rename_even){
+		    s3d1_s4d1_disconnected_rename_even) {
 	/* clang-format on */
 	.allowed_s3d1 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
 	.allowed_s4d1 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
-- 
2.55.0

