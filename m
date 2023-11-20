Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512FAC197A0
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Nov 2023 19:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjKTTje (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Nov 2023 14:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjKTTjd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Nov 2023 14:39:33 -0500
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C4CA0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Nov 2023 11:39:30 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SYyWN4cmRzMqBGw;
        Mon, 20 Nov 2023 19:39:28 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SYyWM6T4mz3X;
        Mon, 20 Nov 2023 20:39:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1700509168;
        bh=dhICoXqRKTZDQa3TOKCVLgfSW5zBAPBd9AY31xPTtZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rTwYPwyiaorKg7CJCZOIBOL/nPvXHCHceLqcNQ0WoZ8ltulX5boVReCEDpxs4SwRZ
         wZHlf8YnSLnfM/LUe2+bLHICNVXFGseemBUPgCgjUqSTa4oeYMON6gO5V3ipxo3qP1
         73+qXR4G/4/us9GqTvnd+B01Zxnd05iAWN8jQegw=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/landlock: Add tests to check unhandled rule's access rights
Date:   Mon, 20 Nov 2023 20:39:14 +0100
Message-ID: <20231120193914.441117-3-mic@digikod.net>
In-Reply-To: <20231120193914.441117-1-mic@digikod.net>
References: <20231120193914.441117-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add two tests to make sure that we cannot add a rule to a ruleset if the
rule's access rights that are not handled by the ruleset:
* fs: layout1.rule_with_unhandled_access
* net: mini.rule_with_unhandled_access

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c  | 35 +++++++++++++++++++++
 tools/testing/selftests/landlock/net_test.c | 33 +++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index d77155d75de5..8cabcbe3554e 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -596,6 +596,41 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST_F_FORK(layout1, rule_with_unhandled_access)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		/* First bit */
+		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
+	};
+	struct landlock_path_beneath_attr path_beneath = {};
+	int ruleset_fd;
+	__u64 access;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	path_beneath.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+
+	for (access = 1; access > 0; access <<= 1) {
+		int err;
+
+		path_beneath.allowed_access = access;
+		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath, 0);
+		if (access == ruleset_attr.handled_access_fs) {
+			EXPECT_EQ(0, err);
+		} else {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EINVAL, errno);
+		}
+	}
+
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 TEST_F_FORK(layout0, unknown_access_rights)
 {
 	__u64 access_mask;
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 9356f5800e31..aec01917abd5 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1262,6 +1262,39 @@ TEST_F(mini, network_access_rights)
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
+TEST_F(mini, rule_with_unhandled_access)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		/* First bit */
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+	struct landlock_net_port_attr net_port = {
+		.port = sock_port_start,
+	};
+	int ruleset_fd;
+	__u64 access;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	for (access = 1; access > 0; access <<= 1) {
+		int err;
+
+		net_port.allowed_access = access;
+		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+					&net_port, 0);
+		if (access == ruleset_attr.handled_access_net) {
+			EXPECT_EQ(0, err);
+		} else {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EINVAL, errno);
+		}
+	}
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 /* Checks invalid attribute, out of landlock network access range. */
 TEST_F(mini, unknown_access_rights)
 {
-- 
2.42.1

