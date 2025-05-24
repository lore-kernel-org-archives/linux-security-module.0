Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9676190678
	for <linux-security-module@vger.kernel.org>; Sat, 24 May 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748109427; cv=none; b=E+ZhQh1wLf9BEaccZd9E3v8LmaKJwgAZcqDxDnOkYzFIawnnQzUCuwmKwcqofrbF3HGXNifnGkn34hh+/e93ckImwS3iMW8nIp6BwEIfYstZcMgGBXyYbFmJzqjHxzUY+NNXgOz/TibHOHyvQo7gpNHkey4mozDIbJ1EhkjwHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748109427; c=relaxed/simple;
	bh=aijsr9W5gX6Rw90BG4K0F5fZdH5yroURqb90ZNGnt6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWgUPupRY3I0i4J+zTWu4czFnxsM9Dy5E/gNPtBxgYr9SVJ4LFVJrX1OiQIkuBsQmeKFypbIG5tG2HLfci+ToIf8bt+hrFuW6crd8m2olhJLExRe/1ly5aMP+5pGB6G/tnIVPlhDsHYFaTIORmBabEqeUfD+cg1prdVjs0aKrd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=pZwFn9VD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYIYbf/h; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="pZwFn9VD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYIYbf/h"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EABE11400CE;
	Sat, 24 May 2025 13:57:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 24 May 2025 13:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1748109424; x=
	1748195824; bh=mvsZ8cMQZbsS5l6Q/dUv1LNUbssrof8xuWzZTyoFI0E=; b=p
	ZwFn9VD075cmEKM2JQXwM8MKK6sSMcA87OQo+kxtdm3HHzt9HXCEmbqUo+aojvkw
	2OccqGUOyj0HaGpI6gn+PiPFj8GosJBGQlyHPefv0kdBeJXoj25gStvZgyNHEYVM
	F0Aovvr4D6OZkrnsuNvS/UzqBbiCBwZDO/gEfsbQSe7y2NUiYCFoTLfpNmbkifj3
	I7fFwX/cv3xft+OB/vwhi7AIwhGBO+0PI+EE62TIk9XV1WybZRqYlZUCq0QQEf/5
	WdIOIf/mmJB5ID6pxukVUmBEaRr3X2IFFk8Zz43ldOOm2DUkp/asyd9RpK+7jEwF
	E2pFRG1C75BF4JHESUt0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1748109424; x=1748195824; bh=m
	vsZ8cMQZbsS5l6Q/dUv1LNUbssrof8xuWzZTyoFI0E=; b=VYIYbf/hDj9cQMYMP
	njXtyg3JyrNo0Y3SPkVdViSF7uafkoVDwsRBo/pRUdUw9sRq6EhnlA6YW4JE5ZOr
	ASOPJScDL58Xu9AftKEXQ5sTSa9NRjvgp8E32JcOOhN5+N0DHH5sNUUrGW6+EmLs
	AmlXlzdceLwMnUTEtAnrNYHShaDHUjdsGPF0PbSrFo+fJUpUWBI0mrQKju5ns2M5
	ucN8AWOX2pesI7gZERwiQrqwtdBqTgXbUg9QbOhDjNDmZpcwduijvrvkNGuxku0T
	WBFooL4WrcEsqESgbTzFug6hPs14WMZsEkJuIk7iWTCU1eTn7gOgcKyIajYyWlTa
	EP7fQ==
X-ME-Sender: <xms:cAgyaO-W-Oj33Xb2Se0kiecD9ZLmyDDA4bpcyDQnYwX0xWq7BpyGpg>
    <xme:cAgyaOsZvTeA9FVIXdz5XuXowQRyJ_T6jhAiSFZ6y-3-npWe44heXOBd2tG69SrlK
    exJw5ukHKRSifwqX-8>
