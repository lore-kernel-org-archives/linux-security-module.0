Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8D368274
	for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922895; cv=none; b=SPT2l6l6kzko5/rz/e5EptP5RVejF1uqXTGZN0zBNb8z8o//Lu0Fbbj6+I50tRI4xFP7hyA5fywYAoRoyrofIySRW13VUx06YH+uuPgVWLwFZIcI9Yu+w6uWPm5H/fs8ONIwLNvpeqwKNq6M44V9E9/JT1d1jbuCFvBpS1NUwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922895; c=relaxed/simple;
	bh=tmdcMFy2Tcq00WsY4kH2FLoVQfXCbswk6h1DNAiZGzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK6sSuoW4c03E7ZInAb5Nc+rVngRzc/tI7sKj19UDISHEXCaL7bvHHsx845c08I65NsjFIHRiza/pULZN+EGzkjL0Pcp26aLQ02xN/1SSk+XwYvUC2dW2w6vgR9e9e+86v8BNqEDIAfwutHXi85TmHVvugx7h1wrBmGBgmBbrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVoUWYkQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVoUWYkQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso44920405e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 00:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771922892; x=1772527692; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KY5ZU4BUIJvQfJTP6W63cIfAdt+Ibsp8oBpmIRSvuWw=;
        b=EVoUWYkQBHI880YvKAtl2ZaTszwjO4zsilwcvtbABmK/7NMw4sq2/5R13ZF0DxRJml
         9DblQehmHe9v6GXVcSxfbTv1TgU4m602Qs477Xils+peB+ZZqY2kLR+kZ9XGHhgWXeHN
         zcl9v0GcBDAmVonlklIYAKO+ezPbOeXHVZ49ONhht/ApOI49Yu9XsWE9dZA0jVwfEQpA
         gjtRiN11MWRnHPCZo4FP556hJpII5CWNMP4zklIC55bM/kU9e38myXBgoF5T9UoIRjFs
         HoisI8u3w/NMFY+blHrXbTUa8pB27PkY6lEa5YI+FWXBDCp3UCn9nVicdkMo2hs74xo6
         5qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771922892; x=1772527692;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KY5ZU4BUIJvQfJTP6W63cIfAdt+Ibsp8oBpmIRSvuWw=;
        b=gWU2ewyIiLvTcbQcerEdje8hP3i2/V1zPQKnTACBrP9Uga03n633toe6Aa+9wECHGG
         VFG0WE+kFQxbx/BpCldPuuReEW1fuR64MeVa9wD9Tg5Vd9zS9eM1PdObw65aa2Wr7Ak9
         XteUsa7j0gVz6M7h+WHnCusrBpqG6YgwrFj66UnijcjIus/UbntfaeBfDqO0TZGnMdbE
         zFjKDYtZgDm4EonbzP7vq8ioEvhM9rpAoT4qMihTkY+1My4b+f31J8H83+QlHiGUxBGF
         R+r8RxU0Wdc6OL52gYNTZfh7c1amxbdQp7gaETiVRNvuY1GY3CSI5TOv8wQ3tCFBwEEB
         YrrA==
X-Forwarded-Encrypted: i=1; AJvYcCUNccft2Y0kdc+4eHNgIOmFfJhX07rZH57objZ77KIQvrc76UMOV3T77OnWUwbWY+3u5mZR/omxRcwa5RDMrZKxUpgJ32o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qZ82+2IckeTOj8j4dkHH95l7EXEekY/e6muLh+6WbQC4LgRf
	9Gzg2AIAlRfGel7Wvs5uRdSzDuzHI9EwDzxffnOMBLERT4aDA024Z9wJ
X-Gm-Gg: AZuq6aK8TWDJxqxtzfM4l/erivdbZc4Vm0OafUoKK1vU5XFKLNzJa8PbWW1Lyk6oRwz
	qMq8Ve04pvaIsI3SNVV/MlM1/3Om+dClhEwurn/T57UOfMLC00uIbcOcuM7T3hsfKeORbtbUHgK
	1P+LFisF2oKoi+ItNNeAvTJMP6UWEdmw0umZ7qaleHowr3uI6EFZcmvUO9NOYfuL5pPgww6Vmg+
	Wvhb0RRgk5FcHyYQ5XvieogFC8OfSNVOv/7Vij2ca9NMvb+2kkhSowCq/dbJDs+meMSpJ0oc9q7
	k4MBCWMMsd7IlP90H/BO6n1RsSkivmJ1iD2b+Zw1bdyqYq+L+LO8AHbNSAabE87rFrGxNF6Lium
	oAupAC7Gji+oPDvbOL4oWVQiMGxCANEAaSUwokTX9fmo8pUXjsfGe2bnQK4S0i2MDO4t7jmBlWk
	l1TrIZD63uC6lI0yzRGsZzB6MWLl9IJjsX45TjWbxEY73GRvkE
