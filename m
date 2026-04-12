Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A4358373
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022365; cv=none; b=QcwQxW58Ye0Ad8s3BQICHHt0C9W9xEsAACqpzcl1LDwmH7bYQmYMPvv5D6ThVbxgqPioxr34EXJRMPOWXitLij98NOboPMkEj3d1OGLB7kvx2NnuOC+P1U7AK1oR1rH+xjc1Z6/nm6+L4WHqHKLcfgdt71zSEadSL6zyWPW+zH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022365; c=relaxed/simple;
	bh=OVMx+T+6O8TSobkN20u4vAXc6ufTFEiqT0NR3bMsC4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jR2OAb76GAnC8ckWB046qNaUohNywrHvo1XQgFx9AuurqhmsNkIDuwvwdtE3vSISkyfMymhZyhQx7MKTU1IBPKQVKEBfXkCQHzz18p5nmcjIhPnb+F0REVIAPXp1KfytHCnUv+MXyYPdTawl3/GSpZng0/pumSdWKsJ3Vr8MLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBCX20Ci; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBCX20Ci"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79be0de8610so34906437b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022362; x=1776627162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0dHE+b6FwceWawQvH+k0U8IcA/LTR3O55BR1iBSm5I=;
        b=hBCX20CivObHMxRJBWl22h0P0H8Pw7cBAfQQZul9cRXDGE1il8WOcCGRrvWjQcaufA
         LtUonlDZWUIn0qY7LHR0b0YA7D9qWALsNoZJzEWDX9X8hv4QDWnJuBlGdFC5eLIeiAuY
         wuGNwpqb1n8eKQBYVvVrFvYwGinfg55yeUxCKQgLGSAgQ3B7pt1Wk/LMZqCvh7iPm4W5
         ZhgdI8bpa3oovEj8vRXqZ53FEH/Xqkpu6W6/hv0WRUqtPUiMvnpkEeVmaoCUsPzAiJfp
         DN8YUnysVumdoU5Bvw9XV8pZLdMaLdxC1SKR3ozWVCO2ZGvdrTIqGdUPL0cWatFmoRXj
         u2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022362; x=1776627162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0dHE+b6FwceWawQvH+k0U8IcA/LTR3O55BR1iBSm5I=;
        b=dTCazK794CXVp5cry4ZGqLhZJegKt3LoSFBOv2mVouRZurG6uqZtj3GcmH7TWzdFgN
         ikjZJZ/AaUN8TKvSEHxbVZyXant5ljHNdMmCVoqQyKFM2waUMvkuZh/ATQECn7snfAr/
         fh7HDqesf+E95qEHA7IWz5TEJ/ewz7UXuHHWCzJI+YS1WQzikw/QwIJHhXFK/MCds8BP
         lKTq3WLozCeP96sf2XebQZEXgNqv1Zzgh/cG6QYW3+/MgpCEYHFccfa0a5RCu80bqIRF
         2EqMUFMQORuwP+gaHZyQkHuHugL/qsESZ8CfBhgYKSauLmLAv+Hs0FSNNlkeuRSRK9Fx
         385A==
X-Forwarded-Encrypted: i=1; AFNElJ9TCOSP26gObXS3s66ZwBU2Lo6NX8gZ1DK3etwWcJ7wluTrMX9M7E5325nRH82O/Ub9kJP+m+kg6Sh1DKKg5SgJQuWYhSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2L8X84M5TcNcNHUguyW9CvFz9ZnLqk3acjhlBrkxpQo0G65UX
	lZe/Jec9GYzU8BplZt+8Hy2kPEH3JzKFkfDB2D8x1xSMyYTO0kjVJdtx
X-Gm-Gg: AeBDies1QycWzBFYyPBFJt9p3FXTq1aDF6uWyYFXe1rXKakhLNgicJ5CHWMMVVLBszo
	MxJU80sus5itdHw2KpexcRdiGp1DuurWSYxUsiob81Se3gynDhDDQnippokq9uvqfVpdt1WILnp
	KWtMvZi7PyNjC9vUUvJ9Qku74djWf8F3VZ9Q4XQmhREqtqcHzVmxciNAovqCfkINvU60UjqasOF
	ofXxMHrGH2exvi2HdPJjJ6Uj3J2T2vgOsTo2ncxQC7HM8qg1KGjIZscXlS69yU7/dBNbt7SJVwq
	LM64iZax0M0QssK9uFhDpOKTJ62czW/mVWY7fjrYjsL72CNxppo14TjJWjsUqPogpnlvhYDjo2U
	BEP/LWpfABCpPhK5W7z4AcWSCCwxXeyR/6mU/V2aIWGJYRMwGeanDixpDIvKet6k/OQH7tm0jNf
	CYH8QDFIS3n5cRP3SaNNniDF7HPUsltyUxPv/rCJ8i3ZkhGL1ZAYjvduNVJf5RRCFB2bAhryTe
