Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07837F75E
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530788; cv=pass; b=uE1V4GSRo3Ho6pLW1GifdwwQ/Gq+26sYigVcjlbDAHav8yJNfsTKJ9A+UJPBy+zTst5P4LClGNEN3L90Q6fNYZQBoFUvrnU2Lmfw22pUtYrCU3+k7vGg43yNIW76jus9Yp7Jn8UjTAZfKbZDCI0rfzsdFvxcPzzmEEVNwx6zdXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530788; c=relaxed/simple;
	bh=K6ahRJJ0e5KDfR/InW9PQmfCdOV/MMnKBcw/HB3afOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkfMLKuxCefXSDONQSmRUdFtJax7egf+XxW15cAulxdBJ+p+YmZHIS46UjQBGsXUaiVoCO9HLxzjAWjRadZitinYTTEsSKkz40/ITQyHG26KFvVn9VkCe7r38EjKNhSDtlMwTk8qjJEmZWg/F6FmT8NSWMPWFkR/xAii5d9d5AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZOasl4M0; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZOasl4M0"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso696608a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 13:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778530787; cv=none;
        d=google.com; s=arc-20240605;
        b=PLTyy6MIChURU8g33B+Z6nV5E4o99X1aNJpDr/lzpvP+6VygGn4D6USZm3inqCbhFt
         ruWWhKFiXDK4+MTu1NGm2/Kwz6q70VX9v42ChX1X1D10TSQVJ6XXFy4gK4qj0cEO+zpd
         U93oBA6oFr8jKwvW18lyeGFoUSWrZD6b1JXHG1K+McpW3l+MPYY6e8oGkrZufy8dEXep
         1gHPi7mpssBLhuoDHRHiNMw1E9EX5ElhWDU+caGPhffRxF5ul+JEkIfsZZ3BEA9TVJL6
         /yFYprrtdX8YjoapDlP1hu8rNbDyfWM5YrN6Q3/zMdETaaQv/Yc+qZ33Gg6Aeub0jJgV
         toTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0JbAuhTmAUh8SFVng/KsaglWkjU1Cv2MgFsZRvohMws=;
        fh=PjYz1zP15p3gecshlIro6ts6WCNzcjo7DF0D5JS6pPo=;
        b=Hh3XyQxjl08cS2MJTlqErKMgo1vMJme+buKH1yzx79+xbeYheAqNeOQ3iT/9630pKv
         A/Nm7F9hCoJNrdFshh+BmWMPiRwq+/txBXQmu76lPGZuacCmReF96ydMckxSkALFCP3r
         hB+rxg0aCtjkbw4P/RcbJ+4cVBGw5OK4nNvDOKw5yL+cTuVf/nji+iHUtHUKgXwFobKO
         h0NPMrPcYWjwYjSkYlDIenf4b/dZpN/OR91uU5vz2ajruSdTUDrV8VOhwE+KNPguK/N1
         NEWJdO2AbtC3HwOS+FmmqBpaKUcaaGLNN2LHziyeQ1mr6wFWgaEtd58N/DWnYt1op+ON
         HB9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778530787; x=1779135587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JbAuhTmAUh8SFVng/KsaglWkjU1Cv2MgFsZRvohMws=;
        b=ZOasl4M02vdGq0CtzjM+mJSdzkG+WbWS2zDRXeT3zlmdySNNaKpsmRKaj/NozMmeeA
         4FBuv5gCY/kAmyaFd19D6aKtGP1akbARVnR3WlhARcP+pM+vtL0vvCRp5Z8/hbhuxB8Y
         G25Ai9ebx5/Uy9l2NuYRFOfPdTHbkJWrI3UVd0a6SROG+u1qQ6YchySwuAjbQ+7knXFd
         7wK44M85G5C1WR9QFG5q67FP4m9IbeW/mFVm+deCjCzVbIihKkm6VztMdE3nepc82M43
         S63Y911yCQ8vTV+FZpZ0ZL8BXXU8x+sHK/XrLzZHerG+If8gkHtfX4r0oEAmSymTw77x
         SLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778530787; x=1779135587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JbAuhTmAUh8SFVng/KsaglWkjU1Cv2MgFsZRvohMws=;
        b=AXFrsxyntsz3yn6uBbYPo5fV/3UhpD4yrW2DOtOr2rgAPTW4tjjaV3tE14exYexFYX
         0QkbRcz2aCWoaBADguJqu0R3+/oVh9eRqsqOu/ak39DNHwD+jkh/2/jNA+NLaH6Jl5Wh
         ipSzxL8yFnP3tPgn5497A9jNzG/YvYrCsYjLbwUOQ2tPc5MwbF4hRMfj/YxhdCr7F+IQ
         LR4iiYoPYn+EsQG9yPai1UpXFoa5jcfsLNbTw1l9SuoAA9Io4MlcoaomQgcMyIUSsBB/
         A4GGUvVrpDs4XXWhdtPBsC9YNP2IUuWWzXHFv9TNmyndDOKJnNV0eCC0pOn6yMeRYrfw
         nveA==
X-Gm-Message-State: AOJu0Yx4ZfVsIko/Peyt1xgWS1Zm1aOu6il1LqTriGb8ncRhrxV4nVZZ
	ptbMua/fvuPmM03idaVPaKb36fHVtTPLQz5ZD0tDr/P3OI1BCvsH8v/lRwbVFTV9t/i94kclbsT
	3fByKpKLGN9+5iUlET43nVgSdp1WOJYRyGZQI0bgkDL/r3XyzTp4=