X-Received: by 2002:a05:600c:3d87:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-483a9635c34mr161283275e9.28.1771922891426;
        Tue, 24 Feb 2026 00:48:11 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8195f50sm21851215e9.0.2026.02.24.00.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 00:48:11 -0800 (PST)
Date: Tue, 24 Feb 2026 09:48:06 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH] landlock: Fix deadlock in restrict_one_thread_callback
Message-ID: <20260224.7f9a753fc788@gnoack.org>
References: <20260223.52c45aed20f8@gnoack.org>
 <20260224062729.2908692-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224062729.2908692-1-dingyihan@uniontech.com>

Hello!

Thanks for sending the patch!

On Tue, Feb 24, 2026 at 02:27:29PM +0800, Yihan Ding wrote:
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
> Additionally, update the comments in the interrupt recovery path to
> clarify that cancel_tsync_works() is an opportunistic cleanup, and
> waiting for completion is strictly necessary to prevent a Use-After-Free
> of the stack-allocated shared_ctx.
> 
> Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> ---
>  security/landlock/tsync.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index de01aa899751..4e91af271f3b 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -447,6 +447,12 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	shared_ctx.new_cred = new_cred;
>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
>  
> +	/*
> +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> +	 * when multiple threads call landlock_restrict_self() simultaneously.
> +	 */
> +	down_write(&current->signal->exec_update_lock);

Should we use the *_killable variant of this lock acquisition?


>  	/*
>  	 * We schedule a pseudo-signal task_work for each of the calling task's
>  	 * sibling threads.  In the task work, each thread:
> @@ -527,14 +533,17 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  					   -ERESTARTNOINTR);
>  
>  				/*
> -				 * Cancel task works for tasks that did not start running yet,
> -				 * and decrement all_prepared and num_unfinished accordingly.
> +				 * Opportunistic improvement: try to cancel task works
> +				 * for tasks that did not start running yet. We do not
> +				 * have a guarantee that it cancels any of the enqueued
> +				 * task works (because task_work_run() might already have
> +				 * dequeued them).
>  				 */
>  				cancel_tsync_works(&works, &shared_ctx);
>  
>  				/*
> -				 * The remaining task works have started running, so waiting for
> -				 * their completion will finish.
> +				 * We must wait for the remaining task works to finish to
> +				 * prevent a use-after-free of the local shared_ctx.
>  				 */
>  				wait_for_completion(&shared_ctx.all_prepared);

I do not think that we must wait for all_prepared here, as your
updated comment says: The landlock_restrict_sibling_threads() function
still waits for all of these task works to finish at the bottom where
it waits for "all_finished", so there is no UAF on the local shared
context?

I would recommend replacing the
wait_for_completion(&shared_ctx.all_prepared) call and its comment
with an explicit "break":

/*
 * Break the loop with error.  The cleanup code after the loop
 * unblocks the remaining task_works.
 */
break;

Please also update the comment above the complete_all(ready_to_commit):

  We now have either (a) all sibling threads blocking and in
  "prepared" state in the task work, or (b) the preparation error is
  set.  Ask all threads to commit (or abort).

Then it is a bit more explicit about the error handling variant of this.


(FYI, I have tested the patch variant where I only removed the
wait_for_completion(all_prepared) call, and where I did *not* add the
additional lock at the top.  In this configuration, I was unable to
get it to hang any more, even with added mdelays.  But as discussed in
section 2.2 of [1], there are still difficult to reproduce scenarios
where this can theoretically fail, and it is better to use the lock at
the top.)

[1] https://lore.kernel.org/all/20260223.52c45aed20f8@gnoack.org/

Please also feel free to split up the change into a part that adds the
exec_guard_lock and a part that changes the path where the calling
thread gets interrupted.  Strictly speaking, the part where we change
the interruption logic is only a nicety once we have the
exec_guard_lock in place.

>  			}
> @@ -557,5 +566,7 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  
>  	tsync_works_release(&works);
>  
> +	up_write(&current->signal->exec_update_lock);
> +
>  	return atomic_read(&shared_ctx.preparation_error);
>  }
> -- 
> 2.51.0
> 

Thanks,
–Günther
