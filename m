Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061115;
	b=mu+5JzarT8RpICDzHeS5UQGHFD3BN4BY1bTcElVhmh3JlbuCILv9t4v/4HAisCXxhAJY
	 77oWXSG8P6JopjDGE/DGVG4sQsIjpTc9Cl7XJQzeDfMjhJLuUfyj+TmxpsQz9FqQa5bQp
	 9ysm5kS+FDgK8wRfk6qf73LTDLaC4ETXYE1E8Lf2DS0heINmKjXSKydvXuV3yJK/+QqMF
	 DPIdaomHdGwHDjLmycROFRKS+D5wFK7FsaPgufketUr/GW4c2GXu1QGbZxJzePHIgBy2N
	 Fkl9mHq6fchjD5D0foLIPhXrTyffFfFX71jR41EAa4HgrGTJjDooyX2fDmg6P3qZRyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=KN+qoRD2iK79ZmjSJFmf4z8oGz3kbjrueefoy5xGOR4=;
	b=1xA3PR8Mv4LlnTNAsx2583i5v2fuisJUq4l9KKH2YtY8a/bkbY35jEQmOlUFrFtiJtb9
	 EJWhgXlSuwGp2Ov2r1APaNa3O7kTAsxyeDOq6vpmU8HC7kWc8lexSbW7VUU/URDIr8xhZ
	 Z0JxrBNkw8zs9Bf3HKFgmIgemtb4AI7QQsI2KRZUDjcKwy6cTXc3ozltzVC4T4S/1mKZ0
	 dNrbHsk3yvzjYE4rSB2jOQ3QR2eYDbdjL1nKMi6/ib4k5VpsK3c3DpKfML/BmTxSAMqHD
	 q7a0e9BQzIaOxWLJZso3aW9XvLHWz/yCt134zhIbmKxxpyuCKm149LjV+hjP8vxpGRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+PKwRhx;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE635606EE84
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 14:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE635606EE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F+PKwRhx
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso289585f8f.1
        for <linux-security-module@vger.kernel.org>; Sat, 07 Nov 2026 06:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061113; x=1794665913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KN+qoRD2iK79ZmjSJFmf4z8oGz3kbjrueefoy5xGOR4=;
        b=F+PKwRhxrS37tDpFVJF9wVen2ys6lRYtQxqIo/yzBU1NBddhcdQRyoNVCNiJpLy/0t
         kO7hVIcrmDr1X+PezosRQ8uB4zx/NLYmVvVfmrIHUV/CeF4b0LW3U8kCXd5hw1JaUeSY
         teR4ru7Qps2A8wBz4V1PYF12AUvPxH+Li5vzol5G7VIlGKUvUEga1oFQJ38uP4ihd1oE
         5ddKXMBSum1wgsN7GTHNc2nl/jIqjvpzh98miiJmtKNRvZ0cYW/a7pR9f1EZT57iSM30
         L1sxsNoaeTe6N1MxbNpfYiEfVocDGjSQUaawmpAEFbqgJBYSAGdHaqMzpE9LDc8XhXFv
         l+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061113; x=1794665913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KN+qoRD2iK79ZmjSJFmf4z8oGz3kbjrueefoy5xGOR4=;
        b=SqEZtX4OcGgykCwJnfKhixNq72vkw7tGQNJnwQirUpxyGFOCJMWLCRJA3iVZ4dSc6b
         Pv5fOZpzMNfa7RlU3xUj7c6szs+uiXYoYNA9O2wEow3h3IjKUHr79J7yX23WsYi7BXkl
         sM9aPzy9dX6vVbfeJO0Oq847yA2pB7MJQ/npbx1+F+V47lJUi9DHO9JHu0/ZXGkFg4yW
         LfETEbRoV3eD04L5lK2SVTifC0qKO2dIMW5SeLnPKgJX76AOjnS76HzPGiai2XzLpZZ+
         o81OWTWDlKvl/8yQNCbs6O1VVcopL+eyvTuSEiUeGB4V+YSTBHhMAyLcdBd9hJ70vhqn
         sgrw==
