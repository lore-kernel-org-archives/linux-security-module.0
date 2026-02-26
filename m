Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039B385531
	for <linux-security-module@vger.kernel.org>; Thu, 26 Feb 2026 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090620; cv=none; b=ih8TtaM5TzYc7sGNiDmOfzd0TDJuoebACbYZd5nz3i18gZRHnDyU0dcN4b1infrnkDlDpnSFQmnVy+GD7u3P2DChj34E+5/i1jCIklVeO1Iof8oj17yhyPwVHn5Le8bapBpgSSLnQdQT/TBIXGgmu7tUosK4u7jfmJr3LmZ7V/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090620; c=relaxed/simple;
	bh=TlBZnFpvIh38dF8RUFeIpP5uiHDD561lacDSVT+06AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqmGidUthyWgg5B+U67Wz7nHvGvpBd5GmBqyQATE2aJrMd5/2ZP96oyvoHqKouIcFgsaMmMAQd/Tnz1CmWLhV+aJduoE6tLqC2FTutpVf1Hr8VClCgUP4s2YFQUGn5XKCNgYHMZFR1Yytaeo3r3dM7364SsyqDagFovWv+j2V+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJOeKd+I; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJOeKd+I"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4837584120eso3275675e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 25 Feb 2026 23:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772090617; x=1772695417; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7bAWuIclbGkjTG1lyT9k6PZ5UeO0kHHEk0ofPaogQPo=;
        b=cJOeKd+IbPMbtIMs5IVHTQ/8zf6EK89KQVZel+knRULxLiN51FTx4isr3NRqTSd4hN
         Gn8j04pazfQCXaoK0smaDfF7v53Z6vphH+yhDcmKi+GvVB/S6zb6C+gFqrdY5EUQab2B
         P98oXdnSS+JmzY/zKdjlUWtCckMX/d9utvDy6GvpjUPKlabbhB1m3ZsrWRqHnHa86zk6
         Oo+xxyeFeOiUOxtjPe0wXnhpus0EuZO09Phj1mshwtvmrW4zVl3j5NDCsgUH7b534sJU
         kB5kfKeC9T1DjS/jO99b3kkW3mhx6uFcuJgZJBCo9jyw7XL/3+4zh3ZU9me8WNCt2GDz
         XFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772090617; x=1772695417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bAWuIclbGkjTG1lyT9k6PZ5UeO0kHHEk0ofPaogQPo=;
        b=elPIyTOBwmP04G0ELYcXlR2tKkXhWROmtQfl3b/Mb3lM9TqWOxVR21zlM/yaJaAOrl
         xuPPCCb/6snBOTBA+U/X7pCtWSUFjHtRsMx91L6QgBE94CK6U4ymra3ovTkZfbjPF0Fl
         ee8CXoKNVQjT4Hub4QwXMPkdcXtcQAvdx9X1l1mILOJbA2+C0wNcuPqqezMBb0cZszmI
         37V1JOogHkSwViO1LlUAjjUBVAgjNtBs9HhYTEBNYW43yopu1WXsr54Dg6dvBCll+rh4
         tK4ohT1AUzMyt1Yjl6DM+vzD6dIas6rP9B37NG1M0zJSOPyNcB12OMJ3cBteDiZrdkr+
         3E8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUz2ke2VdQmO0FU6QGayUzPDDUmiDB6J35JlNFicOAtBDh5yLHUC5AXZSBERdWjD/8+zLKgvy6pjg4oLP/idvKM5XdZF+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyfVb+a63bDbktHm3vfek40xjm50Ad2kaJMxtrMe3XIjFipGv
	dJie/Qw5CstElJKn2Et097Vsdc+IRvQyPW2v6gswmfhoNmdVlCD00lw7
X-Gm-Gg: ATEYQzxTLcxA4ReUCnzDBJ2rXbOu6YZgUnkhfoRLJ5QYTLX5aFHNF8jZQE3TSwbCT5n
	yYiN3kIBvhFUKVUoqL94PeZ3lv5T0SSv8rOkwakNwvOx7wsm3WJ7yvQYDXEJDdXFAVhP9pKz3Gv
	1T+ExnGj2I0BsrybOIVnl1r9DfCkK2iUQQoHVp+M9/Xub9wg+qOtn5MY5SYHbLET+NbpAm0jp5O
	Rov4UVzED4FD1fQHJi9q9432+QT9s+uZGoYue+K+CZAl2CvYKP4A8FoUsNU+G2+sABMjU1dU+cD
	bC/eTJlK+4/oxIVE9yP34wvpu1CIbl1ZqyDgmmgY5hInoLamVqqhordw5N38WfMwqSp5FmsMaK6
	rSVy5D61zQqW0iFwWEdDJ+L0pCYFhf4Lgbrh0E5rAN8cS0arsh3Tw2fCQbrltvjgW5mxSm0CCmW
	54ZpXIkMuZP/9Kr6qgkcF75bE53gtp4QQn0hD0khA2t3swFvXf
X-Received: by 2002:a05:600c:198b:b0:483:9cdc:8ac1 with SMTP id 5b1f17b1804b1-483c216fa22mr46355745e9.11.1772090616640;
        Wed, 25 Feb 2026 23:23:36 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c35910f1sm26165275e9.2.2026.02.25.23.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:23:36 -0800 (PST)
Date: Thu, 26 Feb 2026 08:23:24 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <20260226.e93d63ac9547@gnoack.org>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226015903.3158620-2-dingyihan@uniontech.com>

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

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
