Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4692E3B10
	for <linux-security-module@vger.kernel.org>; Thu, 25 Sep 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814118; cv=none; b=Tw/kbzzH7ejJ++zFv7koBnVDurrspwqIaMMx8VyyqCIY1qZSnD/2byFMX4LYoGbgi55k6AbNW+dTeZTzti0giTP2qbukPtmhhJCfZ2bMuwJUyCUgXTOnQDGXrlo+4SGNMI8rdYDH3IkhlH2goHqe8yiTgvuXiKLEe92/y3Cj+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814118; c=relaxed/simple;
	bh=wtyjj5HMg9V/mCMmvfB3/zw/BDFGlntNz9YE/LdNiug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhaCFiXF6gJ3sDSJCqL3vQf1TVMIouxoQCnNfYAT+2tQOh3zevyKQjqgm20GlKtMOcRRp9FAhcy61sUz241+VEirrt0HMDLxXMfz1m9zYACJaqYGNZZVD3mP1L+LVh64/YQXnUiB3K/yI/tMPbCsg8Y3nL7YdWzBymk0NF4OtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D0vjJBg8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D0vjJBg8"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b2ac72dbf48so203616166b.0
        for <linux-security-module@vger.kernel.org>; Thu, 25 Sep 2025 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758814115; x=1759418915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKobXdLFkGKMm2/irUXr6fbBOfkB6Qw77372NdUM/PE=;
        b=D0vjJBg86V8jogxZYYZ65zYu083rRHpJI9I2/kdawyNMHYzmv2DPiFz11K8gZoxLT2
         AeZH1gYjC5gbg3xHGnTaw940a84b/CFIQ7gLgoLHPepNLqBMVwT1Acl4r3Jm7vowDUEU
         2eBks7aeOEHfpRoRGtE5s2RzeQq9yZc4i/tEnvJ1uRkHIGmpQdBDfxXxlwOeIB1J7HOp
         cNumbnFObAHelUXStdWU/Sn0aRvJvcWLhz7UAQo6sxjeU2g2rVimsvxcMDOUfqhIafkF
         PXMkSu4m1XZ1FUmCnIo1buVUjM67VmTt5BHtUT67Znecl0G1HfeMw6GMnUvI3+x8gUi0
         xS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814115; x=1759418915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKobXdLFkGKMm2/irUXr6fbBOfkB6Qw77372NdUM/PE=;
        b=snzvcrsEI0Tkx0ZxbkTA6l1MzuQHlWLpqyDFiEBcwa3yDY9QO3QplKgje6PYwT8oyn
         LV2Nnug21zE0fERRIKMFM6rArIH3dc9GVeCK3GOTAWoC39L7RfasZpsfgoOTBYkBQb1h
         Tk+mwZHkPATf7a2tOrAx6TrcponzrojH88vfVnVdUoGI+1p2ToOvZ2xbZ9Qm+gKKc5JY
         tSz0CP4U9QW221NKxz0hp+zCvh84RifDt/WwhZOSSnTNSLlSQzfPGQ9Bikel57LlK7/k
         ubS3I2yhCG8+xOr388tUhDX28MpBvoSpyCupEJMQWDeoCsJnWGUU/sBX9/LTemtQJxVL
         OrQA==
X-Gm-Message-State: AOJu0YwOsbB+jDo+qshWlM5pb4EK6hhHaAYKH324Wq34unPfUr+1LyeV
	ih6q3pOVZEIgTPWbEqiygX5gKOBGRB/2tx20saKQLH8RSsHBvodnNjPC/WCbXXrYRfEQPmiHAfd
	1GFizo3pAjEA4F36qb/fK66RO5zJpf/JPwqkYYi81
X-Gm-Gg: ASbGncsIQR1pZvfcUPsn+IX2kN/PXXl2K87btIMt4xqvPVWElYPZ+szj6NSnPHokBvg
	xRnfXABSzG5clf/7x+jLoscGdpEoE1pUOcnlpolAldSvruslq+KhrVZTfQA3gWNQXNEkcHtQQF1
	g5QSGWIGeSrxYxHr1qfeEKSmxqW4lWenGybqkznYTnhRayaL7NUZrX/cZm7Vm84Rb9zrTsUhEGS
	MOZ9xQ=
X-Google-Smtp-Source: AGHT+IFO/fjLqIN4PDy2/c1HOCYYPOmuvQn62UY5lq01KtaWtEk2UAQPpnbUb4D5Ky8gx7kKy7wdQoLN/VdJ1kbDa3c=
X-Received: by 2002:a17:907:3e1d:b0:b03:d5ca:b16 with SMTP id
 a640c23a62f3a-b34b80b2a29mr424706466b.23.1758814114617; Thu, 25 Sep 2025
 08:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
 <CAHC9VhRu=-J5xdKgYOJ1eqQ6EiMoEJ3M+cjDU8AHrts-=DoTvg@mail.gmail.com> <cd35aa283cf010188a3b0e318f2c16655224767c.camel@gmail.com>
