Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2F394EBD
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jun 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560615; cv=none; b=irFgyfmMgnUJVGuhmUHbOyjOPPFfI68hieAwNKahB+PfbLrW1diS8ZTANdCUfwrW7TaViqigWjajPzqnpJCwQulHpkm6rpGT9kCp+VRkMW+EY6zcsKwvjX68wWYPB2sbu4+jSNBIQD1nGKljQ+j5LqKEj6mBvxzs+w+/D0h8ybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560615; c=relaxed/simple;
	bh=BWS9lbjUH6cG29qY7vMpjrBlZckUblhveEHZbaq0COY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvjfq7h6bW42c5+q9tBRAcOpzr/Ifp9ubKPlrKgI7PnGNY9k7884hgHBgV44SAwpUEUm8QzXcL6lpY70mYXE4NgtCsNoVmtE6EqTfJ1hGKgqoahQmWhfHfAdVq6pbQxVwAT+A4cZQJnCZT6b+V+qi7+ozkf3OxhHsZaIMr6sRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq/5j4Ig; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq/5j4Ig"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49068493267so3216215e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jun 2026 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560613; x=1781165413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gt3j5PWgV+/Y+B0YLTlGpMfo+JURr3GkvDSyfJsnJxc=;
        b=dq/5j4Igc13UeXh4MiOxuIv6HJ/QNxG92MQVg8gyB/P8pM5ZFcf9T4aqV2H2EVw8Pv
         qyjpZByKaUOVlgec+Jp/KhxvW1x2BhZq47Xm73CWNG9EzPMzOpekSdBeqZaepqWq9mcc
         TF0gUsSEnYGvc1O990RwVuG8jc5uCiIxy5dZi/3TathHmJdazvu536wP46FOv6CURDeC
         7Ugo9hXGsk3aAA7MhaAAb1IUoCe5G3IuYKkb/eE8HMlHczjbiaY3DCGW2ZQ7RmBig4ui
         SjQpGOTmDvkn1IoRlrI1gdfBgdY2f1xR52z7s0/oIrxH/vIsEuAqiIc6alkMS0ULpgV1
         k3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560613; x=1781165413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt3j5PWgV+/Y+B0YLTlGpMfo+JURr3GkvDSyfJsnJxc=;
        b=VP+OUWCCD/cA4N/y/svvyO+Oc2SvftOiD2qNnvHO7WX+nRcv6esJuV6PMJNjReMR9r
         25YxcfMlCq4ZMXEAc8Sz550ryG9DA9pEMKxpeI5ZmdVFXdsk07+DFoHTai3FaONwW4t8
         oUcnMEsUZZmkov1hkf97EefkojxNMfquicHzmqLIEOg9JLzrU2N+ywQyYM8fW2dLC/0E
         WGYaJtLQ83Cqljcga0OWZbYvMMb8gZzhVuTONHBEGbV3T0ZKCPV4robqxiKoVbLyQ1Zk
         FqYJ4EsyMEXJj/ONuLInT8Z5V98E53iKuf8gbnKTsMS8r5C9kt2zB4sHviuqvFsn9voX
         s7dw==
X-Forwarded-Encrypted: i=1; AFNElJ9rJKY/FjkQvKIiM4xZYk1epVDByGht44XjcjO8Eqndkw2m/6WmF4UXtIauKuTU9gp+3RP6oY1Qs+DYEeG9r6U1+Xqwth0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKljoCD+i0ydRug1SA2bMsjUL1uvG+YFMJOl6qgEYN8k6/lFD
	mgN0hsBw7cITwy3CN4UMr5pnqUj9yZawjf+3Css8595SYfhjVUMCShtG
X-Gm-Gg: Acq92OFHZ9FAIKdQSxTpCQc3vEE1WdqKdmql+1mxtMLT5vvlqaiVy9LMB3EzfVbIC3L
	0xywW3KHu4Em0akvo563S1vL3nHJ/arCp7dE636sPix9NQkfwAnG1c8H2mLc/00WehEe4E8ZKbi
	oU2XStelWVwe7YJ40i0cd+Su5TQPTq2bRoVp+f50Cwc6mQ1DC9VPPfTekLZg3wqAOjM00jhpAVG
	/eP4yNp3F2U+SnOQpht40MeWBE3xV3I4aIqe+lgi7uoZrFp+qhlTTskTjCaKuos+YT/jTt8qOMe
	3n99qZ4T6+FNARUAOoRwEQ6cIKjPOvy30UoEdpQBzryJteRPlHncaFo7r+6IsHCBBNzaWTmMabm
	LsOS2v8c6icWuNG45gNdCKnfmqMKUe9QhO86rfbXKR483PoLpQUCgp3p8ovCN6IiO70+w4J3YNo
	029qmBIeSFSlm6+r5TY3vxq6MN8Sw8ApEosIDoh6M0+ZZ6XSmOP7jsnrqK66M=
X-Received: by 2002:a05:600c:1392:b0:490:a964:14f8 with SMTP id 5b1f17b1804b1-490b5e94f3cmr108464105e9.8.1780560612480;
        Thu, 04 Jun 2026 01:10:12 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm62600695e9.9.2026.06.04.01.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:10:11 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:10:06 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] landlock: fix LANDLOCK_SCOPE_SIGNAL bypass on the
 SIGIO path
