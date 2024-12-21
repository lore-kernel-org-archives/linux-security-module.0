Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B01F37DD
	for <linux-security-module@vger.kernel.org>; Sat, 21 Dec 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734788492; cv=none; b=keWzPpGc/xo9aUkDimm9ZgdxKsM3bNDQe+1ipdKfHc5jN0ITd0QBb1sIz/Ec3zx63eWxYFCB9BKgHR/CMqtZ/SZ92Znoe3yA+AOtArjkGH2DGXT7P3AS9dmXD+AHp4jZzci1L2PSv6JfzEW64+trHcnjudeOovCeXXQkh6gdL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734788492; c=relaxed/simple;
	bh=Z9We1rb8g/BTgFT44ZyENN1u2DAWMdjEypWUs7v0Aic=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ckaVXDMupHujcyxQp/jqLbPmvROpHgk6jmbONLS12KGdZZvUrAdmrX5TUjDcAsygEQo6HJ6IZaNKHk5oEwAM0nMlZ6GgFwHYuo81NGmi90AA5NO6lFdV2DX4xK/2YwI+rtl1uhGdTKpZCY7GcDoC7mZASFk0vATxYhCCQ5G2KjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4BLDem8S051026;
	Sat, 21 Dec 2024 22:40:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4BLDellB051022
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Dec 2024 22:40:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9fcd3f3d-33c1-4feb-8c98-472d44bc0a54@I-love.SAKURA.ne.jp>
Date: Sat, 21 Dec 2024 22:40:45 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lsm: check size of writes
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Kees Cook <kees@kernel.org>
Cc: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        Paul Moore <paul@paul-moore.com>, Leo Stone <leocstone@gmail.com>,
        mortonm@chromium.org
References: <675f513a.050a0220.37aaf.0106.GAE@google.com>
 <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
 <ed6e5639-c87e-49e8-8125-5b93cec69d43@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <ed6e5639-c87e-49e8-8125-5b93cec69d43@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

Hello, Kees.

On 2024/12/21 19:00, Tetsuo Handa wrote:
> FYI: I sent
> 
> https://lkml.kernel.org/r/014cd694-cc27-4a07-a34a-2ae95d744515@I-love.SAKURA.ne.jp
> 
> which makes this patch redundant if my patch is accepted.
> 

I got a question regarding commit d73778e4b867 ("mm/util: Use dedicated
slab buckets for memdup_user()").

While I consider that using the same slab buckets for memdup_user() and
memdup_user_nul() is OK, I came to feel that we could utilize
kmem_buckets_create() more aggressively for debug purpose and/or
isolation purpose.

I got three bug reports on TOMOYO
https://lkml.kernel.org/r/67646895.050a0220.1dcc64.0023.GAE@google.com
and I guess that at least the fix for the first bug is
https://lkml.kernel.org/r/20241218185000.17920-2-leocstone@gmail.com
because the syz reproducer includes access to
/sys/kernel/config/nvmet/discovery_nqn interface.

If the slab buckets for nvmet and TOMOYO were separated, we might have
received these bug reports as nvmet bugs rather than TOMOYO bugs.

We switched to use module-local workqueue if that module needs to call
flush_workqueue() because calling flush_workqueue() against the kernel global
workqueues might introduce unpredictable locking dependency. Therefore, I came
to feel that it might be helpful to add a kernel config option for switching
whether to use dedicated slab buckets for individual module/subsystems.

For example, I don't know whether it is worth using a dedicated slab bucket
for each LSM module, but I feel that having a dedicated slab bucket shared
between all LSM modules might be worth doing, in order to reduce possibility
of by error overrunning into chunks used by LSM modules caused by bugs in
unrelated code.

Maybe we want a flag for not to bloat /proc/slabinfo output if we allow
using dedicated slab buckets for individual module/subsystems...

What do you think?

