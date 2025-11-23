Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF40E25EFAE
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931764; cv=none; b=a+grrIrgPafTwd/2LdyryvX6VmVyS8VI0LT/ADqVj9tpFbKLzklj+I52GGmL+/IxhFNfHB6htWq7VFdm5X+YyNUlNRBTGVGWgRXGqUwauT+6cu/8zfuJ3xR+OmPkrkAISlC7WNx4IVEwC0ifoAX7POcpjFQ7FnTMG/h/bk6o4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931764; c=relaxed/simple;
	bh=LPSYOt6p9RsF0wjBKMFXHs1jhLQAlKqyLmg69yELv14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtfukMTS2hM80cNwNbv7sDSxmH3o8cyGvfpXPTv3EkmbP6dUMwIyFgDnP0RNk0UtyFAEjBO2W3C4dUoyqoVzOVRVOKT6+eK9Uh5GQhTnmfXqTwkGAOxc7A1HJG4+ETcuNbppGS37db+3HNr6V8gVZLshTwjj/3C987eakuQp6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=TZItqEwO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQI1PgdX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="TZItqEwO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQI1PgdX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0484914000CA;
	Sun, 23 Nov 2025 16:02:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 23 Nov 2025 16:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1763931762; x=
	1764018162; bh=5Rclm6fHE9Yy7fKk3zzq0qe7YAwRr2cxst08JAbJY9I=; b=T
	ZItqEwObCb0ZKpItp4xB1eNcK2KYHrI3FrFia4jQxGPcbfXQs+F7dvG+5E9E2aKh
	HEduCCDzVKn6uiKyq3fW/M3sxK8FLDxbNv6ZVe57P7vmFUY5ZLK4B/G3ugk4pAlb
	SY32Crrg0pY10MoFKWQtf0POuR4t2T3RlTPKiG1odXHClQmNn81bk8dYiKv6rM9h
	0aWLwx8SGblIHTMD7KutLU9EX4QMk9r6S5GfvkrZPYjCVCSxv8AP1Qfhafe4ZUN8
	U4JX02rz+XXIiVY4Lr7tEvXMXnzgy8q3Nu5ED9lF8Rwy1VPlMDG60jn/fDH735iK
	3P3MVsXPL5M8prqR0kolQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763931762; x=1764018162; bh=5
	Rclm6fHE9Yy7fKk3zzq0qe7YAwRr2cxst08JAbJY9I=; b=VQI1PgdXOA+i3y4fS
	6BrC2yPzMjFOYXoujVXGmDAxyEAjNDne4p+b4VQLQS1olYdK5CgFDM5iC7UZCzl3
	WhF/gmog3hY0GaP+pQMtGuGhzQkOZA04omVCBwwfkUQonL3DZiVoML+eKpqSXMcR
	MX1DE7cG+vsUBRpAQHSr5zH34ehgndOatsfI+b+ILdernBEhBQvCJ8Xb6hs9C6zG
	V4QeE9n/komAvc9g4aVYovZAtSpgwRMhl/eYLumcJm1FNg2rBHWGE2PrlzNIQbm4
	LoXgMWcuK2vcP5u/biz8jMyEwb+dB6WfQIBpeuorUKoz5jWl5b/bYS1XvDNo9Jvd
	QTL5g==
X-ME-Sender: <xms:cXYjac7X1MQZILCz2hFl51oWDbS8Bfv7NN6Nw3gxnEnJaPiuJySomw>
    <xme:cXYjaQL7OJ2JssllWz2MakdToBNor7JMH4Q6hN1Hp2IFZHl1XhSDgSzkorHs3HGq3
    Oy9uIn0yWeZEhAEiTJOkt1I5mmmQXc5XoDe6xs5adfWKTYR9oso_kc>
X-ME-Received: <xmr:cXYjaduH4i_IEBo5yY1BHFWe-rf5nWUGyvMiN6GtATSk7AQ9iHlFnO7T0EaTmss7jLr_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cXYjaXIIFqBBk265vGKzYBjKS-C6BGm-dpWab_8_HWZbo78twWj_tg>
    <xmx:cXYjae_YxOFsrqktI_4UOCeQKaIYtMZRXuD5ZVuztFOKQe8cmrtU8g>
    <xmx:cXYjaYx3WIyKlp1WP03d1HEd61P0YB5mu1VKJj-bdaoHDj08lseZcw>
    <xmx:cXYjaT4K_U3XA0rpKkpNVd6E0tutc2i7b8a1dcndL2SifRs-tEfCkQ>
    <xmx:cXYjaabhg9g3XM0zAHS6FbueDWT4Kda25FyQ9byzlGj2KyJPJjB0F83q>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:02:40 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 04/10] landlock: Fix wrong type usage
Date: Sun, 23 Nov 2025 20:57:40 +0000
Message-ID: <7e27007239d0b82ba7fb1ffcb13e286e63e25803.1763931318.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763931318.git.m@maowtm.org>
References: <cover.1763931318.git.m@maowtm.org>
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

Changes in v2:
- Added Fixes tag

 security/landlock/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 1a9d3f4e3369..d51563712325 100644
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
2.52.0
