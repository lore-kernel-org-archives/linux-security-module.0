Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AE1F8691
	for <linux-security-module@vger.kernel.org>; Sun,  7 Dec 2025 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765072335; cv=none; b=sbnOrilRBeIn4f/AHUA7/mekVnPtisBo/umsBs1BQSvBDyxm6GxDzj8/9PwSoV29Qj2CRQRtcWa+aqYdTshgapnwzeWVgkm2HgNQThoVYv3tz6zp9qelYpVqnjz7PO2rP1tfZ76yA7dV/z/08f8So8xRMi0A9wizFzFiYA6m4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765072335; c=relaxed/simple;
	bh=xYqTEFDvYOKCXiO8PYj66jVFilomLYqFnpT04r0S7Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clNigpnIKS18hoCW07pDp5+1I56NckQtstctmWWUWXdttlTC7oxY6blVpLjpxWNnec/PchHvMOgWbwT4+0U+qUh6HgL4hOcVvmZtJEjag8BOnqWv1yPpINQed8PrbESYP8sh9BzcoHPHd5mX0+nVLHH2QjxxLE9YBljpxjgWkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZtqWnIQ; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZtqWnIQ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-642fcb9c16aso2915231d50.1
        for <linux-security-module@vger.kernel.org>; Sat, 06 Dec 2025 17:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765072332; x=1765677132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuoCndBH2jVmrx/nKTWr7jh2hznrjCp1q5f8q5Z9gbg=;
        b=dZtqWnIQDKti2X/Pdqj8FP3/QbicoYGbuHmLaW9+mMmD2HvRe5UPFldpc7s5urTMLx
         A74RRNsBIyBqjpo+kxclbctdiTsRbbqPteF/04/cztXlZoyocSX21kBcsLsGU6hM4hMs
         85KFYUPTYFdDSeZ8llI2irldYHVV0B0p0Wp6cPngD8JkqZEgmyxWL4/jxSo6RbrXEjqH
         AeOnOqduPm5AQTOiER1aRNO0tu6RI3lRwsPmwgFO9eV5d2loP/2c8wPzHhKN66XOniUt
         j007BW7kysKSwdVl9RvnF8GhcyVMrkv/o33VTzjhD6sWgJw0hZINcZzWwhc9AxjMpSRJ
         6NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765072332; x=1765677132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UuoCndBH2jVmrx/nKTWr7jh2hznrjCp1q5f8q5Z9gbg=;
        b=iQDf/gLjNutzLOPssw6VzQQq9AmuzPEwQv3J3QjcoKbN5KF9iH4ZBJscOFILxxtMVD
         TiM603Ysln0n7+7TYrV+vsjb4+woiq1b30SVurwxUi4IuPNhZtzUuyws76M4MSh5+xTy
         wzCVVrsn0F9AWhNhG/eFrhgV8jPLEo4fySeEQrrGtHgA97krd6IL56XIRhSgWFOYgWvE
         psCwwkblW6sBkfGTNt5YsIafaSIvqstnYl9oqNbg4AuwXPdjrZQzAM7Dp5dZYm++KJFP
         I50/wnJ4QgLktKfHR9ZVuX7ZXHoidluPeHBTWlTT/NL4nrX4YyL/WW8+MktMLOndOrNO
         BBpg==
X-Forwarded-Encrypted: i=1; AJvYcCVA9bCuIzyIwIr9iAwPN2Y3kFFXVi9riYIPLcrn7eM86+p+e4xOATYwm6qnXY59d8i4LFmEEG5m9vNSTW/TO7+dzSr9W4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHbzcfrRJCOqeRv+kH9OrjkRN0LYW5lb6P/gC2KwUwJS6hFhC
	fnXQmrzPF2yx9mr0y49ogKigJYy40NNQbMaevwPQe1MraSW9FAjzo5GrpbaV4mCd
