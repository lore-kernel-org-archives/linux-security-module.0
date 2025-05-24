Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBA33997
	for <linux-security-module@vger.kernel.org>; Sat, 24 May 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748110455; cv=none; b=fNLzuKp8u7qDgdFJODF5iQovTmip6Z42VyGbyXZc/vc6ScwL9SlW368UBlU65yx12N0e/V3KtGkjt4sCC9fdospq2eHh99/JvyrbbnJ8CmSlcUq8UDSVWwQPjN/JVqCwEln6anft0+anuUZvD6GOoyWybNN7pJ/lDMc0zllQ2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748110455; c=relaxed/simple;
	bh=XG3KjYV+MGafoEw8/p4uro4V9yp57B/1r5e9aQjV9Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tlz0L8lFUafWOj8lPsRisBfL/wCFkPeRDMRm/TNVeuWvid2QAOHqcrDZaraG/gPWKTDPfu65pBAIDybInV3JCY909GY4cXmgXrMp8Y94z7SQ8FY0m2CBtxzjJ8pIf2XtJB4B+JW+osHEYR/uQPtW1dOH5xcw+c6sjpc8F7fBvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=FAUDBebs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wx1xyANp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="FAUDBebs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wx1xyANp"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68F3C25400C3;
	Sat, 24 May 2025 14:14:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 24 May 2025 14:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748110452;
	 x=1748196852; bh=GThjlVVQ7Sw/HkC2Z7+uLTRfCUREz2tAG19ohgHACsA=; b=
	FAUDBebsoGl4/zzH8b15pIAr/dv6RoTU/KNK2YptRVm49MEALS9mMx1jHtme0p1d
	1uMY/Z+O+9kBAgAW2s3SfRk7BbnOO0SR5xrX6K7gPK2Udb6w5wVtU5XO/EUQbVKs
	RFoApp1zKuf2oYV/8xjmkOwZzSL5Ye5dZI7u4inhkI1yKIlhx0wpOl7XxZLuOQjE
	24viuuy15KaAan2AK2XbSlQcBcWd8mnk75fUCTsSpqQIZQ4ahfWLLB2qo+nETC43
	oojIoG7EAAhjTLvXOsZ/8YiI4B9huo0Mt8i4pxkI4retw/e/nLB8X4pmo40PaZeF
	ps+j8COXVLVdjAphxkfWAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748110452; x=
	1748196852; bh=GThjlVVQ7Sw/HkC2Z7+uLTRfCUREz2tAG19ohgHACsA=; b=w
	x1xyANpw/UBpwmreRNi198AzN6XhqUkaHK/i6QHc8LXQu+IVfUUxckbrW6Hxul4g
	6LTV5X7TcSvfIrerzh5QsobTEL4NE29Qzv+TbyIIakhhOOXJjht7GdBFOfeJn9Wo
	WJ39OtsXcPpVp5CVrZinuQdrru1gJhWA0cnHYmVuElytBMuyUcBZZEZPySYwUtAJ
	OTdOr15og02Q2j7WlZ3Z69keF3+f91Rg+XRaULcU1SVH19LclSB/cqVwpNYEbNfd
	2Hi31Q3F4zD9zD+Eh3Bccg3Ach9Zdg2pCRUr0My/LMX2Frjru5/eWe3XVOaUAHuq
	GR71Uljs0lvV9Tb3kesQA==
X-ME-Sender: <xms:dAwyaJJ1i7QzEMqmC9m0gluka0wdrZZYP28j8yfCuFLUDnAdvgA_3g>
    <xme:dAwyaFJXkHFmIIH_ny26VgN2cizlSWPtOljrVK9LBQF5Jk09Yq8BdbRSJyZF6M8hs
    rUQkhkpPiQZ7qNQDZU>
X-ME-Received: <xmr:dAwyaBsy4Zvqeumx8wT3jhzrQMVkyW96OpTS5UhglpkH2JXaoIVPMmO_LIy5Csz3vG2NpXa-Zo-doss5jpxUqFNT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduvdegvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfev
    fhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomh
    esmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedtteetjedtfefhfffhgfel
    geegtddvkefgvdetudduudduieejheetheevfeffhfenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohep
    ghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuh
    hrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dAwyaKYDrpHbVY3QuWETNbB-vbAwiaXE1_EpX0qvnrp0h0Brgz_8wA>
    <xmx:dAwyaAZ2quuwo7ct9d7C7QEGj8hLzS5PeTynFUGnCP9FkmTR6btebg>
    <xmx:dAwyaOBADACbHdapcs_iQkzeJi06ysHORsEPkZlW2v97-7H3sWrgPw>
    <xmx:dAwyaOZwnoi0nQA8GerPxNTeApx_e2Qs2wi3-nRbNZgpwve3zQ69ew>
    <xmx:dAwyaEpYPRCYDdU9VEwFNXRducpUYcphN-RenUSC8iCHSwIDPWY6AaZq>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 May 2025 14:14:11 -0400 (EDT)
Message-ID: <93398ba9-11b8-4bdc-b5dd-e2d271a237a8@maowtm.org>
Date: Sat, 24 May 2025 19:14:08 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests/landlock: Print a warning about directory
 permissions
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org
References: <cover.1748108582.git.m@maowtm.org>
 <9f5a3c41c1752e8770998f1e5b3e912b139fc13a.1748108582.git.m@maowtm.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <9f5a3c41c1752e8770998f1e5b3e912b139fc13a.1748108582.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/25 18:56, Tingmao Wang wrote:
> [...]
> +		TH_LOG("Hint: fs_tests requires permissions for uid %u on test directory %s and files under it (even when running as root).",
> [...]
> +		if (strcmp(path, TMP_DIR) == 0) {
> +			maybe_warn_about_permission_on_cwd(_metadata, err);
> +		}
I immediately realized that I forgot to run checkpatch.pl after sending 
the patch - fixed in my own branch [1] and the next version will have 
the fix for these style problems.

[1]: https://github.com/micromaomao/linux-dev/pull/7
