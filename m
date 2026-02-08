Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF64086A
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770594913; cv=none; b=Yw3YDBklUXAdh1l7SvGN1Tm9//bST6hqe9L4fJn4z0kl27OPNGFRiZpyPByf3/ybIqHZHd4CF34S/GuUcVDQz8HG2vk3DMpQCjSyeaBxjtUkzGQU7J9ngLcpeY6RM5V6udNNIAo+keDGeKORff5siBuU+SQfD/gzoSuC5sY0vcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770594913; c=relaxed/simple;
	bh=IU0xHaqUtYi59stM/77X/UcYvQx8Gjq6wDakU8tGMXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnRdoChVjsVBDu1HdQX9aTt7wIS4Q/h679S6MfkJOTZnYSGh+gQQuw/V5HR6jiCdmrcZw3dl9qVYWcmbYHwGyuPc1zOk0GCIgowel1id3d1JrUlJIV6MUDy/rYOBV5Aq0VVCU3k9TE/aw2XMU1dcMBNfoK2BcQML+o8dVQU4jaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=uiNo+rCj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0N5lOWS; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="uiNo+rCj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0N5lOWS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DDDEEC0553;
	Sun,  8 Feb 2026 18:55:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 08 Feb 2026 18:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1770594912; x=1770681312; bh=FuewQc9gokyav3ev14WQ8
	XVSMqM7wLlQ/lE9Elk2vOE=; b=uiNo+rCjZQo3rqMV/IhVaE7yEYMiH/kUD3rbm
	vxt18/BsNnM6sqIe5l4+oKXodePRxgfEckojl9OQBSkQ9HBbsZsz7aGCE4PadV6n
	9VHhyETA/vexnBlbEI7dj19jkRRYxJn1nc0cPm0Ip0mjG9nTiart6VkEvDFIfz5H
	LZKLpBjrhx+vlM2CW11u5eqVFngpfnE1V2L7HarAhCEEndapnA9jHkCt8Tv5N757
	mQUBTvmrFORLY1dk6r7W7P1hGDa9YU6MsSFLbFIJOc8z0bgkvR0d84QTUCsYfdJl
	7qd4Ci3uYoA0vIDYGOLsLF7Gjk8cKW38/3Ioo3HWJHgPyAyfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770594912; x=1770681312; bh=FuewQc9gokyav3ev14WQ8XVSMqM7wLlQ/lE
	9Elk2vOE=; b=Y0N5lOWS+D0YEN8L/ybEh5Whe5DS7OnwHUBODMCycCKwoJJaeFx
	WJaGlnvRU6OnsDmwOChdSDbuzmZS53iAjT3j8Z31p0drLiogMyPanYjkrqFiDe+f
	Qf19zPYIdWyIPNDZgNEQSZRKgms+3DWJkJ5kkzsFp42M6IsMjKBthHpUuVn/AE34
	7YbIFGEM9WxsOglhClwHcK8YN2JPnrz34U5AMDfasWgDf/vGZwD7WbEq5wSrgoNp
	8V0e3EKtxtSBJ7apqZa29+fHtCqUGhBQnJBPQwdQDaVxH642VmVg/tS6Lr8c7afi
	lQ6EW94PVbpmFHp6Et6lQvZfMivtSMGBp2Q==
X-ME-Sender: <xms:XyKJaSC5pSzZQesMDwn5UUBAxkVkPGMyQXTbUm0_YEqhmqJuseWejg>
    <xme:XyKJaThTkbPyY5b8LiydywRCOIhn3GMr5PzFFWXKmQsfA_Nkk4U1qwvSuPbyn9ERD
    YUtpY2WeNB93y2-C0z8laufId0PeA3SfjBxmNrpFZSs-8MuaY0QRw>
X-ME-Received: <xmr:XyKJaanMLrvL42_xqPc7CwqMIAmT2sHr1kM6OEPp4lcF84VzhX-AGx_wIAOVRZm02Zgv_CNcxC5CX2hdddow5j3YRdz5p9hjhCOIoKxYE4lZX33ncoPK91g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgrohcu
    hggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeejvedtke
    fhveetjeekleegleeiheeuueetleeftedvieffieevgfekieeiffevgeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdroh
    hrghdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    mhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrgh
    dprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XyKJafoHudEPQnvSfz_DCo2vNowvPfEu0bB5WdnEMykU9FMVV6Xt1g>
    <xmx:YCKJaTE3rFzKTvWRXpsihv7MaEwhip37N0UJQ9LOF08zqgs9cdCJ3Q>
    <xmx:YCKJabzTq9yj9kilMtg59RnTAzRN7Sb-KL7K3fxqNT3HWh2pasdJNA>
    <xmx:YCKJaYoinxYa-7gLxYm0XAdDscfUmbqb1M0ih5G7bp5_Ubg2tS6ddg>
    <xmx:YCKJaSjH7Fie1LIJ0CMyQ2nC5RGPsh3lNYmYIZVdzCdp2YpYHo2dycbb>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 18:55:11 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] landlock: Add counted_by and fix comment in landlock_ruleset
Date: Sun,  8 Feb 2026 23:54:48 +0000
Message-ID: <20260208235449.1124354-1-m@maowtm.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a domain, this array stores the access masks for each layer (of
which there are num_layers of them).  For an unmerged ruleset, we have
one "layer", and one element in this array.  This annotation serves as
useful documentation.

This also removes a comment saying that num_layers = 0 for unmerged
rulesets, which is incorrect (it is 1).

Signed-off-by: Tingmao Wang <m@maowtm.org>
---

I'm not sure if I should add a Fixes tag, but if I should had, it would
be ae271c1b14 ("landlock: Add ruleset and domain management").

 security/landlock/ruleset.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 9d6dc632684c..7005840ac641 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -168,8 +168,7 @@ struct landlock_ruleset {
 			/**
 			 * @num_layers: Number of layers that are used in this
 			 * ruleset.  This enables to check that all the layers
-			 * allow an access request.  A value of 0 identifies a
-			 * non-merged ruleset (i.e. not a domain).
+			 * allow an access request.
 			 */
 			u32 num_layers;
 			/**
@@ -184,7 +183,8 @@ struct landlock_ruleset {
 			 * layers are set once and never changed for the
 			 * lifetime of the ruleset.
 			 */
-			struct access_masks access_masks[];
+			struct access_masks
+				access_masks[] __counted_by(num_layers);
 		};
 	};
 };

base-commit: f179e1859c711214412876c57f56f9b0cfb13264
-- 
2.53.0