X-Gm-Gg: ASbGnctklnJ4Gh62l38RMbBEEEC6i8HNdQHW3EuoXkKSOW5T1Uii9vUzIqo/5j4K1TO
	seXWXvUT75I5zltRzg4/hu+NUAGbs1Qh9PIrA/0/VPEirf+XGd2gyb/jWon77WiwsTP7AaQwYim
	Prv0zoPAwbqHxFbu+FTAxoyrdJfIxRTuNrndyS2Ma1msgmYn+DYzpIlXVR9TYO5UtQxqMpNYEjv
	PuZWZYOJAcUapAVcu7YdCmvzACLc5296C706L8RTlgOqZpGLbyEl4TR7VPptwQOO+3gCI9i8tJk
	LKpa5br2NucWFJUlYFtkHukW551wKdp4u2gRQAJVrAVLeYxgmwRsJybvjo9P5cUhC+zAQ84O1P7
	kCj+S5r8s23K+V7u4D/1Itu+gZy4LaEz1DOaXByh3QuygbduBQfLT9DwC52ejypzbNplIH/pQ/l
	2SgXcL9fGOXAUSrBh9b+xSg/Ajt6fg+AUvH6f/ivahUgyQwKfA2aUgIwy8TPgocJBddXD8TZQ=
X-Google-Smtp-Source: AGHT+IFU/eW3k77JL0/dnnLZnZTn7dvXt7xCrC30QaFGdBc7dEePtlDp0gtiJeR2QzhNPvMhnQy7pA==
X-Received: by 2002:a05:690c:630f:b0:786:5712:46c7 with SMTP id 00721157ae682-78c33c16146mr71587897b3.41.1765072331557;
        Sat, 06 Dec 2025 17:52:11 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm33158417b3.3.2025.12.06.17.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 17:52:11 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 4/5] selftests/landlock: Implement selftests for LANDLOCK_ADD_RULE_NO_INHERIT
Date: Sat,  6 Dec 2025 20:51:30 -0500
Message-ID: <20251207015132.800576-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207015132.800576-1-utilityemal77@gmail.com>
References: <20251207015132.800576-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implements 15 selftests for the flag, covering allowed and disallowed
operations on parent
and child directories when this flag is set, as well as multi-layer
configurations
and flag inheritance / audit logging. Also tests a bind mount
configuration.

v3..v4 changes:

  * Added 4 new tests for bind mount handling, increasing selftests
    from 11 -> 15.

v2..v3 changes:

  * Also covers flag inheritance, audit logging and
    LANDLOCK_ADD_RULE_QUIET suppression.
  * Increases number of selftests from 5 -> 11.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 710 +++++++++++++++++++++
 1 file changed, 710 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 44e131957fba..079742278969 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1484,6 +1484,111 @@ TEST_F_FORK(layout1, inherit_superset)
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
@@ -4408,6 +4513,246 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
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
 
@@ -5747,6 +6092,277 @@ TEST_F_FORK(layout4_disconnected_leafs, read_rename_exchange)
 		  test_renameat(s1d42_bind_fd, "f4", s1d42_bind_fd, "f5"));
 }
 
+/*
+ * Test that LANDLOCK_ADD_RULE_NO_INHERIT on a directory accessed via a mount
+ * point protects the parent hierarchy within the mount from topology changes.
+ *
+ * Layout (after bind mount s1d2 -> s2d2):
+ * tmp
+ * ├── s1d1
+ * │   └── s1d2 [source of bind mount]
+ * │       ├── s1d31
+ * │       │   └── s1d41
+ * │       │       ├── f1
+ * │       │       └── f2
+ * │       └── s1d32
+ * │           └── s1d42
+ * │               ├── f3
+ * │               └── f4
+ * └── s2d1
+ *     └── s2d2 [bind mount destination from s1d2]
+ *         ├── s1d31  <- parent of protected dir, should be immovable
+ *         │   └── s1d41  <- protected with NO_INHERIT
+ *         │       ├── f1
+ *         │       └── f2
+ *         └── s1d32
+ *             └── s1d42
+ *                 ├── f3
+ *                 └── f4
+ *
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
+	 * be denied because NO_INHERIT grants only ACCESS_RO (no MAKE_REG).
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
@@ -7231,6 +7847,100 @@ TEST_F(audit_layout1, write_file)
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
-- 
2.51.0