X-Received: by 2002:a05:690c:83:b0:79e:9cc1:ede3 with SMTP id 00721157ae682-7af6f327352mr130155227b3.2.1776022362088;
        Sun, 12 Apr 2026 12:32:42 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:1192:20dc:2cb3:dcdc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3c8decbfsm42395807b3.8.2026.04.12.12.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:32:41 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 09/10] selftests/landlock: Implement selftests for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sun, 12 Apr 2026 15:32:00 -0400
Message-ID: <20260412193214.87072-10-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412193214.87072-1-utilityemal77@gmail.com>
References: <20260412193214.87072-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements 15 selftests for the flag, covering allowed and disallowed
operations on parent and child directories when this flag is set, as
well as multi-layer configurations and flag inheritance / audit
logging. Also tests a bind mount configuration.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v6..v7 changes:
    
      * Reword misleading MAKE_REG comment.
    
    v5..v6 changes:
    
      * Remove redundant tree diagram from comment
    
    v4..v5 changes:
    
      * Fixed a bug in a test applying invalid access rights
        to a file.
    
    v3..v4 changes:
    
      * Added 4 new tests for bind mount handling, increasing selftests
        from 11 -> 15.
    
    v2..v3 changes:
    
      * Also covers flag inheritance, audit logging and
        LANDLOCK_ADD_RULE_QUIET suppression.
      * Increases number of selftests from 5 -> 11.

 tools/testing/selftests/landlock/fs_test.c | 705 +++++++++++++++++++++
 1 file changed, 705 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 2e32295258f9..28096576928d 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1429,6 +1429,111 @@ TEST_F_FORK(layout1, inherit_superset)
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
@@ -4179,6 +4284,266 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	EXPECT_EQ(0, close(srv_fd));
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
+
+	/*
+	 * Both file1_s1d2 and file2_s1d2 already exist from the fixture.
+	 * file2_s1d2 is in the same directory as file1_s1d2 and will be
+	 * used to test inheritance vs. NO_INHERIT behavior.
+	 */
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+	ASSERT_LE(0, ruleset_fd);
+
+	/*
+	 * Add a NO_INHERIT rule on file1_s1d2 with READ_FILE access.
+	 * This should succeed (files can have NO_INHERIT).
+	 * Use READ_FILE (not ACCESS_RO which includes READ_DIR) since
+	 * directory access rights don't make sense for files.
+	 */
+	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_READ_FILE,
+			 file1_s1d2, LANDLOCK_ADD_RULE_NO_INHERIT);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * file1_s1d2 has NO_INHERIT with READ_FILE access only,
+	 * so it should only be readable (not inheriting RW from parent TMP_DIR).
+	 */
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+
+	/*
+	 * file2_s1d2 does not have NO_INHERIT, so it should inherit
+	 * RW access from parent TMP_DIR rule.
+	 */
+	ASSERT_EQ(0, test_open(file2_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file2_s1d2, O_WRONLY));
+}
+
+TEST_F_FORK(layout1, inherit_no_inherit_layered)
+{
+	const struct rule layer1_and_2[] = {
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
+				    layer1_and_2);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Layer 2: Add no-inherit RO rule on s1d2 */
+	ruleset_fd = create_ruleset(_metadata,
+				    ACCESS_RW | LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				    layer1_and_2);
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
 
@@ -5931,6 +6296,252 @@ TEST_F_FORK(layout4_disconnected_leafs, read_rename_exchange)
 		  test_renameat(s1d42_bind_fd, "f4", s1d42_bind_fd, "f5"));
 }
 
