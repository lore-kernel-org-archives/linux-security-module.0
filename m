Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA52C15B0
	for <linux-security-module@vger.kernel.org>; Wed,  5 Nov 2025 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365646; cv=none; b=AWQz2N8LMQmXXPFEqbtZsFej0iZ+kLGEuETB0h/KcTcX0fsrCdsMBoQmYP/nIgZLiQyDZq47E//2rvzkKXKo4/uiB6xhrXFf2J97uz+FfgTQLfcgKWslXd5sGl2GwbXr/BhDlduOughZVXznNz9pYZn2bYtZFFdskmpGeRQZsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365646; c=relaxed/simple;
	bh=uxML2mtj7bU6IUhRinLu2ot7esY7OHheOUnb3HCN5Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4K58FNg5Q15CLAvnTfJqrIhWBIVXypXx+I7zyE0RadBmBX0O7Ol9UTwyqjO8mfQ8/enOV9YtiS6XhrgZDb8ar10kCyzb8MHKG/AWHXYSYdOnfxwVqX27pUVY+9ott1MIbhI/XM08iVoxRT4rXTwtkOQQO+rX1NZm+tBQz4O+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpMDcQGm; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpMDcQGm"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7866e9e62e1so508947b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 05 Nov 2025 10:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762365644; x=1762970444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8Jf6SZa3CPC8rNbW49bQ1Pq4+WIXfIt59Z2zSwN8II=;
        b=bpMDcQGmU7n8viq3VuUzvSVTUcgJhrXudENIGFLwnx7tfEAAMBsfRgN4kugp/7SnhP
         dGR29tyrOVQ1+ovdsVkEWWrj34/zjoHZk8qAZPXsd5slNbsLbhEmhEYVK/XSO/5v/JWq
         HiZSnf0n9+G90zx0uFBA6KozmGrCusI86q+sKhvzgmbz88H/Eu0Jhxt2vYXB57rL0FXS
         wIcfkI+4DIozajtFtx1B5aToUhzHiX5SmhSTvd/14Sme60pPb2WTa8N5wsVSPO3wVpSa
         nyatWDKLjrtUWR3Y+j8mZk8KL+GEbOknSNhJUPOBFhbqkthjUyn7hnAk2hyxYCNPXurk
         4VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365644; x=1762970444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8Jf6SZa3CPC8rNbW49bQ1Pq4+WIXfIt59Z2zSwN8II=;
        b=w7vGh9VH/nziYJ3nFVCWS0OZd3XN5Nx6Kru7hwfbEO3TN6ejL3U/Zrl+JAskMBc5Bl
         vi0mM6XvZYJ8HXNbDnpJ7hE4uaiWPL+onzdZGkonttMH+BVirj1UpIqq6Ge13ARVSmT4
         LfL/sh4rKfny1x+QoMfoMShiO/hnTqFWAibC1uVqnXyeZv8u1JQC9XkMrrT0svxyW+73
         Mkmw3DTnpkP+XeagF7jAbsFLPzb4kUG1awxblmoMjS1GEr5i+QVFZ+vTVP6Zdgpk01Ph
         EpCSYLbI2BBQxipLKR7BE2M2NcSDRHVwtnBdSCA56176d0WG7TPOuxsepUh9UN03yJS1
         CzEQ==
X-Gm-Message-State: AOJu0YwAnLl16qHQbUxotHgq+aAkIl5h+b5Ad1MFzo4Cf9QnDQWJslhf
	sK9YIZhVSkKkC3ZReLgQWGU+l9sUliMT0ul2g2rsopDFypyOq77yZe6fl+K9AKaC
X-Gm-Gg: ASbGncsEK3JGudYYkXXZkoZ5YkzrIqYTsCWJ/jmRZWQlYFHjG1n+NOZ2LgV2rVvl8t4
	gc+efB8ftqsFaTIs4TnR199E33Vzd20fY8unOlzxm6TEKwLjl0ZINW3pAA9OtYXKp3+N5DGNkaC
	w278pVBYz3j/K1I4dz+UWPY9UpCuRRXhfTrhC5P6EdVLtW+77g+RlLBKNkaDoxhMNsrhUHBE6e7
	jmH9AMvrvfbDIAQ8nh7ivLSSAgcawOJtnMyE4bT0Q84yWsVKDwANgvfPPKpxWA7HzVrPFvPfd/Q
	waXk38f0CDZDQekFima6BXlrU+lnvcWA4vN+Jf7gJqQxdmlmoZSB4Jel5yggDm+3QbfeZHGNMIf
	PyCmtLgiSrS6YsTOg/1/QFVKt82QzWIjlhY8RB6l55wAoFiimLstHCbPLjfQB2KITjy1XEK6SXp
	YCXwFJ5tpb7wFXR7y+PvSjc37KRu1Gt8Ja7LNWLKv+3m8juxaw2Q==
X-Google-Smtp-Source: AGHT+IFhsq81n0mEabB32EErsDvAxsRTb7gi8r7rntelcOT6Mx7z50VMZ5TqqoVXi1XM1YLxGNYkqw==
X-Received: by 2002:a0d:e785:0:b0:786:393c:5f1f with SMTP id 00721157ae682-786a41051d4mr30745787b3.12.1762365643718;
        Wed, 05 Nov 2025 10:00:43 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13faf56sm756657b3.19.2025.11.05.10.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:00:43 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 3/3] selftests/landlock: Add test for new no inherit flag
Date: Wed,  5 Nov 2025 13:00:19 -0500
Message-ID: <20251105180019.1432367-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105180019.1432367-1-utilityemal77@gmail.com>
References: <20251105180019.1432367-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds tests for the new no inherit flag, validating the expected
supression of permission inheritence within a layer. Also updates
the add_path_beneath function to take a __u32 (instead of bool quiet)
for the flags, since LANDLOCK_ADD_RULE_QUIET isn't the only
flag anymore.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 53 +++++++++++++++++-----
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index d4819ff44230..a7ebe4ec1b5a 100644
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
@@ -7647,7 +7676,7 @@ static int apply_a_layer(struct __test_metadata *const _metadata,
 			continue;

 		add_path_beneath(_metadata, rs_fd, r->access, r->path,
-				 r->quiet);
+				 r->quiet ? LANDLOCK_ADD_RULE_QUIET : 0);
 	}

 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
--
2.51.0

