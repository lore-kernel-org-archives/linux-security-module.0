Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58A8F58
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379334; cv=none; b=dmmxe9IpgGaiE32ZnwS+Rw/5/BenponM24t7PSIOChQ4ExdeuBnAR2UEmjXZ1dMIXkdPPbwctvq2tGpkljTM/ChMZ/qRBgf6XCc7iqMMxkFx4ySaWMuL0YTc8llic6xYkAKJfakYJ9nPHSSVUgNg2V5FNq+P/BTlA3C5GVfs8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379334; c=relaxed/simple;
	bh=3MjshFLmpoCLAIuAEi2mN1X0uSJtUyscGF+01qeLEho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4RCZobzeTCxo87G6CIKpDoOFlgb1tS5xL+jiw9ZoMOtrSWJCCFm4rdO8eaUIUNRX9v+6NKouB/+o6AAxilP0aCLmYqFV938AK/ikTY/RVpdEzyi9yT6SpPMgOCjEIGiqEb2jXnvhRytWHhqqIlR6YVXOk8TQZY+akrGfvStiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=bfSh2P69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EBbnmuXr; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="bfSh2P69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EBbnmuXr"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 93FDD1383819;
	Tue, 27 May 2025 16:55:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 27 May 2025 16:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1748379330; x=1748465730; bh=tL
	Qcn99qLdmKFRUPaLF+h74vDk8spmCEPFliNm9QrT8=; b=bfSh2P690CiHYG9LBN
	0S7WNqtkHT5OwxEQ0aXeN/4uhXGBaQ7s6TVZ4NtnzWVB+ABRBZr3jgVyRoGIZlGL
	QjE1vXw3B8MbenyjokntzaFSS/lkXn+eZOoPe77r4WVS5g9IykOGQY7z9XAx6glE
	iyB0M6axSKtP6P5coGpfRFLn9M3jPV96YgOiQ4QzSgzQFuBEXxH0My61V/fbaH2y
	8j7CpxrgppihBO0C4ih1haR5Zh0R1LqWznmlqXJpreJR5SCaYGFIjN9dpCCcT/eK
	a0fyIeixxa6N1HWNIdiJB7KI7PGtaWpyY1xRTsSwuuVTzE50e/zGYg1gDMkrbM5K
	pNbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1748379330; x=1748465730; bh=tLQcn99qLdmKFRUPaLF+h74vDk8s
	pmCEPFliNm9QrT8=; b=EBbnmuXrYVddRmGr/nWO0jS+1b3uacPkHfLj+ZjgIv6k
	K0sqxGBggHx2hz0dJZINFonM/mZo5tjvYK9oyVoOS5k1ItmP36rU7E+naqEcxl+D
	Byl3QDwR1H1ZTaoTamVxeNFAdJg9jb1kdadx9RCjGsRxDLkC+9wpN3xAA6Q1bfoZ
	oh7mbNWFD+A53MwdY/UtLTYyFhVWZu6dBg+xt4srZkRA5vzEaBXvMIe6cRxuqR2W
	spfcoFoo3VZfT9XXsWV8b8erqFjjXDk001MJWtyOBEV0BDkUauwGp0/ABaKBhleP
	6Hyt7oqdoj7iogYY2t9EsuL7nF+a5ZAsCSS83HyQJg==
X-ME-Sender: <xms:wiY2aEL5kXCpf3tOaxrAYwAF9nFqgoJQTFM2NgJYJ7aWlMkgRvWrRg>
    <xme:wiY2aEKJ5mCQ1YJMA-o4l09wAaMxR8BTXK7S_TrIEX7wgk4Z8BKJU9dirAyNH5klg
    yxIbIzOeitdnkdU54E>
X-ME-Received: <xmr:wiY2aEsVsh0Ughxafyz81WlwZd6N8yh16TDLG5i_EesIgNCYq3KLdHjzrgbA5eKci1me--zOgm4u25V8emsbyXLApbMluiLTzzy58SANMbr8FTfYOg8xAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudegtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    gggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmh
    grohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeevtefhieeujeehvdejvefhhfdu
    tedujedutdefudeuieeiueejleehfeeivdetleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikh
    hougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehg
    nhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurh
    hithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wiY2aBbf-5OyRvj2dPSCPO7H75KyMRuRbMVge7-UueFwGbDbMQTrZg>
    <xmx:wiY2aLaEN0V6VqWWMBy1DLgz9LkYxeXNKnka4FKYH_28QwWtRsZ4Hw>
    <xmx:wiY2aNChjQYJhq-iMf5uO10t_Mcam093Vrxq5z9nCBGUf1wWP2t9kw>
    <xmx:wiY2aBZXDAjVmmU9_4fQS5My9nJSboRiL7TTGjb15xgH9_PSyxzcYA>
    <xmx:wiY2aM6k7R4Mx0wz6psRdrb16cIfbo5vZn_t4jLd5jZCvzl5QbYcHZQo>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 16:55:29 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] landlock/ruleset: Minor comments improvements
Date: Tue, 27 May 2025 21:54:48 +0100
Message-ID: <20297185fd71ffbb5ce4fec14b38e5444c719c96.1748379182.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël,

This patch contains some small comment changes.  The first three I sort of
made along the way while working on / trying to understand landlock, and
the last one was from the hashtable patch but extracted here.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/ruleset.c | 11 ++++++++++-
 security/landlock/ruleset.h |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ce7940efea51..2ed7043ed2f2 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -83,6 +83,10 @@ static void build_check_rule(void)
 		.num_layers = ~0,
 	};
 
+	/*
+	 * Check that .num_layers is large enough for at least
+	 * LANDLOCK_MAX_NUM_LAYERS layers
+	 */
 	BUILD_BUG_ON(rule.num_layers < LANDLOCK_MAX_NUM_LAYERS);
 }
 
@@ -290,6 +294,10 @@ static void build_check_layer(void)
 		.access = ~0,
 	};
 
+	/*
+	 * Check that .level and .access are large enough to contain their
+	 * expected max values.
+	 */
 	BUILD_BUG_ON(layer.level < LANDLOCK_MAX_NUM_LAYERS);
 	BUILD_BUG_ON(layer.access < LANDLOCK_MASK_ACCESS_FS);
 }
@@ -645,7 +653,8 @@ bool landlock_unmask_layers(const struct landlock_rule *const rule,
 
 		/*
 		 * Records in @layer_masks which layer grants access to each
-		 * requested access.
+		 * requested access (bit in layer mask cleared if layer grants
+		 * access).
 		 */
 		is_empty = true;
 		for_each_set_bit(access_bit, &access_req, masks_array_size) {
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 5da9a64f5af7..dfd883a9a52a 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -27,7 +27,7 @@ struct landlock_hierarchy;
  */
 struct landlock_layer {
 	/**
-	 * @level: Position of this layer in the layer stack.
+	 * @level: Position of this layer in the layer stack. Starts from 1.
 	 */
 	u16 level;
 	/**

base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
-- 
2.49.0

