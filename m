Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8411B6D1A;
	Mon, 16 Dec 2024 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343587; cv=none; b=u+AKoDv4r41jAgCtM4gv1L0C4jAUGVVIknOHQ3nERdGK7LAtFKZS1eQq4NuWv6lVjkzY9ttqjVv8yg10vgqM9CnsjwPaCYmUHgdVKKpUCg8F04IHKAEfnTTaoR18TaWcJbIcL6CimUGGrk0RJASUfg8sDERpcTgGhuXPbQZ0/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343587; c=relaxed/simple;
	bh=6tPdULa14btJWCBCOrB4JoSxQdOIe7Tc8dnAL5JfdPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtHMS/FGYdxqsvfyA6pWlgC2upe6m+2Rzj1X0QTXIM2xXi8Uj8WLuZvTogFdqn7kn9xG1uFkA4UnR3tO918DdI6UWUEd0EWcn4Ag4Z4Py3j7OXUInp5iuQn9w7EjIJSIB2Oj2w9+Jnfu6eCxAPFRHw/XcV5NY9xmO42asky+7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4BGA61PR040048;
	Mon, 16 Dec 2024 19:06:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4BGA61GO040042
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 16 Dec 2024 19:06:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0e2b7b6c-ae2e-45b1-aefc-f33864208c33@I-love.SAKURA.ne.jp>
Date: Mon, 16 Dec 2024 19:06:01 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: prevent bad buffer size in tracing_cpumask_write
To: Lizhi Xu <lizhi.xu@windriver.com>,
        syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Cc: jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        takedakn@nttdata.co.jp
References: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
 <20241216081953.3566217-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241216081953.3566217-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/12/16 17:19, Lizhi Xu wrote:
> User input a too large buffer size 0xfffffdeful, although it is truncated to
> MAX_RW_COUNT in vfs_write, its value is still too large, causing warning when
> allocating memory in tomoyo_write_control.
> 
> Add a check for it to avoid this case.

Thank you for a patch. But I don't think this fix is correct, for one can make
head->writebuf_size too large by writing chunks without new line for many times.

> 
> Reported-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
> Tested-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  security/tomoyo/common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
> index 5c7b059a332a..f63388c2fffd 100644
> --- a/security/tomoyo/common.c
> +++ b/security/tomoyo/common.c
> @@ -2654,6 +2654,8 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
>  
>  	if (!head->write)
>  		return -EINVAL;
> +	if (avail_len > KMALLOC_MAX_SIZE)
> +		return -EINVAL;
>  	if (mutex_lock_interruptible(&head->io_sem))
>  		return -EINTR;
>  	cp0 = head->write_buf;

