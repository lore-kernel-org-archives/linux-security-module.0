Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D02DCBF7
	for <linux-security-module@vger.kernel.org>; Sat, 24 May 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748109426; cv=none; b=rPo1WS+Bll9AeCNcMtV1Mv5GXPWdojye80nFEgQs2NMzSbsm6CzmzE0kSxzkQvwMRrpxDAiZR/WNNe5fJVQaNs6S7GiBl++LOqrklDck2FLSRo30kGTYnhvlkZlJV6oVlfLx6sZzAbeqdTUaxMP/vI1sL9r7VQKXwBm/poZqtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748109426; c=relaxed/simple;
	bh=SY0+lWnkrLq5Dv040RZqXWCTsYFOK3lt9T4UWXihWe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPJN2ok+3dvQnp8fSRVBOpJX9DK4I6BiH3edttsZf06b4NWXeRkCFAVhcKEmk80wwNJFL+6TU2So32NWDYOJFpP+yW7PHaeYzLslKYPELRy1gbxjcU80XkxDJLpxRqn89VLwGe9mtpxycGxRgmjXpvx7arrYDWgfdNiL3+02Fmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=PTZkliHc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s/E6X0Dm; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="PTZkliHc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/E6X0Dm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 514FE11400AE;
	Sat, 24 May 2025 13:57:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 24 May 2025 13:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1748109423; x=
	1748195823; bh=ML07XdKY+aLB/2QMS8MBj+hL+mnPvmSVHIUU4TK+J8s=; b=P
	TZkliHcWVST2xVQE1xD75BcUJ5OW18AobNgdMTuuoMxDVomuDQ2nzw+Y7CupqXQO
	w4fHymPaEDXJdillXqC2urOQyoFkTjBVVDcK6ioKyUlK0m90DlaMJzDNoGnq5PN3
	JxCB54f3B3a1JJEX8MhD8djWHaqaxmiGwsdYDysCo+h7hrtVbjHfSSXmtfihixwh
	b1KNgJN2AZpKUUaQ55xe7aj+TGt9/PRr9jL+Nidg3v9zFV794Zu5hTkZhToVrtt5
	HVGYrlT3o2MagH2ft43bNNFD6PEpMAgf6RxvVYeVR5eLAG9M8mSULqKRz7PMEsSg
	z3bv6DLvoDBWGV6HPqD2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1748109423; x=1748195823; bh=M
	L07XdKY+aLB/2QMS8MBj+hL+mnPvmSVHIUU4TK+J8s=; b=s/E6X0Dm/9q3AUtqr
	dCETltm8hjc+jzAGl2qNLhhybJNp96RmdmiCSulSVD4zde0wXbDs2ILbEJG+/Vyh
	oYDYlzoqu7QL/PqonGlEE9fDkAZvgdlr7SXgZOs/hTxRSgcnFmgn18X7uURhCr2J
	iJsQ8DdH2YGJHMjws3Nf/6VBBIOWI8NbCsjzhp5Dy76etbv0uTK3d9YzKPOTYuWy
	irHNyA/J/e90T5SLS7cgxA9rhHDDQVHKl8NBdpefwFp0m4iPXJcNPVVY+cgPf4gK
	2xm5aZQgz0q4Wc/qtdinN5UDUuz0YsVmOSXV7mzBMP9zvc1+AjEhOf3J4Aafzi++
	YKVew==
X-ME-Sender: <xms:bggyaA-YTrUbIEQL4SIGh1EWZN_RVN3HRt0Fjd2_kRXP4hJBNufJGw>
    <xme:bggyaItU3kZeaBWlqyeiNe9qE5VrGi-oF2oI5Nu0wiUUtmSVvDv6KkyE0aXRycMP-
    K1WkIaEger7RM2T7HQ>
X-ME-Received: <xmr:bggyaGA5I15iBN52I2z_kaed2KlOOhj-vxdeCxSBoSd4ncB46Ge1ykK66-Las_ASmB38ZncMaPkZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduvdefjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmse
    hmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutdehhfehhfdvjeetvedv
    vdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgih
    hkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuh
    hrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bggyaAca7yN3d7kH0IXye429gvGw_MbA2GY3U2p84WaKHt0-3zNNDA>
    <xmx:bggyaFMj6GrCF8M5l_vG9I1XIvjoebQ9XVFsrjEAJhAt9EaU_cWj5w>
    <xmx:bggyaKk4_h-arTAhg2g3Y3lHCA0n8KGyYaBOVXGKYzLXByJEcsTvKQ>
    <xmx:bggyaHuHj0LfNE-7G0HJKekvOF1nCv3j24NjuXqjrJHvKlf24vBNJg>
    <xmx:bwgyaFMD_IghwfzhiHFdS1-SAIqCEp5hNJ_Mtc2jUZtaA8g55qL5fQ_7>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 May 2025 13:57:01 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/3] selftests/landlock: Print a warning about directory permissions
