Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0773BB672
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789943665; cv=none; b=X5ssJRkwdy3HIXlzgGyszgrEF6E22bXWHle2PicH/K0SpOxNtesNi234OqcTC6kH+YJCyKvj2+Pp9V7yYIJCDdHmGrRjHSFMI2SYQ2dvC1N7FRjN9jBzAaZynZKh2UfwsTCwoPybxT8ggKyKdDKYU61kLIKaTIxQaO6rYBDsako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789943665; c=relaxed/simple;
	bh=lzif6gMQZPHIDAgY5VT8ymWjZ51k6pH2LQ913gCIVFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2CKKXcFa7yv7emJxKIPzrhH6F/r+Z3EO8olvp8gGHalqPbInBXbHO3aEvJ3ijBJc74EtPxU3NHnpvWrqdvVVmHsNI2SrXFpv3o3d9fggsoxJfbfrkm0brwjHkFn0+nU8InwdwwfNLQ5zdxdKJTxXfa0MLcy5F1WzFGY7YNxmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=rOld4tbt; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="rOld4tbt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1789943654; bh=lzif6gMQZPHIDAgY5VT8ymWjZ51k6pH2LQ913gCIVFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rOld4tbtej2KL8ZzdP3Ira8sTsGZFSFKrARRPfPEhifWZqK7ywuvDFflAuAftMUaS
	 4lZ94BDtLihX1PnhmrtbHWU2IgLEcTc6Z3Rvskhu75+jESf55ZDn4hTBAjQZMEkET5
	 mj1dq9c2C/j1UN8lvyX96f9ZrmcN4p1mKUpN2H+VZ3EELrjxcqdLXj+DVJGaiy8Nfy
	 6TvjM0oaWxexsabkoBqqu1AGgUMtudwn5S3tOJPxpY7Ojpj0xMCuPP1DRUcofzSEiA
	 Cc9HGWSTBuXV+AKk01ATq0ADpY3o2Z//dlEjv2QfrpPOunFODSTUdjjzf21q2KCCmD
	 VPiCdpW3fjH2A==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 541121253F9;
	Mon, 21 Sep 2026 00:34:14 +0200 (CEST)
Message-ID: <4163fb5e-c4ee-42cf-a964-f617bb378173@buffet.re>
Date: Mon, 21 Sep 2026 00:34:12 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: Enforce connect policy in TCP Fast Open
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
 linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Paul Moore <paul@paul-moore.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
References: <20260619002207.61104-1-matthieu@buffet.re>
 <2951101e-d503-4a48-91b8-d6f041f0b1b6@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <2951101e-d503-4a48-91b8-d6f041f0b1b6@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomoyo maintainers,

On 6/27/2026 7:28 AM, Tetsuo Handa wrote:
> I updated your patch like below in order to exclude kernel threads from this check.
> If we are OK to go with modifying individual LSM, I'll apply this change.
Archiving this patch, I see you have had no answer from other 
maintainers to your question about the approach taken (per-LSM instead 
of aiming for a hook-wide fix). Patches have indeed been merged for 
other affected LSMs:
4d587cd8a721 ("apparmor: mediate the implicit connect of TCP fast open 
sendmsg")
44c74d27d1b9 ("selinux: check connect-related permissions on TCP Fast Open")
33cb713db016 ("landlock: Fix TCP Fast Open connection bypass")

Have a nice day!

Matthieu
