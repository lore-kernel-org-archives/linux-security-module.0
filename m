Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294623D1CD4
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772651142; cv=none; b=rMjfcnNp2kdl4FJEzcFqnTPOVfQ6Z9xQUZzsX2LcgR1brGenzJ1iJ2zY2vZxgWVqrrvibwk80wg0Y+raALk9v8mf69WkfQXyia8hry7P2m1ut5bh02dSbMqKR9AJbZ5RzPjXAev7heysMrIvVwQNLZTt8tGKjWNojDy542kq0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772651142; c=relaxed/simple;
	bh=EnYhy+TuuyxL6bTrDS8XAlmj5oIe9epdawpeCPxdN9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXmySt4KGIg5tzw6UFr+DlMxU5vjjmicyU+A5QjD/klT9PLUuJMbttvFv7rmx5zdKGdbvtxDn6udo/Bn3u3hCf+KZPKtMKdz58W8TcmKg2LKqqwEgQiq9/n0pWWKKXl3DAuZLrLLOqhK4N8HjP0iui0rucnPdUXNUFVi+1uknAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5/Lvngr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5/Lvngr"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a27d39067so28045191fa.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2026 11:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772651139; x=1773255939; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3jFUpHh9piiC4hG9dP2zuQYvuYEb2t/t97Zqgys+0B0=;
        b=f5/LvngrRyRbKHVFBoBAt+WBfSKNe0z5zYIVUcEubTFc8jLW4K1P0SXyNBVEBzjtBR
         iUv/m9KEHxe9Xc92FzYBvL0Ts4Rq3+dUp+j4wbYu3aWHH7b/Lis4VkKVBrrI9Cqnh8nB
         sIilM48NEcjh0Mq9XdFQMwubauRCfSs8pwLbrVlN6Az+RrB2AC3Q7ToPNdkJhpjrk+z8
         GXdRejqwvugIj0bFYd4NY+bmlGia0QGzIruouGEDnTj16W3kYQK7hnx7ObNsLAKMvr4t
         UxADrLv1k0ud2L4xoyd7Wyd4nEw/62TEeJEJLO03rOyvUjLQadbD9rDMcQ1qQQfz4sDQ
         9D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772651139; x=1773255939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jFUpHh9piiC4hG9dP2zuQYvuYEb2t/t97Zqgys+0B0=;
        b=ZJIw49MbAzP7mQq73ApwlH/j2PZW86wmZCO7d3N2MoQ4FS1SVuASLzZ86YZEDI4zJF
         oNPaGY8ow5pNaVfbD3PWm7LkQNpstVuDa2eZ8Id90ofJNrnYPyAMia0rU9cqzHGFGCHi
         oSigK+fFn5igfZppC9KN4lDNwKM5+101aicCGpi0vIpKxOak2k6oamGJU8PL2JWzrztD
         4nJjL6AP5BlFxioqHs1Z7IQVKc0q0YQ502HyQ8VUeBfQ9uLr11l1Ajg7zfXcPy2IoLk9
         zl80mwE4OpJ1mqxmy3+65knvjg3pmbTwVCnWJegcryjL+s2oZZijFNdig9VWs7tiGwQ+
         wvCA==
X-Forwarded-Encrypted: i=1; AJvYcCVmwIwWLZevRyFnijvFk56LHY92lUvpnW97kV4Gk3HJ46rCNeoIvuxn2oGzkVARo7z6Rf8onNLdq9TTP7E1uJcq40vJFgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PHOaCNOLivQTI6IqLb+T1IIfHVTY/0jZiP15387CYzWiUHOm
	1omxCK8Bs58Lw5Ded7lEzZqjOmf6reEUwNT9d1cFqdHM1m9b0CmJjepX
X-Gm-Gg: ATEYQzxzAhacTqOsoGa7yzjebaNxLX2p/2VZspgGBoKhNouNtH5uXoHfKWhzuf4aMWx
	cVizNU7I1mi2mETAPneRuieqY+Rc5eNXNMBZ60+e4cMN7qR1VsKppa3CxiKUhqX5B4q2GO6Z0q9
	MBgONA1iJ7H4N0E15iGeQdbkxkMSu3nOiJl7hzZbqOAW8ppYlMQJcOUMYamPViOaxjy4r8oXN+v
	X1EvZj8wLAtW+l3npul4WSZ+EGtCEnpqGNCGiBmzcx6nOa1Y+FDuhfrEtj/IWvSyydkCxo3VrPm
	ErjMF6o5+g9wsDQ33I2EZXneDkwnj2QLr+wY9Ub6j3pbdVOKR+2jZe1KyJFcCerH7bi2l0EiSH4
	C9IcFx1RImiqRzgrJhU0bf6s//BVh3aNkVowWCqRoMrpgHjXGa2MACR2hyWvocggqEH6NcdBgMt
	1CXk3JXHXhs/KMJuiQZ419URNQcslLiMa7ONj36i+zo9Z2TGu8
X-Received: by 2002:a2e:91c2:0:b0:38a:30c0:1cd with SMTP id 38308e7fff4ca-38a30c004e4mr11607791fa.7.1772651139047;
        Wed, 04 Mar 2026 11:05:39 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a123585025sm1429702e87.11.2026.03.04.11.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:05:38 -0800 (PST)
Date: Wed, 4 Mar 2026 20:05:33 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: jannh@google.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	mic@digikod.net, paul@paul-moore.com,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com,
	utilityemal77@gmail.com
Subject: Re: [PATCH v4 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <20260304.8cc838dcc68c@gnoack.org>
References: <20260304095418.465594-1-dingyihan@uniontech.com>
 <20260304095418.465594-2-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304095418.465594-2-dingyihan@uniontech.com>

Hello!

Thank you for the revised patch.  I tested this and it passes the
selftests now.

I noticed that the comment is unfortunately wrongly indented, which is
also caught by clang-format (see below); we should fix that before
submit; I remarked on another two less important nits in the commit
message as well.

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
                                  ^^^^^^^^^^^^^^^^^^^^^^

Nit: Maybe it would be better to write "restart the syscall" now,
as we are not just returning -ERESTARTNOINTR here any more.

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

FYI This would be a good place to add a Reported-by: Justin and
Suggested-by: Tingmao as well.


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
^^^^^^^^^^^^^^^^
This comment should be indented with one tab, not with two, the same
as the code that follows it.

The comment text is good.

Remark on the side, the Landlock code is formatted with clang-format;
I have a small tool that runs it for me on these files:

  clang-format -i \
      security/landlock/*.[ch] \
      include/uapi/linux/landlock.h \
      tools/testing/selftests/landlock/*.[ch]

clang-format does not fix the indentation perfectly here either, but
it discovers the issue and reindents at least the first line.

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

These remarks are all in comments and documentation though; the code
looks good to me and the selftests work!  Thank you for looking into it!

–Günther
