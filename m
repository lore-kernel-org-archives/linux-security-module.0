Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA02C21D8
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228966; cv=none; b=i/5CJNFMgFavZJnV0F7cREHvZ1y9p3O8Jn9jheK6MshTv7R3svzhz8auENHoAfAdSUDOONa6i5xZUA4MYtdeig54hIc/+46CS0fO4VkbcGB/+lAt/b8ubtQwe9+jmrV8L17ApbrNYXLYDGpdWWac6cvqfd/wx9LEAjmRbAuIVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228966; c=relaxed/simple;
	bh=Ru2a86M2fqoXWMHWzLgSsXr9za/N81B7hojsocd5Gdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYyR2XbmVLkzp2nsWgbZHCgYMF5+MAUW+pCLD+6m6id3VNfIxmR/mO0/jwWmeMVSiItTKmyqKW8k3wl+OOPm5c/jDwEM2Fh5kBy0vJiRd9TKY+8p0d+sBjyz67tOUdG/frghKdVpMmKOnxIc8e76QOdiOCVrIIXg9SVwyL8kxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=l1+WJPNL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JpyWe8oT; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="l1+WJPNL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JpyWe8oT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EACFF7A00F6;
	Thu, 11 Jun 2026 21:49:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 21:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781228964; x=
	1781315364; bh=oTuzTq8Yho+CQijMGMVhKlGaJlQ+kGouoR0/M7tPdxA=; b=l
	1+WJPNLPqGtsINL50LbDxiFl+RscV3kg3C95sYh6sk2ML79D/hfyjZyp/paor7Zk
	tKdwSKN9tf2EpThhpq2vrosj4lkFEL49SlnsA3uuuYKJS+qoVKzt74ZH6C6L+5RI
	QgJGdEJz2hJjaF4H+Z16+/qgB4Lery9wHUSvrt7raSshS623/rMWNuPEXM8D/uu/
	57V/KuJjJ5YQivzvRyUTNR11Uhhjo73Sm4ki+tGdtzaJJtow2n7SjzL1QKjwELIO
	+KwekYbGZPLC8W7gFTpA4DNbSIOZopGSvKr0pEiOEfGXezEw0nxucx1dCG7aute/
	G/Ru0otmPTOr8/iTfnJ3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781228964; x=1781315364; bh=o
	TuzTq8Yho+CQijMGMVhKlGaJlQ+kGouoR0/M7tPdxA=; b=JpyWe8oTdHnOlxhHJ
	0ypQoqQ6uAQJc218Osx+D2xp0Ty/T/sREui7nO2UT6CSOzHGmcT3XLElJ3dYl1Ar
	poftwjQkoUF6+np6YUSqWNuKg2CD1v0C9KHxmbAW6lkzgDWn0tKCnirxwirfQ2mh
	CrtTEIkwhAQR+2asp67titD8pCexrVlFwUvgMPTusyHW897txpqpWYb9tL21Bsct
	g07dspZaX6TiYZx1DD2dP4UgY5AiRfoeQKxI6BFSvtm08Fwi/ZWw439x/lwj2NXy
	C84phgWd9yoD3GeZQqUW6LTPb86qCn6ztPzJB/gkVmdIE+1/7cYhIzvZSt7hzQIY
	DM8nw==
X-ME-Sender: <xms:pGUravDH8IFTVFyrnwKv10y55u9jRmeLHGCYpvSR1pBr5ERUFYNWRg>
    <xme:pGUranzFNBdsaoyDAcA_EmGH0uxj0MeS-HGrrXCCRFXAamjJJws5zfYRidXI8lXPg
    TyWUy9wWbIgNOJcqYkUSNvSVGzukSd6QCmAnLx-Rh7v4jVtpCmxU9g>
