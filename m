Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9F310636
	for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021257; cv=none; b=Iu0ailr6nJn3+/bSmWty502EAlkzNxVXcHW/2dahuw0f8GDNpkJwFPn4vXo7bXfUGzGT6jCzj3XziVtck4HKMDLnrOwsVrQlN1cT1OqUmyi56QY1223YLrAAu0EOrkDvs9Afced3PgOxSCPx3/Ez4tgv0w3VLf+wP+XVMPvW6IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021257; c=relaxed/simple;
	bh=k5AyMm38axpCnNUZMKhOaaUCpu5/4L5dhb8UvkyUQsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN5X6UMtyj2hghMws/oVjSkx/LQXsO+LVhplna/qdXdH+4L9Pbfa4sSp8Givd+XUhWgtehha5jlk55dsjlU38UdA/fcWDSvoJVKpXK6pkX9BEFfx5771rCHsYphrJzvHj5PYiiUO5oTA8hi3m0dwg6yIwVLLSrhJ7V9WLSsn8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvwIjWAi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvwIjWAi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48371bb515eso82931125e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 04:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772021254; x=1772626054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hP3eP7lQUeBanoY3mNDaFgqzxq5QqafounHzIr8KfRU=;
        b=VvwIjWAiTv8QN//0TIgBWS46JzOL8IVPamvbbeRD6S6TvQsU7bM3m2OB6Q/igWxqxM
         1C/gLxJX8OyFxNDzgvNnNnSzbVYf8JhVeOZhnZ03ecaXY6P37wyJbK5XwYpwL7POM1yi
         TflbFZqU9hrj9zhHLLH9v47uT8BVR4J2DsMB5cyqMOGqapLQPnkDtrgxVCW6raDITXPI
         jRyNcJ2h7UzX+djG9JmGOwVFnAh58Ag3dDYkFj2crSpvQWLP4MGWvziGT7Mw9jxYXTfz
         k/EwAXB/5W7itgVOgc8tK89k4XekKeiZBzLZPwKPtj333AwSCtr91bNdGtS7Aym92vmW
         YUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021254; x=1772626054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hP3eP7lQUeBanoY3mNDaFgqzxq5QqafounHzIr8KfRU=;
        b=TutaUbEWfaBijw1gSjtQt1139wrJGcyGp9IcghksDdBN6VOjzKEcCJjVH+Fy5EnGzs
         4J4Ivdmu4Fxo2iKuEIkwGmQ73QQ2b4J//mwjIhakc+3HcquXUDqoXVs1b/RDwrz8Kazr
         6PHLO4LeWnqM6BpdXF3vkrth+baG4O1KICpR3Ttxv2qfXGtP2NYtr1qkcmJYDI+op7Wj
         9ynHzd/GcIS5sZc7so3/6xx/4eU6wa0kOk/7ychPOHVbLdzLejngaaLlrDxQYxt0QggA
         R663pAGi7B9bXikAgU3ANXol8ToGME/f0ur6oIs/iveMarT2PtxptkO+R5NMDimuXx1D
         nWAg==
X-Forwarded-Encrypted: i=1; AJvYcCV/HSdMhyxUznAntOcoOlTlamCg2zuZt9P8OxtE8wlRfJrEU/giNUlOq6OKV5q2MiOe5W1LsNcnfAA8WJzz0miDz3lD6OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymN9X8yhQXjmyo/NT7HMNtgSHncpnrN2g07spdtY7RYn61xGdh
	agK1N00fAEcSpTh+KGYvRRpR9ociEMxkOZ6sD9BfvmvNSSO6P4hTgAUfSM8p3CJYnQ==
X-Gm-Gg: ATEYQzxd8iypyGdOmDcDddSGe+YUqkM5AbZ90fksPSDhkOCm1lNpSQ3wchTXNl/5E2H
	AEgLy8SaBRCnQzOlGnEEe/YjUH/Qq2qwi0Jsbn7YYTZe2/dfMo6jFdNCUshxRsxBAORma7meZBP
	4t0OARvPyhugyftBqBxQLAB6ZowtpY1EO+u8SreYKDAmICG9ON63hm0aUyTAOXzsZ5XJfVb6twJ
	OcvlrstvyUOlW73JHFzl5jJDHZrE3J7ikp/Aafij6LuOPhEyJ6q6uoenZi1I+IpBg8KzCUcwR+V
	L9kOBuqtYnQ5HjapBDGQka1hIzsyjhMrGbl5jIoQeWFH59ep3VPVynBQ2CXnkUlWxGWQRz7NuXk
	lMfI24PpGVMUkwOwjzV3jbWDzN3L4CBCq7mbM1ESxfgWYaCNCikIvpsaUBzH43774MXBehXp0Z2
	WPGODoRjEd+OBIBSTRgRsx6u15o+LHDznmcfKNwhiDv+YVWYPwqIhkGw==
X-Received: by 2002:a05:600c:64ce:b0:483:498f:7953 with SMTP id 5b1f17b1804b1-483a9637a6cmr239087565e9.28.1772021253116;
        Wed, 25 Feb 2026 04:07:33 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:dd44:5fa0:1b9a:d7c9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7141e4sm70330895e9.7.2026.02.25.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:07:32 -0800 (PST)
Date: Wed, 25 Feb 2026 13:07:26 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <aZ7l6jU7XJ1BYbN-@google.com>
References: <20260225024734.3024732-1-dingyihan@uniontech.com>
 <20260225024734.3024732-2-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225024734.3024732-2-dingyihan@uniontech.com>

On Wed, Feb 25, 2026 at 10:47:33AM +0800, Yihan Ding wrote:
> syzbot found a deadlock in landlock_restrict_sibling_threads().
> When multiple threads concurrently call landlock_restrict_self() with
> sibling thread restriction enabled, they can deadlock by mutually
> queueing task_works on each other and then blocking in kernel space
> (waiting for the other to finish).
> 
> Fix this by serializing the TSYNC operations within the same process
> using the exec_update_lock. This prevents concurrent invocations
> from deadlocking. We use down_write_killable() to ensure the thread
> remains responsive to fatal signals while waiting for the lock.
> 
> Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> Suggested-by: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> ---
>  security/landlock/tsync.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index de01aa899751..420fcfc2fe9a 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	shared_ctx.new_cred = new_cred;
>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
>  
> +	/*
> +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> +	 * when multiple threads call landlock_restrict_self() simultaneously.
> +	 */
> +	if (down_write_killable(&current->signal->exec_update_lock))
> +		return -EINTR;
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

Thank you!

Reviewed-by: Günther Noack <gnoack@google.com>
