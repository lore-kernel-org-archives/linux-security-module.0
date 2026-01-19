Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0221917ED
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768860318; cv=none; b=b8jHwCu3ARvCydpqwLwzLuGqWnBcWt3SbSuCIiAmo7sO/Vudi78di7KEPTCdIamWMU1fQ0yNpueJU8ID4LhrJLXdSXuibZua1NNmAqhH8ONWdh9vzL8pwjsR7yZ36msbclF5JVzRCBccAg2MURaCBGOpXfQDTtk5qcNo/a1e8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768860318; c=relaxed/simple;
	bh=fSS4w8zFfFLmlB2ztTIKivn3N6AJadm/MqUvIOgQwd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXqzbpKDit9OTHDol5JI/xYGpIXNsljKxwBZ5sbBqvaqe1Pg2zEBoVuK6JXntC0f/ROEyDxu0Pp24Iy1yFuB7ypuzugYaXlAA/rfBDfN6x4rRtFiTed9o4iuYLWF6/lD4tt/4nQ4YbAKRGqj9/U34S1dJFBehU8DWa9MDvWZ8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=RKi9t6Mg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TS8KoIGT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="RKi9t6Mg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TS8KoIGT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA7E0140036B;
	Mon, 19 Jan 2026 17:05:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 19 Jan 2026 17:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768860315;
	 x=1768946715; bh=pNEjoQXt6BnR5tETb7oyglwZC2Lm16JGSl8n0gYXzM4=; b=
	RKi9t6MgErddXP4yAnU6+E7kIJyC4Zz/a+8sVM9qBp8c6Pg7vhFuOcIF/bfKn4h4
	Gvp+h2C9Uo5BlBaInXjgowV0lB4wzAacg957j4xYGI3cBMCbgdJdUycrxEa6Xgrw
	vuzpSrOL3JNv0A/PdR0gi/tfkUh4+T8T8KRDVEgCcdOjhhj/430V5Zexb+1qSvgF
	VdqsbSlc+SSv8BPsyWuXvT5vqsjapQU45OLWFqJ7Dra5zl2U3qkczyGOR7pmb74v
	eHhjz2HD3IIy0l2zW8yXOZ6yZQADlcFJoo+0gkAj7vKR1nC+MdXutf3UP3Vt6VZX
	WvSC/iYzrpp6oTabtIGLzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768860315; x=
	1768946715; bh=pNEjoQXt6BnR5tETb7oyglwZC2Lm16JGSl8n0gYXzM4=; b=T
	S8KoIGTrp3dwfH/3ug+7sV+pgOTcNwMFSDoycgP/oCc82+BylFa/sxt1cszy62Sh
	eL0wAWMOWs/yC1oq4pfGsh61wH5/YD7MOzbFZcC/v8nEnGMTBOCBtSDWQBV+1Gti
	bGfT37x8j1jdrWgRV4hAijI5lNHLeLG1+E3J1kPuYDr75k2yYCNNgwsx38jaMRfq
	hRlEDVzUTiBRLJOcTzjq/6ZoIeuY6zaj87tNoCRCFQFsQcNBQl3PWZdS6XCbtqeo
	EY2ujUHOY9jJwrxcRnQGuYjVbdLc5Wq8CbaCE2bcAtFlGkGwz8K6tLLzgw7aU0AW
	mk/9b0Pma/LRKoiZsUQyw==
X-ME-Sender: <xms:m6puaQQZbSxxiyx4a4TMdP3Mh5YGkfYXAE526TiPKe8sRJVGIj2Snw>
    <xme:m6puaVM2byhqXBTn6qYq0tiMkSmCfGx6qK8nLiUx3Yw-Tm09wvdUzoOyBmoG18VvY
    ug0G-ixVMgn9ruzEFDXsb83gcJ2UFfythCWcy_j_fv6FOOUjAoDoGQ>
X-ME-Received: <xmr:m6puabO7KmVDD3_HBEktvPp4EkkAlyaqr_FXF53rG09q1Ad7YEX_0C2pwrYeaG5lGLhrGG3-hlE2HrKA1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekre
    dttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdho
    rhhgqeenucggtffrrghtthgvrhhnpedukeevhfegvedvveeihedvvdeghfeglefgudegfe
    etvdekiefgledtheeggefhgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhm
    rghilhdrtghomhdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpth
    htoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:m6puadtAo6MpGpuuomkuWvtsZTaYzYhKhWq5XTYpFYFhA7jhblS8pA>
    <xmx:m6puadXaDHeaJVOiPoCg9RzYFAdznT-HCKSpWkeUmLPgwPrV_p9fzQ>
    <xmx:m6puadsLArpQ7OAdGBPEIjMLZPXkhxFGuLSrOb4mIctnQ75zAPZW3Q>
    <xmx:m6puaRXYPE_SSLBwGQ66AK6rGUNrOZv_wXyIVJIYow3L3PVqtUT54Q>
    <xmx:m6puaa6wpANVJDnLgP8XD_bgDiKALTDaLb95j_U-h_EJ5g928rjXP0qE>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 17:05:14 -0500 (EST)
Message-ID: <940f474c-5831-45d1-9839-5e7ad7b047fc@maowtm.org>
Date: Mon, 19 Jan 2026 22:05:13 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] Implement LANDLOCK_ADD_RULE_QUIET
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org
References: <cover.1766330134.git.m@maowtm.org>
 <b7a2444d-c3af-428f-904e-ec5a6452e513@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <b7a2444d-c3af-428f-904e-ec5a6452e513@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/19/26 14:26, Justin Suess wrote:
> [...]
> Hey Tingmao,
> 
> Thank you for your work on this patch-- I don’t have any further nits,
> this looks very clean.
> 
> Do you plan to rebase/resend this series on the current mic-next branch
> at some point? It would be helpful to be able to test it alongside some
> of the other Landlock series that are in flight.> 
> Feedback on the latest version of the series has been fairly quiet so far,
> and having it rebased would make cross-testing easier. I’d also rebase the
> LANDLOCK_ADD_RULE_NO_INHERIT series on top for further consideration.

Hi Justin,

Thanks for the reminder :)
I don't have any changes waiting for v8, and all the patches except one
already applies cleanly, and the one that conflicted was due to a fixed
typo, in patch 6, which git can also sort out automatically with git am
--3way:

    $ b4 am '<cover.1766330134.git.m@maowtm.org>'
      (ignore to suggestion to checkout the base commit - this can be
      applied onto mic/next cleanly)
    $ git am --3way ./v7_20251221_m_implement_landlock_add_rule_quiet.mbx

I should probably still resend at some point anyway just to make it easier
for everybody - but given this is lower priority (rightfully) than the
socket stuff, and review is not blocked anyway, I guess I will wait a bit
before spamming :D

Kind regards,
Tingmao
