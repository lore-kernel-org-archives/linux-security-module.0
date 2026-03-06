Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366B2FDC3D
	for <linux-security-module@vger.kernel.org>; Fri,  6 Mar 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780417; cv=none; b=ZPLS2KcDIbkesKsV68TxLStf1Hf4AjJzuiRZNZzguIOuaPzXPUE2yKHrQtl1LW5Wtp1JANAmcGWaUa/PjsCTQv7QnG59Ocd5q23Qwpq4w9l0URSE9sHmiOr4Cm//W+SyNRaZkpzPA5EWopBqU1NbIkv+zoFD/6UJ/o0g1rRObYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780417; c=relaxed/simple;
	bh=s6h012+eZXW7ZuP3pbkTzMsxN2VpFuXm9Btnpg6Ueb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwm3gXJj+ORv4SnlHAxio8xLv02wf6MU6+MYMfOS7Ses2W+gpoPsPtgGmdNzOdSAr1uVMisrwWAGNWbemzA7L/oYevFNB1CvOoAJghwweykFfUYnpsQi2KUYFq4RDFewr+zWQsrLiI29lW/wy+G+rAPtgrSb+aAvsn3IeAF8Qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9i5LQOw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9i5LQOw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48379a42f76so76958755e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2026 23:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772780411; x=1773385211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xeN1/e/Ujc8gdHB6c6k4NdrMO1jLQFb1La6T5MsRtOk=;
        b=l9i5LQOwRxYHz0unZvYT25zNK5YwvKvAzk5ajiW+DtbhcczMx0GFVTqRxWM5JW+oPm
         Wb1YoSwJJQ564TeSnIuER1LQvfhlvK8OGbGd2dwX/gFv3XHzMfy2hCBUZlceDQqOuzPW
         wPHQfs3mI+SZZFxSnDO/9bHNBo0ShjkIi4qkXieiIpqodBzYdP1C/0mmff1pMaUTBQMP
         ZGImVu62uKP/aegpyDzhMbhiHQM8sCyYY6KiXCb5rM3ZnKQnwIf+4kHJuCaQIfl/ysxE
         drX1KM7zRNvm+cz3ghxwz8X+zp/oqwkOBiRsSCx56F3LS5h0MHrqSvOhkywCSeC8fjfJ
         BZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772780411; x=1773385211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeN1/e/Ujc8gdHB6c6k4NdrMO1jLQFb1La6T5MsRtOk=;
        b=kDJz/04xHMo5mTcIT1sx9GPvpRnHJFpFDWO63SZHgxlfdfwuIajNsQjC+HUfTaLZnW
         W/EQb7ZDbq/AXMScZf0EvNWR2usRmn+D68p4fEMyjRJ4EqXlvoMVym/KG2lux95ud5xW
         7GZqkBfIi+h87U2pE3PTT0ZvfxkLKExbgXzhqElxSjrWmvi0jVVcm+9WhmGb2oduoS0k
         VPzCxx3zHkeKCiryQsTy1Fl5Ho0iSkM381HuA5/711F/bvy/+LMWjleCnZfKJpzX6O6p
         ELJT95TzQ6nP/mZM9cAHvhw52kLddCdtKpLE6YW+FM3D/Z8U39YwQdrZH1lG7zk76Kef
         KUQw==
X-Forwarded-Encrypted: i=1; AJvYcCWaJ1bD2/roS7aVGaWrwZep8SqOlFwLDI25DrdqeAk5oA7L/QYmwKX4JH9IBT3wA5tktbPC3tLFeZfidubFL8mTzJ5qObo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/49+ic07c3bTPV+JAE/XyjF61k3Qt09cafA4o1R4SSmHRR+v
	APkSy+m0HYHk3dD46QGJWGw3FHKVCJO0ctXXx1ddA8ER8LLe8LKrRPeZ
