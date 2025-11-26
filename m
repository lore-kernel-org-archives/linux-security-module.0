Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7D325736
	for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159669; cv=none; b=ayvCbJ9fdCLq369+WRoiBYtWvDej9aHI3lSg7/Ggx9gGCZUC7Ws+xcjZVdheF6/jolzJsHLR2xOX3VRq6TAHZsutNcfVCg4kUKfh7ssRnpSpXyzvepi9AEdJ2EKPgSGt8QDU9HZC45F310CKpPHMycFV9bH50Uv8/usJmij9C9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159669; c=relaxed/simple;
	bh=3bdEA+irE7hfczY2Gd9pgrHg+1yB0OyzS5PNNPSeGPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxwNDwWiX24jV1vmKxRpIUjwoFSfAOeCyk5PCtppqg/gMlOgWnE28UwiGmVHGvEUMkBLMh6jnz5oQiqxaodEDr0dMwYA36PgC8gN3/UiiwjTYGZCeI15lPLGHtjQsY8I2swau8pwbwnVJDs/WpjnNOIL0of6/FZGItlDi8K/8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5BoS04s; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5BoS04s"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64306a32ed2so3980830d50.2
        for <linux-security-module@vger.kernel.org>; Wed, 26 Nov 2025 04:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764159665; x=1764764465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q0wc9nZjppjb4gBqRMgr5wVBS1dfN/3fzCWOLHe8ts=;
        b=U5BoS04sfjCcMLt23FxLfm6unAvAAxqULS7YW/CXkvM8vZ97MrAIQCSkmLDa44UzOz
         sZXcf0JP8YtyLH2OYrxvLB3oAwZdQ65HKePUS+mnkn2M0tdGYv/Hwfh+oAtjeqzK4/VH
         mBcMeTpOZYjbVGP+phcSiOiiLTxbvTCZZ01+uql26MReE1FkhWb4sS68/lA76yT/hdRX
         e7iQUaTecrfORn9WYesXhoV9UaZGIiHBvqoaHCWJ75M4wGFCrHZoBW+NRnV4Z8RbVvwL
         cPqN5BZYIR77T5MlihDh+bIYCEzH717RqYVMX2DTPIAXr9ROJ8olHZeMoG8SnBJW+RW+
         P/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764159665; x=1764764465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Q0wc9nZjppjb4gBqRMgr5wVBS1dfN/3fzCWOLHe8ts=;
        b=WcVhYYSNjhZWaXRUE/dn1BKSqWEVuDFqZieMEhb0z8DrBzYow5zN0tO0/+53JjIlQ/
         c8DT0RuRKnTQ2u/Ap/XJpofbNWfu5DkUSlxw2xXvSMr7xcJDjQN8RbvRcHXqCiuqtrcn
         Ud2lwnjVcPil8xZw/ZUZwXzF4UQBVSA5jdA6egsZ0MzciSBOXlmtinnKpv177y/T5J/n
         83NvxUSc5tj0iWDrqI3HnDKCDbonTeE7kswY+beFDvdNOXbGNEvfURg2iwKVACjzZuZU
         L2Wr3YtJUajers8uifOP5S3xHGylsQt+qvMhkyD6rC85Ioi2fZEHqHb6zayUZTb3na9W
         UAUQ==
X-Gm-Message-State: AOJu0YwPWzHp2i0AKIZXGvoTBctxX1xqbXhz49E/TqnZM55zOQ7b/gfp
	HYJ5LPMY+cp4i3x+tewqIrXrjsfTEyNFnHGA8+m0b/JJJukVASsSsQYoLlkdXJ51
X-Gm-Gg: ASbGncsmhicf+k5PrpULRhkPL28bnDhFuSZD/ZzNKLa0+YRtdjzsWN8jwkwqkX6S+FQ
	V9xCSPlUHVMvmoxWL4flqkfKx26oKLddodsb0pBGi+CoLy+RnkpGGIPa1IYEeIcuOgthXi0hBZs
	e3bD9Elv6ae9M5APkyDay5uYtgwWvYZL82i5I8OozTauqPbb6ewYsjXzEzDJ2TcaRSXTsl0tgYl
	NKdaeo/6enxWs7mhBwcmTCZxLUWNKxVuM0rEIB7yIEjeOId3shO3iKj0bmlgouvVTBiOmhStdB3
	CpoNjsIpvOahiU1AGhUXumnPZqqU+HKjaX8dY3MJnRuxzV7vmSNX0N/vAwHdQsv7fQYeXXmn90a
	KRZmbh2KGDb4AGPla1DT97rCVELz+8UHvvh5qI9tMC4Zwyf2h9OHw8u4uKBacUdGTfM29ZiCDSR
	4PG4UBLgO40kR0J/VXna2K3f14J42Jq32Qelr0eXAOvhfizc1B82Vmz0RvRfCz
