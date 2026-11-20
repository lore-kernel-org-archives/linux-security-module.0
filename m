Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203226;
	b=40+cLZl3/GGbrasX6X9a2g+9cl+OLOJJ7LHCKBm5tMl2ALYFpzl8AVO+XvEOczd8T4qX
	 /kZkoRvfbOYplKqAzJj10erGuBQuiJ45Cp7ZyCq9AM739ZPGVArl9tU676R71e8XkO5t0
	 oCukHs5UkWgiHht9gvbcbe2xFbGAvMRi2OHl3zpoOmK8TiUUWvk8674UJQaza8iYuEvfq
	 sGHtOMPLeVBCXtX7RXnlWKZerLzFb2uvYwIbEif5DsEWZbUIBjk5RO8iO3xPmhLfxGgsD
	 4e2gc/FOHtvtaAfafE+BJ/uVGPaS3vdMwwzCjrT4tyLMAXBmZrTK+b6swHIgy79IlvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203226;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=hGQCtwo0ArzvoExkz3JfbYbHfP1u7nAX1DBGGzhx41c=;
	b=P4nVTbTQBMspVmmtr2yWi+AT1FA1kH3xIKNXNHsu3jzutYH5DYVQJlefPZ+/kKsQqQaw
	 qhF8p/bE4HHuzHKAL+T/JWFb0T38nUamvFx2sN+u2Nq+8oNRECfrDuPbDYjH0FlMf/9V6
	 cjNdbGd8PmlZY4nSwxeYCd7pqGK3m1nes6F7lZpkSrD66KdQuz1XXsTxbNEAFNRFoDJ5s
	 gCu6XeOeGY0/FfWt6U5rruxA9lG4itrKwx8QWqvQvWfOq0xLrtGUIFQJpDoJ+hpLb2wG6
	 g5NATKPzgRptt+xFJiS6VqGa617xR/tr0a/fakdKmzM20iWs0HXVChRxLqDFT5kIWWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b="0iirAh/H";
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE1606A33B;
	Fri, 20 Nov 2026 19:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00AE1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=0iirAh/H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1795203212; bh=BJadd8bh/WCqOLjyC3GixtLreoc3B1AOAw5RfvVecVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0iirAh/H0lfOXqSgJqoohJAsCHuq+voxTF21GS92ULC/KLTYKRXNIjJPt1KBXD4e3
	 nPG7ZRkefz8GngkoEae4Nz2BDrWSoU5xSh+ORhv+ds92uqTMMN3hsjKSQ2VNp6pxTI
	 syLq6RPLAFuj58tUw+cBdjN8IZI4hnYvePhs19ONW1yaymwsHrZvhGNp8+3i3FxGeP
	 N8PGLcK/voZE6Wf4+75yjDzRS5XxSv/s7f4WbGCaClM7boPWyjtfDl07xTVOSG7Gu9
	 0MG0Idat3xqIgO+/hTJTMjRoMGpl0sbY1U8IFbYelnJaWfp6TG8Au68nqgeyWy4wKM
	 9oYg7wzHUHTIg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id F217D1D7F; Fri, 20 Nov 2026 13:33:32 -0600 (CST)
Date: Fri, 20 Nov 2026 13:33:32 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com,
	syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] cred: annotate data race on non_rcu when copying a
 cred
Message-ID: <awCgjAHgzJi5Wn4+@hallyn.com>
References: <20261114052900.7-1-bbnpreetsingh@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114052900.7-1-bbnpreetsingh@gmail.com>

On Sat, Nov 14, 2026 at 05:29:00AM +0000, Babanpreet Singh wrote:
> prepare_creds() copies the current cred while another task can be in
> get_cred() on it, clearing non_rcu. KCSAN reports:
> 
>   BUG: KCSAN: data-race in io_prep_async_work / prepare_creds
> 
>   write to 0xffff8881046cea68 of 4 bytes by task 3646 on cpu 1:
>    get_cred_many include/linux/cred.h:222 [inline]
>    get_cred include/linux/cred.h:238 [inline]
>    io_prep_async_work+0x9b/0x3c0 io_uring/io_uring.c:367
> 
>   read to 0xffff8881046ce9c0 of 184 bytes by task 3645 on cpu 0:
>    prepare_creds+0x71/0x550 kernel/cred.c:192
> 
> The race is harmless. non_rcu and usage are the only fields that change
> on a published cred, and both are reset on the new cred right after the
> copy.
> 
> Annotate the copy with data_race(). prepare_kernel_cred() makes the
> same copy, so annotate it too and switch it to memcpy() to match.
> 
> Reported-by: syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ee58b040032d8bed63d9
> Reported-by: syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=557fdc985d6ac3831e14
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

At the moment this seems correct.

I do worry that if struct cred changes/evolves, then this solution
may mask newly introduced regressions.  But I don't have a better
idea.  I mean, I guess we could keep usage at front and nonrcu at
back, and memcpy just the parts in between...  In a clearly
named new helper function that wouldn't be so bad, e.g.

static inline void cred_memcpy(new, old), and let cred_mempy do
the offset and size calculation.

> ---
> Drafted with Claude, an LLM coding assistant, from the syzbot reports.
> 
>  kernel/cred.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cred.c b/kernel/cred.c
> index d01df40a9a386..d9ab1cb4230a8 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -189,7 +189,12 @@ struct cred *prepare_creds(void)
>  	kdebug("prepare_creds() alloc %p", new);
>  
>  	old = task->cred;
> -	memcpy(new, old, sizeof(struct cred));
> +	/*
> +	 * Another task can be in get_cred() on the old cred, clearing
> +	 * non_rcu. That and usage are the only fields that change on a
> +	 * published cred, and both are set fresh below.
> +	 */
> +	data_race(memcpy(new, old, sizeof(struct cred)));
>  
>  	new->non_rcu = 0;
>  	atomic_long_set(&new->usage, 1);
> @@ -573,7 +578,8 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
>  
>  	old = get_task_cred(daemon);
>  
> -	*new = *old;
> +	/* Same race as in prepare_creds(). */
> +	data_race(memcpy(new, old, sizeof(struct cred)));
>  	new->non_rcu = 0;
>  	atomic_long_set(&new->usage, 1);
>  	get_uid(new->user);
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.54.0 (Apple Git-157)
