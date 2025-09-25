Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFB2E173B
	for <linux-security-module@vger.kernel.org>; Thu, 25 Sep 2025 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812220; cv=none; b=MaxmNX4h+Ypew3XUNDyZDOn8jLfvIbPd5MWS8rVNr4hoZl8xP+G8n+LYx1Hwyvl8JYmx/OdsQ5HR6p72idUQQPsDxmY9xzXGrO5kmYRvEoITFafCq5t4pLlur7950gPbnfFpzD+FenvRrSsEWB3o2AwzNSV0FwE3EDr1STtbKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812220; c=relaxed/simple;
	bh=iXjdYy/Oe5sVP96M1v1HO37ho1pc8PIfeIRa6Jk7gsk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HnKqm0f/wkIVfeZ74mlDJruLwyJ3JvHW9HG4MCxTGP3EBHgbwoSn6NaSRMfdOhJPxTejhWxsRwBBZShCuIBLd5zSdAToUmK0PW6MI4qm0sIWbauJwoeHW1RM0guS52u+S1ZTp+lBfd/ZwgQgg6MyV+cLzVHLW6qlXD12c6g14cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfiu3FKo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfiu3FKo"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so9241575e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 25 Sep 2025 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758812217; x=1759417017; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vQLgyQTTgUDea9nF4s1X9HICWryIv9j0DFy7IvOKWt0=;
        b=hfiu3FKoJ0+bIORChplDlPZzuM2+HuuaqZoAvJA1CH6hy48Ts8+VvMEUjcvVHAusxX
         sBTqceF1dmm13bGbmx6jAB2ZJZO36bE7c1Po6DvSJa4dsoAQqPBaZ5IBHQLXOxTeHTGK
         4l6GAcwpCTzFHJfV8NXjDAmtVZVQSj5eIDFW+74DRzPo/F8kUuxxSyTUGHG9sKscMehg
         thw1CtLyj7/vShcVFIYbb+kR84kshDsFHefOgKyFntSf+7pKS/FM2N70BZuHI07d8IiS
         00jS8yTBdPnbguET0tHlwX0wX5t3tMAaZFjxX7aonbabNGlxIIRNvnOk4j17fgTErD8b
         Hdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758812217; x=1759417017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQLgyQTTgUDea9nF4s1X9HICWryIv9j0DFy7IvOKWt0=;
        b=i9aZs/R7egqZrAudCGkdSe9pKYm9bAOcOwsgS0da6v7N2b2rjFDmCM69ClP0sxdy57
         mAOmrRRsThq2AYlrT0RkHqEoZnxWRVWgeX6T3UgCssBE3Ziv9Aj+h5txVHpxSDZY5LC4
         8q+DUzf4hsV3X3C3vzU84XadKYmSaAZB/AvpPXYy4/o4XIaUECQ28aJbsTJNrt/pepp5
         M56R5DeUTVUmeN3Pwpv5rNhyXJVG41DBWzxhMtW5WK8fZTdJ5giG/VorzOfXKbRByVED
         jcb+8XBV1Z1iQ4Ap0poxHxVRJWpazC5vA0yvBJ3ayqeHDVPdTAA41U0OcsArof3jYK81
         iUfw==
X-Gm-Message-State: AOJu0Yxe5jSDXvtufV5Q5VhvV6r33G/jmWw7QP+OA4+MX9ymyYI8D24a
	rg/IlAqLu7Y7PeGWhkS1yyJ2Sdm95bQyDecCvftG0LL8VH+Nx3kmGFUL
X-Gm-Gg: ASbGncvDvN/yiVmQRNb2OwaPsjIyNfNfWBwJW/0P4kQkMf24bICElgiW6OcDY4EGuUr
	Y+jkwJMMYE9UDgKpObTECn6UmHzBvNMUhPsels4TiQsk7HrwliehKbmlumao//CIcOxaoPIzyIm
	LyhhoJOPGJKEJbAsGWOE64RRUGC9ItMTT6zcTOi5FDsNOY065wDsnvods+VQdTWtKiu50bjFFSk
	BiyqUx6Wxplo3biAMH8yvetFbEWe3fnVnqmISDyDfs6FSfAmyxGnWZmp+6jYPGiX/nOjzbCd8Ta
	mZ+WZIk4gvCNMQV40VBBJO8YgLe/hR3TquAuqWLWR3tDmgdXiVR/G5OdRi9I2RXVgLj9qBleYv7
	HfUGNzWsdR0QK6nvZh9z7u6ogcHn5g2Xwm0JIaOJwTYoPTtRidvCSBPxv7Q==
X-Google-Smtp-Source: AGHT+IEzGD5aTIxkgOT3hW9heRIa+e6bI+J2eP+kb7/6OWm0dTSB2R32Wm5QMktzASbLVZB/YT64hQ==
X-Received: by 2002:a05:600c:1553:b0:46e:39e4:1721 with SMTP id 5b1f17b1804b1-46e39e41ae1mr1183735e9.12.1758812216424;
        Thu, 25 Sep 2025 07:56:56 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bede2csm36381395e9.17.2025.09.25.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:56:55 -0700 (PDT)
