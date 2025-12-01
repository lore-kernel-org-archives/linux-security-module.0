Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C462032D
	for <linux-security-module@vger.kernel.org>; Mon,  1 Dec 2025 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764549786; cv=none; b=BghJTlUj/YK02zSGH8LNY9Oq3v8w+ptRpRX3aHAg4Sb4XzVo1fXWJyhEYlHoZMvDxfh6EpS33P9eMSqUwxKslaLiO8YzpjGAC+2y04QJD7r2B+qB6HOMtotlnz6Lvl1FjcN8PHvYrwn1Rdpjg/SpdWtuMUz+Ypxg1+MXdI0uepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764549786; c=relaxed/simple;
	bh=+tol7uBnoVDMYXgUQUOMqfxfW9bjBTLEWGxXAnIISkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZCXY0ViMku3zWOayFRCY2e9Ly+lPU2Dgx82NORhDchstnF6+2XhKcOtuusKV/3KawU1AitTGyc1aOVo/NvcLnv9qE5XqbU31Afmxz6/sMZAwl2z92tSj644c7T8vExXe/yOHSD16Oaw/HPK6BuuONmlruC4bxc7q+db6V9oyu3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=slfm3hjt; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="slfm3hjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1764549406; bh=+tol7uBnoVDMYXgUQUOMqfxfW9bjBTLEWGxXAnIISkE=;
	h=From:To:Cc:Subject:Date:From;
	b=slfm3hjtbx9kpZlJgGq3WrNwnbCWIHM+PoJkr2p3mntxcmDsHL/9R54wUJrPTCkHB
	 RZQy0Sgr7z1ZgIujx+Y/1++eq9aEMGflV55beBvFL+jTuaLudS0XUId6p6RUbiiL3Y
	 8ycjh9gLteVL2si9G3uHRt0Lp/SW60C3qhPv0OAStDmVZMOSTHg1cLZMwSKPEceX8T
	 3R3B+JT47kYGz2LqOEwDulYh0FXP8lB4EZVQ5kjRY6h+LhahABKRhOuNTHFRFwL/vi
	 agf3g1axeFd91HZ70z8XMhMsRtQOQu4MQOS/cxzjCAfalY6bRnhPR4sVObVrA6cUsR
	 Uu9TjwfUBb30w==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id C9C4C1252FC;
	Mon,  1 Dec 2025 01:36:46 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH] selftests/landlock: Remove invalid unix socket bind()
Date: Mon,  1 Dec 2025 01:36:31 +0100
Message-Id: <20251201003631.190817-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove bind() call on a client socket that doesn't make sense.
Since strlen(cli_un.sun_path) returns a random value depending on stack
garbage, that many uninitialized bytes are read from the stack as an
unix socket address. This creates random test failures due to the bind
address being invalid or already in use if the same stack value comes up
twice.

Fixes: f83d51a5bdfe ("selftests/landlock: Check IOCTL restrictions for named UNIX domain sockets")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
 tools/testing/selftests/landlock/fs_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index eee814e09dd7..7d378bdf3bce 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4391,9 +4391,6 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, cli_fd);
 
-	size = offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path);
-	ASSERT_EQ(0, bind(cli_fd, (struct sockaddr *)&cli_un, size));
-
 	bzero(&cli_un, sizeof(cli_un));
 	cli_un.sun_family = AF_UNIX;
 	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));

base-commit: 54f9baf537b0a091adad860ec92e3e18e0a0754c
-- 
2.47.3

