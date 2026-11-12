Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466364;
	b=uPKWF2bH6BX+ymy+xBK5tU3UVoPcmsUXWyhL1XCvoqC5vbndmKSTKaiUzEpr7utzU0S1
	 cqv/sQxrDIYJzN1E3p+IZMtjmZGAYBHS2tSmQ6eCC9J83CArAvbSS71fTy+baTrR1hkVQ
	 s2Cfp55qpxrgDYKXkHhZRmrgap/2aJImnotcswjFStoxtjelC2QsZY0iGNoKCbo14ze0P
	 MgcIZRn5cUd2s/6HVfjBTSR/J9kA6TmK8JoInBvZk75Wf32kHVasvhH3j2DnH7mVzSxws
	 kgq/15TZOxM3ozK+c+JrKlHDMl9MVu1yMnQ/tyyvFI2pNnJp4m6CyrC7aV2wkQYWSlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466364;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=5nPSUbImYjps6gGn8wgU47+zVNk2hMbntclCpegbno4=;
	b=bzdmk4mDSoOC+nhK1K7cmWHkGqIvrfmF8mbkslgmMehURwdpdkA6WbHY3EjPY31tFesT
	 5POSydDXx9Kg7/sctHZPLUWp/ruGw7nlePgaDFCjnwYToWn/ui7chZThrhdx5V8GW4eSh
	 u7YC5BooXRCZwawWxRQY8KzLBhXqgwVc2cHKEYFT7ZNzMLDDrcCaKYf+64dcMJgl9/kpm
	 qPjy+URa11o9VQvfoOU8KP0PujXlIBINW7leve0h6vaT5BZdXnv8fR2OL9JIfr5OQSizB
	 0fBtXOj0qoKBlBIx7OQptx1ZURB5ZJBz10p7xo1ThHOaM99TlpFHyR6cU5oS8ekWQUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Zu4YIoXQ;
	arc=none smtp.remote-ip=220.197.31.9
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB17606A327;
	Thu, 12 Nov 2026 06:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBB17606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Zu4YIoXQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5n
	PSUbImYjps6gGn8wgU47+zVNk2hMbntclCpegbno4=; b=Zu4YIoXQp5GHDtMD97
	w7UO90OWGRALvTLZD2NyxHu7RFKID6HB/kU1TzzGgphNH7aaOs3lpBamXgk1B/lR
	CKF5dUw34YdmjFxyfRedZ78rJu+yf5gFLbIZikq7MQBCM/Jw/d42r+6CeYiGnIDh
	GIhQU0Fh72SvCKdZWFLwnNut0=
Received: from kylin-pc (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3P8UXYvVqLbJWDQ--.30997S3;
	Thu, 12 Nov 2026 14:52:10 +0800 (CST)
From: pandaWall <mangosteen922@126.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pandaWall <mangosteen922@126.com>
Subject: [PATCH v3 2/2] landlock: Add a test for REFER layer composition with network layer
Date: Thu, 12 Nov 2026 14:52:03 +0800
Message-ID: <20261112065203.1066536-2-mangosteen922@126.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20261112065203.1066536-1-mangosteen922@126.com>
References: <20261112025528.443654-1-mangosteen922@126.com>
 <20261112065203.1066536-1-mangosteen922@126.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3P8UXYvVqLbJWDQ--.30997S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF13AF4rtrW3GFWUJF4rGrg_yoW5GF47pF
	WrWw15KF4Igr1av3WfurnruF4Sy3WkXw4UGanF9ryxtF4ruF1fGwsaqFyUJa17ZrZYv398
	Zayj9rW8WF4UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRL0edUUUUU=
X-CM-SenderInfo: 5pdqw0pvwhv0qzssqiyswou0bp/xtbBlhu2rGr1Yhuc1gAA37

Check that stacking a network-only ruleset (i.e. a layer handling no
filesystem access right) on top of a filesystem ruleset still allows
different-parent renames and exchanges allowed by the filesystem layer.
Before the fix, such a layer implicitly handled
LANDLOCK_ACCESS_FS_REFER and denied these operations with EXDEV.

A single rule on dir_s1d2 is enough: it covers its subdirectory
dir_s1d3, and grants all the filesystem access rights handled by the
domain on both parents of the tested renames.

Signed-off-by: pandaWall <mangosteen922@126.com>
---
 tools/testing/selftests/landlock/fs_test.c | 37 +++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f725882fa..94b339252 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2569,7 +2569,6 @@ const struct rule layer_dir_s2d1_execute[] = {
 	},
 	{},
 };
-
 /*
  * Tests precedence over renames: denied by default for different parent
  * directories, *with* a rule matching a parent directory, but not directly
@@ -2612,6 +2611,42 @@ TEST_F_FORK(layout1, refer_denied_by_default4)
 				layer_dir_s1d1_refer);
 }
 
+/*
+ * Tests that a layer not handling filesystem access rights does not
+ * implicitly handle LANDLOCK_ACCESS_FS_REFER, which would otherwise deny
+ * different-parent renames and links stacked on top of a filesystem ruleset.
+ */
+TEST_F_FORK(layout1, refer_with_net_layer)
+{
+	const struct rule layer_fs[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_REFER,
+		},
+		{},
+	};
+	const struct landlock_ruleset_attr ruleset_net = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+
+	/*
+	 * layer_fs alone: different-parent renames are allowed.  A single
+	 * rule on dir_s1d2 covers its subdirectory dir_s1d3 as well.
+	 */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER |
+				      LANDLOCK_ACCESS_FS_MAKE_REG,
+		   layer_fs);
+	ASSERT_EQ(0, test_rename(file1_s1d2, file1_s1d3));
+	ASSERT_EQ(0, test_rename(file1_s1d3, file1_s1d2));
+	ASSERT_EQ(0, test_exchange(file2_s1d2, file2_s1d3));
+
+	/* Stacks a network-only layer: still allowed. */
+	drop_access_rights(_metadata, &ruleset_net);
+	ASSERT_EQ(0, test_rename(file1_s1d2, file1_s1d3));
+	ASSERT_EQ(0, test_rename(file1_s1d3, file1_s1d2));
+	ASSERT_EQ(0, test_exchange(file2_s1d2, file2_s1d3));
+}
+
 /*
  * Tests walking through a denied root mount.
  */
-- 
2.56.0