Message-ID: <cd35aa283cf010188a3b0e318f2c16655224767c.camel@gmail.com>
Subject: Re: [bug report] [regression?] bpf lsm breaks /proc/*/attr/current
 with security= on commandline
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
  "Serge E. Hallyn"	 <serge@hallyn.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	regressions@lists.linux.dev
Date: Thu, 25 Sep 2025 16:56:55 +0200
In-Reply-To: <CAHC9VhRu=-J5xdKgYOJ1eqQ6EiMoEJ3M+cjDU8AHrts-=DoTvg@mail.gmail.com>
References: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
	 <CAHC9VhRu=-J5xdKgYOJ1eqQ6EiMoEJ3M+cjDU8AHrts-=DoTvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-24 at 17:24 -0400, Paul Moore wrote:
> On Sat, Sep 13, 2025 at 1:01=E2=80=AFPM Filip Hejsek <filip.hejsek@gmail.=
com> wrote:
> >=20
> > Hello,
> >=20
> > TLDR: because of bpf lsm, putting security=3Dselinux on commandline
> >       results in /proc/*/attr/current returning errors.
> >=20
> > When the legacy security=3D commandline option is used, the specified l=
sm
> > is added to the end of the lsm list. For example, security=3Dapparmor
> > results in the following order of security modules:
> >=20
> >    capability,landlock,lockdown,yama,bpf,apparmor
> >=20
> > In particular, the bpf lsm will be ordered before the chosen major lsm.
> >=20
> > This causes reads and writes of /proc/*/attr/current to fail, because
> > the bpf hook overrides the apparmor/selinux hook.
>=20
> What kernel are you using?

I'm using Arch Linux kernel, which is very close to mainline. I have
also tested my own build from git sources (I used a stripped down
config which I based on config from Arch). Example in QEMU:

$ qemu-system-x86_64 -nodefaults -accel kvm -cpu host -smp cpus=3D2 -m 1G -=
display none -kernel ~/git/linux/arch/x86/boot/bzImage -initrd ./initramfs.=
img -serial mon:stdio -append 'console=3DttyS0 security=3Dselinux'
:: mounting '' on real root
mount: /new_root: no valid filesystem type specified.
ERROR: Failed to mount '' on real root
You are now being dropped into an emergency shell.
sh: can't access tty; job control turned off
[rootfs ~]# uname -a
Linux archlinux 6.17.0-rc7-00020-gcec1e6e5d1ab #3 SMP PREEMPT_DYNAMIC Thu S=
ep 25 16:28:02 CEST 2025 x86_64 GNU/Linux
[rootfs ~]# mount -t securityfs securityfs /sys/kernel/security
[rootfs ~]# cat /proc/cmdline
console=3DttyS0 security=3Dselinux
[rootfs ~]# cat /sys/kernel/security/lsm; echo
capability,landlock,lockdown,yama,bpf,selinux
[rootfs ~]# cat /proc/self/attr/current
cat: read error: Invalid argument

(Note: In this example, uname reports archlinux, but that's only
because I based the config on Arch config, it's not actually an Arch
kernel.)

Maybe the different behavior is caused by a different config? You can
find the Arch config at [1]. Based on Fedora package sources, I think
their config has

   CONFIG_LSM=3D"lockdown,yama,integrity,selinux,bpf,landlock,ipe"

while the Arch config has

   CONFIG_LSM=3D"landlock,lockdown,yama,integrity,bpf"

.

[1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/=
main/config?ref_type=3Dheads

>   Things appear to work correctly on my
> kernel that is tracking upstream (Fedora Rawhide + some unrelated
> bits):
>=20
> % uname -a
> Linux dev-rawhide-1.lan 6.17.0-0.rc7.250923gd1ab3.57.1.secnext.fc44.x86_6=
4 #1 SM
> P PREEMPT_DYNAMIC Tue Sep 23 10:07:14 EDT 2025 x86_64 GNU/Linux
> % cat /proc/cmdline
> BOOT_IMAGE=3D(hd0,gpt4)/boot/vmlinuz-6.17.0-0.rc7.250923gd1ab3.57.1.secne=
xt.fc44.x
> 86_64 root=3DUUID=3D285029fa-4431-45e9-af1b-298ab0caf16a ro console=3Dtty=
S0 mitigation
> s=3Doff security=3Dselinux
> % cat /sys/kernel/security/lsm; echo ""
> lockdown,capability,yama,selinux,bpf,landlock,ipe,ima,evm
> % id -Z
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> % cat /proc/self/attr/current; echo ""
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>=20
> I even ran it against the LSM initialization rework that has been
> proposed, but has not yet been accepted/merged, and that worked the
> same as above.
>=20
> Is this a distro kernel with a lot of "special" patches which aren't
> present upstream?
