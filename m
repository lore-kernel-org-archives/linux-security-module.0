Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461277;
	b=bRHEDyGqPFcwcvvS7n4Z3VuoFL2i9QDfqwmiMdDtiD+FVebLxhBn8uD7WO0mDIEcUyBV
	 Hkx7jB3XP7+tWABrTHs6jmfXEcGc37fMqJpVN0rZLyW3OXQUinm4EOGhyvptJLWN3n92W
	 shxFCO0ATnU8Xfyqvh006yjI8ivZfOhB7bzqaiMg8DniImxr9LLhvv/68UZJIZ6C836Mt
	 ppSajitHgZAG/2UFN0NngXeBKLBM/xeHY1RhBejHQf+5KUnQeE3lxzYOlngFw5iJQRNCc
	 clX+a3o8T7p78EPB8ZHWQBw3F3Nm7zesDUyvoeQnC7Pf9tYeIBa0LBRtnmcCb0ct1rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461277;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=EffbcejEitpDOf8ri6BW9Q+H6j5n7n7Kbuii1BDruOk=;
	b=qEMvzYYx3AY1d4NWESVhzRdmCr5ZbQxWTCvFX68qPu4zwtoQr2QElXxu/vhGXuAXTQnI
	 /el20iMRkhMEld6xlR/imToefzQbcVmeSZkMatAW/O51dP57qbbv6FtFLee7XCR1QOtoh
	 pgBA7Ro8uwj53gUm35hRgEGkB5GS1t8dyM7JczJvJa899NYvxFyizejGcKLdVl8tn9Oap
	 fkQTysk6/3Rd7riK0v4ybqa1FNxurh2AU1L+48+jo3CKqDqAMZkpci24CJrw7uTBYNtT9
	 lzdskVOAIpsIbKpcqny/QfIcHJuYsoU7lIoa7cJgBwzLP4BA5xR9DlObX0508kXjdmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=g7USKRC3;
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FE606A324;
	Thu, 12 Nov 2026 05:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 180FE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=g7USKRC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ef
	fbcejEitpDOf8ri6BW9Q+H6j5n7n7Kbuii1BDruOk=; b=g7USKRC3+xHXEmpi0p
	eg3JE5VNJ9ygmYEzK2qv74XumzgLpvP0UKMPMfAXYKGCZnr0WhJt+04pV7UHJvXx
	h2rOsm5aSjeaavz/QIXN8i1y2ion+ppu/tAm+SAkE8GzEVrV6wpFHq3axKswJq3L
	CmTR3SE+hYdzvI1i25QN2IRQU=
Received: from kylin-pc (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3FyY3TvVqG+3LDA--.21631S3;
	Thu, 12 Nov 2026 13:27:36 +0800 (CST)
From: pandaWall <mangosteen922@126.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pandaWall <mangosteen922@126.com>
Subject: [RFC PATCH v2 2/2] landlock: Add a test for REFER layer composition with network layer
Date: Thu, 12 Nov 2026 13:27:13 +0800
Message-ID: <20261112052713.859515-2-mangosteen922@126.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20261112052713.859515-1-mangosteen922@126.com>
References: <20261112025528.443654-1-mangosteen922@126.com>
 <20261112052713.859515-1-mangosteen922@126.com>
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
X-CM-TRANSID:_____wD3FyY3TvVqG+3LDA--.21631S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1xZryxWF4UXw17Gw4DArb_yoW5Gw43pr
	WrZ345KF4xKr4aq3WfuFn7uF4Sk3WkXr48GF42g34I9F45uFn8Jrs2qFWUJa17ZrZ3ZrZ8
	ZayjkrW5ua1UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRFJPiUUUUU=
X-CM-SenderInfo: 5pdqw0pvwhv0qzssqiyswou0bp/xtbBqwi9s2r1TkiirQAA37

Check that stacking a network-only ruleset (i.e. a layer handling no
filesystem access right) on top of a filesystem ruleset still allows
different-parent renames and exchanges allowed by the filesystem layer.
Before the fix, such a layer implicitly handled
LANDLOCK_ACCESS_FS_REFER and denied these operations with EXDEV.

Both parent directories get MAKE_REG because each is the destination
parent of one rename direction (and of the exchange), as
current_check_refer_path() requires the moved file type's access right
on both parents.

Signed-off-by: pandaWall <mangosteen922@126.com>
---
 tools/testing/selftests/landlock/fs_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f725882fa..cf1128163 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2570,6 +2570,49 @@ const struct rule layer_dir_s2d1_execute[] = {
 	{},
 };
 
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
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{},
+	};
+	const struct landlock_ruleset_attr ruleset_net = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP,
+	};
+
+	/*
+	 * layer_fs alone: different-parent renames are allowed.  Both
+	 * parent directories need MAKE_REG because each is the destination
+	 * of one rename direction, and the destination parent of an
+	 * exchange.
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
  * Tests precedence over renames: denied by default for different parent
  * directories, *with* a rule matching a parent directory, but not directly
-- 
2.56.0