X-Google-Smtp-Source: AGHT+IEiiQeZh2WnXoH8aNCUJFfwhy9WCLZbXzZuW6pslrTvtHpyrxYZZf5AkRsvTuBdBPHfGJAUzA==
X-Received: by 2002:a05:690e:1442:b0:640:c9cc:6a98 with SMTP id 956f58d0204a3-64302ac7343mr11501879d50.66.1764159665005;
        Wed, 26 Nov 2025 04:21:05 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7992799dsm66318057b3.33.2025.11.26.04.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:21:04 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 4/5] selftests/landlock: Implement selftests for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Wed, 26 Nov 2025 07:20:37 -0500
Message-ID: <20251126122039.3832162-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126122039.3832162-1-utilityemal77@gmail.com>
References: <20251126122039.3832162-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements 11 selftests for the flag, covering allowed and disallowed operations on parent
and child directories when this flag is set, as well as multi-layer configurations
and flag inheritance / audit logging.

v2..v3 changes:

  * Also covers flag inheritance, audit logging and LANDLOCK_ADD_RULE_QUIET suppression.
  * Increases number of selftests from 5 -> 11.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 459 ++++++++++++++++++++-
 1 file changed, 447 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6aa65d344c72..87b66ad7a0b8 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -717,16 +717,12 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
 }
 
 static void add_path_beneath(struct __test_metadata *const _metadata,
-			     const int ruleset_fd, const __u64 allowed_access,
-			     const char *const path, bool quiet)
+			 const int ruleset_fd, const __u64 allowed_access,
+			 const char *const path, __u32 flags)
 {
 	struct landlock_path_beneath_attr path_beneath = {
 		.allowed_access = allowed_access,
 	};
-	__u32 flags = 0;
-
-	if (quiet)
-		flags |= LANDLOCK_ADD_RULE_QUIET;
 
 	path_beneath.parent_fd = open(path, O_PATH | O_CLOEXEC);
 	ASSERT_LE(0, path_beneath.parent_fd)
@@ -790,7 +786,7 @@ static int create_ruleset(struct __test_metadata *const _metadata,
 			continue;
 
 		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
-				 rules[i].path, false);
+				 rules[i].path, 0);
 	}
 	return ruleset_fd;
 }
@@ -1368,7 +1364,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * ANDed with the previous ones.
 	 */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
-			 dir_s1d2, false);
+			 dir_s1d2, 0);
 	/*
 	 * According to ruleset_fd, dir_s1d2 should now have the
 	 * LANDLOCK_ACCESS_FS_READ_FILE and LANDLOCK_ACCESS_FS_WRITE_FILE
@@ -1400,7 +1396,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * Try to get more privileges by adding new access rights to the parent
 	 * directory: dir_s1d1.
 	 */
-	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1, false);
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Same tests and results as above. */
@@ -1423,7 +1419,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * that there was no rule tied to it before.
 	 */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
-			 dir_s1d3, false);
+			 dir_s1d3, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
@@ -1476,7 +1472,7 @@ TEST_F_FORK(layout1, inherit_superset)
 	add_path_beneath(_metadata, ruleset_fd,
 			 LANDLOCK_ACCESS_FS_READ_FILE |
 				 LANDLOCK_ACCESS_FS_READ_DIR,
-			 dir_s1d2, false);
+			 dir_s1d2, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
@@ -1488,6 +1484,111 @@ TEST_F_FORK(layout1, inherit_superset)
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 }
 
