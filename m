Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928D1EE7AB
	for <linux-security-module@vger.kernel.org>; Sat, 21 Dec 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734775269; cv=none; b=OZWdjPPpZqf073XA80nSvShD8kcTNtwTd35aeFtl6JXkoUYeml64IbtDyL3eS+RV9CFxTiKQdPrSw1+9iPUnIAIA0yBsrSzCbiIXzobFVtlscZCpgTbpfvHKcufs3hO8JWWaIdenVl8v5Fr8xL/ooQItCxazrjYv0jgVnSeEYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734775269; c=relaxed/simple;
	bh=q1TtQkdp2BFFO7afCbuAIghBqVzQX/6xewpFIWAyhzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTpN+U/ouO8qnsUpGE54Psd/qn4Ab/ddDr8eYSQDA9YAkoTjjBAcsglCXooMVfB2xSf/julsb7viZB4Ooi0sBDDzp/WvB4DGCgN94ChINxOpqP4UCYODSBZyta395wMoD3wdc+glNsERrMhG1SLCUpLI3wUWDJXnFOI3c76p74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4BLA0YGo047999;
	Sat, 21 Dec 2024 19:00:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4BLA0YWT047991
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Dec 2024 19:00:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ed6e5639-c87e-49e8-8125-5b93cec69d43@I-love.SAKURA.ne.jp>
Date: Sat, 21 Dec 2024 19:00:31 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lsm: check size of writes
To: Paul Moore <paul@paul-moore.com>, Leo Stone <leocstone@gmail.com>,
        mortonm@chromium.org
Cc: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com
References: <675f513a.050a0220.37aaf.0106.GAE@google.com>
 <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/12/19 6:51, Paul Moore wrote:
> On Tue, Dec 17, 2024 at 1:27 PM Leo Stone <leocstone@gmail.com> wrote:
>>
>> syzbot attempts to write a buffer with a large size to a sysfs entry
>> with writes handled by handle_policy_update(), triggering a warning
>> in kmalloc.
>>
>> Check the size specified for write buffers before allocating.
>>
>> Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=4eb7a741b3216020043a
>> Signed-off-by: Leo Stone <leocstone@gmail.com>
>> ---
>> v2: Make the check in handle_policy_update() to also cover
>> safesetid_uid_file_write(). Thanks for your feedback.
>> v1: https://lore.kernel.org/all/20241216030213.246804-2-leocstone@gmail.com/
>> ---
>>  security/safesetid/securityfs.c | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> Looks okay to me.  Micah, are you planning to merge this patch, or
> would you like me to take it via the LSM tree?
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> I'm going to tag this to come back to it in a week or so in case we
> don't hear from Micah, but if you don't see any further replies Leo,
> feel free to send a gentle nudge ;)

FYI: I sent

https://lkml.kernel.org/r/014cd694-cc27-4a07-a34a-2ae95d744515@I-love.SAKURA.ne.jp

which makes this patch redundant if my patch is accepted.

