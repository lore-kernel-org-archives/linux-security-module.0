Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D223594C
	for <linux-security-module@vger.kernel.org>; Sun, 28 Sep 2025 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759103467; cv=none; b=b+Sr/SGDyEUQ9/BWk+A2E67KvgRnFIf336jH/D3VfBDdFfI68qwzzbRjatd2ApUaPeCWSpdKQ+QNOvzgAuanvKUq493brsjSij3+BEkitOSWqksSZGPbzda2hqkFfM7X/B6+lomrDV5k6NspQulf4YbUXxl5E7rRxs1RMD521HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759103467; c=relaxed/simple;
	bh=mI93xh1CbdA/lGW0vSaBYqhivBqZ8PDOvC6RYjmX71Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyKXrKv+envdEpydLoFmMuJOa9GvuJd390+oYqPH6zgga8LojRg2VkSRQex+RC+jz1hzdkcCO5NosGZME4xcumUuuJEw0oCrSXKJ/C5Rlg82uVYPtynHTGpp1qXdbmtgMuA9VYoMwqngn6y6D92xWj2lPCDB5Zb4wkUC+T5sqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=AFnKM4ga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wFn3Mo8R; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="AFnKM4ga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wFn3Mo8R"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CCD41400180;
	Sun, 28 Sep 2025 19:51:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 28 Sep 2025 19:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1759103461; x=1759189861; bh=KNYT+qDZvBJYx4AVDB/Uc
	4MiSyan7R9Ct0ToqdRAy74=; b=AFnKM4gausA0Oy+UXH+MsPlhnwt5qI0i99WJS
	AF0U7ApMecHHpBuOq4ritSua4wnygpYTbZ3yS1dUw2kGiMAMKCAq3V1BAUswBzhZ
	hDSotZugc4BBUoRMnxnbpDDSow+aNp0SCoHnboB4cDYLyCdbfcB3f5QANean2t+9
	1BsJ67bclM0CgXDpR2rbbtD/i5eyMwBZY0xKVHeVUN1o4kNV8Rx0vZxLEmjJRJAO
	QJW48XUp10FrhXGr056e/+OHEGKnjYh4JyKxedcf6cw9nkJc72CinSDuAoIQ2JkR
	G487mlPrJeczrBV6sHlYBpZhmZMtFMeDkrVyGgMIARSP80rNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759103461; x=1759189861; bh=KNYT+qDZvBJYx4AVDB/Uc4MiSyan7R9Ct0T
	oqdRAy74=; b=wFn3Mo8RS8KYeqJSlOzOb/8EGaiOk0Gjg+zBg7ZsY/w6ghPHgNW
	hCt9qR9jUF4fbGGnNzsFq23Z4hes9XU9CvIP3mlX+lqx342LkyoY7fb1mY9JRI9Z
	dyH0QCZ/YxBtXZLZa4Xim7txjBLv4Tk8XQzOBNbAt+fkawA4T9jqluEuMoAfvX4f
	7PdFCWSox1zcgBuvMF6Tn8K1ksI3arJ3c7Hj4F2a15/5sDN3IQvFJrVt6znrCmRM
	G9mRAt3ujYngKb3zOX0Py6bxGqmUkCji//d8+XxhXdUWzFS/z+B9mqnlF6n+F2du
	3glGiDFury3izgOeFz/njP42LzDq79TgiPQ==
X-ME-Sender: <xms:5cnZaJlMDNjFEE-fi-Riyo2J6qfac1nB8rGiK5R7SXvdB5nhhdo2Ag>
    <xme:5cnZaL3TSLhgn5nXX189CZxXWkcy9cLssvysIMM_Yynak0ZtuMdnFDILMkSjWh76W
    4bCd6wEq8wGuru9yppdlimhro-53vBUC-odQTr9qqTFm7oul6cd7XA>
X-ME-Received: <xmr:5cnZaEoDZGvjBOWAo41mCOvHIESb79nfl8HurrmFHdiDFw2_wec1Kg-1jyuEKx7Axm8g9m5XTKs9wC6vm8llso6FDMjMBjIMx3_xatLgWcmVadC74qudgDH9SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejieeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrghoucgh
    rghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepjeevtdekhf
    evteejkeelgeelieehueeuteelfeetvdeiffeivefgkeeiieffveegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorh
    hgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehm
    ihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpd
    hrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5cnZaIfw4aF7CdpxmoNYAnHzSaaD66GtgMAWRW7GcyZ6bENEB68oWQ>
    <xmx:5cnZaDrpAWeQK_PjgLEpyHCE9mvolGHk6RmkruN6Gip3WH8t4rgLKQ>
    <xmx:5cnZaJG3aC86GzudJfDP9JNKLAAH-qOLC9D3ijVpON2llqrUMOgJGQ>
    <xmx:5cnZaDuCGcQInPZNomXRAQ5dqh8TFONeBeni7hWAKP9cKUhWCq69JA>
    <xmx:5cnZaHnItsztZUsbn9LNemzV6tdmjmh4H--HJ_1EQtUK10RFqWf3SCbh>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 19:51:00 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] Documentation/landlock: Make docs in cred.h and domain.h visible.
Date: Mon, 29 Sep 2025 00:49:49 +0100
Message-ID: <6050e764c2679cba01715653e5f1f4f17091d8f8.1759103277.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently even though the structures in these files have documentation,
they are not shown in the "Landlock LSM: kernel documentation" page.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 Documentation/security/landlock.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index e0fc54aff09e..5066f8c3091e 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -110,6 +110,12 @@ Filesystem
 .. kernel-doc:: security/landlock/fs.h
     :identifiers:
 
+Process credential
+------------------
+
+.. kernel-doc:: security/landlock/cred.h
+    :identifiers:
+
 Ruleset and domain
 ------------------
 
@@ -128,6 +134,9 @@ makes the reasoning much easier and helps avoid pitfalls.
 .. kernel-doc:: security/landlock/ruleset.h
     :identifiers:
 
+.. kernel-doc:: security/landlock/domain.h
+    :identifiers:
+
 Additional documentation
 ========================
 

base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
-- 
2.51.0

