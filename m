Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22E1F0E32
	for <linux-security-module@vger.kernel.org>; Sun, 19 Oct 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760895601; cv=none; b=DQVx1IE9jyBesPrOPeX7xe1uzWA8ENzq8dZlG7wuV3mV6KbdXqo/u8tNZAm1Z43WDJu789Z5pqivgFA6eS/zvlg52muWf6XtQTjZYakn8az8KFXgLvHwFhu1i41ui+mbm+cjWGywDt6PLLjH8NOQ365Ofr0mdwQItgdph1SzYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760895601; c=relaxed/simple;
	bh=a+eJmfsl0ycB0+YrHyAE2lBqM+OHy+WEwNmg4BtL030=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccHITfEFY9GvQU2bPlOq9SLlG4rpwGS5QjrUKchkYq0fFCdG+Zkt36kzuo2lQYtCb9Yv044ox2HAramnyE7f8C57t5+MrxAur2NFmz8jcJsalTQQa4zp4MFeWmc/x9JPxYO44zm4TjBTYsne1ZScCgJlAPJYN0IxYIeQUhBNIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=SXezitbL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j8y9yL6n; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="SXezitbL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j8y9yL6n"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BE2B14000D4;
	Sun, 19 Oct 2025 13:39:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 19 Oct 2025 13:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760895597;
	 x=1760981997; bh=a+eJmfsl0ycB0+YrHyAE2lBqM+OHy+WEwNmg4BtL030=; b=
	SXezitbL2EH3Z0eqkm5nQ7TAe6NZnH68d2Ha8pSxTob6VGeFUeKU57/8BazsUciR
	NpQ2zB0CR8NBp5WdbBQ13E4Xkaw6Fi8Cu6let/hMsXQTD3XOibQXryI7b690jzpr
	mSoAVWwkWtzz7fzxt3DyrOiM2ETeyz/5L9Nt5/APApkq+n+ZzIFxnWG5EQ+W9cAR
	1KMVXCjG0zF9GaQ8EhUTk/0Uuk1VeZiRpkXjkDioPO2aZbszVO6rmIjyY/BBVwhs
	VcDc9loILQ9hWmILM5Xut7uUuIEz+6xg/or+uyjnBFACvCekOb7+Q0OS3pf1tS2r
	zquWXDZtVKREtiI8zneL5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760895597; x=
	1760981997; bh=a+eJmfsl0ycB0+YrHyAE2lBqM+OHy+WEwNmg4BtL030=; b=j
	8y9yL6nxVJatYBx+ohkHyBEwTKkBYhfZ529fifsgp8OLAzHe9trNkHug5DkdJqtV
	t+iwyQJa1L6WKVE7VEp2t91DRzbgFriaoaqggoKrR330leuu2ZiiEDsPqBD5TX+G
	NSOwpVaTU9M46RQFmW9HrE7hZw3bQq6RAbG3PUD4IarrkjAigwVi4HAu8aTTrm0A
	t+iV1UajOgTTYGQMaIAiNNk13cc3Z2dRWQwjIpu+y1Dvg5dTfFozUy14TkfLejX2
	oI7zPZA/L2C4HbNPcWZ7nSqj/x7uDw1esuhZhAyCsJuOMMz+b/56O6IE2acVFyTF
	/OoDnZXRwJV4inlDuYTsQ==
X-ME-Sender: <xms:bCL1aDsGRLpERipZTdCDTxmY1IiJOfYJIbOEVulE-lJiWzduxU5Bbw>
    <xme:bCL1aLdpIriLGn745NYPAnBAUbVBwlqR6nYFlKuK2PMAjTUSAdn1GfhElnXgl1T50
    ygLfoe7CH7fw1yzFWWfcruPP9Mz6rC4yqXqTAWaXnoMWJYkjmCjtN7r>
X-ME-Received: <xmr:bCL1aLx6P-ZAuyptWyd1KfWTXKKMXOdp1RaZToz19PHZ3zQqp0SCPfLPmTCeivOPedQhyFOUH5DlFqLQSLkCvIDr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthho
    pehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:bCL1aBE4vBdzadGxoaeTfE6J_l_r4GZegjm9kN3xhnsRXkZNGjTnZA>
    <xmx:bCL1aPxacFCT0wxA2nnyMCRg0RzWFewMg2m2gZCwU5iz0zcNCabU-w>
    <xmx:bCL1aCtze-gt8Wqr_1OSJDYuz732-tpsyLSORPVgfUh8_aanR5w1ig>
    <xmx:bCL1aM2-l-OS4oEqiQ-oFNmQcMb-99OIZnXxNxcW1lqv180T62ViVQ>
    <xmx:bSL1aEsWHtYf0Xb4TaXbOdNNH0F595NaMJYF7y4DIMUq5cZXjoct_Wzz>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 13:39:56 -0400 (EDT)
Message-ID: <b44db371-59b5-4e52-bdb2-f6359580a0df@maowtm.org>
Date: Sun, 19 Oct 2025 18:39:55 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] landlock/audit: Check for quiet flag in
 landlock_log_denial
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
References: <cover.1759686613.git.m@maowtm.org>
 <730434d416100f6a72b12fb31eb7253bc8b6fcc0.1759686613.git.m@maowtm.org>
 <20251015.Iengoh1eeT0c@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251015.Iengoh1eeT0c@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 20:09, Mickaël Salaün wrote:
> Just use "landlock: " as subject prefix.

What about samples/landlock or selftests/landlock (in the next version)?
Should they also just be landlock: ?
