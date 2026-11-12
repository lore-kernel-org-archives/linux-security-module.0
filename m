Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452168;
	b=ANjsO6eqXKqNoaLJMLBM5vVw1onYCGxgnrIJEhAgNY9McVMTUjWiytcXUNYJmxZ72g6w
	 J1X/nTAqiA3nBiICXB0J/lDDhUrC1H41xe8h5OdDOmXoV67PalChpOY3kiJ59sIUfpZp7
	 SjFlqoFRnlrtulDylTMV85Zq2GwgUm9apH/2HcovuUocTXkDbO+JzmhhPID5cgYFSPjHc
	 /aZQbpP8+Mn+nj1eh+8UcLc9XL1xr+ps+YPyZVsh+C2dw2K8br/uUmg9Vz4FQ8jFgsMQp
	 m3IYwixVT3r0aTnJWRY+yWMab6BNJO1YXLXvw9TCjVUDjYaPW7GAqZFlt/5dhMkM/1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452168;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=n5WIXG91W9gLyKmMED8l0xUJtKd4OayeMuFM/2Jyq5o=;
	b=dq2o6ubgjWt2WKeSQIuxO066q4lf19ambQOdSWvcbcAx5jg1X+k+p16v0JqaSU8vfbgO
	 vMDQd7ScHrHb+Zfl1mEMdTrXXmnPuhQezpQBS/MlHVqmMkmJryYDtiUNVizSB0xU5MLiB
	 pDEDs4N+DJZQ5m0h92PnYLt3Xwq6eTzrO7xkzxZccZSKmNAKWBrjsT0rgxOxuo968sbmq
	 75Gcy8FOk8rtfGm6+NepOKcF6WnEUmvFffAyNDJWGdDs5Olez9J0q+m27MmVfBxqVO2Uy
	 lifcffDDnlVuBO49aMNMFWueKigPWXmbOTkdaURuHEzuaKE9Ab3S7HOwOLUqck9R3FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=KyuygNCT;
	arc=none smtp.remote-ip=117.135.210.9
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F0606A32D;
	Thu, 12 Nov 2026 02:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 972F0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=KyuygNCT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n5
	WIXG91W9gLyKmMED8l0xUJtKd4OayeMuFM/2Jyq5o=; b=KyuygNCTrg80qMUbNz
	9ABNVq8Eq2/TQz85t61RmEYgWb4V+CZD0IViwsKAUd7cJwU2qlYHJiXThTmRs+nr
	YG8mOdm2L5aw2J4+BAR6510v6BZC05QVxXyX5VY4cnmP9Xq/UCdkKz1r4lnjbix7
	hdQSWd2SRryP7CiwEwNHf2pSY=
Received: from kylin-pc (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3V6qjKvVqzNLGDA--.44259S2;
	Thu, 12 Nov 2026 10:55:39 +0800 (CST)
From: pandaWall <mangosteen922@126.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pandaWall <mangosteen922@126.com>
Subject: [PATCH] landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
Date: Thu, 12 Nov 2026 10:55:28 +0800
Message-ID: <20261112025528.443654-1-mangosteen922@126.com>
X-Mailer: git-send-email @GIT_VERSION@
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
X-CM-TRANSID:_____wD3V6qjKvVqzNLGDA--.44259S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry5WF43Cw45ZFWUtFyxKrg_yoWrAFW5pa
	yrXr15Kr4xKa4av3W7uwn7uF43Cw4kWw4UWa129ryIy3WUZFn5Grs2gr1UJF4UXr4kZFZY
	vFWUurWUua1UX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piYhFrUUUUU=
X-CM-SenderInfo: 5pdqw0pvwhv0qzssqiyswou0bp/xtbBqgzNw2r1KqygYQAA3w

landlock_get_fs_access_mask() unconditionally ORs
_LANDLOCK_ACCESS_FS_INITIALLY_DENIED (i.e. LANDLOCK_ACCESS_FS_REFER)
into every layer's handled filesystem mask.  Layers created from
rulesets that only handle other rule types (network ports, scopes) or
only permissions therefore report REFER as handled even though
landlock_upgrade_handled_layer_config() only adds the bit when
handled.fs is non-zero, and no filesystem rule can ever clear a bit
of such a layer.

The consequence is that stacking any non-filesystem ruleset on top of
a filesystem ruleset makes link(2), rename(2) and
renameat2(RENAME_EXCHANGE) fail with -EXDEV/-EACCES even when each
ruleset individually allows the operation: landlock_unmask_layers()
requires every layer's mask to be cleared, and a non-filesystem
layer's mask can never be.

Only implicitly handle REFER for layers that already handle
filesystem access rights.

Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Signed-off-by: pandaWall <mangosteen922@126.com>

Add a corresponding regression test to the layout1 fs_test suite:
stacking a network-only ruleset (handled_access_net only) on top of a
filesystem ruleset allowing REFER and MAKE_REG must not deny
different-parent rename/exchange.
---
 security/landlock/domain.h                 | 15 +++++++--
 tools/testing/selftests/landlock/fs_test.c | 37 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 935e18b12..07d4a23fc 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -262,9 +262,18 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	/* Handles all initially denied by default access rights. */
-	return domain->layers[layer_level].handled.fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	access_mask_t handled = domain->layers[layer_level].handled.fs;
+
+	/*
+	 * Only layers that handle filesystem access rights implicitly
+	 * handle REFER.  A layer that handles other rule types (e.g.
+	 * network, scopes) must not imply REFER, otherwise it would
+	 * spuriously deny link and rename operations.
+	 */
+	if (handled)
+		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+
+	return handled;
 }
 
 static inline access_mask_t
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f725882fa..5588f0ee5 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2570,6 +2570,43 @@ const struct rule layer_dir_s2d1_execute[] = {
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
+			.access = LANDLOCK_ACCESS_FS_REFER,
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
+	/* layer_fs alone: different-parent rename is allowed. */
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

