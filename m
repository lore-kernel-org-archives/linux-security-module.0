Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721314;
	b=MTncO6bhj+ol1uncCFC+ZgtHHUQbIgCaDegfsNpg9owhokHYWOW74pJm/mjMACgb+viF
	 n6b7u6g2515lpS8zhNo9mzzIcXfAXmeVXMUDOi+zTJJ5zTYQUcptVhHtt9+nYdVeRYPp5
	 42h49dWuy9u71+axYS4seOjvlwiMXi32qdk+rGDOiWcC62c+0aqkN/qglHL5PB5W5kzhm
	 D8nwlLxl5ARbLF5gjDEBEZse7QWKftYpD0dY+Vsft3vlzD6qXbcDmYsNQO0eO9BLaKErm
	 91Nwet+CVfIumgPavqN8+/9YSl05GOKO4ymk2gnWj4DkJ6/Pt80O727ubH/2583NJQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721314;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+bvowQ2tsMrsReD+KwAHfxLIFb4ikb5391MbuSpKn4E=;
	b=N3f8eCvMlI3Z2Pkzp4TG8KQLIAn0HtvqSSTy77fGBsKHhbdGmVUX8vFKR/Lbd6hx0CvL
	 G7edE66W9tp9iF+dkuT3801ArWuaQhoqOy9WwSI09NPFQHW/7BHZ8uqV3BpYTYBpPlEeH
	 Yt8hmkAitPXPvT2DCvJGw15te9wMY9boSruMQOPx4BZgBi9Rv9N0/PLJ0LYnsze6pQ6rC
	 ZKpuIVa0+noYxZzOGVOraXTFictYYCoRutFCKoZhhBaQk2aq8JZ/L7kyz5S1iVj2ryayd
	 UKQZVdXgeha2or0TACv6oGfVkmQ6GrxmJWpkFxH7EOYHDVGaCSrCE7yGORWKnVsbPxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YG771SOn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7EB6083602;
	Tue,  3 Nov 2026 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YG771SOn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485D61F00A25;
	Tue,  3 Nov 2026 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721313;
	bh=+bvowQ2tsMrsReD+KwAHfxLIFb4ikb5391MbuSpKn4E=;
	h=From:To:Cc:Subject:Date;
	b=YG771SOn5LCH41hN+89Pt4Ol9E33pLNQO0TsT0O7G5/d6YKDZ/wsgj586ovRKWSEk
	 PbeuOXvwUxQ31ROOqcdNVWFOC8SzjcLlBYXGbNb0uzlsU2nkBMWxPSkkAVRejCYXeq
	 30TfBT8/G0/F+z/4R3SLEoAl3fv+NqvQlMqjRXg96ZZOXY7L47uSRNAvzppc1EH1aJ
	 +eEJ8SA3SCywua3aN27dQn5eRh4bYxfGQXCibX+qu6vMyWyChPNDblB3NXT1GejGIf
	 lZH+8TmnjUqUb598PHcfJ8Ugkr6XvWIN1zQDZYkVoHdQSRpw2C16S2ckd98/gKkGea
	 sq3A4604D0qSQ==
From: Sasha Levin <sashal@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/landlock: print st_ino as unsigned long long
Date: Tue,  3 Nov 2026 10:55:12 -0500
Message-ID: <20261103155512.535137-1-sashal@kernel.org>
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

On 32-bit architectures with a 64-bit ino_t, st_ino is an unsigned long
long, and printing it with %lu warns:

  fs_test.c:10511:57: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type '__ino64_t' {aka 'long long unsigned int'} [-Wformat=]

Cast it to unsigned long long and print it with %llu.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with a 32-bit build of the selftests with a 64-bit time_t (gcc 16
and clang 21 with -m32 -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without format warnings there now, and the x86_64 builds don't
change. The other selftests get the same kind of fix in separate
patches.

 tools/testing/selftests/landlock/fs_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f725882fa4a78..a2dc9a7f0481a 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -10508,7 +10508,8 @@ TEST_F(trace_layout1, check_rule_fs_fields)
 	ASSERT_EQ(0, stat(dir_s1d1, &dir_stat));
 	snprintf(expected_dev, sizeof(expected_dev), "%u:%u",
 		 major(dir_stat.st_dev), minor(dir_stat.st_dev));
-	snprintf(expected_ino, sizeof(expected_ino), "%lu", dir_stat.st_ino);
+	snprintf(expected_ino, sizeof(expected_ino), "%llu",
+		 (unsigned long long)dir_stat.st_ino);
 
 	set_cap(_metadata, CAP_DAC_OVERRIDE);
 	ASSERT_EQ(0, tracefs_clear());
-- 
2.53.0

