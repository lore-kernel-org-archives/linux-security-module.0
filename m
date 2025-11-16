Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EED279DC2
	for <linux-security-module@vger.kernel.org>; Sun, 16 Nov 2025 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763330565; cv=none; b=omATR8pebzlpME91k3w5lCZXvK4FYPnp0d0r+WFxBeKW189YnrFCRGBvhxIO6oSa2T1X1GEp+W4BEEXImxI91zPCce2rDI5kh1btJEy3lTMLQ6RrBL11tiIKBae9VRGTggIYzunuwKebxWcTKh2aF/zyjQ4BrKxqTm562GkmFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763330565; c=relaxed/simple;
	bh=wx9nXC+GX//BFtwh1GydD4JrwSlpfKUc2CklRb+ebIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+T9YiA8UxcaDSstDodmGe3b1jy5DIIjfxLEPd/9oYS01xSztZPgT9dY1aoG8R0SpMpiJzkT94dcTs3ASWKk0jHeOYn4+Ydfp1IJaz/lAlSEyxD1mGtDuyr28EQO0h5/cyWptd9CQa2yYxTcQtdEUZ92GFRhI2HOAE3BO2HZGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=U6OFiBtr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0e3263Dd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="U6OFiBtr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0e3263Dd"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3BADF1D00086;
	Sun, 16 Nov 2025 17:02:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 16 Nov 2025 17:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763330563; x=
	1763416963; bh=MHMq/SBkqXC4hAtSqw6u2UiBQGJmvjvwsCuWJEQ/soU=; b=U
	6OFiBtrLZ7kCfJR69NcyQztxiF9hbMIIEQg6GX/BXbf+IHP1xrK48kka0aIsT3uR
	JN9Ql3QSfCMicKgdJzaew1CXEfFoSlgBfvDh4xmlSGydmMhLFK1NuXfscSuEJCMa
	xASqptBqxhvZAUUYz5g1f+zckG2WRrW9RBxtE6YhY7TXeR0+QBwEwUw0s2uFJRLM
	5bRh0qXWMME1vtfoB7aQoZYC+K5RvvFf4EqdNION070JDnoAeizVXLdZYDurDbka
	un3zBwVLNZrugbzY1rT21GjFtp50GmM5m0LnoEEU9SUtUEdLRbB2oQWsJLA8Z5K7
	VLG0tzNxkGxA7movTir8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763330563; x=1763416963; bh=M
	HMq/SBkqXC4hAtSqw6u2UiBQGJmvjvwsCuWJEQ/soU=; b=0e3263DdZhFR5lrfu
	fq/NwJlod5L1B19RM1jtIo5N8XbMbIUUYKwfSbV3/PFNOrQpFN6m72EfLlEyDJ20
	ycJupwIY9r+c4mJNdzHaoJcOa6Ws4BsjxKIV5HJIFt2UPJs3UEVSUhYTRF9VStrr
	apLUk/+/VD01LrUzNv3zF3CaOdabPmJHa6+bpqK8Ot1IpNCwF7MusP45gdGRV/vG
	C4AecNviPt2i9GLXUpkeGQKhpqecp+JvZQ+5YDSjXz2sDUhPMh3V6b5TVn4rtpp0
	owcWlzBBB0S6LbCyJqpOYXLdPEPeKKMLEwZYn0723wB58s2L4f0S6uNn8iNIgbul
	QacNg==
X-ME-Sender: <xms:AkoaaQYfPT06R7rloRyhcuWjffoCDPQqr3bcl8R7eGtY-Yu1ac6uKA>
    <xme:AkoaadqdO8ktI3n_6aFMBakkp_UVVRnXNk6qtdw0EGGEak6Ap_Gz6WsbIwDmpycT2
    2GnoY-u7WsYAWjgXlt3xwd2zvKCrqgl122GAqGlSoBuRfCEvGRs1e4>
X-ME-Received: <xmr:AkoaadPtb7pKU_tsi5f5IERLVjJpgf467oKRvgNcRsH8vxph6OeJYTzibDLWoTPmZclySzyEtDGTtT-2ZGBNLdMoTD63n2jCklhr477g4QTUZxxnVhgyua0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    uhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkh
    esshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AkoaaQpDh7hSCl9HUaO1eNDxgfOVbE-wfTEeMOettHVy5PAdHIEk6Q>
    <xmx:Akoaaadbv9gHDBATne9-vPJXjfanAqxrPxb5qRHs7UDsNeJAfOhLlw>
    <xmx:AkoaaeRvE9gehxpwoC2EDyPPKmeoI7vQBwinL8XUJxND4QWzEg3qDg>
    <xmx:AkoaabbX18gVwBgBVQrgf8zRxUUbFSpHy790Yg7XMuphD4rWEITMUg>
    <xmx:A0oaaf4wyMv7Uuy6a_wPm7UqQ12V7evkW-RKzF2v67A3309czapKpo0c>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 17:02:41 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 10/10] selftests/landlock: Add tests for invalid use of quiet flag
Date: Sun, 16 Nov 2025 21:59:40 +0000
Message-ID: <969ec5a149bee4ec5ab63c4223cb0c3834ee8804.1763330228.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763330228.git.m@maowtm.org>
References: <cover.1763330228.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes since v3:
- New patch

 tools/testing/selftests/landlock/base_test.c | 57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index b34b340c52a5..055d416508a0 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -526,4 +526,61 @@ TEST(cred_transfer)
 	EXPECT_EQ(EACCES, errno);
 }
 
+TEST(useless_quiet_rule)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		.quiet_access_fs = 0,
+	};
+	struct landlock_path_beneath_attr path_beneath_attr = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	int ruleset_fd, root_fd;
+
+	drop_caps(_metadata);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	root_fd = open("/", O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, root_fd);
+	path_beneath_attr.parent_fd = root_fd;
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath_attr,
+					LANDLOCK_ADD_RULE_QUIET));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Check that the rule had not been added. */
+	ASSERT_EQ(0, close(root_fd));
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST(invalid_quiet_bits_1)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		.quiet_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	};
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+					      sizeof(ruleset_attr), 0));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST(invalid_quiet_bits_2)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		.quiet_access_fs = 1ULL << 63,
+	};
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+					      sizeof(ruleset_attr), 0));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 TEST_HARNESS_MAIN
-- 
2.51.2
