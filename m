Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22A21D3F8
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511538; cv=none; b=TGqNYpqGJOVgZyqh3Mjhpf5vmh61E34qzB96rkq+n1Mx99aANOogaCmTX33UwAXYQtIkB+WI7FZYsrgbXDDV5eJ83N4okMNk1CZfH4YE2Ox9/aKMcKQkfhIw+eZy1Cjw8+zF2E7N/AxEvRxS/GcCVDqwHKzu3hLFb5cJXBElo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511538; c=relaxed/simple;
	bh=rX1aqFJ7Eq+1DMKLAX6N03hfBnx0E6A/XoEtPg9X0Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkRMI62NgZO3knsXgHojdOgCd+JpkDKluRY/vZDEsPBI48FV8ceQSIGhY2rhq0QJoig7AAd66c370Y7/hkZl6XFoReoB3sDioGVneWD7C5/8G+LiafVJGzXFRhPCGluHzG/VFXlbpoUB7R0km6UsDm4j5ocwLvc3SWI2xh5lFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=al3cA4LR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PciFVvSW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="al3cA4LR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PciFVvSW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DECD1400241;
	Sun, 26 Oct 2025 16:45:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 26 Oct 2025 16:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761511536; x=
	1761597936; bh=AoSqoa+KM6UX3E25cF/SLwym7Z/NbWteQv7TWCrkiZE=; b=a
	l3cA4LRzlSviuucMFAnqs0UUYpkSJPGomGmXFtvNtzQBTgbCcigjg7+2zCQJxwOx
	ONtTMB/Lncj1w3TAMMZvqvBryce45fXP/zqM+VbmjgMmzTOP+R/40tVpGfoCd+Y6
	CBPvbe5W9mv7h9i+beCqZAWCZMbFR0KCeiFT1ovQINp/jTi2qO5UHQ2tbdbvF7mJ
	lRHOSgbClGZqcgmwhfRs8wiDDCwVAnbauc7qR8eKx5oKM54sGsOtWtW/rAr5aP16
	wRnzqp2FueuLDE4gpv5l24eT/o9fMwXlmuFpJhZz9ih3c65e4AmuMkt/8zpiH/ey
	Ah283yp3x7srT0kMRNq+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761511536; x=1761597936; bh=A
	oSqoa+KM6UX3E25cF/SLwym7Z/NbWteQv7TWCrkiZE=; b=PciFVvSWRi/pEEjqN
	wV0e+t+VcLt2JV++At9J3o0o0Xs2LVgZoZ6z54nGi0MnREMfYuKTFBLShoXSSb9g
	TXpmD1+EHsoL3YMR3uIpiKB2jOSw3sddGW0R0OelUnpTVBbPV8DMos+egzXqQqf4
	jpl3pGBPZA+jEYDdMfn1sW1oxKOAFv2bcn5IoFlR7PyFY6n4Xfh+cw7qlQK3iWcY
	zBctr7FtbklYcqcY7zFKh9rfJ2pMauyZzlX+PZMacfWfNz9wuQJuqL939aLSG3QM
	diUyB/nUDBKOCzP8mSkli0ItW15SF9IlhdtNDk2v4sPdPoMRhBjJhKhConMjUgsS
	RFC4g==
X-ME-Sender: <xms:cIj-aIhgQe2sheS_QuO6aeu-tFwiLw7NMwO-Yfbq-vg01-y-aQebmw>
    <xme:cIj-aEuLYabXTnLmFrar3-PlZ5PAqAv3h3sOMVyKWjd2YSh2xrceyoR7riwvpU1Aa
    bZ_G3PG4CNXlU3YhXTLFK0ca4DkAL3PIuTurqfcsY5XBLWGRtP9Smw>
X-ME-Received: <xmr:cIj-aJ4LlTZGzN2SEdg5uH3aH_mHzg1s0aRCHVU-z2zgnIPikoPM7JprCwZ3-hblnuaEBEmrlaRajDVAgu3txZUsNtdVKUx7700adsQSGhSuPQUoLjPxX_TqdsVdCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    jhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cIj-aANWe8MNc0EyK9QSbX7CHfcKsZVB4kWQ2ibKUiHPVp59bjwl-w>
    <xmx:cIj-aHsgBFaOo2ZzpYa2QOXBdfDzRkZikF-XocwMQPyYr7w-zfxmkw>
    <xmx:cIj-aDZ1hH-hAEZF6lhXY-TKhHawONjNDN2yAIEKRPcUMX3JQa9xrw>
    <xmx:cIj-aJzihDytt8FexXMuI2PMKLMl3B_wFMYYXvDiJf_8w5eRt1OZ2Q>
    <xmx:cIj-aIpfaByZldpuNt_adChfrhAyOZ3sBFCTTzv_xTowuqftpucegQWo>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:45:35 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 4/8] landlock: Fix wrong type usage
Date: Sun, 26 Oct 2025 20:44:19 +0000
Message-ID: <92c8b2552e3fa2d808b2804281ce128e8235e393.1761511023.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1761511023.git.m@maowtm.org>
References: <cover.1761511023.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think, based on my best understanding, that this type is likely a typo
(even though in the end both are u16)

Signed-off-by: Tingmao Wang <m@maowtm.org>
Fixes: 2fc80c69df82 ("landlock: Log file-related denials")
---

Changes since v1:
- Added Fixes tag

 security/landlock/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 505b13c8f4c2..810b1665de0a 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -191,7 +191,7 @@ static size_t get_denied_layer(const struct landlock_ruleset *const domain,
 	long youngest_layer = -1;
 
 	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
-		const access_mask_t mask = (*layer_masks)[access_bit];
+		const layer_mask_t mask = (*layer_masks)[access_bit];
 		long layer;
 
 		if (!mask)
-- 
2.51.1