Date: Sat, 24 May 2025 18:56:33 +0100
Message-ID: <9f5a3c41c1752e8770998f1e5b3e912b139fc13a.1748108582.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748108582.git.m@maowtm.org>
References: <cover.1748108582.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because we drop capabilities (most importantly, CAP_DAC_OVERRIDE), if a
user runs the selftests under a Linux source checked out by a non-root
user, the test will fail even when ran under sudo, and will print a
"Permission denied" error.  This creates a confusing situation if they
does not realize that the test drops capabilities, and can mislead users
to think there's something wrong with the test or landlock.

This patch produces output that looks like:

  # #  RUN           layout0.ruleset_with_unknown_access ...
  # # fs_test.c:240:ruleset_with_unknown_access:Expected 0 (0) == mkdir(path, 0700) (-1)
  # # fs_test.c:244:ruleset_with_unknown_access:Failed to create directory "tmp": Permission denied
  # # fs_test.c:230:ruleset_with_unknown_access:Hint: fs_tests requires permissions for uid 0 on test directory /home/mao/landlock-selftests/tools/testing/selftests/landlock and files under it (even when running as root).
  # # fs_test.c:232:ruleset_with_unknown_access:      Try chmod a+rwX -R /home/mao/landlock-selftests/tools/testing/selftests/landlock
  # # ruleset_with_unknown_access: Test terminated by assertion
  # #          FAIL  layout0.ruleset_with_unknown_access

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 tools/testing/selftests/landlock/fs_test.c | 35 +++++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index e65e6cc80e22..21ed8afcc060 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -216,14 +216,37 @@ static void mkdir_parents(struct __test_metadata *const _metadata,
 	free(walker);
 }
 
+static void
+maybe_warn_about_permission_on_cwd(struct __test_metadata *const _metadata,
+				   int err)
+{
+	char abspath_buf[255];
+
+	if (err == EACCES) {
+		const char *realp = realpath(".", abspath_buf);
+		if (realp == NULL) {
+			realp = ".";
+		}
+		TH_LOG("Hint: fs_tests requires permissions for uid %u on test directory %s and files under it (even when running as root).",
+		       getuid(), realp);
+		TH_LOG("      Try chmod a+rwX -R %s", realp);
+	}
+}
+
 static void create_directory(struct __test_metadata *const _metadata,
 			     const char *const path)
 {
 	mkdir_parents(_metadata, path);
 	ASSERT_EQ(0, mkdir(path, 0700))
 	{
+		int err = errno;
+
 		TH_LOG("Failed to create directory \"%s\": %s", path,
-		       strerror(errno));
+		       strerror(err));
+
+		if (strcmp(path, TMP_DIR) == 0) {
+			maybe_warn_about_permission_on_cwd(_metadata, err);
+		}
 	}
 }
 
@@ -1985,18 +2008,22 @@ TEST_F_FORK(layout1, relative_chroot_chdir)
 static void copy_file(struct __test_metadata *const _metadata,
 		      const char *const src_path, const char *const dst_path)
 {
-	int dst_fd, src_fd;
+	int dst_fd, src_fd, err;
 	struct stat statbuf;
 
 	dst_fd = open(dst_path, O_WRONLY | O_TRUNC | O_CLOEXEC);
 	ASSERT_LE(0, dst_fd)
 	{
-		TH_LOG("Failed to open \"%s\": %s", dst_path, strerror(errno));
+		err = errno;
+		TH_LOG("Failed to open \"%s\": %s", dst_path, strerror(err));
+		maybe_warn_about_permission_on_cwd(_metadata, err);
 	}
 	src_fd = open(src_path, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, src_fd)
 	{
-		TH_LOG("Failed to open \"%s\": %s", src_path, strerror(errno));
+		err = errno;
+		TH_LOG("Failed to open \"%s\": %s", src_path, strerror(err));
+		maybe_warn_about_permission_on_cwd(_metadata, err);
 	}
 	ASSERT_EQ(0, fstat(src_fd, &statbuf));
 	ASSERT_EQ(statbuf.st_size,
-- 
2.49.0

