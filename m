Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C676340A6C
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488483; cv=none; b=BLJXFxRSDXMklQgCvV915ayrvfhtGb/57BOzleprVhTZk02eQSWGBvAPZza+HaTriCVYZRe3yuY49X4MoKzlGAIYOs+OfwXnR3e7q3yNVFxQABdG6FlPe97OEHNefzljI6qPZbkAn4wkEQLkkjSqSAzcqPgL+RLQVGyzacG4pL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488483; c=relaxed/simple;
	bh=7HV2EwXCsSb46EbBKFd4DNWtpr/PNMyQtH6uXqI7cno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqnDf8GenPZSaERpkv9KuYAy8upNkaWdwA8Ct/1R+FbQ84v6zGo53cTu/lfyv7WssKUOHE/ZaA+xA/t7b7WNQ8hUwBKgLYQxxGNcVJxCorwZk8x3RbiTsNFE0MorLCnuIeQH1C6aSIdMjn2N4Xk82/9XQsEhzaqeTKWwW4AqO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=JFfoPTle; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u9jUw8Bm; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="JFfoPTle";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9jUw8Bm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BE197A01E4;
	Mon,  6 Apr 2026 11:14:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 06 Apr 2026 11:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775488480;
	 x=1775574880; bh=TqtoqQ+ODsPyscUoF3xJCdq9g/w5EPSRw6LsW2jdTfA=; b=
	JFfoPTleT54vcLGY0/Rfulw8lSUSUacKjThL81WevofGTs6Kqa2VbQE3jV6hL8Y3
	N4a2qd/1uiStYjBzk6owKV3PY/YaC2V7RwRq91uAEALoTkSKQoOcvibYYQfRxZds
	gytQQd5cPein4fcUhs3sOvEA3k3IfWoY5fRminEmjWq7qZvFCzO6lGKQ+N0fbbiS
	2w9PLtVAWPG1a96oI94Lfd5LyplB7SJPr2EPsqRUilw8vTc+brM8GGyVre9zUVwp
	0dOO9zE7tec8v2f1wTvnGbusEojw04dcDUANFXmvIJuAB87j6wvo30ew5g3BhX+m
	XECnGGRPLq7XlW7uaexmDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775488480; x=
	1775574880; bh=TqtoqQ+ODsPyscUoF3xJCdq9g/w5EPSRw6LsW2jdTfA=; b=u
	9jUw8BmcsVuDqTV+Z4wh/yNO8+VYxcXJw6bKDFDRCCP4eVNaBFwsC4wolWgMIWGW
	KA0iUSvIPu2N0m2expjmbjn6yuXEgbQJCRQzXNQGUce9lOBNF/oJbP1HHFppPJD1
	Joj9GrZKHhVNBJeoGqrfHmxjjFEgfxxWELASNhw6naI8AGJaa93k2wzu3KvpRyO2
	q6w9GANuhnGaHF2D/jJ4FPpeGMvdi+0Mj4Dghx1ZExaP0kH0v6I6Cd08IngNM6CF
	k4DwIcw83vV0YIG3JmeHI7HDNlrqecxA/tb5obfWNhDQbtJJpqn9ZZvTldsEVluo
	/lQ+/9DvL3nXwQrYWXp3w==
X-ME-Sender: <xms:3s3TabaRKaqCOaUK8q0zU1ndGFjMqdmab8O8tQrKnEJARMyV590HqQ>
    <xme:3s3Tac9uGCcpR_VMixWS7iBVi6RJN_U_lnh5Twut38yidNSoNGqkEViDd8lHVlqiP
    w1hXfxgAtrCEfQkdda-XulNdy-9S_naIJEc99__8XC189v0Io5pfXc>
X-ME-Received: <xmr:3s3TaRn95sjGrvsPp9kp8gXAKVWbvh6zs2XRcrht9kitJmkjUiYk9blKtEiWXvuorj6GN-mUGieZMjSrew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhnohgrtghkfedttddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhitgesug
    highhikhhougdrnhgvthdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhho
    ughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhtihhlihhthi
    gvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmrghsthhhrdhnohhr
    figrhidrrghnrghnuggrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehmrghtthhhih
    gvuhessghufhhfvghtrdhrvgdprhgtphhtthhopehivhgrnhhovhdrmhhikhhhrghilhdu
    sehhuhgrfigvihdqphgrrhhtnhgvrhhsrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnh
    htihhnrdhmvghskhhhihguiigvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehrughu
    nhhlrghpsehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:3s3TaRzvViClxSe1Rr8djyvrNsdH_b3rRl10HIRINpooVHyRoXc8NA>
    <xmx:3s3Tab4mJxd9RRgzFbG1QIU__ATWhR5mCxq3TQVYcjqptK9fGxiD0A>
    <xmx:3s3TaRXpQ5X8MRjLffV-JHX7QAYIYluiIBqOSDLmAPKyuVWj50cKKw>
    <xmx:3s3TaTIYtm-G2puzoiDSXP2RHa_TookT0O37VC3RrLOu3aCJeqh33Q>
    <xmx:4M3TaVcPxuhNJXvMC5WbVsIJXvDz933IsoQgjUlQ2ZIW35CCKcwTXcN9>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:14:37 -0400 (EDT)
Message-ID: <6cf45109-3e74-4917-92bd-127eca5a1176@maowtm.org>
Date: Mon, 6 Apr 2026 16:14:35 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] landlock: transpose the layer masks data structure
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org,
 Justin Suess <utilityemal77@gmail.com>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
References: <20260206151154.97915-2-gnoack3000@gmail.com>
 <20260206151154.97915-5-gnoack3000@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260206151154.97915-5-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/6/26 15:11, Günther Noack wrote:
> [...]
> @@ -406,12 +375,12 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  	if (missing) {
>  		/* Gets the nearest domain that denies the request. */
>  		if (request->layer_masks) {
> -			youngest_layer = get_denied_layer(
> -				subject->domain, &missing, request->layer_masks,
> -				request->layer_masks_size);
> +			youngest_layer = get_denied_layer(subject->domain,
> +							  &missing,
> +							  request->layer_masks);
>  		} else {
>  			youngest_layer = get_layer_from_deny_masks(
> -				&missing, request->all_existing_optional_access,
> +				&missing, _LANDLOCK_ACCESS_FS_OPTIONAL,

Apologies for the post-merge review, but is this intentional?
request->all_existing_optional_access is only ever set to
_LANDLOCK_ACCESS_FS_OPTIONAL tho so this is not a bug, but I guess the
original code was intended to be generic.