X-Gm-Gg: Acq92OG4kNTIcc6WxiMxkBS5JQqAesb+uVwdQwWqNyAcMHOGSfzVbpVShMeiZNGxsk/
	AJAaxBewImYsN+stDoVyoKTI4f5bdrxrPtd9sd4xHBE7EqKGN06DmhpCojf4dCFCM6/LUj6W54Z
	LcojgRe5yyUan4v59cMrPMwHqTIGnYiPJ3OyMOuVCrIQlQ94zB6GEVCOY5noAv0+ZMR29C1oN7X
	L5qaSG8uMXFspxS0dy0dq1PTI4+gDH0CUH026x9JxU8VEUr+1XFHPnxCzMXCqGR4wjlN94dXGJ/
	wfH1Ctc=
X-Received: by 2002:a17:902:d294:b0:2b2:ec33:cf15 with SMTP id
 d9443c01a7336-2bcfcc3cdd5mr5383065ad.7.1778530786540; Mon, 11 May 2026
 13:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agDuCdGIeM-6z-j-@altlinux.org>
In-Reply-To: <agDuCdGIeM-6z-j-@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 May 2026 16:19:34 -0400
X-Gm-Features: AVHnY4I9tIhrxU9BB89LwwsmZTDJPrnnYPaBxKCsIK682ecgTABjXJE_lLrFyyA
Message-ID: <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 5:17=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
>
> Hi,
>
> We have boot failure when CONFIG_LSM has "bpf" listed before "selinux"
> (without bpf lsm scripts loaded). (This also happens with a boot with
> "security=3Dselinux" if selinux was not in LSM=3D list but bpf is.)
>
> systemd reports on the failing boot attempt:
>
>   Failed to set SELinux security context generic_u:object_r:device:s0 for=
 /dev/shm: Invalid argument
>   Mounting tmpfs to /dev/shm of type tmpfs with options mode=3D01777.
>   Mounting tmpfs (tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_STRICTATIME "=
mode=3D01777")...
>   Failed to mount tmpfs (type tmpfs) on /dev/shm (MS_NOSUID|MS_NODEV|MS_S=
TRICTATIME "mode=3D01777"): No such file or directory
>   Failed to set SELinux security context generic_u:object_r:device:s0 for=
 /dev/pts: Invalid argument
>   Mounting devpts to /dev/pts of type devpts with options mode=3D0620,gid=
=3D5.
>   Mounting devpts (devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "mode=3D0620,=
gid=3D5")...
>   Failed to mount devpts (type devpts) on /dev/pts (MS_NOSUID|MS_NOEXEC "=
mode=3D0620,gid=3D5"): No such file or directory
>   No filesystem is currently mounted on /sys/fs/cgroup.
>   Failed to set SELinux security context generic_u:object_r:def_t:s0 for =
/sys/fs/cgroup: Invalid argument
>   Mounting cgroup2 to /sys/fs/cgroup of type cgroup2 with options nsdeleg=
ate,memory_recursiveprot.
>   Mounting cgroup2 (cgroup2) on /sys/fs/cgroup (MS_NOSUID|MS_NODEV|MS_NOE=
XEC "nsdelegate,memory_recursiveprot")...
>   Failed to set SELinux security context generic_u:object_r:def_t:s0 for =
/sys/fs/pstore: Invalid argument
>   Mounting pstore to /sys/fs/pstore of type pstore with options n/a.
>   Mounting pstore (pstore) on /sys/fs/pstore (MS_NOSUID|MS_NODEV|MS_NOEXE=
C "")...
>   Failed to set SELinux security context generic_u:object_r:def_t:s0 for =
/sys/fs/bpf: Invalid argument
>   Mounting bpf to /sys/fs/bpf of type bpf with options mode=3D0700.
>   Mounting bpf (bpf) on /sys/fs/bpf (MS_NOSUID|MS_NODEV|MS_NOEXEC "mode=
=3D0700")...
>   [!!!!!!] Failed to mount API filesystems.
>   Freezing execution
>
> 'Invalid arguments' seems from setfscreatecon_raw.
>
> Reproducer:
>
>   Boot with lsm=3Dlockdown,capability,landlock,yama,safesetid,bpf,selinux=
,ima,evm
>
>   (none):~# cat /proc/thread-self/attr/current
>   cat: /proc/thread-self/attr/current: Invalid argument
>   (none):~# echo > /proc/thread-self/attr/fscreate
>   bash: echo: write error: Invalid argument
>
> This appears to be caused by security_getprocattr / security_setprocattr
> iterating until the first hook defined (which is bpf) and returning with
> default value -EINVAL before selinux even sees them.

Thanks for the problem report, the general recommendation is to place
the BPF LSM towards the end of the list (see the CONFIG_LSM Kconfig
help text), but we're trying to ensure that the BPF LSM works properly
when placed anywhere in that list.

My apologies if you're abilities are well beyond this, but if you are
familiar with patching and building your own kernel, have you tried
changing the LSM_RET_DEFAULT value for those functions to zero/0?
Assuming userspace is happy with that, I believe it may solve this
problem.

--=20
paul-moore.com
