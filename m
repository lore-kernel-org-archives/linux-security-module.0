Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840C63921E9
	for <linux-security-module@vger.kernel.org>; Sun,  4 Oct 2026 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123653; cv=none; b=TbHwa70FXORwH4TuziAb0od+V4Or/pGKcmC/uhDV7yCaT2bavGIfTmIxCtBEhZRLXkBXo2E6MSnLsNwKHhfFzUKZbJego7ZPgr4bzY/Zb8jEtT7RYd1ZFbju/xmaz3FAnwhPDOR4gdkspWMZ7kXRdpEWPb1d+ZvPoVoDJzuf/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123653; c=relaxed/simple;
	bh=j4cIOXhw46BIrZkbNNaU+2mGKLCCpvelM5gwV4i6ztQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8gRvnnu8ZFoD3aIVqSvhqdA1zc7vBMZaAjKMEaBDQTO6GSmghKU1+/kiHj4MvnaLxO3wP1PL5dS+0BzmD4ucSqPn/M2zZYE/KBmS3NqGdSkW+R3jGQpQQPNqdZ8iZTIWfiltKLuK4JKPdSdcMdcavqvEfLgQavfEzQeyQzW52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 694EKmOn013786;
	Sun, 4 Oct 2026 23:20:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 694EKmF6013781
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 4 Oct 2026 23:20:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dbdb66c3-eb3a-40fc-ac68-ff77aa4c7614@I-love.SAKURA.ne.jp>
Date: Sun, 4 Oct 2026 23:20:47 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: Enforce connect policy in TCP Fast Open
To: Matthieu Buffet <matthieu@buffet.re>
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
        linux-security-module@vger.kernel.org,
        Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <20260619002207.61104-1-matthieu@buffet.re>
 <2951101e-d503-4a48-91b8-d6f041f0b1b6@I-love.SAKURA.ne.jp>
 <4163fb5e-c4ee-42cf-a964-f617bb378173@buffet.re>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <4163fb5e-c4ee-42cf-a964-f617bb378173@buffet.re>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav413.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/21 7:34, Matthieu Buffet wrote:
> Hi Tomoyo maintainers,
> 
> On 6/27/2026 7:28 AM, Tetsuo Handa wrote:
>> I updated your patch like below in order to exclude kernel threads from this check.
>> If we are OK to go with modifying individual LSM, I'll apply this change.
> Archiving this patch, I see you have had no answer from other maintainers to your
> question about the approach taken (per-LSM instead of aiming for a hook-wide fix).
> Patches have indeed been merged for other affected LSMs:
> 4d587cd8a721 ("apparmor: mediate the implicit connect of TCP fast open sendmsg")
> 44c74d27d1b9 ("selinux: check connect-related permissions on TCP Fast Open")
> 33cb713db016 ("landlock: Fix TCP Fast Open connection bypass")
> 
> Have a nice day!
> 
> Matthieu

Thank you for letting me know.

I am currently modifying your patch into a series that can please sashiko's review.
Since sashiko finds many corner cases, I need to make several trial and errors.
Please wait patiently.
