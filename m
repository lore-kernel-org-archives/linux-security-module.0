Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185A4A3E
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815096; cv=none; b=jyeRrR5ZllwdT2EF1s3qYmPcvs8q9y6Mcg48sMtYR7O6lVMqaQ8Ko/3tTNq9NBOvUvrbZOix70SOhsNYcifn3D6eRaoZRwmSn0wSRO1P5c2z+ZICQaFfKo4Zihi1p5exO6T5IeOVhH/GiiiqgxQM4eWG12tm8/78urh13YvEDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815096; c=relaxed/simple;
	bh=+i4r6885hmFMYnHDz3CfYr0sXfT6wfMaSTyUbRPZDS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxAsXQqn5HLdxpcxBMcOeidAWQz0JNkbuwxsrMg2WFSuZM2mBIFIUglWDDWCipXwa3Wu3TZUIqnBsJnQ7KyJJ1GCCMl+PyJGQknEGNDV/ImeYI6BoHi7r397F3kkg+Kz8goMgSNNf/HG09NB6zsTNRawtqcsLHQERU79xlNzCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=OlZAjiBN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvoAHD53; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="OlZAjiBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvoAHD53"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D08D67A0156;
	Sun,  6 Jul 2025 11:18:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 06 Jul 2025 11:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751815093;
	 x=1751901493; bh=31oTXQ+9l4/s0CC145ryqLumARM75r5wRkeREFLDuG0=; b=
	OlZAjiBNmv+DMNtUwp9Xchm549PHsoyX+J6zivT0BC/yyu0IVRoLZdRLzX4e/qrN
	Vj27oBT0MDAaaQVmIZq7Mhb8/H66GG7QbXBggufqGrvb/Ix4ikukkzLNbyDKo1bf
	AGGsOfjBm2MyfyK75j3syCtRW6PtdlRr4T4Y5LpsVybdC4/eBzqdxKFlTv6VozQ4
	N+zpB451RzpfCnbunkuodJMdg3BdJZ3nZlMvSAnPdc/or1hYDZJqB2gyEsopkwQn
	h4CmDWx0Anc3IzIdi98MvUxj7njabl/ZDm3rykQqpGTmczDcAe34DOZkPGw7eFYt
	PpLzlPghusQ7mb9fXrIPJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751815093; x=
	1751901493; bh=31oTXQ+9l4/s0CC145ryqLumARM75r5wRkeREFLDuG0=; b=H
	voAHD53Fg5iyPKfVX4L7iqKXRZlUfGGH0xaKMeX3w8c5K+273cl0phld9Dqz0pQj
	3ibN78OmSi55eZGdCDvB0cYz1SspfJiytxG2hQwlDyWjMfBD+wkIWYQa2LHxpZ1p
	tp6JG3Ii9cL1+4+WfiKS/0Wg56BRtZT9u5vTtNHtjUH/3xv3zwMFcG/aa73L3oA9
	jGzeh/khAfPp+EVKQmKDlhDOlO1TeIugBUnkyA89p+cEFCCnVQA0cm5ylmi4h1Zd
	saED5HGKz8VQtVm9ENby5vBw0OvsYeP2sOyNotbNeUFrDMgU6Q1EN0DsZciuT4sd
	BncQpUVJuJprqOwf9vU6A==
X-ME-Sender: <xms:tZNqaNy9HOFFxt_YS7-t31wtP4bll9WfhMGuLR0IcXFEmjqHbEahXg>
    <xme:tZNqaNSalsKu60r3ClUycKWkJMmkJOVhJrTAi7a3yhiIljXye6VYo1fa6LHxbtsYC
    -jGmG_op22NyUPQ4rk>
X-ME-Received: <xmr:tZNqaHW8CrRKduKUHKkmMakcEo1dRlZyLrR5aMVkNYjv-uHyKIHObdy_Ie40PJLFxFtok9hSoG1EROw9pDAcieSdnUwxpBezEjnovchhHbAhdgDIgv3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeejff
    ekjedugfetffeuiefhvedtvdefheeghefffffhkeevjefgkeeifffhheffudenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvg
    htpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehm
    sehmrghofihtmhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhvrghnohhv
    rdhmihhkhhgrihhludeshhhurgifvghiqdhprghrthhnvghrshdrtghomhdprhgtphhtth
    hopehjrghnnhhhsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:tZNqaPjHosTqtOFZy16WNnBaVI6v6xbOMm95v3n4zhFSXWulY-ngLQ>
    <xmx:tZNqaPC42503wIaZwvJgNxHzInBkQeIBaQYk-2vlBbeuanr5aRYzsQ>
    <xmx:tZNqaIL627wmFKYChMxBK9K-9UXONqJJG4j_ZHndaVd-oimiJFZsIA>
    <xmx:tZNqaOAGMCu-sxi5OLt1DgaLpq2ikpCaxcDbk8fJLgrjYtUhSa3O8w>
    <xmx:tZNqaDJ0USzaN6_M7hx6ofmzRSFyiCWTz3pPM0hxYZXBdBfxXE-RSAGQ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:18:12 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 01/12] landlock: Set the max rules limit in a domain to U16_MAX.
Date: Sun,  6 Jul 2025 16:16:42 +0100
Message-ID: <63d2cbb6ece1fe6820371b9156f3121108d2aba7.1751814658.git.m@maowtm.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751814658.git.m@maowtm.org>
References: <cover.1751814658.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 2 Jun 2025 at 21:50:05 +0200, Mickaël Salaün wrote [1]:
> Correct.  We can either use u64 or reduce the maximum number of rules.
> I think LANDLOCK_MAX_NUM_RULES set to U16_MAX would be much more than
> the worse practical case.  Even if one buggy policy tries to add one
> rule per network port, that will be OK.  We could even reasonably test
> this limit.  We'll need to backport this change but I'm OK with that.

The way this series will be implemented, we don't actually _need_ to
decrease this limit, as we can store a u64 instead of u32 as the layer
index and this will not change the size of landlock_domain_index on 64-bit
systems.  But given agreement with Mickaël, I will reduce it anyway here.

Note that a limit of 2^24 still leaves us with more than enough room even
for u32 indices, but for future-proofing, setting this to U16_MAX here.

Link: https://lore.kernel.org/all/20250602.uBai6ge5maiw@digikod.net/ [1]

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 security/landlock/limits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 65b5ff051674..8e7a8816cce2 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -17,7 +17,7 @@
 /* clang-format off */
 
 #define LANDLOCK_MAX_NUM_LAYERS		16
-#define LANDLOCK_MAX_NUM_RULES		U32_MAX
+#define LANDLOCK_MAX_NUM_RULES		U16_MAX
 
 #define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
-- 
2.49.0