+TEST_F_FORK(layout1, inherit_no_inherit_flag)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW,
+	};
+	int ruleset_fd;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1, 0);
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d2,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Parent directory still grants write access to its direct children. */
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_WRONLY));
+
+	/* dir_s1d2 gets only its explicit read-only access rights. */
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+
+	/* Descendants of dir_s1d2 inherit the reduced access mask. */
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+}
+
+TEST_F_FORK(layout1, inherit_no_inherit_nested_levels)
+{
+	int ruleset_fd;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				     LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				     LANDLOCK_ACCESS_FS_REMOVE_DIR,
+	};
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Level 1: s1d1 (RW + REFER + REMOVE + NO_INHERIT) */
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				 LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				 LANDLOCK_ACCESS_FS_REMOVE_DIR,
+			 dir_s1d1, LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	/* Level 2: s1d2 (RO + NO_INHERIT) */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d2,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	/* Level 3: s1d3 (RW + REFER + REMOVE + NO_INHERIT) */
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				 LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				 LANDLOCK_ACCESS_FS_REMOVE_DIR,
+			 dir_s1d3, LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Level 3: s1d3
+	 * - RW allowed (unlink file)
+	 * - REFER allowed (rename file)
+	 * - REMOVE_DIR denied (parent s1d2 is part of direct parent tree)
+	 */
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	ASSERT_EQ(0, rename(file2_s1d3, file1_s1d3));
+	ASSERT_EQ(0, rename(file1_s1d3, file2_s1d3));
+	ASSERT_EQ(-1, rmdir(dir_s1d3));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Level 2: s1d2
+	 * - RW denied (unlink file), layer is RO
+	 * - REFER denied (rename file)
+	 * - REMOVE_DIR of s1d2 not allowed (parent s1d1 is part of direct parent tree)
+	 */
+	ASSERT_EQ(-1, unlink(file1_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(file2_s1d2, file1_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rmdir(dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Level 1: s1d1
+	 * - RW allowed
+	 * - Rename allowed (except for direct parent tree s1d2)
+	 * - REMOVE_DIR denied (parent tmp is denied)
+	 */
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, rename(file2_s1d1, file1_s1d1));
+	ASSERT_EQ(0, rename(file1_s1d1, file2_s1d1));
+	ASSERT_EQ(-1, rmdir(dir_s1d1));
+	ASSERT_EQ(EACCES, errno);
+}
+
 TEST_F_FORK(layout0, max_layers)
 {
 	int i, err;
@@ -4412,6 +4513,246 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	ASSERT_EQ(0, close(cli_fd));
 }
 
+TEST_F_FORK(layout1, inherit_no_inherit_topology_dir)
+{
+	const struct rule rules[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{},
+	};
+	int ruleset_fd;
+
+	ruleset_fd = create_ruleset(_metadata,
+				    ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				    rules);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Adds a no-inherit rule on a leaf directory. */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d3,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Topology modifications of the rule path and its parents are denied.
+	 */
+
+	/* Target directory s1d3 */
+	ASSERT_EQ(-1, rmdir(dir_s1d3));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d3));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Parent directory s1d2 */
+	ASSERT_EQ(-1, rmdir(dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d2));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Grandparent directory s1d1 */
+	ASSERT_EQ(-1, rmdir(dir_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(dir_s1d1, dir_s2d1));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Sibling operations are allowed.
+	 */
+	/* Sibling of s1d3 */
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	/* Sibling of s1d2 */
+	ASSERT_EQ(0, unlink(file1_s1d1));
+
+	/*
+	 * Content of the no-inherit directory is restricted by the rule (RO).
+	 */
+	ASSERT_EQ(-1, unlink(file1_s1d3));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F_FORK(layout1, no_inherit_allow_inner_removal)
+{
+	int ruleset_fd;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+	};
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE, dir_s1d2,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Content of the no-inherit directory is mutable (RW).
+	 * This checks that the no-inherit flag does not seal the content.
+	 */
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	/*
+	 * Topology modifications of the rule path are denied.
+	 */
+	ASSERT_EQ(-1, rmdir(dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d2));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F_FORK(layout1, inherit_no_inherit_topology_unrelated)
+{
+	const struct rule rules[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_RW,
+		},
+		{},
+	};
+	static const char unrelated_dir[] = TMP_DIR "/s2d1/unrelated";
+	static const char unrelated_file[] = TMP_DIR "/s2d1/unrelated/f1";
+	int ruleset_fd;
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Adds a no-inherit rule on a leaf directory unrelated to s2. */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d3,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Ensure we can still create and delete files outside the sealed branch. */
+	ASSERT_EQ(0, mkdir(unrelated_dir, 0700));
+	ASSERT_EQ(0, mknod(unrelated_file, S_IFREG | 0600, 0));
+	ASSERT_EQ(0, unlink(unrelated_file));
+	ASSERT_EQ(0, rmdir(unrelated_dir));
+
+	/* Existing siblings in s2 remain modifiable. */
+	ASSERT_EQ(0, unlink(file1_s2d1));
+	ASSERT_EQ(0, mknod(file1_s2d1, S_IFREG | 0700, 0));
+}
+
+TEST_F_FORK(layout1, inherit_no_inherit_descendant_rw)
+{
+	const struct rule rules[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_RO,
+		},
+		{},
+	};
+	const __u64 handled_access = ACCESS_RW | LANDLOCK_ACCESS_FS_MAKE_REG |
+				     LANDLOCK_ACCESS_FS_REMOVE_FILE;
+	static const char child_file[] =
+		TMP_DIR "/s1d1/s1d2/s1d3/rw_descendant";
+	int ruleset_fd;
+
+	ruleset_fd = create_ruleset(_metadata, handled_access, rules);
+	ASSERT_LE(0, ruleset_fd);
+
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d2,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_MAKE_REG |
+				 LANDLOCK_ACCESS_FS_REMOVE_FILE,
+			 dir_s1d3, 0);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, mknod(child_file, S_IFREG | 0600, 0));
+	ASSERT_EQ(0, unlink(child_file));
+}
+
+TEST_F_FORK(layout1, inherit_no_inherit_topology_file)
+{
+	const struct rule rules[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_RW,
+		},
+		{},
+	};
+	int ruleset_fd;
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = ACCESS_RO,
+	};
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+	ASSERT_LE(0, ruleset_fd);
+
+	path_beneath.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath,
+					LANDLOCK_ADD_RULE_NO_INHERIT));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F_FORK(layout1, inherit_no_inherit_layered)
+{
+	const struct rule layer1[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{},
+	};
+	int ruleset_fd;
+	static const char unrelated_dir[] = TMP_DIR "/s2d1/unrelated";
+	static const char unrelated_file[] = TMP_DIR "/s2d1/unrelated/f1";
+
+	/* Layer 1: RW on TMP_DIR */
+	ruleset_fd = create_ruleset(_metadata,
+				    ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				    layer1);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Layer 2: Add no-inherit RO rule on s1d2 */
+	ruleset_fd = create_ruleset(_metadata,
+				    ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				    layer1);
+	ASSERT_LE(0, ruleset_fd);
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d2,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Operations in unrelated areas should still work */
+	ASSERT_EQ(0, mkdir(unrelated_dir, 0700));
+	ASSERT_EQ(0, mknod(unrelated_file, S_IFREG | 0600, 0));
+	ASSERT_EQ(0, unlink(unrelated_file));
+	ASSERT_EQ(0, rmdir(unrelated_dir));
+
+	/* Creating in s1d1 should be allowed (parent still has RW) */
+	ASSERT_EQ(0, mknod(TMP_DIR "/s1d1/newfile", S_IFREG | 0600, 0));
+	ASSERT_EQ(0, unlink(TMP_DIR "/s1d1/newfile"));
+
+	/* Content of s1d2 should be read-only */
+	ASSERT_EQ(-1, unlink(file1_s1d2));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Topology changes to s1d2 should be denied */
+	ASSERT_EQ(-1, rename(dir_s1d2, TMP_DIR "/s2d1/renamed"));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Renaming s1d1 should also be denied (it's an ancestor) */
+	ASSERT_EQ(-1, rename(dir_s1d1, TMP_DIR "/s2d1/renamed"));
+	ASSERT_EQ(EACCES, errno);
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
 
@@ -7088,6 +7429,100 @@ TEST_F(audit_layout1, write_file)
 	EXPECT_EQ(1, records.domain);
 }
 
+TEST_F(audit_layout1, no_inherit_parent_is_logged)
+{
+	struct audit_records records;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW,
+	};
+	int ruleset_fd;
+
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+					     sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Base read-only rule at s1d1. */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d1, 0);
+	/* Descendant s1d1/s1d2/s1d3 forbids inheritance but should still log. */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d3,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.write_file", file1_s1d2));
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F(audit_layout1, no_inherit_blocks_quiet_flag_inheritence)
+{
+	struct audit_records records;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW,
+		.quiet_access_fs = ACCESS_RW,
+	};
+	int ruleset_fd;
+
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+					     sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Base read-only rule at tmp/s1d1 with quiet flag. */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d1,
+			 LANDLOCK_ADD_RULE_QUIET);
+	/* Descendant tmp/s1d1/s1d2/s1d3 forbids inheritance of quiet flag and should still log. */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d3,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.write_file", file1_s1d3));
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F(audit_layout1, no_inherit_quiet_parent)
+{
+	struct audit_records records;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW,
+		.quiet_access_fs = ACCESS_RW,
+	};
+	int ruleset_fd;
+
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+					     sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Base read-only rule at tmp/s1d1 with quiet flag. */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d1,
+			 LANDLOCK_ADD_RULE_QUIET);
+	/* Access to dir_s1d1 shouldn't log */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RO, dir_s1d3,
+			 LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_NE(0, matches_log_fs(_metadata, self->audit_fd,
+				    "fs\\.write_file", file1_s1d1));
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(0, records.domain);
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 TEST_F(audit_layout1, read_file)
 {
 	struct audit_records records;
@@ -7647,7 +8082,7 @@ static int apply_a_layer(struct __test_metadata *const _metadata,
 			continue;
 
 		add_path_beneath(_metadata, rs_fd, r->access, r->path,
-				 r->quiet);
+				 r->quiet ? LANDLOCK_ADD_RULE_QUIET : 0);
 	}
 
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
-- 
2.51.0

