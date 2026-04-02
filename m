Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECFC368282
	for <linux-security-module@vger.kernel.org>; Thu,  2 Apr 2026 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157984; cv=none; b=YQUwOx0llTGPneMQI9LlFUkU9ict9g4xOtiHn/HrdEEA7QYqBClemrNGgESY7qHdkzAQPlkjJn2MXFAFQM69SUQ27c8N5fTP617DoRc7HoMeGb47wzHmfzWUTjfZCmLFFDfr60V5Q/V2Zg/qW9on34S2vloq21RKwxhDcbb2ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157984; c=relaxed/simple;
	bh=dcVeVcgNXrg3K/4MkgoiKd3lz6c/L/XqVbuYn3jDs2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN7qh7ObNFQ8td0lDdKzQPuB2mvQrKHoy3ajnrrdbYgzc8KysMM8YHktyLu+rom65W3p305Lg5vOz9DSIxkMoIvyD8cOtVNJOiYmygcX4n6nQTfWqEulJRqM0WIdGRyjyyuNbWiIDuPVOmcAvN6GpLzsZgNm08+hP/fuWmB0Jgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xdDQiin+; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xdDQiin+"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmsKM1gDrzcsH;
	Thu,  2 Apr 2026 21:26:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775157975;
	bh=I3+UBNcOi7OC3QVhP9FCEtB94xQThSIJgWT+bxReHUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xdDQiin+NZK9JwdNmHevyLw9/oCXEs9LlKyAawsrTy+Wby2ZysF7Ndd5cnfdmgUc7
	 m/KKcRxPKLa0ur9jRlNgeNUJUPQIjmHe2SM1pqG7CQzUnMci/BFAohIOSNS9fqVd8x
	 PQRja4cfK9K8LudJXJhENITYvTNlZgYug8h131D4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmsKL54h7zmyk;
	Thu,  2 Apr 2026 21:26:14 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] selftests/landlock: Fix snprintf truncation checks in audit helpers
Date: Thu,  2 Apr 2026 21:26:02 +0200
Message-ID: <20260402192608.1458252-2-mic@digikod.net>
In-Reply-To: <20260402192608.1458252-1-mic@digikod.net>
References: <20260402192608.1458252-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

snprintf() returns the number of characters that would have been
written, excluding the terminating NUL byte.  When the output is
truncated, this return value equals or exceeds the buffer size.  Fix
matches_log_domain_allocated() and matches_log_domain_deallocated() to
detect truncation with ">=" instead of ">".

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Reviewed-by: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
- New patch (split from the drain fix).
---
 tools/testing/selftests/landlock/audit.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 44eb433e9666..1049a0582af5 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -309,7 +309,7 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
 
 	log_match_len =
 		snprintf(log_match, sizeof(log_match), log_template, pid);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
@@ -326,7 +326,7 @@ static int __maybe_unused matches_log_domain_deallocated(
 
 	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
 				 num_denials);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
-- 
2.53.0

