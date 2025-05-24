Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A1190678
	for <linux-security-module@vger.kernel.org>; Sat, 24 May 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748109424; cv=none; b=pDVkiJ1oSgHaDpN9dbK8l7upYX3Kuuylf5PmUpwrwGgDUpZ/R3IHtHzYuxrtZPbHXiYRx3ZRttG3lBqT24yxF3q3tQksN/tUtqM4/oKp5wYpUEJDsbR40ugPkvRIlatZrp9+jmnxWwwhiKl7IBkUD8NVc7G/pinIsXNGBDLgjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748109424; c=relaxed/simple;
	bh=dfoUCXJsWRzHVzUEsSF057zghkqBBWWKpfeB0Qk9CDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rgko6v9NinK8LrpoWvgrbjIlvddYC24rs/Gxoyde5KY56x7c7ONFYgowRebcZ4tWKADAvhjasHRm09XJ2Y/ngfC19ZIFw0WFDByUQIwRSgyJ+sVT0TeMEgUnkcr4PmIe0FxFIHDg5qUKJb6Fe5IHTe2INScFnZjR299mO3fhMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=OMFBjn21; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cB/Gjk8F; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="OMFBjn21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cB/Gjk8F"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AF4EC11400AC;
	Sat, 24 May 2025 13:57:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 24 May 2025 13:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748109421;
	 x=1748195821; bh=etdZBvhxuzVE99TB8BMQWbYgS/lhohyBeJLgF2mo9kM=; b=
	OMFBjn21vZQn8kGPGiWt7hRLQAVXMAAosrhFsuaVD57ywK1h4JCQjmE7gGD4B1nY
	zocQ6Xr9Ye/GsED0Y7oNlAM6G+4o2RCzNVCmDU/ntY/ncjaVVx9kRxHmXzBvOyIn
	iekhAWQbnc1X8d4Ki8x5EMoRWP088wD+gf7bjJ8rP5okUyjWvXTuNTpEQRr56jQL
	hZlmeIW/oBu8AhtkPbBdLOJrz0yKpHyIMerVqfwQAFoKFs6KBmBrEaRWFHF/5ODl
	fkecuYUbNu6q7OHtHYnhGCpB5mrOL3GlfyLaIvnd2R1lCqB7FgWSbHeabLCphIQu
	wzeedNjqrJZX5l8aSQwckQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748109421; x=
	1748195821; bh=etdZBvhxuzVE99TB8BMQWbYgS/lhohyBeJLgF2mo9kM=; b=c
	B/Gjk8F0Te7Yvf61T+N7pJU7XvoZVn+VhIyQdcJgIc1O0Bc3EkjA1ZVj7okrMLmR
	TFJLyKLKFtUHf2IptTbzWNFESN6XOoJjngXfu1eKmi85NLYCv0KEfaTkGjTJRZ/B
	vqJqxHXhk8mV381o06D4i2krsLSUL8NsxAajr425ax67pI4ONrTanhrIti/KYVUW
	h1f+w/hLlqwU85P4h346b+jCYpTGoY57jo/Jvgsp7MoXst8jkOwejFey4x1DSli8
	rUoD0yW86zWgaHMqeC3+wvN8ADn4mtGlZuZVksTfqsmvbTkdrd1zPTXSBEkV/zQb
	J2d4RU+4AcfmGVKX12s6g==
X-ME-Sender: <xms:bQgyaKw1Jobuue8Ezonrol_gB_S0baURew4ce8pmc1SxbQbm_BsqWQ>
    <xme:bQgyaGR-A13L75Um2rRLV3-KE0tFuR4JG2dxI5urQU61rO_GqnaRsnd8Ql9dIRNpS
    T6i_PlY8v_DTBHLxFY>
X-ME-Received: <xmr:bQgyaMUAm_El4Elq2oKkMBmlET2TUJ3608geaH8wjTV4m1TwzOG04v4S8rfsdvjQxz2twTJBCCPG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduvdefkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeiieeggeehtdffieffhfek
    ueffhefhveeugfdvkeejkeehvdettdfgvdeghfdujeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughigh
    hikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtg
    hurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bQgyaAi-L_KBlbw0BO4aPJ1YTp3rZlEA6yMxWh2uDrOeSI7mallbFw>
    <xmx:bQgyaMDdsl4aARt7Br53HFwI79dFweo-zoKg3pGRVgsyKwopuLNEDg>
    <xmx:bQgyaBKHSXNkUIGZpcGd5wii15TWzq90Q5fRvLtFTDHs-JVhbiAHnA>
    <xmx:bQgyaDBA3rjdHEO-6KPXujsd3LA54LvDjrStQspS2O8Mo_0Xegz1Hg>
    <xmx:bQgyaCgM4HH_AjiE8ev-PbNbSN8jXisDLglh0N0j_NXPti0U1Bjb5x6q>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 May 2025 13:57:00 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/3] selftests/landlock: Clean up tmp directory even when mount fails
Date: Sat, 24 May 2025 18:56:32 +0100
Message-ID: <7132fe5077ee8e0138d61068188f6d5828433e3f.1748108582.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748108582.git.m@maowtm.org>
References: <cover.1748108582.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A typical sequence for someone running this test for the first time might
be:

make kselftest TARGETS="landlock"
(sees a bunch of "Permission denied", realizes that sudo is needed)
sudo make kselftest TARGETS="landlock"
(sees a bunch of "File exists", scratches head)

This ensures that the newly created directory is cleaned up by the first
attempt (and also gives a slightly more helpful message explaining the
cause).

See proposal in patch 3 message for a more generic solution - this might
not be necessary.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 tools/testing/selftests/landlock/fs_test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 73729382d40f..e65e6cc80e22 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -5,6 +5,7 @@
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2020 ANSSI
  * Copyright © 2020-2022 Microsoft Corporation
+ * Copyright © 2025 Tingmao Wang <m@maowtm.org>
  */
 
 #define _GNU_SOURCE
@@ -303,10 +304,9 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
 	 * for tests relying on pivot_root(2) and move_mount(2).
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, unshare(CLONE_NEWNS | CLONE_NEWCGROUP));
-	ASSERT_EQ(0, mount_opt(mnt, TMP_DIR))
+	ASSERT_EQ(0, unshare(CLONE_NEWNS | CLONE_NEWCGROUP))
 	{
-		TH_LOG("Failed to mount the %s filesystem: %s", mnt->type,
+		TH_LOG("Failed to create new mount namespace: %s",
 		       strerror(errno));
 		/*
 		 * FIXTURE_TEARDOWN() is not called when FIXTURE_SETUP()
@@ -316,6 +316,12 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
 		 */
 		remove_path(TMP_DIR);
 	}
+	ASSERT_EQ(0, mount_opt(mnt, TMP_DIR))
+	{
+		TH_LOG("Failed to mount the %s filesystem: %s", mnt->type,
+		       strerror(errno));
+		remove_path(TMP_DIR);
+	}
 	ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC, NULL));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
-- 
2.49.0

