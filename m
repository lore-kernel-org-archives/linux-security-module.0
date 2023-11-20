Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315D4C2BB3F
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Nov 2023 19:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjKTTjc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Nov 2023 14:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKTTjb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Nov 2023 14:39:31 -0500
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2FBA2
        for <linux-security-module@vger.kernel.org>; Mon, 20 Nov 2023 11:39:27 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SYyWL07jDzMq5WX;
        Mon, 20 Nov 2023 19:39:26 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SYyWJ3yKBzMpp9v;
        Mon, 20 Nov 2023 20:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1700509165;
        bh=48FcIkzGfEEii76weJOrB9S/HMrtMrPx3YpXoamhxds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHMXpXh84S1TKBs00WYbbcTYL2FMy67Aw+nsytuWj1j9SfHuf8tk7flwgPlpKuUeC
         yQ0xRo95qLPUemihSDn2VpEJTtOG7vml3eQzmb8bU6rEDgana/1yBml3uyXEfeS4jC
         +6nYPjc2uIRh04v2hcUQo3KapoMgzp03uIPszm3I=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/2] selftests/landlock: Add tests to check undefined rule's access rights
Date:   Mon, 20 Nov 2023 20:39:13 +0100
Message-ID: <20231120193914.441117-2-mic@digikod.net>
In-Reply-To: <20231120193914.441117-1-mic@digikod.net>
References: <20231120193914.441117-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Extend two tests to make sure that we cannot add a rule with access
rights that are undefined:
* fs: layout1.file_and_dir_access_rights
* net: mini.network_access_rights

The checks test all 64 bits access right values until it overflows.

Replace one ASSERT with EXPECT in layout1.file_and_dir_access_rights .

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c  | 17 ++++++++++++-----
 tools/testing/selftests/landlock/net_test.c | 17 ++++++++++-------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 18e1f86a6234..d77155d75de5 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -548,7 +548,6 @@ TEST_F_FORK(layout1, inval)
 TEST_F_FORK(layout1, file_and_dir_access_rights)
 {
 	__u64 access;
-	int err;
 	struct landlock_path_beneath_attr path_beneath_file = {},
 					  path_beneath_dir = {};
 	struct landlock_ruleset_attr ruleset_attr = {
@@ -568,11 +567,19 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
 		open(dir_s1d2, O_PATH | O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, path_beneath_dir.parent_fd);
 
-	for (access = 1; access <= ACCESS_LAST; access <<= 1) {
+	for (access = 1; access > 0; access <<= 1) {
+		int err;
+
 		path_beneath_dir.allowed_access = access;
-		ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
-					       LANDLOCK_RULE_PATH_BENEATH,
-					       &path_beneath_dir, 0));
+		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath_dir, 0);
+		if (access <= ACCESS_LAST) {
+			EXPECT_EQ(0, err);
+		} else {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EINVAL, errno);
+			continue;
+		}
 
 		path_beneath_file.allowed_access = access;
 		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 929e21c4db05..9356f5800e31 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1246,14 +1246,17 @@ TEST_F(mini, network_access_rights)
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
 
-	for (access = 1; access <= ACCESS_LAST; access <<= 1) {
+	for (access = 1; access > 0; access <<= 1) {
+		int err;
+
 		net_port.allowed_access = access;
-		EXPECT_EQ(0,
-			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
-					    &net_port, 0))
-		{
-			TH_LOG("Failed to add rule with access 0x%llx: %s",
-			       access, strerror(errno));
+		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+					&net_port, 0);
+		if (access <= ACCESS_LAST) {
+			EXPECT_EQ(0, err);
+		} else {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EINVAL, errno);
 		}
 	}
 	EXPECT_EQ(0, close(ruleset_fd));
-- 
2.42.1

