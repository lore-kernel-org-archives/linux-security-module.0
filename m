Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF6263C7F
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931823; cv=none; b=gzV9E8S8++t8kyUGMEGeWWSWLFHCI1YDVFYc3KOU48DKEh1Ib8oJohJ1aDxRkGi5yOIBiHIaNJFxLHUhS6xp/d9IQbCWGcnMpeayQCNedtjCvcvGLvbxSYbEVWYMbkvT6wHBCiao3U2XIrGAgy0yRFTiydxGOcCNJL//nfZNiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931823; c=relaxed/simple;
	bh=2sRnE0Yx1kV/jGNdXvown+KMSGLXkBtsZLIwc0Afgls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6r3dKSgXHhiXdFHL7/Fy9eSiyn4L2sAUAJBrbdENbmQoqOKTj3WianVv5h/SD0unQK9XvrX7drYcr2LvrS4o0826/rD7vSyiZLqum9nedPTGxb63yK/WDc+MVQlSC+fnXDcDP1ba6Kmr/u3gRDxERgrpBaBysQimyNKScW+lZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=M/W4bXVM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUJ23cuK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="M/W4bXVM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUJ23cuK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 48589EC01D7;
	Sun, 23 Nov 2025 16:03:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 23 Nov 2025 16:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763931820;
	 x=1764018220; bh=E1J8PSDgaDW8abY7d0QysZ2GSsoLvYZfYInCo9UGmYE=; b=
	M/W4bXVMsslMvD52914NUvQl6RxYamtdK20UHLHbgf9i/z8y2T+LN599iJ9B1teA
	aTQKJRHwfrCa7QkG5FFgAKPfq8Ab4jIlWb8sGAQYEMtacMyIXZpAugNyjxYMuFfE
	lpzVMH3kOp6AP/9/M8pLfjd8H+OCTqcRHSsZO9xyT3K9BLTLOhQLeHs6Yqxbaz+F
	k7UM+65UYjT1GEAGE5QeGRht72eQaTWl/ZiatmjVaRax3ITwRxAE6coyeoQvWJE7
	1kA2CP1zcSOVPlGsQxZYekIFKCM3RKXBa0bKJ5MF0E7ojOkNSGzrsqNydDNVUk9G
	IoXh/9In3aHZmfDeOPXN3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763931820; x=
	1764018220; bh=E1J8PSDgaDW8abY7d0QysZ2GSsoLvYZfYInCo9UGmYE=; b=M
	UJ23cuKEZQ2byrkbIoIfsNDRDaO7u6GLcQQO4ggLfaU5WwVHJMNxfLKAw1Jmj7O6
	CqZ0lmd3ZiMlltIL04Yf7YxRpAs/117c/ZD6iRIqf3NLouYIst6CNEqLUcrZPbb5
	ssOO+osirDADH+hK14pErrwJPuK4RvJsBQMd7UhlLYS/jf3jFSVHtNOJh3Nea7MI
	OafNRojofei+ZcpGE8RhouKmgyediqii6Qq/QUngbGeSx/1A9oTJjdlMNkcd4Tkl
	XObGnrQqwnDjjNcGYV+h1MBFsjtcQotCM+P2YJl3qpbn8HLDdoUgpAPGSQfbaTHN
	4vPZjtnQhwCVH36e70lRw==
X-ME-Sender: <xms:rHYjaVCPES55wjDjxEiitYnZa5wgbcy5ek0CXj3VQt5zonsn567afQ>
    <xme:rHYjaXMmbdkEY3uKvG9_9Kg3OxU22qlmhbs1E7woXk90FeGF1Hg1dsvGhSPKYgMeR
    Fec0wArBXuix_YXDcwcnRTysbSCodaZUshpOzGpm0JGz7bICV5Vg2E>
X-ME-Received: <xmr:rHYjaaYLzBgczs1Od3AoeirKuYq36V1JeyYC5JUf_CQG750y-it_mbDEzGqQJANDYu6yqkk5l9ORDrk9mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejre
    dttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdho
    rhhgqeenucggtffrrghtthgvrhhnpeefvdehleeutdfhlefgvedvgfeklefgleekgedtvd
    ehvdfgtdefieelhfdutefgudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqshgvtghu
    rhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepgigrnhgufhhurhihsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:rHYjaWuJTXZkGaeiUfzgkdyF7lwjePD2gmxvpKyniEoUnKYGuPRHcA>
    <xmx:rHYjacNzk-ceWIMQLfJ4TtMOXNDQzC_Q-BUCekVTvuf3ayKmhsRpRQ>
    <xmx:rHYjad6avXTVkQ5TmHJUMn6ZRRzueDm1O0dIktRkvwQdnNj5bThzkw>
    <xmx:rHYjaSTbjmT40svkAVqhzX4LCU-8iQKlAGLE7gIn3ocvkjkFsH-CPQ>
    <xmx:rHYjafuLtzmOgX63HJOXs1YmeHPqPN7q1tsHTYExEDqdLXN6MkSrFRp3>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:03:39 -0500 (EST)
Message-ID: <1ff8930b-825f-4eef-ba99-e8f4e5c9d998@maowtm.org>
Date: Sun, 23 Nov 2025 21:03:38 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Implement LANDLOCK_ADD_RULE_QUIET
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack@google.com, jack@suse.cz, linux-security-module@vger.kernel.org,
 mic@digikod.net, xandfury@gmail.com
References: <5c0de8ee7e00aff1aceb3a80f5af162eeaaa06db.1763330228.git.m@maowtm.org>
 <20251123170103.2640561-1-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251123170103.2640561-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/25 17:01, Justin Suess wrote:
> I had a question in regards to the quiet flag in how it
> should interact with my proposed flag LANDLOCK_ADD_RULE_NO_INHERIT.
>
> Should this flag block inheritence of the LANDLOCK_ADD_RULE_QUIET flag?
> It seems to me it should block inheritence of this flag, so you can
> create more fine grained audit-suppression rules.

I think it probably should, given that inheriting the quiet flag is also a
form of "inheritance", right?

Also, if no_inherit inhibits all form of inheritance, then there is
opportunity for an optimization in which we stop the pathwalk altogether
if all layers has stopped inheritance (after verifying path_connected).

>
> So for example you could quiet logs on /a/b with the exception of /a/b/c
> by setting LANDLOCK_ADD_RULE_NO_INHERIT on /a/b/c.
>
> If so, as we add more flags, should this be a general policy that
> LANDLOCK_ADD_RULE_NO_INHERIT blocks access right inheritence AND flag
> inheritence? With the obvious exception of LANDLOCK_ADD_RULE_NO_INHERIT
> itself.

In fact, I don't see why LANDLOCK_ADD_RULE_NO_INHERIT itself would be an
"exception".  It doesn't matter whether this flag inherits down, since it
is set on the rule that stops inheritance itself.

Kind regards,
Tingmao
