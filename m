Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384B21CC5F
	for <linux-security-module@vger.kernel.org>; Wed, 28 May 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443484; cv=none; b=eTuYp76nFpeZGO+3GSf2KWQQGdUnV8nxtY4899xgrUjgzl5gb3nGLtqlkM1OmxCFuKenWLDO8TokfjtzT3kWVtVareultHQeZb1b2x9rNwcYZK9IiN+8OrjU0+wCNm8VrhmfOTbz9rYIgqD3NbxRcCNx6lcoGYltkxecyWQ3CHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443484; c=relaxed/simple;
	bh=Eb1X7PkGheoIv8XiGIrlTLcwGU9i30RBhGevT4gN9rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SI+oTvXloMnTZtVEuGG/e1tQw5Pg3ThMxKR4ROlnBtlb0kLOruZ5PJQClVcgoOcR5u2ZvKybGVH/ja8GF9lAIWKWwovX/AGclWnb45BgV8XsU+55uaVe1Ea9Pa9fa4jc2GquZjkRXl14XxevmqXaMA9P0f9ykZtwUyzq/Fhfdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=sbYOFfya; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="sbYOFfya"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6shr6zv9zwbh;
	Wed, 28 May 2025 16:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748443468;
	bh=l13GJwjXViQjn619duoDpIaDB+zsHVD99BGFAgNqm6o=;
	h=From:To:Cc:Subject:Date:From;
	b=sbYOFfya/y/PfXolcWPrdBM+ncoH1qRrdlA5MICsYXILmvkNl1Pi3/gZ47LKDvKjF
	 S0Cnnvhv7f+9LQH8Dc0CcBTGugji6J8WRmyw1lAmI6x90KKje8Tl6PVB25Bo1axapW
	 R6D/Lbc6O9UmrkqXRi0NycC6AEgzo1rCEXwBwZcE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b6shr23s6zgkY;
	Wed, 28 May 2025 16:44:28 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v1] selftests/landlock: Fix readlink check
Date: Wed, 28 May 2025 16:44:25 +0200
Message-ID: <20250528144426.1709063-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The audit_init_filter_exe() helper incorrectly checks the readlink(2)
error because an unsigned integer is used to store the result.  Use a
signed integer for this check.

Cc: Günther Noack <gnoack@google.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/aDbFwyZ_fM-IO7sC@stanley.mountain
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
---
 tools/testing/selftests/landlock/audit.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 18a6014920b5..b16986aa6442 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -403,11 +403,12 @@ static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
 	/* It is assume that there is not already filtering rules. */
 	filter->record_type = AUDIT_EXE;
 	if (!path) {
-		filter->exe_len = readlink("/proc/self/exe", filter->exe,
-					   sizeof(filter->exe) - 1);
-		if (filter->exe_len < 0)
+		int ret = readlink("/proc/self/exe", filter->exe,
+				   sizeof(filter->exe) - 1);
+		if (ret < 0)
 			return -errno;
 
+		filter->exe_len = ret;
 		return 0;
 	}
 
-- 
2.49.0