+/*
+ * When s1d41 (accessed via the mount at s2d2) is protected with NO_INHERIT,
+ * its parent directories within the mount (s1d31) should be immovable.
+ */
+TEST_F_FORK(layout4_disconnected_leafs, no_inherit_mount_parent_rename)
+{
+	int ruleset_fd, s1d41_bind_fd;
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
+	/* Allow full access to TMP_DIR. */
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				 LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				 LANDLOCK_ACCESS_FS_REMOVE_DIR,
+			 TMP_DIR, 0);
+
+	/*
+	 * Access s1d41 through the bind mount at s2d2 and protect it with
+	 * NO_INHERIT. This should seal the parent hierarchy through the mount.
+	 */
+	s1d41_bind_fd = open(TMP_DIR "/s2d1/s2d2/s1d31/s1d41",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d41_bind_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &(struct landlock_path_beneath_attr){
+					       .parent_fd = s1d41_bind_fd,
+					       .allowed_access = ACCESS_RO,
+				       },
+				       LANDLOCK_ADD_RULE_NO_INHERIT));
+	EXPECT_EQ(0, close(s1d41_bind_fd));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * s1d31 is the parent of s1d41 within the mount. Renaming it should
+	 * be denied because it is part of the protected parent hierarchy.
+	 * Test via the mount path.
+	 */
+	ASSERT_EQ(-1, rename(TMP_DIR "/s2d1/s2d2/s1d31",
+			     TMP_DIR "/s2d1/s2d2/s1d31_renamed"));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * s1d32 is a sibling directory (not in the protected parent chain),
+	 * so renaming it should be allowed.
+	 */
+	ASSERT_EQ(0, rename(TMP_DIR "/s2d1/s2d2/s1d32",
+			    TMP_DIR "/s2d1/s2d2/s1d32_renamed"));
+	ASSERT_EQ(0, rename(TMP_DIR "/s2d1/s2d2/s1d32_renamed",
+			    TMP_DIR "/s2d1/s2d2/s1d32"));
+
+	/*
+	 * Renaming directories not in the protected parent hierarchy should
+	 * still be allowed.
+	 */
+	ASSERT_EQ(0, rename(TMP_DIR "/s3d1", TMP_DIR "/s3d1_renamed"));
+	ASSERT_EQ(0, rename(TMP_DIR "/s3d1_renamed", TMP_DIR "/s3d1"));
+}
+
+TEST_F_FORK(layout4_disconnected_leafs, no_inherit_mount_parent_rmdir)
+{
+	int ruleset_fd, s1d41_bind_fd;
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
+	/* Allow full access to TMP_DIR. */
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				 LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				 LANDLOCK_ACCESS_FS_REMOVE_DIR,
+			 TMP_DIR, 0);
+
+	/*
+	 * Access s1d41 through the bind mount at s2d2 and protect it with
+	 * NO_INHERIT. This should seal the parent hierarchy through the mount.
+	 */
+	s1d41_bind_fd = open(TMP_DIR "/s2d1/s2d2/s1d31/s1d41",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d41_bind_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &(struct landlock_path_beneath_attr){
+					       .parent_fd = s1d41_bind_fd,
+					       .allowed_access = ACCESS_RO,
+				       },
+				       LANDLOCK_ADD_RULE_NO_INHERIT));
+	EXPECT_EQ(0, close(s1d41_bind_fd));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * s1d31 is the parent of s1d41 within the mount. Removing it should
+	 * be denied because it is part of the protected parent hierarchy.
+	 */
+	ASSERT_EQ(-1, rmdir(TMP_DIR "/s2d1/s2d2/s1d31"));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Removing an unrelated directory should still be allowed (if empty).
+	 */
+	ASSERT_EQ(0, rmdir(TMP_DIR "/s3d1"));
+	ASSERT_EQ(0, mkdir(TMP_DIR "/s3d1", 0755));
+}
+
+TEST_F_FORK(layout4_disconnected_leafs, no_inherit_mount_parent_link)
+{
+	int ruleset_fd, s1d41_bind_fd;
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				     LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				     LANDLOCK_ACCESS_FS_REMOVE_DIR |
+				     LANDLOCK_ACCESS_FS_MAKE_REG,
+	};
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Allow full access to TMP_DIR. */
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				 LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				 LANDLOCK_ACCESS_FS_REMOVE_DIR |
+				 LANDLOCK_ACCESS_FS_MAKE_REG,
+			 TMP_DIR, 0);
+
+	/*
+	 * Access s1d41 through the bind mount at s2d2 and protect it with
+	 * NO_INHERIT. This should seal the parent hierarchy through the mount.
+	 */
+	s1d41_bind_fd = open(TMP_DIR "/s2d1/s2d2/s1d31/s1d41",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d41_bind_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &(struct landlock_path_beneath_attr){
+					       .parent_fd = s1d41_bind_fd,
+					       .allowed_access = ACCESS_RO,
+				       },
+				       LANDLOCK_ADD_RULE_NO_INHERIT));
+	EXPECT_EQ(0, close(s1d41_bind_fd));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Creating a hard link within the protected NO_INHERIT directory should
+	 * be denied because NO_INHERIT grants only ACCESS_RO (MAKE_REG is not
+	 * inherited). Test via the mount path.
+	 */
+	ASSERT_EQ(-1, linkat(AT_FDCWD, TMP_DIR "/s2d1/s2d2/s1d31/s1d41/f1",
+			     AT_FDCWD, TMP_DIR "/s2d1/s2d2/s1d31/s1d41/f1_link",
+			     0));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Creating links within directories outside the protected chain
+	 * (using the mount source path to avoid EXDEV) should still be allowed.
+	 */
+	ASSERT_EQ(0, linkat(AT_FDCWD, TMP_DIR "/s1d1/s1d2/s1d32/s1d42/f3",
+			    AT_FDCWD, TMP_DIR "/s1d1/s1d2/s1d32/s1d42/f3_link",
+			    0));
+	ASSERT_EQ(0, unlink(TMP_DIR "/s1d1/s1d2/s1d32/s1d42/f3_link"));
+}
+
+/*
+ * Test that NO_INHERIT protection extends to the mount source hierarchy.
+ * If a directory is protected via a mount path, its parents within the
+ * mount source should also be protected from topology changes.
+ */
+TEST_F_FORK(layout4_disconnected_leafs, no_inherit_source_parent_rename)
+{
+	int ruleset_fd, s1d41_bind_fd;
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
+	/* Allow full access to TMP_DIR. */
+	add_path_beneath(_metadata, ruleset_fd,
+			 ACCESS_RW | LANDLOCK_ACCESS_FS_REFER |
+				 LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				 LANDLOCK_ACCESS_FS_REMOVE_DIR,
+			 TMP_DIR, 0);
+
+	/*
+	 * Access s1d41 through the bind mount at s2d2 and protect it with
+	 * NO_INHERIT. The source mount path parents should also be protected.
+	 */
+	s1d41_bind_fd = open(TMP_DIR "/s2d1/s2d2/s1d31/s1d41",
+			     O_DIRECTORY | O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, s1d41_bind_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &(struct landlock_path_beneath_attr){
+					       .parent_fd = s1d41_bind_fd,
+					       .allowed_access = ACCESS_RO,
+				       },
+				       LANDLOCK_ADD_RULE_NO_INHERIT));
+	EXPECT_EQ(0, close(s1d41_bind_fd));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * The mount source is s1d1/s1d2. The protected directory s1d41 is at
+	 * s1d1/s1d2/s1d31/s1d41. The parent s1d31 within the mount source
+	 * should be protected from topology changes.
+	 */
+	ASSERT_EQ(-1, rename(TMP_DIR "/s1d1/s1d2/s1d31",
+			     TMP_DIR "/s1d1/s1d2/s1d31_renamed"));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * s1d32 is a sibling, not in the protected parent chain. It should
+	 * be renamable.
+	 */
+	ASSERT_EQ(0, rename(TMP_DIR "/s1d1/s1d2/s1d32",
+			    TMP_DIR "/s1d1/s1d2/s1d32_renamed"));
+	ASSERT_EQ(0, rename(TMP_DIR "/s1d1/s1d2/s1d32_renamed",
+			    TMP_DIR "/s1d1/s1d2/s1d32"));
+}
+
 /*
  * layout5_disconnected_branch before rename:
  *
@@ -7358,6 +7969,100 @@ TEST_F(audit_layout1, write_file)
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
+TEST_F(audit_layout1, no_inherit_blocks_quiet_flag_inheritance)
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
-- 
2.53.0

