Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928C344DB9
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633720; cv=none; b=oHpRlYiow3w4wcS020w+52rINlyl9iiEbR5QXjFXZCjp+KX+8LjlQOiVw8DimU/8uJjLAsVxipDtiyiWJfKf7/LUR5FKIAfszzpiilx3fYuJOrZ3nx0HPfabJ5KRALt7aSoogS410taPO8/56RVPur7RvprrN/6nDqep4zD669I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633720; c=relaxed/simple;
	bh=OdLVa3xOpP9TJjOlwk6xaFHmCWB/RN80pngEb2GO6Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG4ZTLkBxe41AT/CpQSpmtkwlRVCBrtsZsltKlKkLMI3S4AXdtE78DkHN5UQaUbrgTJsJg8rXe3nR0aPfwfN9crF0W8KERN8v6HvrpYt+yG9xxbU0LnOUhg5XgOoSEgkJk9WagtMQOuj6yQIgBXcL6AqG4JAODTeKMwOVDakAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ordtj6qy; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ordtj6qy"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79800183233so95066617b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2026 06:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633718; x=1773238518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dcZIcC0m/aXx+Svt6VWiBt7amqyIbeOvrp+VlYL4ncU=;
        b=Ordtj6qyINGdOu0txzGT9S7bNz8k6hh6g1kjl/MQ7b/04ypL3isc07cLuyPbuj++As
         aEE5vPlepizMmTkXSdxCnUzPkGn1D+GdPfXy4NcudqbKX26okHapQdKcOUFEOuQuMajq
         kTruOwZuzy+wrL2KGVEBQ/XoiDHLTYZHTlBmXSy+TIhZ7GLveKv5XY1fcodJxdb1tnD5
         Mly5nUag6QhpE2yEa2H+mRT1qAbVOGNBuK17TpcCqAldtH7kq8xwPUpkJvsmahYZvHzh
         Pqrj8yD/+Esiqi2jIyX3B5RWZcv2Yx9j1UIHNJnEjPwiAwkSrF2uGvqca2Ge6ZYrl9qJ
         P1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633718; x=1773238518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcZIcC0m/aXx+Svt6VWiBt7amqyIbeOvrp+VlYL4ncU=;
        b=o8bEyc2++YzBLl0GabVaHN61RXyq60FPnnNQK8Uxv+lGAfSR63g268TcmE3bn/BxWu
         ZDpLbUyIsV1LmRInE7oa6dK3mRq+4y3SYoUFzN5B1asuT9t2VbjA1jl4kh5W1h/NhbpR
         R6XjTipKrRuV8lecMhRthdC0j8EzQERBKRGFsAcq9Ab/rxbBNAlZiSs0+1kuHmmse1HT
         WPO8Kii5VuZlx3/dq+sqrgVEjivGEdIRfMVt/KfP9yUiygUtKGeOUQklDEPA8/yHpt1S
         nW5Au+BwDD8WxVvv/wypWwVdm8E7u9gyX8IMNR99lGia9wbjOoM1ZeWG6CCUdqm3VAcJ
         +YrA==
X-Forwarded-Encrypted: i=1; AJvYcCWqrtwRvcj0TKvuGqXHYM1dZW6Pz+COyiQeUUA6SrruL3lPQ9vpkjhhgWcS+Pb0Y85DKs1Dxh5p0aiguZpL6d+LATRL7GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZz0FXTbqNvQMm+DLNfSP1tm9+gELenxrOZakbIFjidydaA+g
	z5v7Ra+cQ0IWMllioh/C2v0LAXlfgZ5eXnyFZIyZedM0ymcOqBjM8LUl
X-Gm-Gg: ATEYQzzfTFdxoJtJARKgo+0cPxbANZpj7YW6nyCJp9c9vN6zmrUAXpk9T2RtKLAcbQs
	gvjX0NSKHss+/LekpImIcZsAaruF996iSo7ifrJnAgdWZQvaL5sdOm6fZOv5dWjRIniTwKMw+Zv
	fAy/c2mDCuKjIY2Vzf3vC9spsAkqEnl6suCw6QAIu92pP317ql0XuMqGTNLdsJGRah9cjbm5zxa
	KA2PADoMu6sJIrt/eu1BiXBV0Np0V7fsWwbOPw9cuyihgmphdzbI/yi7bIHJy7RGrXyEo1oj27L
	GrYyiwQVQwTJpUswo2qbNgdMJUDqks+7yvBjhK+kwFI2YWaOeemLrHfivn+WC8wnC4n2dANUb1N
	dXiVRGm7p6glhZ2NH0dL2Crl8Ztt1gtsPfn3OGMwyHu/f0F1UmZGNNmMM1nu0o8psV3PFwOfrIX
	8WECbAwtokqu11tr9+uj7z20FEDFXYHQ==
X-Received: by 2002:a05:690c:9a90:b0:794:c283:5fb8 with SMTP id 00721157ae682-798bb44f72cmr39531407b3.25.1772633717884;
        Wed, 04 Mar 2026 06:15:17 -0800 (PST)
Received: from suesslenovo ([129.222.254.128])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876c860d5sm74414357b3.46.2026.03.04.06.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:15:17 -0800 (PST)
Date: Wed, 4 Mar 2026 09:15:15 -0500
From: Justin Suess <utilityemal77@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: gnoack3000@gmail.com, jannh@google.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	mic@digikod.net, paul@paul-moore.com,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <aag-c-jzYJk0ETr7@suesslenovo>
References: <20260304095418.465594-1-dingyihan@uniontech.com>
 <20260304095418.465594-2-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304095418.465594-2-dingyihan@uniontech.com>

On Wed, Mar 04, 2026 at 05:54:17PM +0800, Yihan Ding wrote:
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
> +		/*
> +		 * Serialize concurrent TSYNC operations to prevent deadlocks when
> +		 * multiple threads call landlock_restrict_self() simultaneously.
> +		 * If the lock is already held, we gracefully yield by restarting the
> +		 * syscall. This allows the current thread to process pending
> +		 * task_works before retrying.
> +		 */
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

Tested-by: Justin Suess <utilityemal77@gmail.com>
