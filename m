Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD823BCEE
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931773; cv=none; b=G9p4J4pm3XVfCuwxCVwt41te+UbffSdLmM7UX4f1ytqgEkMhFNNeSWGuv8pcx1uLbYlIx6rkaeR67nD8nYL9hkBXm1i22IrckEpBFcTgtyfMYQJomCD2i6T3GC8P1CV7dQZ5hz+j96gOQIGxYm9Z7f1L8wliOFyJjJOvfOrqYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931773; c=relaxed/simple;
	bh=24P3VkS7Nf0b+9oZ6vrVjqJCemLZncWE3kDN6P0m+Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiTqvXR2PAl3M6CpuCaA7hzGy6ZE44JpeEgrTFqjixJobzQrjHvMmAUGUsaN74esf5LL3p7Xzk9TbtHnZ1dBf/G+3EqkvtF4+sNUOKeTzqHhG3137/aQmok3f7Dl6tV1FGKkQzY6fRWP+Vues495yDQSScta7APQCSBlybNsHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Hd+YRxfp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRuj6qE4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Hd+YRxfp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRuj6qE4"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9C1F140013F;
	Sun, 23 Nov 2025 16:02:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 23 Nov 2025 16:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763931770; x=
	1764018170; bh=ULUNovb3ypAGtF0YUTzHEbGYDi6V5fXrNjgpUrNVg9o=; b=H
	d+YRxfpdvvPYxz53lB/nmAIvYHREQ+Wzua3LFpVDE5XqUJngYsi3+pv4Qw8Hyu+X
	QFImi1flK9cl4x5110Lf2mOAlrUp4CzOLs7sqaGkZivHOE1f/sZrdcw+SyD5kfCH
	Jqbk2RCJNr4kA2nGstTH0DkCcMm9b+6+D8nTowO7H18E4cz8t6m8zTea9C2vSg8Y
	4SsWWHrcgZdJ/VpiABwOXxf50QJwT8qDMeTRaaOmZH/75kGaIdvJw8jQekGvNB/b
	PSlUjC1zYjhiNSGRJDWuJNv9z5RJrWDXAjmyrm4aqH14XVPnX3/vd4goRa4Rru95
	jbImTajH2pEFZQNEpHQTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763931770; x=1764018170; bh=U
	LUNovb3ypAGtF0YUTzHEbGYDi6V5fXrNjgpUrNVg9o=; b=RRuj6qE4sGpOVW8zo
	CG29NFf9bz03H5VrlSSpcQ5RtB4VvUP9CwE4VKAQu13uUOL+33OYa+fUEr1SzX72
	Vnu6jsg2r5B9gBZ+HPnZQHEVFF8prKppjJmgXEHKweZBAcBvS0P3wmtt0WO2tFmW
	ydJRxPbC6i3jVdnyCoE9f8XX8zGSVf1vO9HHIJi6B9HYXkMJbjX+Ilo9WLkftaUD
	zOf8n+pkv6SvIWov3jo//mN27XTqvMG+JE0xuBVXO7/Ru+AT+prerHyczosWYH0u
	MxbZh0FAN3SMeGvGDwhCzuUvgGsCPFpjNZ5oK8DcW1ZCnwHkIR/5Nngjug9J5/2d
	CiF1w==
X-ME-Sender: <xms:enYjaX8kbhmm-zPAgkN3QvqqFPCeQoO53WX28c2ccL7SSyUMhsfd1A>
    <xme:enYjaV-okY6eZNRGQkz9KVqXjvoOCk_uBSNCKZ12M8MVkk4EqJXEweLa8jhK1ye8f
    emWXgYg7FnBeEEVxWUGS4VUsblHKuly1BVFZSCYoEZlv71ra4MZwQ>
X-ME-Received: <xmr:enYjaXTmIRaZLtN5UKOI39_ocEPZHspJeMw83hzKCGiUhsi4TGFiSg9vwBrW29NcOE6K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:enYjaZfFGntA4P-Agg-Pn-R-_cX3bk9v3H4rIBIB1mOWVj8LzK7jHA>
    <xmx:enYjabCf1Ng0supjrwFueC9k9GXvLSsuQUa1aEx5F_QBTxnxUOHI-w>
    <xmx:enYjabl9jYJpJ9k4qQuYuLLoIisgKFTf43YRMmObkXnaW7l_YdwssQ>
    <xmx:enYjaWcZmX04CAG9SCdVlLElinU5sCvRHyXGHUgQ96Svlhm8V0uiIg>
    <xmx:enYjafOfl1zXMop9xZoTBi1_nKer6P55Ei2rh2lmApLa4-qwEHgfDYS3>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:02:49 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 10/10] selftests/landlock: Add tests for invalid use of quiet flag
Date: Sun, 23 Nov 2025 20:57:46 +0000
Message-ID: <dfefb0f566cffa3984707c7a25213ce44167a379.1763931318.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763931318.git.m@maowtm.org>
References: <cover.1763931318.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v4:
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
2.52.0
