Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HE5k4DYC"
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457B610CE
	for <linux-security-module@vger.kernel.org>; Thu, 30 Nov 2023 01:36:29 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Sgrfz4cdpzMq6hm;
	Thu, 30 Nov 2023 09:36:27 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Sgrfy5Qg1z3f;
	Thu, 30 Nov 2023 10:36:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701336987;
	bh=2vLAw3p61HdIX8Zue22jPa4HyA1Nqm7Ri2MyxWdsa4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE5k4DYCieebGpN4PShNQzVbA4sb03Xm15F8dJQ0xNISwWD9zYntQ/3lZ8rOcU6Qa
	 MG++0xtaNDxLsy8VHirDI8q/Hbd8uGhNcVODkBsEf9i7sR3xhos8dV4Rq8OUrzrrnW
	 9VhknFWKtpPIsdAAXObZdozy8zdqYTeulnvLCIb8=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/landlock: Add tests to check unknown rule's access rights
Date: Thu, 30 Nov 2023 10:36:15 +0100
Message-ID: <20231130093616.67340-2-mic@digikod.net>
In-Reply-To: <20231130093616.67340-1-mic@digikod.net>
References: <20231130093616.67340-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add two tests to make sure that we cannot add a rule with access
rights that are unknown:
* fs: layout0.rule_with_unknown_access
* net: mini.rule_with_unknown_access

Rename unknown_access_rights tests to ruleset_with_unknown_access .

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
* Move checks into their own test/loop as suggested by Günther Noack.
* Don't change layout1.file_and_dir_access_rights
---
 tools/testing/selftests/landlock/fs_test.c  | 29 ++++++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c | 27 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 18e1f86a6234..1e6c474e3d08 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -589,7 +589,7 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
-TEST_F_FORK(layout0, unknown_access_rights)
+TEST_F_FORK(layout0, ruleset_with_unknown_access)
 {
 	__u64 access_mask;
 
@@ -605,6 +605,33 @@ TEST_F_FORK(layout0, unknown_access_rights)
 	}
 }
 
+TEST_F_FORK(layout0, rule_with_unknown_access)
+{
+	__u64 access;
+	struct landlock_path_beneath_attr path_beneath = {};
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_ALL,
+	};
+	const int ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	path_beneath.parent_fd =
+		open(TMP_DIR, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+
+	for (access = 1ULL << 63; access != ACCESS_LAST; access >>= 1) {
+		path_beneath.allowed_access = access;
+		EXPECT_EQ(-1, landlock_add_rule(ruleset_fd,
+						LANDLOCK_RULE_PATH_BENEATH,
+						&path_beneath, 0));
+		EXPECT_EQ(EINVAL, errno);
+	}
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
 static void add_path_beneath(struct __test_metadata *const _metadata,
 			     const int ruleset_fd, const __u64 allowed_access,
 			     const char *const path)
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 929e21c4db05..83d9abc3ee55 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1260,7 +1260,7 @@ TEST_F(mini, network_access_rights)
 }
 
 /* Checks invalid attribute, out of landlock network access range. */
-TEST_F(mini, unknown_access_rights)
+TEST_F(mini, ruleset_with_unknown_access)
 {
 	__u64 access_mask;
 
@@ -1276,6 +1276,31 @@ TEST_F(mini, unknown_access_rights)
 	}
 }
 
+TEST_F(mini, rule_with_unknown_access)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_net = ACCESS_ALL,
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
+	for (access = 1ULL << 63; access != ACCESS_LAST; access >>= 1) {
+		net_port.allowed_access = access;
+		EXPECT_EQ(-1,
+			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+					    &net_port, 0));
+		EXPECT_EQ(EINVAL, errno);
+	}
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 TEST_F(mini, inval)
 {
 	const struct landlock_ruleset_attr ruleset_attr = {
-- 
2.42.1