Message-ID: <20260604.f1cb6ce9cd6b@gnoack.org>
References: <7rvmLIHR1Zh8RDF1IY1-SYRHzErgw9gPHq0k98RLYVsmHqAejjxcuJi8V3QaSbW-SnNvY5tfM2Xn_S1dEajKV_f7iyitoPwJgOSTZQ0nytc=@proton.me>
 <20260531.irah0eiM3Chi@digikod.net>
 <20260602172741.18760-1-hexlabsecurity@proton.me>
 <20260602172741.18760-2-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260602172741.18760-2-hexlabsecurity@proton.me>

Hello!

Thanks for the updated patch set!

On Tue, Jun 02, 2026 at 05:27:56PM +0000, Bryam Vargas wrote:
> LANDLOCK_SCOPE_SIGNAL must prevent a sandboxed process from signaling
> processes outside its Landlock domain.  It can be bypassed through the
> asynchronous SIGIO delivery path.
> 
> A sandboxed process that owns any file or socket can arm it with
> fcntl(F_SETOWN, fd, -pgid), fcntl(F_SETSIG, fd, SIGKILL) and O_ASYNC, so
> that an I/O event makes the kernel deliver the chosen signal to the whole
> process group.  As the head of its own process group -- the default right
> after fork() -- that group also holds the non-sandboxed process that
> launched it, e.g. a supervisor or a security monitor.  The sandbox can
> thus kill or repeatedly signal exactly the processes SCOPE_SIGNAL is meant
> to protect from it.
> 
> The scope is enforced in hook_file_send_sigiotask() against the Landlock
> domain recorded at F_SETOWN time, not the live domain of the sender.
> control_current_fowner() decides whether to record that domain and skips
> recording it when the fowner target is in the caller's thread group --
> safe only when the target is a single process sharing the caller's
> credentials (PIDTYPE_PID, PIDTYPE_TGID).  For a process group
> (PIDTYPE_PGID) the target resolves to the caller itself when it is the
> group head, recording is skipped, and hook_file_send_sigiotask() then lets
> the signal fan out to the whole group unchecked.
> 
> Skip the recording only for the single-process target types, so the scope
> is enforced against every group member at delivery time.  The direct
> kill() path (hook_task_kill) already evaluates the live domain and is
> unaffected.

Consider the following scenario:

 - Processes P1 and P2 are in the same process group
 - Threads T2.1 and T2.2 are part of P2.
   - T2.1 is the thread group leader of P2.
   - T2.2 is in a signal-scoped Landlock domain
 - T2.2 registers the SIGIO for the entire PGID
 - Someone writes to the FD, triggering the SIGIO mechanism

What I would expect in this scenario is:

 - T2.1 receives the SIGIO because it is the thread group leader for
   P2.  (SIGIO with PGID only sends to one thread per process)
 - It is OK for it to receive the signal because signals between
   sibling threads should be permitted.
 - No other threads receive SIGIO.

I believe the result after this patch is:

 - No threads receive the SIGIO at all.

This is because we have been setting T2.2's Landlock domain as the
"sending domain" for the hook_file_sigiotask(), and that hook does on
its own not do the "same_thread_group()" check, and the thread group
leader T2.1 is outside of the T2.2's Landlock domain.


To be clear, the patch is still obviously an improvement, given that
it fixes a bypass for the signaling policy; it just seems to block it
slightly too broadly in this corner scenario?

The scenario does not happen *much* in practice, because SIGIO is not
used much, and starting with 7.0, multithreaded processes should
ideally use TSYNC and have their threads all in the exact same
Landlock domain.  (Before TSYNC, this only affected the case where a
process was already(!) multithreaded at the time of Landlock
enforcement.)

I like the simplicity of this fix, but I'm afraid it does not do 100%
the correct thing.  (I have not tried it out though and I'm happy to
stand corrected if my analysis is wrong.)

The fix would be for a very fringe scenario only, where multiple
conditions come together:

- An already multithreaded process enforcing a Landlock policy
- Not using the TSYNC flag for it (since Linux 7.0)
- Using SIGIO
- Using SIGIO with signaling to a full PGID, including the current process
- SIGIO registration happens from a non-thread-leader thread
- That thread is in a signal-scoped Landlock domain

Mickaël, maybe you have some thoughts on the tradeoff?

> 
> Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of the same process")
> Cc: stable@vger.kernel.org
> Tested-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  security/landlock/fs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c1ecfe239032..2ebad70a956d 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1909,6 +1909,15 @@ static bool control_current_fowner(struct fown_struct *const fown)
>  	if (!p)
>  		return true;
>  
> +	/*
> +	 * A process-group fowner fans the signal out to every member at
> +	 * delivery time, so record the domain for any non single-process
> +	 * target -- even when it resolves to current as the group head --
> +	 * and let hook_file_send_sigiotask() check the live scope.
> +	 */
> +	if (fown->pid_type != PIDTYPE_PID && fown->pid_type != PIDTYPE_TGID)
> +		return true;
> +
>  	return !same_thread_group(p, current);
>  }
>  
> -- 
> 2.43.0

Thanks,
–Günther

P.S: The threaded mail is now in the right format.  Remaining nit
     though: By convention, new patchset versions are posted at the
     top (no Reply-To header in the cover letter), and this is what
     many maintainers filter for - it is easier to get maintainers
     attention when sticking to that convention.
