Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57176366577
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560280; cv=none; b=YinI3FQwSFo1ljZMBh1CNSt4zrjYajeHxEpxMZxKpSPaUboqsyDUxURunXE5yRi+cy1Tvzj7VPIlG34TyaJJpwBJ+E2SmmkR45/63PcsMR02wIn0SfYsXmUFeZZM3+AZAucEBa5TfyRFbILXqmnnAJlSXQLgQYitrOPfY8/u3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560280; c=relaxed/simple;
	bh=MZZHFU5c9nzPMsWGhMOka9ym50lmk4gDf2wx2E9X3gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYhrD7VMpgCchDrVVApTN+4aEyOVUea7ZShTYLv8n5g6bqXfS9efSgxzTU8RxQri4/uTNcgH659MtQ15J4Qb6DC9vXjD4Yh1KszmCB5LlEJI2iLDVJ/6ssKnlnkansB/eqSBK8ER9uf7t8aoSwWMz52cURxMs1auE8aHpaic4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=J6M4l6w7; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="J6M4l6w7"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fQNdV3mtmznvv;
	Tue,  3 Mar 2026 18:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772560270;
	bh=kCNxzUsI4yIMv2cpKtFZc2+sDhpx3G8zFouiMkhcPGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6M4l6w7QR/aY1/unnMZ25dvUHQKc4agfjo4MVk5t5Jb7K8M9yoTNRFRZoClqGeu+
	 y7UsdGFmKypQtN0uPfOeh7LY/vQrPBETwnwqdLXWQ7T4PC+5s0K5ttOhyKyOu+G9xh
	 L0l9jpRGQS6hZnvRaP+MPcmAPEKlBcuFHhnxpNhk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fQNdV0M2wzS4Y;
	Tue,  3 Mar 2026 18:51:10 +0100 (CET)
Date: Tue, 3 Mar 2026 18:51:09 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <20260303.yeGhee4uj2sh@digikod.net>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226015903.3158620-2-dingyihan@uniontech.com>
X-Infomaniak-Routing: alpha

On Thu, Feb 26, 2026 at 09:59:02AM +0800, Yihan Ding wrote:
> syzbot found a deadlock in landlock_restrict_sibling_threads().
> When multiple threads concurrently call landlock_restrict_self() with
> sibling thread restriction enabled, they can deadlock by mutually
> queueing task_works on each other and then blocking in kernel space
> (waiting for the other to finish).
> 
> Fix this by serializing the TSYNC operations within the same process
> using the exec_update_lock. This prevents concurrent invocations
> from deadlocking. 
> 
> We use down_write_trylock() and return -ERESTARTNOINTR if the lock
> cannot be acquired immediately. This ensures that if a thread fails
> to get the lock, it will return to userspace, allowing it to process
> any pending TSYNC task_works from the lock holder, and then
> transparently restart the syscall.
> 
> Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> Suggested-by: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> ---
> Changes in v3:
> - Replaced down_write_killable() with down_write_trylock() and 
>   returned -ERESTARTNOINTR to avoid a secondary deadlock caused by 
>   blocking the execution of task_works. (Caught by Günther Noack).
> 
> Changes in v2:
> - Use down_write_killable() instead of down_write().
> - Split the interrupt path cleanup into a separate patch.
> ---
>  security/landlock/tsync.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index de01aa899751..xxxxxxxxxxxx 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	shared_ctx.new_cred = new_cred;
>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
>  
> +	/*
> +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> +	 * when multiple threads call landlock_restrict_self() simultaneously.

Please format this comment and the next patch ones to fit (and fill) in
80 columns.

> +	 */
> +	if (!down_write_trylock(&current->signal->exec_update_lock))
> +		return -ERESTARTNOINTR;
> +
>  	/*
>  	 * We schedule a pseudo-signal task_work for each of the calling task's
>  	 * sibling threads.  In the task work, each thread:
> @@ -556,6 +563,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  		wait_for_completion(&shared_ctx.all_finished);
>  
>  	tsync_works_release(&works);
> +	up_write(&current->signal->exec_update_lock);
>  
>  	return atomic_read(&shared_ctx.preparation_error);
>  }
> -- 
> 2.51.0
> 
