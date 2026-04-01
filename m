Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179E3115A5
	for <linux-security-module@vger.kernel.org>; Wed,  1 Apr 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060511; cv=none; b=ENhHTfCB4dsQRiGvm3m8cBP9Qujt0SOQOD9i7MoxEW6uNkaIZeqihXi5PkXYbr/1nTntkaZKtr5reFPoahS/iPn0M+Z65pVh1ES6/sSYGDi3KKw6VXT/FPXkFWONFV94Smwl5K7+phHsIPTBF4jExU+wRcSP3TGBBEgyNUBfyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060511; c=relaxed/simple;
	bh=obyOfmRaXFMuUHo9g0PeEd21rFKHLRLTpOLGFY98/+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhQmPs7GriIUMIqL6K9gTRYY5OHtlA7+vgxOGbCIXBlpkQcAj15YBvILPxO8aE1MSMksyAR9sfymKU+UYt+vvgD3t4T+YTuKpwXs5GQz5hvSC8s8mnpG9g2ntTvrE0O+xOTmb4q0uLTUHl16n4odJF3NGRRYTdHCVMSyNqbHwDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iUpzxhHG; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iUpzxhHG"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fm97c2rGkz49m;
	Wed,  1 Apr 2026 18:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775060124;
	bh=5b8QSKrxs4WQ0WQ0ydOU1r7n07mMZCPyxsVvc52Lipg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUpzxhHG37U2dfFvVgbCEnBwRvoIIXPRSEplRFO2Xg1hQpHLoK1j7syxmjGs4y+M3
	 kNmfU7lTBRyh9t9Wx/vIcH6SzbQenPMKEduTzO9ikzCgOapEk4bEhzrCophvBvQDOy
	 /uG7GBIyWHwhtKqboKyP/4/oIGW9VUvonOnEkwCU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fm97c05Zvz8t2;
	Wed,  1 Apr 2026 18:15:24 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v2 1/4] selftests/landlock: Fix snprintf truncation checks in audit helpers
Date: Wed,  1 Apr 2026 18:14:48 +0200
Message-ID: <20260401161503.1136946-2-mic@digikod.net>
In-Reply-To: <20260401161503.1136946-1-mic@digikod.net>
References: <20260401161503.1136946-1-mic@digikod.net>
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
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Reviewed-by: Günther Noack <gnoack@google.com>
Link: https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
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

