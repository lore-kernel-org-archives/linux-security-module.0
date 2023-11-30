Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ru4n/YAB"
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6C110D0
	for <linux-security-module@vger.kernel.org>; Thu, 30 Nov 2023 01:36:32 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Sgrg32D04zMqLLF;
	Thu, 30 Nov 2023 09:36:31 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Sgrg22QT6zMppBD;
	Thu, 30 Nov 2023 10:36:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701336991;
	bh=Rc1mq7YRDYcefoFHN+Nu/aHCcl2Ks0lLR4m2TUpsvSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ru4n/YABEc/0H7ta5Wwd9opYn4cM7zp8ZkPy8fGkUhdtMl4tQptzTbxacYAbIfLqi
	 l2qhwzKphAdmsKsMF/7zxw1YXfnyuCFFcW/IJOi3JNRK3+SknoxaZzEocJ54muae80
	 3UlgZ64vRPjKX1v505Kkz0/pHZpXX4GaltONITVo=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/landlock: Add tests to check unhandled rule's access rights
Date: Thu, 30 Nov 2023 10:36:16 +0100
Message-ID: <20231130093616.67340-3-mic@digikod.net>
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

Add two tests to make sure that we cannot add a rule to a ruleset if the
rule's access rights that are not handled by the ruleset:
* fs: layout1.rule_with_unhandled_access
* net: mini.rule_with_unhandled_access

Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Reviewed-by: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
* Remove confusing comment.
---
 tools/testing/selftests/landlock/fs_test.c  | 34 +++++++++++++++++++++
 tools/testing/selftests/landlock/net_test.c | 32 +++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 1e6c474e3d08..a1d17ab527ae 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -632,6 +632,40 @@ TEST_F_FORK(layout0, rule_with_unknown_access)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST_F_FORK(layout1, rule_with_unhandled_access)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
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
 static void add_path_beneath(struct __test_metadata *const _metadata,
 			     const int ruleset_fd, const __u64 allowed_access,
 			     const char *const path)
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 83d9abc3ee55..ea5f727dd257 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1301,6 +1301,38 @@ TEST_F(mini, rule_with_unknown_access)
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
+TEST_F(mini, rule_with_unhandled_access)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
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
 TEST_F(mini, inval)
 {
 	const struct landlock_ruleset_attr ruleset_attr = {
-- 
2.42.1

