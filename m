Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007F71B969;
	Thu,  3 Oct 2024 04:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727929610; cv=none; b=hdARfzlhD8j10Ta+nB7LPEa9ZXyIopB8vk2CuDhwwsjRwlO5jrKtQffuIZWiE8YI/LvqAGe1XsNV1Q6YwVX21VFGnGUdy+d+KCOo2rTqCpb/vix1403tVv8hFQDyrRUeX4OPZKm8JU9beeZb0IZIQtVY9V60UfaUnZ6NIsxZVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727929610; c=relaxed/simple;
	bh=sd8kJSpZzVd91nXQ/gzm0RmNx0jJQqy50eufUkghbBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4jabBlLlAj0BHqUVR5hRvkImBJTyKwWuFumjL46bdEIMqsSTVV4QRwuqaaQMT8BzfoplQMutUco1UkqcKSBB6Gq/g0RaXsV4gDF8jJ8B3EuG98mB8VXt1133pp+GLEtL1kkehTvUYvoWLYR70ew9JWfa+lQkdo6RSdPgpFhenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4934QUvA080966;
	Thu, 3 Oct 2024 13:26:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4934QUwm080960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 3 Oct 2024 13:26:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8114a37e-1306-47ee-b27e-a61c1c7bca94@I-love.SAKURA.ne.jp>
Date: Thu, 3 Oct 2024 13:26:26 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
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
 <9387e6bb-484a-443d-ad87-24cf6e976e61@I-love.SAKURA.ne.jp>
 <2e182814-9317-4de1-ab96-b3b1eeb89733@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2e182814-9317-4de1-ab96-b3b1eeb89733@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/03 11:45, John Johansen wrote:
>> But due to above-mentioned realities, your assertion no longer stands.
>> Kernel source itself might be open, but private keys cannot be open.
>> The vmlinux cannot be rebuilt without forcing penalties (i.e. having a
>> negative impact on the user side, which cannot be a viable solution).
>>
>>
> Yes, and this is an intentional choice on the base of the distro about
> what they support and what is required to meet contractual obligations.

The reason Fedora cannot enable TOMOYO is lack of bandwidth.
You've just said "Bandwidth is a very real issue". Thus, I need a solution
that can solve the bandwidth problem. The question is how we can control
division of role (share the workload) in a secure manner.

> 
> Users are still free to build their own kernels they just don't get
> support or certification when using them.

Nobody can provide bandwidth (or infrastructure) for supporting their
locally built kernels.

>                                           Stopping the load of out of
> tree modules that aren't signed is in general good security policy.

Yes, distributors can prevent load of out-of-tree modules that aren't
signed. That is good for security. But building kernels locally cannot
utilize signed modules functionality. Also,

> 
> Let me be explicitly clear. If Tomoyo is by-passing module signing, and
> exporting the LSM interface to loadable modules Ubuntu will be forced
> to disable Tomoyo.

TOMOYO is one of in-tree modules that can be signed together when building
distribution kernels. Fedora can provide tomoyo.ko as a signed-but-unsupported
module (i.e. excluded from main kernel package that is supported by
distributors but provided as a separate package that is not supported by
distributors).

