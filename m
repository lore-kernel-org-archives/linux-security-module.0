Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92281E1A3B
	for <linux-security-module@vger.kernel.org>; Sat, 30 Aug 2025 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756525785; cv=none; b=nnixVVk2ppfmhIH75D+LqbJig8Z8GuwmZnSlTRFGwnY3+jlcl+EaJhtNb6XML/wAlcna47PX7CYMOMPR7ZjVLRUHUURW2uZlsAQ7ZTyVPCXoKR4f0WDBwPXiJVNgDNUZNGuqvAxrlskYFPOysfQlMIyD2iJm5hdtk9jKMnOZa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756525785; c=relaxed/simple;
	bh=yKmGGmJPteTt+Z/f0vrNbwA0MgiXGEm8DnAUUpjuiew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdB0wFGzOoH1I00s3Yb8OaBzJEH7D3aWKet5ZH2QoCBNjWgW1RvFTj2xfJIeRuTHHfff5+dP83wUL/CWqwF23KYUy4W7m6vBO5uFriOPcIx8HnLgDoB2y3FQcvLgwww6lOq+6q54NhwVVmzSZ3jS3h/INu3K/74IVLlLwtJoknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=fxvLwZMf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SIYWDtJ+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="fxvLwZMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SIYWDtJ+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3A7F14000F6;
	Fri, 29 Aug 2025 23:49:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 29 Aug 2025 23:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1756525781; x=1756612181; bh=4JG/NW5MB8Tf7RE/JRcbz
	RPzdzDJ10F1Z5eN7VVuhvc=; b=fxvLwZMf5l60BIwnLqlaWnuolb9cJEhfqr0zv
	57knCO81QoSdwgrUYwuvS4p+dg4pPL9kUNANz2hHDyQvf4Vcj0pTNPxK91tC6TOX
	Z8B9moNw6E68u6IfhDSDw3RHoki6PipFx3MKxnF9qqQTut3L2EIdw3XTZuSicfBj
	0QLyPwpbEjZKbciW8oOr1yxXIeCSmtDd1MhiTy+pq66b//m6lCU0/I1odSMN3jNG
	jamcKbIAqZpsQNt1o6qjiJTU2ECPOFpNG2o88yF5yTezZnPCUeUBxRjo5bvQNn1O
	rKStHI/pMXMMqDDidne4vttdFjdWD4LuGx5d8Tcr3ZKm3co7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756525781; x=1756612181; bh=4JG/NW5MB8Tf7RE/JRcbzRPzdzDJ10F1Z5e
	N7VVuhvc=; b=SIYWDtJ+HMoulmSQbmHRIuUMkjk/gV62nWIAhccOOc8XS1Xrn14
	Zp/Dlc7c+S8yBm2376pecVReOFQCV1nBATU7rSg57cQMwT4gMTjNEes10qUb/Uvx
	Zdmpi7wqOE86wrEmqkWI+tBkeW1w8A0kVfHfrrL7KHDfjUdPwZvesq/xHhgQv3ji
	qJqsnrsD5PdA6ilLbKNmpGSQJLmZpdqvefI4PbSPcHaN7UdeQYNLt3mJOc9FeRpF
	6BLCprjZGXLiOM6bzb9lLWNUWNTXj30EhzcVwLLlHvbB+L9wqA2J6NtVBEVQPDI1
	cp4XCVdDYbhEFuY2K/WZ0tKpb0NQ5gHP+jQ==
X-ME-Sender: <xms:1HSyaAEEPMtmgdd5yZ5i5PSNq7QkC-5XzxX5B_OON2YnIXQV_oWYMQ>
    <xme:1HSyaBz11Usfe6QZHQ2Iq-9A-dIqTx_8cQFFXGgjtwbnv994CGhMhAJXQQmDl0-62
    8qt6ucvNAosWwdIc-o>
X-ME-Received: <xmr:1HSyaKn0Daajh-vYeq0SSjH75nKhVRkI17VJNI9uTmHzihhYQE0uMxnrsqxA1dhf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeehfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgrohcu
    hggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeelieegge
    dufeejhfeugfettdefgeeggeffueffledvieehtedutddutdduueekveenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpd
    hrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehmsehm
    rghofihtmhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoug
    hulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhvrghnohhvrdhm
    ihhkhhgrihhludeshhhurgifvghiqdhprghrthhnvghrshdrtghomhdprhgtphhtthhope
    hjrghnnhhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:1HSyaCnRAr5rY-aGc-QWgkWGwGMSAPrQH8DWCfuCJo6iCx3OKmdqtw>
    <xmx:1XSyaEwDGl73vvHROER7mlpj4WXntr554pdpP4qCCRNdZdFTizgUhw>
    <xmx:1XSyaPolInDa-ybWqRZQg7Ws3I4T3EZs2JkzbDcOWymZcAg7aZc2gw>
    <xmx:1XSyaL7L7jkpbwx-tBGifS7kLQUapa_01aJ1GZP5s8yxgwXTd8xREA>
    <xmx:1XSyaIJsnrpZaG8vQ0ZwZw2gKqnY8N7gOcel4_56dxmkyWJJofdI0ZRs>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 23:49:37 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH] selftests/landlock: Support running the full fs test suite on another FS
Date: Sat, 30 Aug 2025 11:47:51 +0800
Message-ID: <20250830034753.186551-1-m@maowtm.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a TMP_BIND_TO environment variable which the test binary will check,
and if present, instead of mounting a tmpfs on ./tmp, it will bind mount
that path to ./tmp instead.

Currently there is the layout3_fs tests which runs a few tests (but not
the full set of Landlock tests) in separate filesystems, notably no file
creation/write/rename etc.  This is necessary for certain special fs such
as proc or sysfs, as the tests can only read a specific path.  However,
for a more typical fs like v9fs, this is limitting.

This test makes it possible to run the full set on any filesystem (even
though this is still not automated).  Note that there are some expected
failures, such as v9fs not supporting RENAME_EXCHANGE, as well as the
known issue of ephemeral inodes, which may be fixed by a later revision of
[1].

Suggestions for alternatives welcome.  Maybe we need to also detect the
fs, and disable known-unsupported tests like RENAME_EXCHANGE?

Link: https://lore.kernel.org/v9fs/cover.1743971855.git.m@maowtm.org/ [1]
Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 tools/testing/selftests/landlock/fs_test.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index fa0f18ec62c4..847be67fff9e 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -285,6 +285,22 @@ static const struct mnt_opt mnt_tmp = {
 	.data = MNT_TMP_DATA,
 };
 
+static struct mnt_opt get_tmp_mnt_opt(void)
+{
+	const char *const tmp_bind_to = getenv("TMP_BIND_TO");
+
+	if (tmp_bind_to) {
+		struct mnt_opt mnt = {
+			.flags = MS_BIND,
+			.source = tmp_bind_to
+		};
+
+		return mnt;
+	}
+
+	return mnt_tmp;
+}
+
 static int mount_opt(const struct mnt_opt *const mnt, const char *const target)
 {
 	return mount(mnt->source ?: mnt->type, target, mnt->type, mnt->flags,
@@ -322,7 +338,9 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
 
 static void prepare_layout(struct __test_metadata *const _metadata)
 {
-	prepare_layout_opt(_metadata, &mnt_tmp);
+	struct mnt_opt mnt = get_tmp_mnt_opt();
+
+	prepare_layout_opt(_metadata, &mnt);
 }
 
 static void cleanup_layout(struct __test_metadata *const _metadata)

base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0

