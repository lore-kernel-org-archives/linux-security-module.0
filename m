Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7B34C811
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677451; cv=none; b=XIZsjunC1pTsI/ZK0FszwyTvs3r4fCUFz60QGED0EYEKXkPcfMOkkTuPocaX1+vqfn375NDzNiR9RCFY8mnA8hLl1zlPnG+ZTtkNs3xcJSXYZCKb7xA0rYUwDRHWT7RdOuST50E2uKaawg9qz2zZfOoF3FJKQyuVoUjgqplB1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677451; c=relaxed/simple;
	bh=+l0A1ZsaHB+YqH4/0LB18H6atjpd/H9rCdhg9nVl5R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyJvlDit24KMliOeleZX1xuPAbL8xP6Nc7ctgvqGxM9HHw/h4c+isFr2QCYmb5QtUeTe5s+PJl2H41a39d3Nacjt5R8EP6ydPdbGIAxXPx7c9OHxEvh4S5LPaCal60w1/Opkxisnhya2oBdawA/VUk0PPsvGeTzjKiyS5mHBs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEWilbpx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEWilbpx"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7895017c722so14113497b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 14:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763677446; x=1764282246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx+yWm9IGQZ0wcAhyXwJxNhL34knZcBkBnmzIMrYmIs=;
        b=hEWilbpx/cgPbGrOjZeTHs82rS3jHB+rGy9n7AXUsYCi4yDJ0om3AZxSrjaYToNnC9
         m+6zpF85ySrmO0IukwIf5V6FJ4H9GDLg52N5DlvtHj4kW4yD1mCjJ+cxEC2lkSsRn5/D
         fdEpsl9cpqpqEwiHTO3nlnpBs3LCRcCcmZfv5BWFZai9DuJXp1Uq2T55uC0+kjayDuHT
         5e4yDjRQAOyGuqCoOI67v7sTlZ8sE7aR/qdEo1kx0/1cGCxQ5HI34/ceF9xyCphnNwLc
         Zx1JOJryHwrw9vmO5ydbn/z6myv9NmuplBtnksZ47SUqdDDmPV6y8GGWSlaZ7/3DqoRa
         7S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763677446; x=1764282246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mx+yWm9IGQZ0wcAhyXwJxNhL34knZcBkBnmzIMrYmIs=;
        b=tlwZHVE9hTzJfeF6B1b2eDfvnWaIdtvq/Igt4uEZsSMLeti1S8bvOfiqYgSvfHGOBi
         ozFNCzDBk4lYyGW19F1abLeaagTClhj+mab6m0iixmVx6EXzaeHxICDU26znevUBvQZH
         H7Py1gFfXqBsWUNoUqIcwgTvoE9HIPRc8X00nnjQbgnlYOkOn+IPZ7sDndj/vudQucdC
         0X9D4YQFROArwiRZrwj0lewRRsMc7WCnJuAH/SyPpd185XXIhtPUzo13e8f2BqfZcRDg
         D8XMeCr8WVd7y5tCRVQD3w+r/erQXGBwGdwNOKl+8zeRr1XA+B4qeITtNJz4F64fitUU
         rQYQ==
X-Gm-Message-State: AOJu0YyZ3BvIPyJQdmqMiY0PttowMOeXbyw+XGlmXRHGHPOSXXsDNtzy
	BUI7p+iVJfP2ga3+Ce0DSOmJe4UXj5ku5b850u7BPRCJxlylts26kXels0409fJ9Ub8c1A==
X-Gm-Gg: ASbGncssXfAdfUD1LPDdkgs+3Jq7PRroe7otpwD+OZucaxAHtkWdETVFqF+rs6mdLSL
	F9zrRcl/opTzc7cXMEgWvlANTYxaBSibNd+YJDy9NDGbhbeXFE6d3XBMvE9PrQMLYH12UTHVZ9t
	xqWCHa15F/rDeJIWp8eIjIn4slFoR31LKzg2+Y7YH6hviHsIorWQ+/oQDbjJTKVyt+L+1OwNrb0
	qSbijgW+2V5v37pplJ4kKtbRfVP14U0CMFJ7eVIij8qjnY77bjE9ANjndGk+NANf36RiTqa3hz7
	3fcIJX2oBKNQ9caA2bL8dKlbs5qqzQEE8jXLjcpxOGgFVM4AGOql2kkfEFAkC7VRu6HSkPnpq+3
	9RxcCkU1PFiZQsTPYoBSevtnKKaCSI5hyHuom6QS5/JRQ4P9JgG6wgT7+OzgvrcnmP5cKuLSVk3
	Y6FZUitVzNc/3qGs06xA5sQM6qsWDyJR50fG5vlSh3G2IZgXsWHZLh5DCD+seo
X-Google-Smtp-Source: AGHT+IGj1l9e5PTlDXp4KS10BTFkfUdPsSk5//vQB+GrdG9GZGkknrDge/eD6SXs46JeQOhYmb/B6Q==
X-Received: by 2002:a05:690c:4f92:b0:788:1f8b:2b98 with SMTP id 00721157ae682-78a796592b7mr33787227b3.56.1763677446230;
        Thu, 20 Nov 2025 14:24:06 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7993cedesm10954757b3.41.2025.11.20.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 14:24:05 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 4/6] selftests/landlock: Implement selftests for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Thu, 20 Nov 2025 17:23:44 -0500
Message-ID: <20251120222346.1157004-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120222346.1157004-1-utilityemal77@gmail.com>
References: <20251120222346.1157004-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements 5 selftests for the flag, covering allowed and disallowed operations on parent
and child directories when this flag is set, as well as multi-layer configurations.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 222 +++++++++++++++++++--
 1 file changed, 210 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index d4819ff44230..1cdded3f67e6 100644
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
 
@@ -1488,6 +1484,39 @@ TEST_F_FORK(layout1, inherit_superset)
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
+			       LANDLOCK_ADD_RULE_NO_INHERIT);
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
 TEST_F_FORK(layout0, max_layers)
 {
 	int i, err;
@@ -4412,6 +4441,175 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	ASSERT_EQ(0, close(cli_fd));
 }
 
+TEST_F_FORK(layout1, inherit_no_inherit_topology_dir)
+{
+	const struct rule rules[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_RW,
+		},
+		{},
+	};
+	int ruleset_fd;
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
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
+				       &path_beneath,
+				       LANDLOCK_ADD_RULE_NO_INHERIT));
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
+			.access = ACCESS_RW,
+		},
+		{},
+	};
+	int ruleset_fd;
+	static const char unrelated_dir[] = TMP_DIR "/s2d1/unrelated";
+	static const char unrelated_file[] = TMP_DIR "/s2d1/unrelated/f1";
+
+	/* Layer 1: RW on TMP_DIR */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Layer 2: Add no-inherit RO rule on s1d2 */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1);
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
 
@@ -7647,7 +7845,7 @@ static int apply_a_layer(struct __test_metadata *const _metadata,
 			continue;
 
 		add_path_beneath(_metadata, rs_fd, r->access, r->path,
-				 r->quiet);
+				 r->quiet ? LANDLOCK_ADD_RULE_QUIET : 0);
 	}
 
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
-- 
2.51.2