X-ME-Received: <xmr:cAgyaECD0Ub2P15UGA38k5R1qvO5o01Wq_aBvsdg2ZzI0dW5v78eHE-Cnnl_V0MB8SWAQm_N3qy8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduvdefkeculddtuddrgeefvddrtd
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
X-ME-Proxy: <xmx:cAgyaGfOAycVfqG5GiEmBqkdgNwfTLQ5P2O-TL1Cp-vcJ6-AAYZb-w>
    <xmx:cAgyaDMwR906sQcKRkiIKFGaC_BmNLHhBoP4FXNIOXla1p8sCxjNIQ>
    <xmx:cAgyaAn0h1YKwbBiONHjvrRgaVgsyBoWZA2PjJ-76SUW9QmVKOGJfA>
    <xmx:cAgyaFuPDDZZr-AFjHu8P0WoaL3Wrw4-IyJJtl4QbeI5NLCjbMMq7Q>
    <xmx:cAgyaDOXnalUKF0PgqhwaOZs1gbNPZjup92NrZe2Z291KLPydvivvcmJ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 May 2025 13:57:03 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 3/3] selftests/landlock: Clean up TMP_DIR and retry if dir already exists
Date: Sat, 24 May 2025 18:56:34 +0100
Message-ID: <e4347a4a1a78071e23d125ded9bd977ad62c4477.1748108582.git.m@maowtm.org>
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

This ensures that if for whatever reason FIXTURE_SETUP fails, the next
test run will handle this gracefully.

I don't actually 100% like this approach - maybe we should consider
enhancing the test framework to add a FIXTURE_TEARDOWN_ALWAYS, that will
run even if FIXTURE_SETUP fails?

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 tools/testing/selftests/landlock/fs_test.c | 44 ++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 21ed8afcc060..e6891f59803a 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -233,12 +233,41 @@ maybe_warn_about_permission_on_cwd(struct __test_metadata *const _metadata,
 	}
 }
 
+static int try_teardown_layout(struct __test_metadata *const _metadata)
+{
+	struct stat stat_buf;
+
+	if (stat(TMP_DIR, &stat_buf) < 0) {
+		return -1;
+	}
+
+	TH_LOG("Attempting to cleanup layout and retry...");
+
+	if (umount(TMP_DIR)) {
+		if (errno != EINVAL && errno != ENOENT) {
+			TH_LOG("Failed to unmount directory \"%s\": %s",
+			       TMP_DIR, strerror(errno));
+			return -1;
+		}
+	}
+	if (rmdir(TMP_DIR)) {
+		if (errno != ENOENT) {
+			TH_LOG("Failed to remove directory \"%s\": %s", TMP_DIR,
+			       strerror(errno));
+			return -1;
+		}
+	}
+	return 0;
+}
+
 static void create_directory(struct __test_metadata *const _metadata,
 			     const char *const path)
 {
+	bool retried = false;
+
+retry:
 	mkdir_parents(_metadata, path);
-	ASSERT_EQ(0, mkdir(path, 0700))
-	{
+	if (mkdir(path, 0700)) {
 		int err = errno;
 
 		TH_LOG("Failed to create directory \"%s\": %s", path,
@@ -246,7 +275,14 @@ static void create_directory(struct __test_metadata *const _metadata,
 
 		if (strcmp(path, TMP_DIR) == 0) {
 			maybe_warn_about_permission_on_cwd(_metadata, err);
+			if (!retried && errno == EEXIST &&
+			    !try_teardown_layout(_metadata)) {
+				retried = true;
+				goto retry;
+			}
 		}
+
+		ASSERT_TRUE(false);
 	}
 }
 
@@ -320,13 +356,15 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
 {
 	disable_caps(_metadata);
 	umask(0077);
+
+	/* create_directory may try umounting then rmdir if tmp already mounted */
+	set_cap(_metadata, CAP_SYS_ADMIN);
 	create_directory(_metadata, TMP_DIR);
 
 	/*
 	 * Do not pollute the rest of the system: creates a private mount point
 	 * for tests relying on pivot_root(2) and move_mount(2).
 	 */
-	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, unshare(CLONE_NEWNS | CLONE_NEWCGROUP))
 	{
 		TH_LOG("Failed to create new mount namespace: %s",
-- 
2.49.0

