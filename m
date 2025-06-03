Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C4227EB9
	for <linux-security-module@vger.kernel.org>; Tue,  3 Jun 2025 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987830; cv=none; b=FlJg2zoNp+m5SLn6yGLT93bDRuKmxNoMon93pCXL/IJTLrxuuBFFwiCL5ZJRKw9deghZUFKX8W+gUcwzvk+c9qlLIPDjJlncfz5vcsYqVifA2gQ1X2lSbne+ffXYJgcgBcgl2q21wO8ae7DWpufWyO8SkXwyhpdTMW3XevjfS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987830; c=relaxed/simple;
	bh=3JDVED8SuKP3nYd4lkEnTIV4GbpTqW79E/ctuwY3sTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbYZIuyNewUNZPfqV3T+G6WrCNIDpB2H9pShtVv3C8caTm7pj/wGNHew47GoV33E++Bmqbeu0GRX2YJXiA1JBawhOnAr7qjf3tuPmCC3beRHK3EDZjT8cwbxAcmr/5YIeiSR5Ix1bDFyZiUoA5HOfUoGSuiF20Zhz+VukS161fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=WwTJYMNe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOdlw3Sh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="WwTJYMNe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOdlw3Sh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 67DF41140111;
	Tue,  3 Jun 2025 17:57:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Jun 2025 17:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1748987825; x=
	1749074225; bh=Ir1Pqyh9wOPRzv2hwQOjIUZ5PBAMv0r3sRtOD6ol5X8=; b=W
	wTJYMNeeuQbzrt7CLwRnC3GiMdRqdB9veUSMGQoF0dBKhsBhJLcujpH4lHGkehwH
	h/VVEfIEbEp6Gh/t+rasq38+TKZt4LKc+3J+jJl6uhw75SC8X522ZdojrKIDYCx2
	UocmCSg4nb3Gcak8VProkhZkwGUx20M852/AJrKMs0Gg+GkyloqILsTVQjrZ1q3M
	2oWOng+7uRqApvsUsJ5rq6nGadv1Byscqtp4pt+58umLlz/6Mj+Vh857uU5eu1BK
	McJsIeSWnerxuknUEaAbKwHvztEM1BE2uL7XRC78eFBNWoBKL7Fu2PB0PaBuYxxz
	EdoaCbLyjTOJ2Nlm7i63g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748987825; x=1749074225; bh=I
	r1Pqyh9wOPRzv2hwQOjIUZ5PBAMv0r3sRtOD6ol5X8=; b=SOdlw3ShfCLihmMn6
	Fn0wtF/3gp8hUqnYOW0eYZ5hbZTxAXhBpXyrm/uSk2e7vLBPhIjMfrXOqwiN0HSQ
	rBD0SdGwaSUVqtA6D72uEtwOXMbnt4svTYuTnUxNogfffu75qLTSdvXYMk7gnwPR
	jiA2JJ/MssIEjBMBhR0wAAOVjlTQo66EGD/XvALHOQ32eQcbuE7FjPFVOEJeHtUQ
	QRl5XMBCQd5whSxcx1ipXq9So0DOHxEOMpNX4PPF7DfE7KeLeg2MUBHqZ4NoSJK0
	FMyS/H2SV1fkDmqOjzN+AroWTj9QJsUjsdMi6BIRsVMNAoQvCCuWg/wn20qa12zK
	hrhWw==
X-ME-Sender: <xms:sG8_aDDEVEZmK3n8oYCh_gqzvYITHSADQvoQ39_hE_XSBoIBVOQaag>
    <xme:sG8_aJjEkN4McnNxFN81con1MMWdL14JYFXb1Z-uGSVofuUrNnfaTRgDVQn4ts9lZ
    lNRO_7aHi2I2PkXlvk>
X-ME-Received: <xmr:sG8_aOmcxNcxwSnYEezzDtZcq7lptuIPWx-AwU2UiNVAgKzvwY9NjgDlKe-KFZsBlXxnMFWLeA3gR8kAj-nbvMYSB3bCkFue1_08X-zHW-jjT1ltwO4aNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueeljeef
    ueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtth
    hopehmsehmrghofihtmhdrohhrghdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sG8_aFyRX31pq15DGXQ0i-sh_fuRJLR03ZNlMeEwcLiqzBP0b50MmA>
    <xmx:sG8_aIRQXUPlh_MSVyBpUpIIomLPR1JKaJkifIg4wyxGPzHocMdpvA>
    <xmx:sG8_aIZ8qLc5EghkAnbkjp1jO3BftRVXhugrW9YugQI8cuzSnnUTSg>
    <xmx:sG8_aJT6wgTMTb96qsmerjdSIDLb3PM-o2HGJVmSua17N9pgqR0bqg>
    <xmx:sW8_aAxxc_hvU5DsWMVKZfOff7-M-zhoXVDNlfe1kB1wCRBy3VDdlBPn>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 17:57:04 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock/ruleset: Minor comments improvements
Date: Tue,  3 Jun 2025 22:56:35 +0100
Message-ID: <20250603215636.111939-1-m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20297185fd71ffbb5ce4fec14b38e5444c719c96.1748379182.git.m@maowtm.org>
References: <20297185fd71ffbb5ce4fec14b38e5444c719c96.1748379182.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in chat, here is another one for you to consider and squash :)

Current comment here is IMO a bit confusing - it says "Only allow ...
internal filesystems" but that's not the case.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/fs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 9396d2d9df40..11b469002c03 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -911,9 +911,10 @@ static bool is_access_to_paths_allowed(
 		}
 		if (unlikely(IS_ROOT(walker_path.dentry))) {
 			/*
-			 * Stops at disconnected root directories.  Only allows
-			 * access to internal filesystems (e.g. nsfs, which is
-			 * reachable through /proc/<pid>/ns/<namespace>).
+			 * Stops at disconnected root directories.  Allows access to
+			 * internal filesystems (e.g. nsfs, which is reachable through
+			 * /proc/<pid>/ns/<namespace>), in addition to what's already
+			 * allowed.
 			 */
 			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
 				allowed_parent1 = true;
--
2.49.0
