Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A609EADC
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272066; cv=none; b=FlXcTKPtG57xYdV+oimknNw/8H8wp+JKhFFzW1pLXB5oYk1y3OQAFImCjzzAb/4TNSg+RCxe1BkPYWcJwwfnNZ4n2soUQR16FfptrjPqph6Cc+qedsQGsGr+XUwqpZjaolXe2aPPhwGW86gJi885HEyfMU8e60DzAdpXrwSMEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272066; c=relaxed/simple;
	bh=cUhv65Nn1WWcYgngADsl6N9ARMwd14CNSvmcI0iRDpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWUmWvF2PX8KuEVUZW3JguDNyewUA/v4budZ0OplQsOQJph6wqNT6g2MUPurFAeBBFgWFoCd9bYkcuuI0KgXhvIGg1Gf9rL/QVUl4xL5rK/m0b6Ak3y92Ba4X/FEAPPsZSYg/PlYvDPtYorM/DefbIa2bAs1YYXNh6PGJ17oxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=NfM/Dou9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrWUaF4A; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="NfM/Dou9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrWUaF4A"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 498AF1D000B1;
	Sun, 31 May 2026 20:01:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 31 May 2026 20:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780272064; x=
	1780358464; bh=b13pEkIfIiiSJ6xPQK2ZRzTYTz5AXB6jDcLQcP8HpD0=; b=N
	fM/Dou9RRlfC+z5/7+Hw+I2o+SModWwde4Yz9AjbPy+s/rt15jcvLnUYH99AAkT3
	2pEIB0Ue88Ne8pwW27N4JG5MQvSc2slO8DopDkSVLOooY0azMKOyM5FXzdkj1Jur
	dUM1DJ0Q48p1jXPhi8jRe6Q3TO3OTF9lCHSrHaeTXQ0AuVMl2xzwTNiCpn6jecG3
	r5KyzOOMRA6ugNdor927URhVy3azNvhd62vSffxg5OXEYDmqu0XkN4zA5Z2/ZmnA
	LqLosJ8Jk4rV/popfZHwwz57xQ+8xpSlj9L9B4yq05ztppsENoMQdlUv4sUhWzCI
	1oPDh/qLgxq7Bg5bFUvYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1780272064; x=1780358464; bh=b
	13pEkIfIiiSJ6xPQK2ZRzTYTz5AXB6jDcLQcP8HpD0=; b=VrWUaF4AL6Yz8LKaV
	wrQt/KUAOq5feN37wVjC2fOJnraYD+b1DvaYRC9yLw6+Z1VypuhOuduOKLbNaVtp
	A/lgGxHUZ/QYx+wW4KSCCIVsODDBAjSGlSZCJGBYH2cDUD28QmLM/xa44FQolAMA
	pdk013TwBMiTq5xPgGyTbHwLF85I6bDqbvyJ6/JtSYE/ccbkOHqizgT/Rht8B5Ba
	7eplTpPhD+SGYHXC/G8Oi1JCv7S/9ad8zdbqy3OUQzIVYpVknSe7krqYlLC87HJi
	PJU9fCifB1nhrCFLqKGAdTqLPqgyNO1NioVlurCkce90JENFhj49hPXRITwCxgfa
	YW0Fg==
X-ME-Sender: <xms:wMscaoNYpT0kbK49I830S3QuP93dlHJXjoUFlqbCol5V5sUlUiV1kg>
    <xme:wMscahNmfv5R0TV9vCIowjUZolV6f9OwfGVFT6RRyRgoDXDiKS9Exi9YXKggxN690
    66NnowLNCN8oIgD65H6TD-Z2sOKiHrWy7BjxKxxLtuVbQFMjVl8CUo>
