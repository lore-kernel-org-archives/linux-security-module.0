Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512FE2222AC;
	Sun,  9 Aug 2026 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291288; cv=none; b=hFk6wxBcxchyBztt2JZBL6X5IDsNc745cLF/f5KOXrepFrT72iN9rKzQghyuFxaw1XS0gbwHOEO+Kwn387y4+3SgT+GLn1Cclqw4U8dtxhIzf61+HUou0pXKri+mxsBm8BR67tO2A/i9mUaMc6KSDvn4wq2dg5Yho0E3GVdOpcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291288; c=relaxed/simple;
	bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DC1cYzh7pq0k8/ew0/KZ16tLXLRAEwihKBXyDHBFJnIePSSV8v7LA74W6Ak4dGFrIrzvT7SYdx4Zc7psHqb1AsYK8N7FEv9nytWPpkuGHJgpQBStxq4qacsLrDND1Lgig49iyvyUa0wZkj2HZZ3AyoH1Q6uxHvt/zdBIIVIblHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=KvV61qqf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cb/2sonN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="KvV61qqf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cb/2sonN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 720F1140001A;
	Sun,  9 Aug 2026 12:01:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 09 Aug 2026 12:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786291286;
	 x=1786377686; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=
	KvV61qqfD8Ff8ZAx7O9WP97H7S0Bn9sCmd7Dg+40W/+L9ewl1TkHJya/UDZFlmCJ
	UKIbAteoMkAJnyPrz7oaEX4az8awP9GRKvYd23jFH7/iGaH7ar/KQayIZkDKrikh
	nuMRvIhDcMalg8NA6RmMftd6cKOI2hyj2YHvvLIX1gTLzm6VGs4ySMyGMEtyHXRL
	gXLhEGyfyvXAIhnbg2yTgBS2b4ebUX4lf29qfxYKN/dzocY+vidzxGrOqxm35VWa
	cGl4ceoF/ibxF93YJSoaPmwjvBooxNO0QSgoVaRcvaiwzuPsIQiRL/kFy3P7P/KQ
	tPqstW7LBM9I2XNDu8AaSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786291286; x=
	1786377686; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=c
	b/2sonNzxJxrco9ek4taBDyGaOBR7sMPJ5xuNr7mFW2Qqv6k2tWzPgUEbux4f+0Z
	rPG6hAtQtWCeU3KWQUCG8KYln2wmEqzNyYvgmExQVSp6WQapowUw4YdmJvU2PwPA
	Lw89+H8jEZFtXytbzQ752hAh5qAybkS1IHO6gVhCEvZWHrcrjLlCcduZ33u/ephJ
	Cbr7VBUwo9VY/zulWYX8dnfSoumx8gCRDrWyztg7jT6CHzBjaUQvYw6ji8EprPBu
	06V9qxd8SXtiEbam+6dFAPwaNmPzStbbveFmL/XyngN+vurbV8ZVN0+v3oOML9ub
	/3jNiEWveJ65HcY376Txg==
X-ME-Sender: <xms:VqR4ajgVECRB7bzLJM1cdoU6TUGqyJ1AVK801Xn8MzFCu0_FDhT89g>
    <xme:VqR4ao-yhfE5tOvrNqMFcJBNsi2S9q_H0f8Hfm2nDgvcnC0k9RslM-rQws_lDv6HQ
    PXZmf52_MhRtDdgl9KVOSN2qLB0nUnnPJuAqYAKJysRWeZecgoTFeU>
X-ME-Received: <xmr:VqR4aurIZujiEJ-HXXu37sq41aLPaCR-utwrqnOhXzS8so1v8RMu-29Q2sgIviAl84fF3V3aNEjljJqAxw>
X-ME-Proxy-Cause: dmFkZTEjx6qIP7eMhzMZphCIXDAnOfYjQaD0F3caSctHdgFSZOEkZD/vXKVMYffUgbhyul
    QfdhmJHq572x5X/XzXor6K93EqZ8wB5g+VSSl9M2B/USDS32cYmv5HtVlIBB1UeVr5/oWL
    2ybPhX3wMnA/l87AGx0GJKI0ejSSc8pWgOxwtDSAaH+tEC5L7bFrUSvCfRvonZLbWVrYpi
    V2KxpCFEsieYDL0zXH7yavTuzUJQgzM3R+A+3rQ0Y44hLZCHVmXr6fCzQtuUWRRqktWtsj
    dEJdIPQsOYmTuTrTdvVrRVCYAEyPEds4xBjLw7ddKU5iv0C+C/Iv6tehNTnQJCYLFYnpUB
    XAouLlg2srtPlcTV4qFfHVU/8J3Aw7uT35gboRR66cxWYr1vZSTDGv4m9LIfRmLEVoUJfa
    dPNmbOFq/F/mpLGf+ZFAKDHUiLh54mrJ+jjzPd63tkNQEjIewRLQZKGx5wvTuRE40fNcKG
    qLuX2jXA3zisPfnayBade+0xKFgV8GQ20DGGc2R+nlSk6t0HRaLUwCx6sFY7gV2SFyha8B
    9OAExVlGFCVxqcIR3SQOABjjONqoKKI9xUKZ7/NMwFmyF37p88GIEGFOdPV9+HCzpBocia
    6p3o+Rr2p0eVsVKNkBfmPpxXrkjJyInRleLF8l9YAib0CiujTkSqORB4s63g
X-ME-Proxy: <xmx:VqR4agUJb2dP86eo5wrFxKSoiNLRTFjzOJSu-14CXYUlrrtFiEb1bQ>
    <xmx:VqR4atCvwLvFZ8iwUT8qQE2aoKkc0wWQQly_j5ZZXxNDkttE8FQWQg>
    <xmx:VqR4ak0rrWbqGtnIR3f_UXGwDijs1rayKR3yCOedLbYlMbrqAKaorw>
    <xmx:VqR4av1sFGQMRMJ-FAh5eRfUxP_gPKiOAPiwPfD5tlKpIakxYLut9w>
    <xmx:VqR4akCXXktW60eUs7j14xZFmP5y-apzf1HkwVGVgUOHXDkYCtRzqQvM>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 12:01:24 -0400 (EDT)
Message-ID: <09ed8e62-9c01-4a4a-8410-1051d98757b5@maowtm.org>
Date: Sun, 9 Aug 2026 17:01:24 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] landlock: Copy the quiet mask in the ruleset
 merge helper
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260726161400.3010511-1-mic@digikod.net>
 <20260726161400.3010511-7-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260726161400.3010511-7-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tingmao Wang <m@maowtm.org>
