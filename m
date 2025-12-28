Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0B5B5AB
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766885362; cv=none; b=hWFX4LlHhDxF83JwBZh3JojaIQws66Rv4tf54VY+g0JuKsmiuyNoo5118foqhlOcxmNLyaWX3UQWNva+b8MhhbrdY/XGkt8SHtWmB0yWGuXaP25efGFrnIuYwtbJPZDeY/Oo+Bjp3+0EDOHf7BXK50lROVNOe1e4ERgxnkEAeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766885362; c=relaxed/simple;
	bh=ggK4wcAkPNWi1k3qPXdX2/kZJ2mTBJAFSrKIiW65GvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjbg/HaqTtzNFx5LNeRGWlwHuBqWPxLEaglOCgWM8d6mz0WoRTleKqGO5187OFwuu0l2dK+rIopBGv1icLEJ5PTTUljuVu1WLdmJyE94jAd/lUccb4SGzCfV6aJ6upEKFhl+sx76nfcI7jQZ2824U3Z5Ev9YHyfLUCwy/NiGF60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=GoTj/ZIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k07i1au2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="GoTj/ZIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k07i1au2"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 975D514000B7;
	Sat, 27 Dec 2025 20:29:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 27 Dec 2025 20:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1766885359; x=
	1766971759; bh=AgbQyNHi0rX7B76BzHi+a9JseXtk3qZXOuWI3uKmQ8k=; b=G
	oTj/ZIyGHH3+vMP1sNHLFRo4f0OAxuQF+m5dNstFHJOp3Xp7FAsHLtMAfBcv8KCy
	kjiaXnJbojw6C0MW8hLfm3hUgA7IoXCIN2XwBC3USCy2DlmMpJthia77YL59TrAY
	JjXsTcaDgV5e0spGFM+aYkIBsUN1iNFuf8zzMt0mCZCs2RKbCzwRnF3A1jl0QbbV
	8YPkJy2/v2mYvj4JH6Kg4CfNTXEPMGdTMTMAJO8xjbkAYac848Utuql9jnyxKtRv
	chh4vn4tlk6GREi2BlEIgJHHRypRBizMKgU3cnOWITNSMeLqJb+GiKLSdcHvIHrl
	7qxSoeyrs/GlLA4NNggbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766885359; x=1766971759; bh=A
	gbQyNHi0rX7B76BzHi+a9JseXtk3qZXOuWI3uKmQ8k=; b=k07i1au25s8PuCuvV
	tgeZ7l40zqYPkxWilFotjN3OwIMacFntXIBVVczHLBhfNk2d+gqj1pNyeEGTSAd9
	iGkqmRlMKfH9zjZM0wb3iKf3PEqqzl8tnrw1buAv94pDNGEF4rdDQUmub7TwCYMg
	+DFP1pVwVq4hZ9fz0OeFnPhsecgfYGsKe2mj8x+bplgAuIg451SFBubu9FpYx/Xu
	CzKFzxnatpknlrupCpARuZPmZE1L2v6ubocMNEBSNPEZj6cudL6nvB6fVEeSrxo8
	+7zN3yB97YrVJjnfl9FqykEkgqOP6/YMiugy0Xz4wK32zUIMmMfx88gc99bFM6EG
	Poz0g==
X-ME-Sender: <xms:74dQacOohSPcmljKFC_1w5sZY-oBfS4yaXqvJme7E3m0GUIN3WGvcA>
    <xme:74dQaZ_NekafjMzBGmcyoXtIOvqFU0gQZwbMbYNZFGtnu14pnnU8bwXYpyxrQ3WMO
    qilT_urGWoNN_KeRfkOOREKo8HQVllXVgskC7WVNzY1vQSD6CpUeg>
X-ME-Received: <xmr:74dQaYR0hDUB-c_AysBZJ60dcrffVBvhKYOFIhtMG47SGMhLBq2DA8iHHfortX4bqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejvdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:74dQaTlC5IQgIWKB1krEJkq8G-fYyO7bvGQF5b3qFykvyXcGNSMElQ>
    <xmx:74dQaQSefNBgnYWjJqCCWypWQc7E0Baj1BW0HNLYGpEET8BFJOU_9A>
    <xmx:74dQaZMtTS1OeEK1R1_u0KL8M1RshAxWKOstaGM_QMbUPVSHk_V29w>
    <xmx:74dQaRWNPaYCl9yjGql8vvTybVxjwFVVQobHtYYAzhJhgVQmbMt5KA>
    <xmx:74dQaZOpBRgMR7BwQs9xESiTKvVnx9ZLzssy7abVSRyUbpLX0Y1uRIbr>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Dec 2025 20:29:18 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 3/5] Documentation/landlock: Fix missing case for ABI 6 in downgrade example
Date: Sun, 28 Dec 2025 01:27:33 +0000
Message-ID: <1175b37d065b49520cbc335a9a2d501513a6c6ef.1766885035.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766885035.git.m@maowtm.org>
References: <cover.1766885035.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note that this code is different from the one in sandboxer.c since
sandboxer won't ever add LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF and
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF.

Fixes: 12bfcda73ac2 ("landlock: Add LANDLOCK_RESTRICT_SELF_LOG_*_EXEC_* flags")
Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 Documentation/userspace-api/landlock.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 1d0c2c15c22e..903d2ad11852 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -127,6 +127,12 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 6:
+        /* Removes LANDLOCK_RESTRICT_SELF_LOG_* for ABI < 7 */
+        supported_restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
+                                      LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
+                                      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
-- 
2.52.0

