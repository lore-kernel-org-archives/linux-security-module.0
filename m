Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880D2D7DDB
	for <linux-security-module@vger.kernel.org>; Sat,  7 Mar 2026 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874114; cv=none; b=uuKCWC4UOb5l6Q73sgRXsIcAHy9u4qSI8ukKngUmRRdx6CyCNL9aysXRAHbS8iPB6A8I97E7zHmDeGNP/iFoa4rLppHW6HuDwHG7VSbWnkRisWYX18/T3hmE2OouEyBKEUOwMC9fXHxcXiRyGpi5FRHxbeSy4qBfwC5FlbQQKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874114; c=relaxed/simple;
	bh=E2gP2VUra6Fxrt0Vxn/BXapZM02jznWx/ZRkr+CF6zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR/6iihVf2QBOkjqxw7RuW3mbqny5tULXPOJjhtRN5WOhiqUH7+CQ40GW1qzYS+5rYXKrHecXZhLErHQldWDyBaXiNH0wLOFj4G70qbDLBZaku6azwRUCPUx45CxyVJLh8cwRHjkz4w0+gky0d8WVhB7k7P7Nyp55cn6HugzT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ic4la1Lx; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ic4la1Lx"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fSchh4NCNzpcF;
	Sat,  7 Mar 2026 10:01:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772874100;
	bh=ecBDgP/EmJ9hmzOdgVx7Xqkzq56E4sjb/ePEnN87+es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ic4la1LxkC2vxd1Buj4RBOBLlqtLmMuYLtoWwSdFmgTkHMvYpgOrtre2+ZG04iPxs
	 vdZYQ+ZmiVf4mqc/CwJ9/k7PE6N47N5Cu2Uy4sw8pWB/9bDBEgZ2oTv+GRVFD3GPnO
	 XS1pVkyUrEPrco2sQgc6BANQe6vAOMNm5o3XDn+k=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fSchg6RCCzH24;
	Sat,  7 Mar 2026 10:01:39 +0100 (CET)
Date: Sat, 7 Mar 2026 10:01:30 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com>
Subject: Re: [PATCH] landlock: add missing task != NULL check in
 cancel_tsync_works()
Message-ID: <20260307.va7aemeThoon@digikod.net>
References: <69abb4e3.050a0220.13f275.003d.GAE@google.com>
 <a96efa12-003b-46ed-9444-40b69d84fa05@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a96efa12-003b-46ed-9444-40b69d84fa05@I-love.SAKURA.ne.jp>
X-Infomaniak-Routing: alpha

Thanks. This issue was fixed in -next with
https://lore.kernel.org/all/20260217122341.2359582-1-mic@digikod.net/

I'll send a PR next week.

On Sat, Mar 07, 2026 at 02:21:32PM +0900, Tetsuo Handa wrote:
> syzbot is reporting NULL pointer dereference at cancel_tsync_works(), for
> tsync_works_release() checks for works->works[i]->task != NULL but
> cancel_tsync_works() does not.
> 
> works->works[i]->task becomes NULL when tsync_works_provide() incremented
> works->size and then task_work_add() returned an error. Therefore,
> cancel_tsync_works() needs to check for works->works[i]->task != NULL.
> 
> Reported-by: syzbot <syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=741e2278ef71fef03a10
> Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/landlock/tsync.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index de01aa899751..8925acbef8a5 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -412,6 +412,8 @@ static void cancel_tsync_works(struct tsync_works *works,
>  	int i;
>  
>  	for (i = 0; i < works->size; i++) {
> +		if (!works->works[i]->task)
> +			continue;
>  		if (!task_work_cancel(works->works[i]->task,
>  				      &works->works[i]->work))
>  			continue;
> -- 
> 2.53.0
> 
> 
