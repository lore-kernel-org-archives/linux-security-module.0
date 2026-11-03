Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723959;
	b=z1ea9v0dgaNAYmV0UIa5yrlyG06umzHxqQh1vqO3sZKx+RDdOQ5MCsldsosLoWSuXb9P
	 yD43IHkv8kwnpc9BQSimj+3b0xZOR22kfapA9UxYl2RUsdaFMBYpdT0v7CyPro7QquHGq
	 novod9RSJNqDYGbrU/XRZIRR1j/ekJ0YtvBOPcUDDbhlXHfHPxgfXZTSKXoRQnlR7mhH1
	 ziO3Jswfv7neHZ0mA4vklQ7L6gImVQfHV80H9agTShV47UnifNO3JREU8zmWrlmyqwKI4
	 Fk3vQI2Km39s+RVlImVRRmZIAVHzFmtWwidzDKJ6nWauAdTiN09ZZrt4RvoVs38jpbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723959;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nFEbpr1S/fywdsLNs6gMW5AfQVW9GmywjT2Nznx1bkQ=;
	b=hg5SS0dGMCmIiXsuFXn1+bG9JR/jNxKSiek/UwUfNzjnKukgQNxM3x8GCjUPkwXD+oBP
	 h9V4Blzo6mV9I4tfrJeBUVGOeeY5nbRbrnFbk4pG7f0TBl39I8JdhnDoipEJmzP8trn53
	 CGM2PEglKUMcQMXvsuh1PMyBRj+25NllToR9KsAiz/L6I6TwsM4MRGSaKx9VWDdpaGb4x
	 1Wo3sF/jR3TE8dVCKuvJ9DCmfG/ZY9p93DKEWDicMFTWo5kB6Mm/HxVAW+gr89PlVJZJt
	 tr+8AKqI1e+uJadyD20x+hewDMNbpT2dJwcWkEzNwN3UzWqPFIJXow61x8NtCsgSuww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9Wh75Qn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC436082BFA;
	Tue,  3 Nov 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9Wh75Qn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3030A1F000C1;
	Tue,  3 Nov 2026 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723958;
	bh=nFEbpr1S/fywdsLNs6gMW5AfQVW9GmywjT2Nznx1bkQ=;
	h=From:To:Cc:Subject:Date;
	b=G9Wh75QnGhYvovPg5xAzjnRYZqswO6/JSyToounH/GNCzWXa1YiMDtTzI0yEf5A1e
	 R6bL/+7PGUsb9YoJWx4mQ5x9FUsppgUSwvz5oOLHDmcmBhVMcgw3NKlVLre6kfKSEY
	 xte9qOcNLndu3Rxu9Jur0l5DoNYJqcGa1l8T/STZzPuBBdI8QVFxnmMXPMAQYDH3Ns
	 2aUg22dCfai76o3kJX8k91825irAJGyj9xKK7GQ0gKJRN33FYBXLSwOEtwX4j/4POE
	 7myZOqswosqcRIrlguNcREYjFu4Of2YV0N2c+NbLSLOQMoNN2rmH3eIrPWupUdNr8u
	 xJIIHhOy6BU5Q==
From: Sasha Levin <sashal@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/landlock: fix the regex_escape() error check
Date: Tue,  3 Nov 2026 11:39:17 -0500
Message-ID: <20261103163917.641130-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regex_escape() returns (char *)-ENOMEM when the buffer is too small, but
matches_log_fs_extra() checks the returned pointer with "< 0", which is
never true, and goes on with a bogus cursor. On 32-bit architectures gcc
also warns about the cast of the pointer in the error return:

  fs_test.c:7474:24: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Compare against (char *)-ENOMEM instead.

The size left after the escaped path also subtracts the prefix a second
time, which can make a long path fail with -E2BIG. Compute it from the
cursor instead.

Fixes: 316d06b01130 ("selftests/landlock: Add audit tests for filesystem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
-m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without them now, and the x86_64 builds don't change.

 tools/testing/selftests/landlock/fs_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f725882fa4a78..27a78434d1c21 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7470,10 +7470,10 @@ static int matches_log_fs_extra(struct __test_metadata *const _metadata,
 	log_match_cursor = regex_escape(absolute_path, log_match_cursor,
 					log_match_remaining);
 	free(absolute_path);
-	if (log_match_cursor < 0)
-		return (long long)log_match_cursor;
+	if (log_match_cursor == (char *)-ENOMEM)
+		return -ENOMEM;
 
-	log_match_remaining -= log_match_cursor - log_match;
+	log_match_remaining = sizeof(log_match) - (log_match_cursor - log_match);
 	chunk_len = snprintf(log_match_cursor, log_match_remaining,
 			     "\" dev=\"[^\"]\\+\" ino=[0-9]\\+%s$",
 			     extra ?: "");
-- 
2.53.0

