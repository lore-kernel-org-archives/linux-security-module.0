Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311BC221F13
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765041111; cv=none; b=CHcz0uunsWIWb+Kgo9dCHvb/gnO1c/fpESOCHHgfH2dJ7FLPDyrB1WyNoCurXBkXFZUofZ5OF3/33T6KLXXC2snzk+4XMMwr4aGsDEIvmjuV6J34mCnNbZGb7LeqiiLEgc3iW0owvSwrTIZCK4vSyupT4xWBqTN78RKgcbeFPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765041111; c=relaxed/simple;
	bh=LPSYOt6p9RsF0wjBKMFXHs1jhLQAlKqyLmg69yELv14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHc/ifrYb9VUrI0n4uvrwbGKoRuUNa3yYGpnqHa8cdY1w/C4SOPMXV2fUUKALFVf85Wy8a1IvxKC8ywGp4QITXqb07zsg3LpvFTJ+HwIR7LkfkVS1nqo4OIb9rXlIegtlxU1i2xeU4/ZTdzui7J5TWsa2+de6qB00Y3IxeDVemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=vrQYqxzg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMvhghWF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="vrQYqxzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMvhghWF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 658A97A00F7;
	Sat,  6 Dec 2025 12:11:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 06 Dec 2025 12:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1765041109; x=
	1765127509; bh=5Rclm6fHE9Yy7fKk3zzq0qe7YAwRr2cxst08JAbJY9I=; b=v
	rQYqxzgcWZRZpzZWEenJTPSh09AkgmcBNPlRXtlFwg9jFpHt9VItIktbhiR4aSPH
	Y5LRS7EYh4zEuH+8gvi1p48L2HtcjrmHQR9tjkpfRi8FKu9ZLaTSJET5DN7M75ks
	rBL0DigD89U+vkg6t+o+jHIlSDCyESeN5Q/IZMI4DHNu+2LAfx7Q7+rqiV2+ZRAB
	4107x/G7xMkcqymvUpmve5EflRu7ObhUk+QO1jgxS/+Y/oQaI40Zl6x3FQTTNq8n
	MxDiXXmKntLzo14qZE+zMemY7Yt4yUsMAjGC0G3d2fuZ0/+0e2WitE3xgm8Fo+SL
	p8+rmzQ4udo2ukNv0QDzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765041109; x=1765127509; bh=5
	Rclm6fHE9Yy7fKk3zzq0qe7YAwRr2cxst08JAbJY9I=; b=vMvhghWFEEotLs9IM
	/Cp6xMsGQMip6jLw949RzFbstnJTYePnc8R7fS6tr/f7p77lhIH/MV2yAw7rtlNt
	IVIZLBvUERz4fXqK59GtG9ugaKcQcmEEtP4Olnr61Zsdsy48HQXQee7uUPHNR/58
	cndLXzyWpy3X4J5VXtJbhj+ZH56Xb1UidE9fbOwiuD/bxvelGVRFOe8Pd0ndVh+9
	RY7Lc73G+lZU1S21/71/J3fFjjbHIcZZA0AvUWRpts+7mf9ZNkbD4Ksuz3bjXQY7
	439B+SseEYPN+Vt8S1023/veOvan+IpcNnS6HxpXrWcdoDbtKEZpS2/YBa1wCtay
	+TKqQ==
X-ME-Sender: <xms:1WM0aW2RbPDTcewY2DXI4iFqXGxRqASaSB07Nyxo2EKkGuj-cJRb4g>
    <xme:1WM0abXdK36bterJWVFg-Lb9XZVcf-L-mot5PAG6yFq7QlEBKYVSt0jppeHc-fIhm
    j0vf7JC0Kyft53IY7sPUZWQEzWvIuJ8k8XZUQq4lSP6Qr1Rz1yDfRQ>
X-ME-Received: <xmr:1WM0aRLg_WXG_qXyQmP6a5Y6v6_SeWlCudwnVv_Rl2be6exJq0IxlY8FZA-NUd5KGrw8DAq09S5Bss5AZRpP5dZgRtDnVoRmAwz3Ox9kRUjfzEF7Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehu
    thhilhhithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1WM0ad0BsD-IdtcqFopZKpjm8Cdrx8dNcVAQ52ukmjNbwJE5M6uWWA>
    <xmx:1WM0aX4tDuXEgpxQZ4xoA6DAeQRgYQ_G04nFnCOI75XAWRtK_8v_OQ>
    <xmx:1WM0aW_yXcrholoGITwS9adPmA85BQo6a9zZuzRYj38H0m-iO4Ml0g>
    <xmx:1WM0aeVO_sUK4_RHfmEtWF2X-8pXrq62WFUlxn4WbkbXOGZ3pPTDiw>
    <xmx:1WM0aWkOxO2YnN2k-k7J4Lw2b15FOnAcAbTLPQqk8DShaJlfCT_Oh7HU>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 12:11:47 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 04/10] landlock: Fix wrong type usage
Date: Sat,  6 Dec 2025 17:11:06 +0000
Message-ID: <7339ad7b47f998affd84ca629a334a71f913616d.1765040503.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765040503.git.m@maowtm.org>
References: <cover.1765040503.git.m@maowtm.org>
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