X-Forwarded-Encrypted: i=1; AKwUvBx0pVoBvxLWzF5DkPFYTXtdDZ0eoIAwVWnbIP7z4CbBPBOY8CquzVU006OGIL0hfgGVPJ2T+JdAzzShpQC6DsyX5kAc9T0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1bs++n85YCuc8rHzLJAV8CUxVVPiWlqv8hOWrOVIkDQw9QFmO
	78AjC02feISCs3DLKDRkbnBhZfi40uha3x/WNwQC5Ay9VC6ex35tTC2Y
X-Gm-Gg: AYBFou2mVV+C8cejJPH6VKGtvnvAgVm+lvkW2MB22OU90Pi0JwnXkAU/c0jv69ljpp7
	/h9u9risW3WNabpisnewKA89zOxfRhIEmtrWC6HnoJP2WuQlqGYK5d1OObk0V+Pk+mzBLrQz/m1
	KounElvG0tVvbehJ1AFBW6c69vzT3fgIYwoop3QmKMVvIjTiIbAff7ZR5vv7OTlh4Tkd6UvBWv6
	lbkZSMklshBJZ6v9ZbsFg4FKQZeZOqGXz6BRDIgZQAGiIFXlvKCk8V1RI4I/rOj/MRz8txbB2fr
	fiXZR75k+DeoymqYNC2cKYUQevxytQbzsTfU9VoxJYflADUwR9eDVRFrPCbgFN8yPFI17y5k17q
	IbSgrdlufF8XfgBY4YhjhHEft+8ZN/E3OD91RIkNFOcn2DitjoQ9pxdrp16QITWlG8In3Nm1mJV
	/LKWYINfFkh/JCgOdZijEyzXAvNDEQJoJWBbbIm6vYit5cg59jfQzD7rehHTkf+OEbDG5q3oo3K
	eQwr8nJCR/rbfpNiL9+nvYbah23NHWZnpKkXazjQ7QtlORi6QmH7g6Bv6Q3gU1afKNYsQmGqtwG
	XnYv4eq9sjKoFNH+e7MSUybpXHDcWaST7Yx6RGeRrYHlCr+2j8s6
X-Received: by 2002:a05:600c:c165:b0:4b0:b9ff:1e7c with SMTP id 5b1f17b1804b1-4b820563f79mr33635055e9.15.1794061113105;
        Sat, 07 Nov 2026 06:18:33 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e2e9ad95sm68386835e9.3.2026.11.07.06.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:18:32 -0800 (PST)
Date: Sat, 7 Nov 2026 15:18:30 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Shi Lecun <shilc2025@mail.sustech.edu.cn>
Cc: mic <mic@digikod.net>, gnoack <gnoack@google.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	=?utf-8?B?5byg6ZSL5beNKFpIQU5HIEZlbmd3ZWkp?= <zhangfw@sustech.edu.cn>,
	Bryam Vargas <hexlabsecurity@proton.me>
Subject: Re: [RFC] landlock: clarify signal scoping for pre-existing f_owner
 registrations
Message-ID: <20261107.2f1fa9977739@gnoack.org>
References: <tencent_1D938EDA50BCDB080CFADC6A@qq.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_1D938EDA50BCDB080CFADC6A@qq.com>

Hello Shi!

