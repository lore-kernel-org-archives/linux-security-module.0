Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4DB1372;
	Wed,  2 Oct 2024 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839945; cv=none; b=Rg+Xzu03pq6qUaIw4MICo4/mOZDti2Wl7BDy3US3MM1iUsXCqnyH8lkEuc5jZBepylC6428motbFQE/RSXGulA/QHVI/TUa/6Qz+BLpzKuulAoR+yqnYfQj1WWYR/LUbvmC/C1yHcxpiFplFitqI6APHgV+aAIk46a49f47A9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839945; c=relaxed/simple;
	bh=GrshfNrdBEhbre/HkSZmIqVi0NqnliVcnKoyd5hLewQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQEIHPEAAuFrjzrCisbKiyG5eGECflb6ziSwuJUJssogSolij+9wrcRxxLyOXWlpOTOlwvkvVv8ZRnh3lk+z8Z9SPTqJcN6LBiyrxgdTNghp2/VNz+adDKNQdsQBTMEO1RQnscLxnVzY8QsEk4XthNvAo2Nl40SjSMBVqhOQooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4923VsnQ071604;
	Wed, 2 Oct 2024 12:31:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4923VsvN071595
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 2 Oct 2024 12:31:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <19e29693-718c-4667-ab40-948718bcc6f5@I-love.SAKURA.ne.jp>
Date: Wed, 2 Oct 2024 12:31:54 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Paul Moore <paul@paul-moore.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhS_8JtU0KQyy3rEGt0CQ_XMQFt2Kic-bz-Qd=SMjeWe4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/02 1:36, Linus Torvalds wrote:
>> Linus, it's unclear if you're still following this thread after the
>> pull, but can you provide a little insight on your thoughts here?

Yes, I want to hear what Linus thinks.

> I absolutely hate the whole "security people keep arguing", and I
> cannot personally find it in myself to care about tomoyo.  I don't
> even know where it is used - certainly not in Fedora, which is the
> only distro I can check quickly.

As far as I am aware, TOMOYO is enabled in Ubuntu, Debian and openSUSE kernels.
CentOS plus (which provides additional functionality over RHEL, but was killed
by CentOS Stream) kernels also enabled TOMOYO. But not yet in Fedora kernels.

> If the consensus is that we should revert, I'll happily revert. This
> was all inside of the tomoyo subdirectory, so I didn't see it as some
> kind of sidestepping, and treated the pull request as a regular
> "another odd security subsystem update".

I will revert TOMOYO changes if Paul succeeds in getting rid of
CONFIG_MODULES=y support from the upstream kernel. ;-)



On 2024/10/02 3:22, Paul Moore wrote:
> Starting tomorrow when I'm reliably back in front of computer I'll
> sort this out with the rest of the LSM folks.  Unless something
> unexpected comes up in the discussion I'll send you a revert later
> this week.

What I am asking LSM framework is as simple as
https://lkml.kernel.org/r/caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp .

Now that built-in LSM modules started using __ro_after_init static calls, !built-in
LSM modules can start using !__ro_after_init linked list without affecting built-in
LSM modules. I can't understand why Paul does not like it.

> Yes, that's fair, I think you would need a deeper understanding of the
> LSM framework as well as an understanding of recent discussions on the
> list to appreciate all of the details.

Yes, please. How strange recent discussions about LSM framework is. :-(

