Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2462199929;
	Wed,  2 Oct 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910564; cv=none; b=qUd4VS3i7rScLBWuuOQVNTZbWkoXtR9u9IWmJxs8dIGcQZsJfCz9z4rIQzWcqrIO36McycDKgPDtlKcTcKcAn7N4+HSrKGvEwCVd312Ytir2EoxIcXWqs9MmKvg3VthMw8eZr2yzlibUG9x+zWg1Pv0rDWH6/Ppts9P2FokcNnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910564; c=relaxed/simple;
	bh=/wJUoSuKY4AfSrm5P7gnm0y/XmsdFTw25QoWKsm+8vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/jf61vqh80PvE+Q/85SOu7dfi0FfOAUHnjrU0DfeB1udGFUSCWaiT9UfsJ+GYfT8SvJfffMf7CZNcqWTfGsPDR73HVAT9Hl73Cm5iFX2K+TBO0U/WgCDJvYCUARnSPVM8KUvJJgUbkKdWrsrgMCBwuv2WDQyC4894HkXw+fsVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 492N9Dlp067508;
	Thu, 3 Oct 2024 08:09:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 492N9DAR067505
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 3 Oct 2024 08:09:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9387e6bb-484a-443d-ad87-24cf6e976e61@I-love.SAKURA.ne.jp>
Date: Thu, 3 Oct 2024 08:09:13 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com>
 <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
 <CAHC9VhT3yfahvwSVqGHyQq5SDpf8QRjDoEttoyD0zSau41Sb4Q@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhT3yfahvwSVqGHyQq5SDpf8QRjDoEttoyD0zSau41Sb4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/02 23:01, Paul Moore wrote:
>> Now that built-in LSM modules started using __ro_after_init static calls, !built-in
>> LSM modules can start using !__ro_after_init linked list without affecting built-in
>> LSM modules. I can't understand why Paul does not like it.
> 
> A *lot* of effort has gone into both hardening and improving the
> performance of the LSM framework.  I'm loath to introduce anything
> which would take away from those gains, especially if it is only done
> to satisfy out-of-tree LSMs, or users who don't agree with their
> distro kernel's build-time configuration.

Forcing distro users to rebuild distro kernels (with or without modified
kernel configurations) is no longer a viable solution.

Since cryptography (e.g. module signing keys) is getting used inside kernels,
noone except the one who has the private key and has built the original kernel
can reproduce the same behavior/functionality (even without modified kernel
configurations). Also, from package management perspective, users get confused
by being forced to use different package names/versions (when installing kernel
related packages) and breaking package dependency (when installing userspace
packages). You said

  Comparing userspace applications to kernel code isn't a fair
  comparison as a userspace application can generally be added without
  impacting the other applications on the system.

  Anyone is always free to build their own kernel with whatever code
  changes they like, this is the beauty of the kernel source being
  available and licensed as Open Source.  You are free to build a kernel
  with whatever LSM you like included and enabled.  You have been shown
  examples on how to do this in previous threads.

at https://lkml.kernel.org/r/CAHC9VhQq0-D=p9Kicx2UsDrK2NJQDyn9psL-PWojAA+Y17WiFQ@mail.gmail.com .
But due to above-mentioned realities, your assertion no longer stands.
Kernel source itself might be open, but private keys cannot be open.
The vmlinux cannot be rebuilt without forcing penalties (i.e. having a
negative impact on the user side, which cannot be a viable solution).

