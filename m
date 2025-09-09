Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B951172A
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376424; cv=none; b=OxyDHovhF2zt0wnONrAvrW6xyod+/XX6mkfNYhMeKEmuQEAoCAm9tpn1W2Fxm3ips07QGt10aZWHqAVmTYE26dtqpZel7/OQ2QHVL8sE+2eptSejZgxLKnCGn/hYOk08Q8cTjVUysSCQru8fcoGWQgaGADNZIu833buk7YHIKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376424; c=relaxed/simple;
	bh=rC7cDXp1GcGpkcrUgWI/+A5bzFX31l9OwyBVldBsSjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2nCrPnTg/S0c+0LUrhBUhaSDewinyc6KtyqllhGhP61D0METPRPUb6EKi+e5p+k34WGJKW+WGdD4eFKgJVz24zhoAxCp1Bxdim3lHY1BQWOfCx5m14yc40plhc2LYx8fytY1ILY9/WyzpTTM2XLYL/xC13s8km0eKwH0M3SXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=SULcCo6p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCmPR8oB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="SULcCo6p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCmPR8oB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C8B161D00188;
	Mon,  8 Sep 2025 20:07:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Sep 2025 20:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757376420; x=
	1757462820; bh=B+2WlJRanSYP+7qBNRZRYYkS2oX6VG43wAMLSVAyILo=; b=S
	ULcCo6pPpY08We2wUu978tC8EGMTSFGRJGFggQBgMfqykPnCOXm2PJ7mE8du8yRJ
	WN93n+pIjJ5LBinVyV38ZmdUxmPvqikhbTbWIuI8ghOG7xZttvEUaCO6hMjq5OFz
	9Yomt3srsqsG+JFWey/Wvp7PhinhFTAyaJNCV9hI8vxW3ECVtg/4/OA/W6OORwC3
	FLZZFBCnH0c6DIbxWtPiaZM+kOzNW8cbkYVBGJrihjxR9Nm1Gi0k26CWtzaYZGrk
	wD2aPzN2X36ZbGKRHp+pSxCT7bT6uh/kJx0/a6mfnQ85P8RHMAgHsRBvV8Vcu990
	Chv+fHIVvLH2Xr/Tp3o9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757376420; x=1757462820; bh=B
	+2WlJRanSYP+7qBNRZRYYkS2oX6VG43wAMLSVAyILo=; b=VCmPR8oB/Tk7Rv5QI
	/54JikZwQKjoFRgim2z+kXVPtKrsuHIZfcHsv+Zzl83+1W11kToBzlmuDDHPY9Yu
	5q8vUIpvpXR3vZh2/dnuIhh7ZkXhY/fQeptdaVTUz0+vi4eZUuhV7ZA4PuHXyOeE
	B3D4oCFkLTux6WO21HrXPGDlezNvlzFtlv+D0UCrbTQvxlmQGEyY4tKnybbIet6N
	56e8IAZrjoDikGkhUST3YJr6DeAS5S3UelK+AQk7eVpwsKindNhbd+TBJfXS8m/w
	LbrArrEwjO6Vckh/rmndolNK3K0m4BqRx2utqXuNz/Mu6sKHl4f8WqqSoSWF+O8e
	bdvIw==
X-ME-Sender: <xms:pG-_aFCc5Lrjtn3SJZ3NSKnCqkQYfNa5j7P1i_aVp_N197fMbyEZKA>
    <xme:pG-_aPAAmRQ0J-2fFe4R1qHv7XbtSzXIAixperXB-dOM5Wicm7dPXIUoQpakYdmbM
    kyd5XQzY_9OBf-cL1c>
X-ME-Received: <xmr:pG-_aHAw3r6Zt42mFzQQ0cgfuK0b6_LH1fRVh7FXaS9Y5F9MI5ADartSHhZKZwn19kqDVQ7KSLQvNW04WkERQ16dy9psAOst5TZ0Ja6yPDPJjMJ3C0zERJ31Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pG-_aKr8dODxkfulwedtanMXMc--7G2f5DPhTgFhsjNboYtTBhz3Hg>
    <xmx:pG-_aBmqhAkL0SUHsr3F--nnCVskePutIs5mPxhO9GHhGxntaXPVyQ>
    <xmx:pG-_aKwqlBH9CoWw7iNu3iEJlXJ-sRI3J1-WNxWFbX3Xj2nh9vLZkQ>
    <xmx:pG-_aJ_0bRCBoQGPVOydX-biNf7CBjbxpNPRR_pHQnuHNKuh3-n5PQ>
    <xmx:pG-_aLt1nTxKb-psLaQi2S0RDbCRot_vvc886zdD8DiMqn39shz0OPgD>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 20:06:59 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 4/6] landlock/audit: Fix wrong type usage
Date: Tue,  9 Sep 2025 01:06:38 +0100
Message-ID: <ad6c155f38dda6ed31be1f1cbc6def6cdbd9769c.1757376311.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757376311.git.m@maowtm.org>
References: <cover.1757376311.git.m@maowtm.org>
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
---
 security/landlock/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 2b3edd1ab374..a67155c7f0c3 100644
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
2.51.0