X-Gm-Gg: ATEYQzxIeNDw8mF5Zi1y3q0czNNHzDo/7b8l/QKkjua9f2f/Hoz6z5Z1nuoRPelKUCC
	MzMxQ1zetX4X9dS1+N+nBbcHQpP39K4nH2FJlkP1Qc0ys1p3DJ3VEE7KzSth9jwAND/UlnWQyuV
	mTFNGXDQT2BaUkj82rw6dn5yIWaIDZlFTAwKpvXMMuFtbCp8K3WOjKdgTXFzgAAucdtFx0Vg/O1
	V9ifhTMqDXnfMWpcs8GRzKrT4HG725AdFWrDSJ8UQVSK7J+P5+iPNjsJILaRs0JKUXR0Ax8KcaN
	1U8tZsIFhB4ZZbQ9KH7lwej3/RdliwJEupoMlD/QriA5EBuAQ/Fl2B3824nY3WhV+l1SWc+jAX8
	OIUGaK7oPHp6sDz0F5OUoUFSifvSncGPSRUVRWutofE/54XDJdrmkV7rkG78mUSlANic6fxIkbL
	hoE3gde8UM5E5ZE3x2OVgS8tDgIpf9NgHU2e7rCeXaC0vckzjU
X-Received: by 2002:a05:600c:8b01:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-485269195afmr13193415e9.5.1772780411131;
        Thu, 05 Mar 2026 23:00:11 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852470b412sm19585965e9.8.2026.03.05.23.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:00:10 -0800 (PST)
Date: Fri, 6 Mar 2026 08:00:02 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: jannh@google.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	mic@digikod.net, paul@paul-moore.com,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com,
	utilityemal77@gmail.com
Subject: Re: [PATCH v5 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <20260306.0ef023ccdaa5@gnoack.org>
References: <20260306021651.744723-1-dingyihan@uniontech.com>
 <20260306021651.744723-2-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306021651.744723-2-dingyihan@uniontech.com>

On Fri, Mar 06, 2026 at 10:16:50AM +0800, Yihan Ding wrote:
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
> We use down_write_trylock() and restart the syscall if the lock
> cannot be acquired immediately. This ensures that if a thread fails
> to get the lock, it will return to userspace, allowing it to process
> any pending TSYNC task_works from the lock holder, and then
> transparently restart the syscall.
> 
> Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> Reported-by: Justin Suess <utilityemal77@gmail.com>
> Closes: https://lore.kernel.org/all/aacKOr1wywSSOAVv@suesslenovo/
> Suggested-by: Günther Noack <gnoack3000@gmail.com>
> Suggested-by: Tingmao Wang <m@maowtm.org>
> Tested-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> ---
> Changes in v5:
> - Just simple formatting changes, no code changes.
> 
> Changes in v4:
> - Use restart_syscall() instead of returning -ERESTARTNOINTR.
>   This ensures the syscall is properly restarted without leaking the
>   internal error code to userspace, fixing a test failure in
>   tsync_test.competing_enablement. (Caught by Justin Suess, suggested
>   by Tingmao Wang).
> 
> Changes in v3:
> - Replaced down_write_killable() with down_write_trylock() and
>   returned -ERESTARTNOINTR to avoid a secondary deadlock caused by
>   blocking the execution of task_works. (Caught by Günther Noack).
> 
> ---
>  security/landlock/tsync.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index de01aa899751..1f460b9ec833 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -446,6 +446,15 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	shared_ctx.old_cred = old_cred;
>  	shared_ctx.new_cred = new_cred;
>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
> +	/*
> +	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> +	 * multiple threads call landlock_restrict_self() simultaneously.
> +	 * If the lock is already held, we gracefully yield by restarting the
> +	 * syscall. This allows the current thread to process pending
> +	 * task_works before retrying.
> +	 */
> +	if (!down_write_trylock(&current->signal->exec_update_lock))
> +		return restart_syscall();
>  
>  	/*
>  	 * We schedule a pseudo-signal task_work for each of the calling task's
> @@ -556,6 +565,6 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  		wait_for_completion(&shared_ctx.all_finished);
>  
>  	tsync_works_release(&works);
> -
> +	up_write(&current->signal->exec_update_lock);
>  	return atomic_read(&shared_ctx.preparation_error);
>  }
> -- 
> 2.20.1
> 

Thank you!

Tested-by: Günther Noack <gnoack3000@gmail.com>
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