On Sat, Nov 07, 2026 at 12:23:35PM +0800, Shi Lecun wrote:
> While investigating LANDLOCK_SCOPE_SIGNAL, I noticed that the current
> documentation does not describe how signal scoping interacts with
> asynchronous notifications registered before the scope is enforced.
> 
> A minimal reproducer performs the following steps as an unprivileged user:
> 
> 1. Create a pipe and use fcntl(F_SETOWN) to select a same-UID process
>    outside the future Landlock domain as the notification recipient.
> 2. Configure F_SETSIG and O_ASYNC.
> 3. Add a Landlock layer handling LANDLOCK_SCOPE_SIGNAL.
> 4. Write to the pipe.
> 
> The configured signal is still delivered to the out-of-domain process.
> Using F_SETSIG(SIGKILL) makes this especially visible by terminating the
> recipient.  In contrast:
> 
> - kill(2) after enforcing LANDLOCK_SCOPE_SIGNAL fails with EPERM;
> - registering f_owner after enforcing the scope does not result in
>   out-of-domain signal delivery.
> 
> I reproduced this matrix on 7.2.14-arch1-1 with Landlock ABI 10 as UID
> 1000:
> 
>   direct kill after scope      victim survives
>   post-scope F_SETOWN          victim survives
>   pre-scope F_SETOWN           victim receives SIGKILL
>   FS layer, F_SETOWN, scope    victim receives SIGKILL
> 
> I also inspected a local kernel tree at commit d68ce4e71248.
> From security/landlock/fs.c and security/landlock/task.c, my
> understanding is that hook_file_set_fowner() saves the applicable
> Landlock subject when F_SETOWN is called, and
> hook_file_send_sigiotask() later checks delivery using that saved
> subject.  If no signal-scoped domain applied at registration time, the
> saved domain is NULL and later delivery is not checked against the
> triggering task's newly added domain.  The usual UID/EUID checks in
> sigio_perm() still apply.
> 
> This also appears to be intentional and covered by the existing
> fown/sandbox_after_setown variant in
> tools/testing/selftests/landlock/scoped_signal_test.c, which expects a
> signal to be received when F_SETOWN happened before sandboxing.  I
> therefore do not consider this behavior itself to be a signal-scope
> bypass.
> 
> However, Documentation/userspace-api/landlock.rst currently says:
> 
>   "This limits the sending of signals to target processes which run
>   within the same or a nested Landlock domain."

Thanks for the investigation!

The F_SETOWN signaling restriction was not initially covered correctly
by Landlock's signal scoping support, and was discovered and fixed by
Bryam Vargas in [1].

Another signaling-related report we received was about pseudoterminals,
with a documentation patch in the same place, in [2].

It feels that in both the F_SETOWN and the PTY case, the underlying
rationale is the same though -- a signaling mechanism that was set up
prior or independent to Landlock enforcement continues to work.


> Without a lifecycle qualification, this can be read as covering every
> signal delivered after the scope is enforced, including notifications
> whose f_owner was registered earlier.  The same section explicitly
> documents the lifetime exception for previously connected UNIX sockets,
> but there is no corresponding explanation for asynchronous signals.
> 
> Would it make sense to add a paragraph along these lines?
> 
>   Asynchronous signal notifications associated with a file owner, such
>   as SIGIO and SIGURG, are checked using the Landlock context saved
>   when fcntl(F_SETOWN) sets the notification recipient. Adding a
>   LANDLOCK_SCOPE_SIGNAL restriction later does not apply that new
>   restriction to notifications using the previously saved context.
>   Sandboxes that require signal isolation should therefore enforce
>   the scope before untrusted code can register asynchronous
>   notification recipients, and account for any pre-existing
>   registrations on retained file descriptors.
>
> Does this accurately describe the intended userspace semantics?
> If so, I would be happy to send a documentation patch for the IPC
> scoping section.

Your writeup matches my understanding as well, but I am a bit worried
that these corner cases start taking more room in the documentation
than the main point of what that feature does.  How about something
shorter, maybe:

  For signaling of I/O availability (F_GETSIG(2const)), Landlock
  checks are done with respect to the Landlock domain at the time of
  fcntl(F_SETOWN).

?

It feels better to link to the existing documentation for such
features instead of trying to describe them correctly.

–Günther


[1] https://lore.kernel.org/all/cover.1780614610.git.hexlabsecurity@proton.me/
[2] https://lore.kernel.org/all/20260923163321.79770-2-clusk@northecho.dev/
