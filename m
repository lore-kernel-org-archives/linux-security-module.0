Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34627462
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376424; cv=none; b=dHryzCBavoloQuPXMM1lwMbjVmES7gOXrPlmxiNphSoYkGrDE17ipC9lhxLAdp8H0u8A3lxkUEdxCoVaWYFrlqzJvlnTKyuCjvuU9SbU0Z+yW04HHleAANAVj6dYWYz4jBu7g4dB+JtrNNlPiC8suSHO0hKM8ZsPdPlacp/OI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376424; c=relaxed/simple;
	bh=qfwQgV5DAYbkzEL8FMOQUM2ZIN4UwdZaw2llApRIHPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWknAjGt7UK89OK6myspT/fYlTKpelCBIMH/atdH1Ps725wmpXY55tsi9pI07vje/MbuqiaWndUdw+Az54VYQYq1kcfT6nYxLx8roQZjewS6hsF1BnmhH282m/p8fwniG8+HmnOXLylXQ2ox2lnL5/d/gQmPVQ5pF2RjO6r+ax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=E/F0tAzr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYGCV0sn; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="E/F0tAzr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYGCV0sn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 482E31D001AA;
	Mon,  8 Sep 2025 20:07:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 20:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757376422; x=
	1757462822; bh=VTo5y6MojU4pEH5dGDmGgQtDudtktFoaROQl6MVefoc=; b=E
	/F0tAzrzXz8VGHS6PaaCVGV7tNWb72m8c5M/cvlT76fRhl0pfVk33jDqKQyiI05l
	EVf/mhmjfmNREWQZvqYiObatcgh7Ah5YCoHm+EN92XdDN+clf2GsgPTBSLmLyU4I
	bZrNddnJV0sC79RvRZ3z8m/m+oALZxOXF9htz6mtR+b+VpIvButhu/gW0r8yEeXV
	RQFxSHStz/Uk3Y60Fb+EJcF1ony+Un7nRZ0OU6kizoOH0/hjY+kMB0h3J8nsGE5K
	VI0vobj0IGYKxOYuSMgYVAe/LEBFZszjHrdX3HToeqhYltZBNS4FtfINub6ercxi
	Zk24cY+qAbQ5ZMzM+g4kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757376422; x=1757462822; bh=V
	To5y6MojU4pEH5dGDmGgQtDudtktFoaROQl6MVefoc=; b=PYGCV0snrWX0a3mYP
	DeXtcw4G7Rz1bMsTVeONjgulWBqjtWHsnFS/Vk4A/UaMwIz8rWHEc+5AjyPo5I+Y
	JLXTttqqsYwwtnpdbvqr106dQ2W8bZEsedQxbAD6kQGKpWaSbVsVEoVwabZnFUQO
	Y1y6wDn37h7S0aB7cgNYdX6wZkgiwxgaGVB12yQHl7ha/zY5Ss3danX7idbWNv+L
	XYS9kyKIt8fwEgpLPIBB8WaTrLwNDV/BKvHtWMyFwCnggeuD2InQWSiiOmvkqZ7h
	ss19prM+986TVvVBpKdMQniQ7TuJglBEjMV6Rbw9rqNgLUZPc47H1DFWCE84qRL9
	ch9Jw==
X-ME-Sender: <xms:pW-_aCQU193jT3A20H6GzCNRhDCqrfUtx_NwCbsyHPYHrUpXia50nA>
    <xme:pW-_aDR-7hxZj5EKuXynIECIMjG-rVPvqimm6us0P44bc65vJDj2H06QaLZOW3zV-
    7-aCiLlY_gXH1-JFIc>
X-ME-Received: <xmr:pW-_aGSef4x6ecryW53cIGx5hxxw7c9KyZyzkSRqLjNx0UZRqsTsfyrExOSHPxWXH90QkdITiYuuVo1K3_OrGMnwghj_N5Bjp9GLqnqUyit6DWvjKlwxK8lu1w>
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
X-ME-Proxy: <xmx:pm-_aI4F6muy46UoVa2CnWKvslNbpsG8QSXIaAEoO9rfA4y1q2JSIw>
    <xmx:pm-_aC1LhnpXJ0JVMZ4MFD31_fJhV5S4ZeTmDSjxe-4drnCB9PUSrQ>
    <xmx:pm-_aDC4bXyuAvAOrGQYhl4QEkiB1Ci2c4W-smlD99y70SmtIFodaQ>
    <xmx:pm-_aNPN4_H7We2gPxRi9zazw7efCAGIFURLP50OoAG_xsYgP5PKdg>
    <xmx:pm-_aB9apRKAHQ2Ke0zPl074TA_Zff3cawscK6n8kQ0_gykkjvnG9ngq>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 20:07:01 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 5/6] landlock/access: Improve explanation on the deny_masks_t
Date: Tue,  9 Sep 2025 01:06:39 +0100
Message-ID: <9253127a0386f53f84897f62a2beaa5aa5959360.1757376311.git.m@maowtm.org>
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

Not really related to this series, but just something which took me a
while to realize, and would probably be helpful as a comment.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/access.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 7961c6630a2d..5e2285575479 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -67,8 +67,10 @@ typedef u16 layer_mask_t;
 static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
 
 /*
- * Tracks domains responsible of a denied access.  This is required to avoid
- * storing in each object the full layer_masks[] required by update_request().
+ * Tracks domains responsible of a denied access, stored in the form of
+ * two 4-bit layer numbers packed into a byte (one for each optional
+ * access).  This is required to avoid storing in each object the full
+ * layer_masks[] required by update_request().
  */
 typedef u8 deny_masks_t;
 
-- 
2.51.0

