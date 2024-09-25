Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D371428E7
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272641; cv=none; b=oA5aoQA+sZGDNb/TNvDBfKW+JdhakOT3tpEEFc5NpAEfxeL3DEasCVEAugfLSD3BK/Ev8PoMPYvalD5Dti85DjXxSFz2CVbSlpTnq7Prib1daufhvg/h7vQo/QsLb02iNI9hSxkaINQKwmOhvqtwcV20k2Az1UJXmhbPCjv70rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272641; c=relaxed/simple;
	bh=NXuQYsZo5HpM2y6ai8aKDL+Qgc8F/AtXiBT2joeg0lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uRE0h9SMhEPbtewCNii0hZ+idXxIWMp2MyjLB0+nw4+bZrR2UN5WbjZePtkX+BbtTe7i1eGSY1Clmk7mG2gsQHbyecSImshkfGbFrR19DeknH/fMVaNYatFKG+8SiVGhruRuFK/6tIxUtWo6O3+qbMVBZ0R8zcObLbXglHphFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48PDv6df014770;
	Wed, 25 Sep 2024 22:57:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Wed, 25 Sep 2024 22:57:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48PDv6S8014766
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Sep 2024 22:57:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b5381c2b-6b01-4257-8b6a-6417b2fef08e@I-love.SAKURA.ne.jp>
Date: Wed, 25 Sep 2024 22:57:08 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: fallback to realpath if symlink's pathname does
 not exist
To: Alfred Agrell <blubban@gmail.com>, tomoyo-users-en@lists.osdn.me,
        David Drysdale <drysdale@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <d26b117d-1e13-42d1-9580-6dd6ce034c21@gmail.com>
 <ca37ee54-574b-44ba-b967-ef6f8f2780f9@I-love.SAKURA.ne.jp>
 <9ec5667e-6c3f-4f0f-b0a5-2047c3345a9b@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <9ec5667e-6c3f-4f0f-b0a5-2047c3345a9b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/25 21:49, Alfred Agrell wrote:
> Hello
> 
> The environment in which I discovered this issue is a homemade sandboxing
> solution that chroots to an empty directory, and uses seccomp-bpf SIGSYS
> to forward filesystem operations to the sandbox manager process. The exec
> target is a statically linked binary specifically designed for said sandbox.
> 
> I don't expect that exec of arbitrary programs will work (most of them have
> .interp = /lib64/ld-linux-x86-64.so.2, which doesn't exist either), but I
> do expect that this specific program works.

I see.

> 
> I don't know enough about the kernel to say anything about that patch;
> if you say it works, I'll trust that. Thanks.

I confirmed that this change makes your example program work.
I applied this change as
https://sourceforge.net/p/tomoyo/tomoyo.git/ci/ada1986d07976d60bed5017aa38b7f7cf27883f7/ .
Please request for backport after this change is applied to linux.git tree.

Thank you for reporting this bug.

