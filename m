Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68F2AE78
	for <linux-security-module@vger.kernel.org>; Sun, 16 Nov 2025 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763330554; cv=none; b=XcK7tu8cuI38JXGrbuy1yVOb1/Ey0cAfOnEk4S9AwAy5i4/fuDwJFMc9f1jYi5qe+HolVE3rIxuGzTrHFYKPLib0ut4KwoLWJfJh979rg2O8WayV5rKIaxl7hxSJyiDOnUjkgVImgU4P73Ho/lv7rz6ewqIXKT6G4dvxFgEI/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763330554; c=relaxed/simple;
	bh=BUdRocjdUK1MrD2m8LxSIiMQt97ZJZDJjKvdrfHECio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/N11Jl9E3iUMOuD6cZ+uOX1urNJt/ISZIF+v7H5SymB4pzLPBwhxj+4+2/EY9UnUPGUiIsnTAYHMloNJeQocXs21FlqxsMu8Ju1SgOFnJlWKECJH0e1bCJRTb/h0KxIfz2Q/cJioylL2V+Uo4LLm3xuDaryU7J/a8bWxhkOdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=cfMSNnvd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EizMjE4f; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="cfMSNnvd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EizMjE4f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4414C7A0085;
	Sun, 16 Nov 2025 17:02:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Nov 2025 17:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763330552; x=
	1763416952; bh=SQGJtNwQ+CsV2jkhCuQQISQJxYK0xtwa7P8DsSkGb1g=; b=c
	fMSNnvdKRYdMdKRwERlQE+VD3Duoek3RrVDb+QKKKUPoD8pwhcX+I79kjCr8MMI/
	0MRrSnO3mm34Yi6REW2pnRPU5MRvslvq+uEEmv5nw8BW4Av2XIBIFHCX0R4l2mai
	8qt4Is/FVvlJwFsnzKMw6FkiYUhla2apZPT9T5x+LTcRCdbbJqqtdFpKjQ//YiBo
	joj445MAujY/Pbv3dLhy5+SjNuT/LoHLCBhWGyXbLRp6+GjpnA+Wwi/P1Cm/S04k
	bNryHc1HeYsoenDfc3TF45LNU5ltDqKKG6AoPvz6PEz591AO5hNd4zkq0TOcUSOi
	G1ZkLYhM8aQ0kmXjnZtTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763330552; x=1763416952; bh=S
	QGJtNwQ+CsV2jkhCuQQISQJxYK0xtwa7P8DsSkGb1g=; b=EizMjE4fuxwOikdlt
	EinIZ1hGuSykTdUTmTGHe+v225Mkfmit38e3bGNTVO3Rmm62rkWYDAIsTzrpdE1+
	F8fWMeQa0P/nqxQz1vuBrVP6CojqZc73LaiT7qb1xQmKKXtanTUFONx8gpEWVk8G
	8iE54fpZ/3JMAqnwz2ihF5C7uI+H8uUmvK85AynQd+MNFRL6XnNWUcqfxooy5Alw
	3d9ADs81pviVS2rHzxksPo66s2Z3yKO0d4mWPwRgtVLSNaRask4T6gMgllvQsZas
	DtRfzdm8PhbY11kJQqBYkBuOUMfTP+mHEJtQS/VZ61pf1QWg3vFUMxQWi5usBA/B
	PUpkQ==
X-ME-Sender: <xms:90kaabd4_bo8evwHS3C4dWbVOsmrqD2a2TuxmnHN9rXnmr5bM5Ev4A>
    <xme:90kaaTfU4lGSDuBaS70HsyGsrWLmP5UseOCyg6wD5aZEvmkJMAbL6GdcRGHFWgCNm
    X0cQd1fXD5iFqtTsPSC8nGiTRxKVQ0U_fAimBf0UbPXJqx326LwVhc>
X-ME-Received: <xmr:90kaaWyhNegY-pbtH_sWiJu8fLyjOZY_PyOQyTDThoujAzdSxQvhak400ejmgPqwI8b-4dJF1_uAN1TrYST_E41GGatMPB6dLiolOk20rXsH_AbX9GpVkgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeuud
    dthefhhefhvdejteevvddvteefffegteetueegueeljeefueekjeetieeuleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdroh
    hrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    uhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkh
    esshhushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:90kaaS8xHBT7UpAGZPidCe4U97yD8R72NoJ_hjm__UtZw7G7lmHRqw>
    <xmx:90kaaWj_OUULo4PQhGFT9wQF0TFEp_iH8-tE8UYt_vEtUlBuVq12Sg>
    <xmx:90kaaRGPVovrHYbrMYPGHW8-sWz0uJbR9tqlcM8FwjcL3oSq8Hrehg>
    <xmx:90kaad-L6i20ibz02721Gg1WTjP5aYyZYxcFXaD4ZL0LEBTIM8hxFw>
    <xmx:-EkaaUuopeQEGnSxnReLboarMdKE9ayKr-SCuTosDcLFcsaK_LnCs-M2>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 17:02:30 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 04/10] landlock: Fix wrong type usage
Date: Sun, 16 Nov 2025 21:59:34 +0000
Message-ID: <4859d86c52b001b1eb606a57735239668575da3e.1763330228.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763330228.git.m@maowtm.org>
References: <cover.1763330228.git.m@maowtm.org>
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
2.51.2