X-ME-Received: <xmr:pGUras1ZeczhhwHlYtc-WpETsFhtMBe2uNxaEkrpYQX2nQ8jDCpmavJdmC8ZGYu6R8a8-BmtC36oJqPRrzkI-NQmuJl38m2vh_o5p6STr0dZcVwtcplvSVVZH28>
X-ME-Proxy-Cause: dmFkZTErrYj+6BPPVz1/IV8jcji/YbJf7tNmbzKUklDVBw37Mo5r82nPd5buxFHV4OrxKd
    +00SDQV9sSVg4R4yvs2QLHos0drG5qYNr6GNhg9D8ngYxfJUcCtRRhPXhE6kz5yGXnYKMY
    oJHiB0gAaPzyeGZH5d5BTyheBut4xCTujqDHaTful/fQaUhKYSKVr/XYUjihn5pTjMkS8X
    sKVE+fTH1iGH2FWO/9EBeuJFKXH3xovFqufQzUi7llGvIp9TU54IXL348v2qQAgPhg5ZW1
    SUBEtCpHKVb2aYxBd3Ta7zLOiViueqFsE4VHkel083qbKxQFVcQ42U+V55ljlncHcKp7NP
    ecciijLFa3Ipt6XjqLiIiSixeG8SK8WmloesLN5OOJ8VGEyRMn4mYkjtz1HkOf7a1iQ7mc
    utTiFK8iVSekhdvdVifcbJpY5mLRtFivO5CFHlWvNX11LaPjzNY8GZ1uxnZ9E3kfXmH+np
    dq9ldADxw/csYkDCWkZ1gT+v0ms0k0L0CWxKl1OVbjMzte4yR/9iqLAO89DGA7yCuCLo+9
    TczoobwC21PwC8NcO3BNG9tRjmFtDzzX4myaqKAVLY33NyxTBhzsAceEO8sPB/KXRS8gfA
    JqBxF+Bpqevuivguaz+PXdTgQHVI6JemuWecDCB6nj1qtXUR3IdYSeC41dvw
X-ME-Proxy: <xmx:pGUranzYBDRAgsU6ZRPP6whsaMzBIO1qlphw-VFkPJJr4udbzmtV2g>
    <xmx:pGUrajFplOKV8nV_PmwvQ_Y1S8BGZTmcKj0YWukschaBgn-HhABYFA>
    <xmx:pGUraqYvLJl7xeLxOdJdoEZhGkbxVQw9UeRtylPegYtiHTR4ig-p0A>
    <xmx:pGUralDJgT-rJD6pVOUZiIHqQxxOw1OGPzWJWQjxinfeurfvW5JW-A>
    <xmx:pGUrakeNpbRS1IKGx4r0oUDj33rt5AwLoA5CQZnt6U29Tsgi6XsSYhNe>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:49:23 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v11 9/9] selftests/landlock: Add tests for invalid use of quiet flag
Date: Fri, 12 Jun 2026 02:48:55 +0100
Message-ID: <9401d5c6468675863d944d6c26640d97db1a1f31.1781228815.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781228815.git.m@maowtm.org>
References: <cover.1781228815.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that these calls return EINVAL.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Tingmao Wang <m@maowtm.org>
---

Changes in v11:
- Test net/scope quiet fields too

Changes in v4:
- New patch

 tools/testing/selftests/landlock/base_test.c | 116 +++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 84e91fcaa1b2..cbd3c1669951 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -526,4 +526,120 @@ TEST(cred_transfer)
 	EXPECT_EQ(EACCES, errno);
 }
 
+TEST(useless_quiet_rule_fs)
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
+TEST(useless_quiet_rule_net)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.quiet_access_net = 0,
+	};
+	struct landlock_net_port_attr net_port_attr = {
+		.allowed_access = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.port = 1024,
+	};
+	int ruleset_fd;
+
+	drop_caps(_metadata);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(-1,
+		  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+				    &net_port_attr, LANDLOCK_ADD_RULE_QUIET));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST(invalid_quiet_bits_1)
+{
+	const struct landlock_ruleset_attr ruleset_attr_fs = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		.quiet_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	};
+	const struct landlock_ruleset_attr ruleset_attr_net = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.quiet_access_net = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	const struct landlock_ruleset_attr ruleset_attr_scoped = {
+		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+		.quiet_scoped = LANDLOCK_SCOPE_SIGNAL,
+	};
+
+	/* Quiet bit set but not part of the handled mask. */
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_fs,
+					      sizeof(ruleset_attr_fs), 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_net,
+					      sizeof(ruleset_attr_net), 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_scoped,
+					      sizeof(ruleset_attr_scoped), 0));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST(invalid_quiet_bits_2)
+{
+	const struct landlock_ruleset_attr ruleset_attr_fs = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		.quiet_access_fs = 1ULL << 63,
+	};
+	const struct landlock_ruleset_attr ruleset_attr_net = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+		.quiet_access_net = 1ULL << 63,
+	};
+	const struct landlock_ruleset_attr ruleset_attr_scoped = {
+		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+		.quiet_scoped = 1ULL << 63,
+	};
+
+	/* Quiet bit outside of the valid access range. */
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_fs,
+					      sizeof(ruleset_attr_fs), 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_net,
+					      sizeof(ruleset_attr_net), 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_scoped,
+					      sizeof(ruleset_attr_scoped), 0));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 TEST_HARNESS_MAIN
-- 
2.54.0