X-ME-Received: <xmr:wMscahhkTmrZq0X1kIDS8nF1JaBokGGpoa3G6Coq-Vt81rNe3J-pbAqJgfDTQzaemVA>
X-ME-Proxy-Cause: dmFkZTFaMgvtkU5cUMPK0yU98oDvWOzpAYeMhN6aMUXtU4L7MwcKncPHJaPl4+cGgu1JI0
    EJ65/ML7NvOlSUVJa8l5uXMdv/mUnguQOCcC2icc1ZXjjLsNzMkUCKyQlbEBicETnqmtP8
    V4/nafj+1tyqc2otrRysHo6IhIGGM5np390qdDh9LEaeKa/4Qws/BPAZKjy+dDxKryc9qg
    Q8A0sIEGZz09juiWINU35VdyeilGbBB5ZoHpZXLIhRHy2THMHvko/tD37PFkmt4QtvfETI
    tQU1e/n24xflYW4xXjnlT4AP+bCyLpkxJbnO5GERtfQL3ejxX6XVGxqiE+iMrJ8Aq/pSJf
    PtQGNRXx2mA7l7r7IyuNnPJmNpX3MuGx2NKWPQzsse0d9XQQv7QQYfyhrESqUyTW+IHFun
    RrKOzZka+NpCTlDdtXAp0wxe9iMFO/wTPQWFexeyf5feuEV3zvJ6WxOaeOPjqJCp5oVfv6
    aeCEItG+qNHV5a716XI9xXfFSLhuMHSKd/o0e759i3jD/Pv6ZqY8YM8sfNiJQxpdBhHZqH
    N5+auYGFdpi/t4mA8bidvrSyJKLn3X3429hBMiSi+W8CWoBpapLVuWeSZjhdZPa5LEaOMA
    ezyWGh+bP7+CESRzx2XBw5cdB3zqQJx0CIbAZsoLWth/fC7LRzgRCzTt3X1g
X-ME-Proxy: <xmx:wMscamucHVapJ9jBlVB_2refbwIfGPTZ_CzTifj68Vemx1JbdKFXYQ>
    <xmx:wMscavSPfImX4Z1r6P_y6OPtx-r5TItqcIDT8YYV8k2FAHjvhEKFiw>
    <xmx:wMscaq3imxKCukwCHF2bndZyi4JWQ4HLfnY26gxbXcC9SYoOC_zVLw>
    <xmx:wMscaktNXWsKXYpGPQkcJwN1lkTg0y8meSuCgJcp5FO6sNbaK6r7XQ>
    <xmx:wMscaqaT_sMiqxvFcrsA0ZboowRKIEhZzJ1_MVpmbDIM8CT_UAuh9pgQ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:01:02 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v10 5/9] selftests/landlock: Replace hard-coded 16 with a constant
Date: Mon,  1 Jun 2026 01:00:39 +0100
Message-ID: <911b1de2f2a543bce5b84d8a228c79df75fec2f3.1780272022.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780272022.git.m@maowtm.org>
References: <cover.1780272022.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit will reuse this number.  Make it a shared constant to
future-proof changes.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v3:
- New patch

 tools/testing/selftests/landlock/audit_test.c | 2 +-
 tools/testing/selftests/landlock/common.h     | 2 ++
 tools/testing/selftests/landlock/fs_test.c    | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 132c18006d07..7044781357c0 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -79,7 +79,7 @@ TEST_F(audit, layers)
 		.scoped = LANDLOCK_SCOPE_SIGNAL,
 	};
 	int status, ruleset_fd, i;
-	__u64(*domain_stack)[16];
+	__u64(*domain_stack)[LANDLOCK_MAX_NUM_LAYERS];
 	__u64 prev_dom = 3;
 	pid_t child;
 
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 90551650299c..7206d5105d66 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -25,6 +25,8 @@
 /* TEST_F_FORK() should not be used for new tests. */
 #define TEST_F_FORK(fixture_name, test_name) TEST_F(fixture_name, test_name)
 
+#define LANDLOCK_MAX_NUM_LAYERS 16
+
 static const char bin_sandbox_and_launch[] = "./sandbox-and-launch";
 static const char bin_wait_pipe[] = "./wait-pipe";
 static const char bin_wait_pipe_sandbox[] = "./wait-pipe-sandbox";
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cdb47fc1fc0a..10d9355ade5f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1441,7 +1441,7 @@ TEST_F_FORK(layout0, max_layers)
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
 		enforce_ruleset(_metadata, ruleset_fd);
 
 	for (i = 0; i < 2; i++) {
-- 
2.54.0