In-Reply-To: <cd35aa283cf010188a3b0e318f2c16655224767c.camel@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Sep 2025 11:28:21 -0400
X-Gm-Features: AS18NWBarlzZOSQr7OCNIDNef4KOm0vks6D5xuABgZBWI2HDW6eEgkpbJbc9oXw
Message-ID: <CAHC9VhQ-c65UJS+dRaRFn_D=Sq++QXePTsCkN+cV5BVQEbf9fQ@mail.gmail.com>
Subject: Re: [bug report] [regression?] bpf lsm breaks /proc/*/attr/current
 with security= on commandline
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:56=E2=80=AFAM Filip Hejsek <filip.hejsek@gmail.c=
om> wrote:
> On Wed, 2025-09-24 at 17:24 -0400, Paul Moore wrote:
> > On Sat, Sep 13, 2025 at 1:01=E2=80=AFPM Filip Hejsek <filip.hejsek@gmai=
l.com> wrote:
> > >
> > > Hello,
> > >
> > > TLDR: because of bpf lsm, putting security=3Dselinux on commandline
> > >       results in /proc/*/attr/current returning errors.
> > >
> > > When the legacy security=3D commandline option is used, the specified=
 lsm
> > > is added to the end of the lsm list. For example, security=3Dapparmor
> > > results in the following order of security modules:
> > >
> > >    capability,landlock,lockdown,yama,bpf,apparmor
> > >
> > > In particular, the bpf lsm will be ordered before the chosen major ls=
m.
> > >
> > > This causes reads and writes of /proc/*/attr/current to fail, because
> > > the bpf hook overrides the apparmor/selinux hook.
> >
> > What kernel are you using?
>
> I'm using Arch Linux kernel, which is very close to mainline. I have
> also tested my own build from git sources (I used a stripped down
> config which I based on config from Arch). Example in QEMU:
>
> $ qemu-system-x86_64 -nodefaults -accel kvm -cpu host -smp cpus=3D2 -m 1G=
 -display none -kernel ~/git/linux/arch/x86/boot/bzImage -initrd ./initramf=
s.img -serial mon:stdio -append 'console=3DttyS0 security=3Dselinux'
> :: mounting '' on real root
> mount: /new_root: no valid filesystem type specified.
> ERROR: Failed to mount '' on real root
> You are now being dropped into an emergency shell.
> sh: can't access tty; job control turned off
> [rootfs ~]# uname -a
> Linux archlinux 6.17.0-rc7-00020-gcec1e6e5d1ab #3 SMP PREEMPT_DYNAMIC Thu=
 Sep 25 16:28:02 CEST 2025 x86_64 GNU/Linux
> [rootfs ~]# mount -t securityfs securityfs /sys/kernel/security
> [rootfs ~]# cat /proc/cmdline
> console=3DttyS0 security=3Dselinux
> [rootfs ~]# cat /sys/kernel/security/lsm; echo
> capability,landlock,lockdown,yama,bpf,selinux
> [rootfs ~]# cat /proc/self/attr/current
> cat: read error: Invalid argument
>
> (Note: In this example, uname reports archlinux, but that's only
> because I based the config on Arch config, it's not actually an Arch
> kernel.)
>
> Maybe the different behavior is caused by a different config? You can
> find the Arch config at [1]. Based on Fedora package sources, I think
> their config has
>
>    CONFIG_LSM=3D"lockdown,yama,integrity,selinux,bpf,landlock,ipe"
>
> while the Arch config has
>
>    CONFIG_LSM=3D"landlock,lockdown,yama,integrity,bpf"

That's interesting, you're running a LSM that isn't normally run in
your distro and you're not properly initializing it (no policy load).
Both are acceptable, but you're definitely operating in the
corner-iest of corner cases ;)

I'd have to look at the relevant code, but I suspect that with
"selinux" missing from the CONFIG_LSM list and you manually specifying
it on the kernel command line with "security=3Dselinux" you are getting
it placed at the very end as opposed to what I saw (I have "selinux"
in my CONFIG_LSM list).  It's further complicated by the fact that the
procfs call into the LSM's security_getprocattr() hook is going to
pass a 0/zero into the hook as the @lsmid which means "first
available".

Considering that the "security=3D" parameter is a legacy option, I'd
encourage you to try the "lsm=3D" parameter (make sure you specify the
full list of LSMs you want, in order) to see if that works.  The
"security=3D" option predates both the concept of multiple simultaneous
LSMs as well as the uniqueness that is the BPF LSM.  Assuming that
"lsm=3D" works for you, and I would expect it to work, I think that is
the right solution here; new or unusual systems really shouldn't be
using "security=3D" at this point.

--=20
paul-moore.com
