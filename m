Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D19377543
	for <linux-security-module@vger.kernel.org>; Sun,  3 May 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777826797; cv=pass; b=eC6qGn1GxUitCu60lG5FaV2/W680G1HiGFNom7B0Go9dKBi5aCkxAdpBy06aBKn9+cV8zoyeUsPckojaxmhnCF3Ih6p8n6wv4Jr9xiLU7ndBsVDAbx4jX+VcXRZy+CGE32Gxqjw6D0dj3UH51opyg5QTSqSfRjfQDke9mezvLCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777826797; c=relaxed/simple;
	bh=YM2w+8iga6X0KGUCUEQ+IcUBubK3K3glecWKuCK54Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnjbTluk2QQqlVzdsUH00c011iLtsYRW4tPE4wunAQnqRwFgxJ+f1g8qbKUO0sD1X3EuRBWRW2ZFQbM4Y8ePqt6eRo5+j87SxH4MatDzfUwwbjFqna5ObwsIK3YogD4CgcL8JU8/OO232xbnXLUGXHWcTqcD/EcPm2X956VVxlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LwpDfoqR; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LwpDfoqR"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-358ed696623so1459212a91.0
        for <linux-security-module@vger.kernel.org>; Sun, 03 May 2026 09:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777826795; cv=none;
        d=google.com; s=arc-20240605;
        b=AwuCC8kS3i773rb7M6teABj5BChOkxSucTUQn3POd8oP940dXBZ2Vm+tX9aFt/0aKd
         BdeWWt/rj6ga1NF+6xNpUgTyvVyIhaLwrBh6nxsKuab4FragoXo6+UVy+wyZ0Ah3VecE
         43XIIn4c48WzjVYg3veeIPpAy1/1WuUlPoHPNFP4SGwukqp3UkM/iXEoCrr6XgL90gyG
         IQ8dfChQKvxtGhXFjagZT7f2yiYMfVRzATiE9t3JjKBu0ebiLGbFJfWkgp1PBfNh49xz
         UqBZ6qxfnjLKwcaAaoRSaQD0fsJZB9TAjcPA5tXJkT9LQVyGjwxpyZuT+okvJJugUANq
         6oGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lV+PWS6h5YsTugRvYXVkVMVA3Y637YXU6QnwmmlucsU=;
        fh=hlsB3OxfJlhUN9lANCZOaW5bzJMS1r84QPfFIIAZshc=;
        b=NnqEFS9Oid5JaWFpjDWV73u3pKOdvjC3pG0BRUx/AFfys/U07L6Wd4W0Es3DMb+rVh
         B2eXFnp5gSM4sKDmjBJTYgwnfj9sr/ffwlaGaFdTDKyVr7Io1OuFOCZBa1ryYNH43YXF
         M0hHaZXgLM/f5D8BijZZJsZb937/5wM7SXY1o3AKtlPhkpGzukmx3xNvQK62wZJdU5xL
         cWMOWQbX6ikrIi6IxSQDRoenGVaCmhqfwnvUiWV/hOedNraHXLb1MxlG1E0FLtJsxwzj
         SSd2wiF6PDI/ZwsibKlUDT1/oXqaVvJL7qK4KoM6KLFB0uBPjoBP4SG1NaTvaidBJOLG
         J2vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777826795; x=1778431595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV+PWS6h5YsTugRvYXVkVMVA3Y637YXU6QnwmmlucsU=;
        b=LwpDfoqRRUUb1UVKoIAAo4bld4m00G4+bFiEaVlCP1gnddr9nd0jF+lQ8lccFNLeQT
         43cfHHEuJE/fnyo6cp4agULY/cMhbFSkGlm4LbxVUzl1mNP5b716d4t4TuD2vFhFjrVZ
         4QF81mbyqbt1KLgvmDRHFeoSju5ABmJvVqvvG8uDxn3Mu7PrmEHfPsP3vrWlpKmY1rgk
         Bt3L/UgERg+OQ3yWm9go4ipvh8SusV1JnNZlB0c33KSqSsMxb7cXwtBiKX6rcPVTxode
         BUFELIabuOjsNtSrIlNxuYZ+GuQj2ytDCvV/vDNX9nyoSziOprS0/9W08DWdK/xOp9jR
         WUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777826795; x=1778431595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lV+PWS6h5YsTugRvYXVkVMVA3Y637YXU6QnwmmlucsU=;
        b=lmn0BEenUkY59rS4LPoP9pl7/QpISOLs6NBl+h5Zf+SoceUOmaE2nDak/1Kv5qBbqi
         8DEFXL2cRiak5uv/WrSgVLZHWtPIttXff9SDmwfYxuSgT5vZqc8fJg+MeSpYn88vRzsl
         WNfIn70I7qaCvoj4LkLv7a1Ri7XjWy+jZE1C4F51Bl0iQWiIGO1PVlw3GfTXkMfaGhWt
         8zfwDqBjG45LD8SfOWnagKzsSAdgcilSdDAixMjm5rqpyUjbUmB5wJvtLgknLeHXXy3s
         g43+2p5twkO7t+l+B6pLJIJILpV3Tm3lqHLH7z4++56ozGPbPz/i1FK3gkl76y10x79x
         YPSA==
X-Forwarded-Encrypted: i=1; AFNElJ85+pMGNla6SpJR33+Vq0HaRMiIvV43cQWbhEQE8K2sROatwKzBpFIrf1DvupgCsbujECJ3A/pFB2/ASR6B/3I0wrUEqSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcFYDXPnKaBzQ52zW3MyASqKBgpUKONFFjkKsNvsrXmWaoRU2
	OaL6tHxRBUqoG/+iR2jNhhiTnkSSO6amU+T1/0roxh63W+Ils76WE9kLHJSqDIfS3bTllEoEJjm
	rL/5AfJtRvX3nY5Sbv59xeknXKDaih+3lDw/IzRvA
X-Gm-Gg: AeBDietEdlWgwsEYDxhFcHnTr0MmfNGUx8ul9WzPavIPaABHUJN7QgJzcQ6Qm+WDnf0
	89GRBNJAjQnCJNeXV15+ckAYjwxQWLyAa2eQ3jLrzAny4HoaXdW7ob1zdwoKWQffOpCkhjvhIoX
	dCZlSAwLUTpjDNthOvJWCg7Q8TKceFIwA7HKpLl5ENbZ8UpWx/3woVuhi42+VeRFI6kPh8kXO7H
	IHWOVW/g0uY+shro3mKB8vWrV/QqiatoBtDUwqrsA6axPfOKK/T90T8iBIy+xGVgpTXlqEF4bRd
	ZaZhW6SY3rigtx61BgJ4vZWhpJyx
X-Received: by 2002:a17:90b:3e46:b0:35e:5ae3:298a with SMTP id
 98e67ed59e1d1-3650cece2d0mr6631879a91.18.1777826795343; Sun, 03 May 2026
 09:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777036497.git.noodles@meta.com> <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com> <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com> <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
In-Reply-To: <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 3 May 2026 12:46:23 -0400
X-Gm-Features: AVHnY4L2at1Ee87namZ-f-yBAzCWpTyJONd_xc3EwssaGjpCZndG6MYs1AyLIxg
Message-ID: <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org, 
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	noodles@meta.com, sebastianene@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:51=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2026-04-30 at 18:35 -0400, Paul Moore wrote:
> > On Thu, Apr 30, 2026 at 5:39=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> > > > With above change I confirmed there is no meaurement log
> > > > between boot_aggregate and boot_aggregate_late except "kernel_versi=
on"
> > > > But this is ignorable since this UTS measurement is done in
> > > > "ima_init_core() (old: ima_init())" and it is part of ima initialis=
ation.
> > > >
> > > > 1. ima_policy=3Dtcb
> > > >
> > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000=
000000000000000000000000000000000000000000000000000000000 boot_aggregate
> > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000=
000000000000000000000000000000000000000000000000000000000 boot_aggregate_la=
te
> > > >   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6a=
e3d35cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
> > > >   10 17ec669c65c401e5e85875cf2962eb7d8c47595f ima-ng sha256:dc6b013=
e9768d9b13bcd6678470448090138ca831f4771a43ce3988d8e54ffce /lib/ld-linux-aar=
ch64.so.1
> > > >   10 58679a66ac1de17f02595625a8fbeafa259a4c81 ima-ng sha256:494f62b=
cfb2fcf1b427d5092fafa62c8df39a83b4a64402620b28846724f237f /usr/lib/libtirpc=
.so.3.0.0
> > > >   10 42f74ee200434576e33be153830b3d55bbe6d2bf ima-ng sha256:a18856b=
4f6927bc2b8dd4608c0768b8f98544a161b85bf4a64419131243ad300 /lib/libresolv.so=
.2
> > > >   10 626b4f7bd4f123d18d3a3d8719ed0ae19ee5f331 ima-ng sha256:b8d442d=
e5d31c3f9d1bbb98785f04d4a23dc53442b286d85d4b355927cbe9af4 /lib/libc.so.6
> > > >   10 655a200869696207646377a58cab417fd35b09d2 ima-ng sha256:ad46146=
b6dd32b47213e5327f1bb2f962ef838a4b707ef7445fa2dbc9019b44f /etc/inittab
> > > >   10 81353202685e022fcd0069a3b2fc4eaa6b1db537 ima-ng sha256:74d698f=
e0a6862050af29083aa591c960ec1f67be960047e96bb6be5fc2bc0c0 /bin/mount
> > > >   10 ae64184ee607ef8f3aa08ab52cb548318534fd4b ima-ng sha256:27846b5=
7e8234c6a9611b00351f581a54ad6f9a1920b9aa18ceb0ae28e4f7564 /lib/libmount.so.=
1.1.0
> > > >   10 5ea01f34e7705d1bdb936fd576e2aeb5fd78dab9 ima-ng sha256:3d2a414=
ec0355fcf0910224fb4a3c53e13d98731a35241edfdf4fb911ed9b210 /lib/libblkid.so.=
1.1.0
> > > >   10 22c48b4853594a08a73ad4ae6dbe6f2c2bebc6c5 ima-ng sha256:e3b0c44=
298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 /run/utmp
> > > >   10 3024ea5021f8a5d9fb4bd519d599bdca43b7fb93 ima-ng sha256:71ea9ff=
e2b30e5a9bdceff78785cf281cc41544474db8dc4605a06a597ce1edc /etc/fstab
> > > >   10 2e7530a0f56420991ac7611734cea4774b92b9ef ima-ng sha256:df4697d=
699442cfe73db7cc8b4c1b37e8a31e75e01f66a0d70134ac812fa683b /bin/mkdir
> > > >   10 3ad117a863aa1ed7b7c09e1d106f84abf7d2ae96 ima-ng sha256:c19a710=
989b43222431b02399273dba409fe10ca8eefff88eaa936fa695f8324 /bin/ln
> > > >   10 4141c82cb516ac3c846e0b08abcd6abeee7efa1a ima-ng sha256:b75d7f2=
8772f71715a941c77e07e3922815391dd9cc5718ad21f2231c2da09bb /etc/hostname
> > > >   10 dfcedd3c7dc3ed42e09219804504489ab264e2e3 ima-ng sha256:dc1615d=
f9f2012b20b81ffad8e07e16293039ba7fd897854ca3646d6cfea0c0f /etc/init.d/rcS
> > > >   ...
> > > >
> > > > 2. ima_policy=3Dcritical_data
> > > >
> > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000=
000000000000000000000000000000000000000000000000000000000 boot_aggregate
> > > >   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907a=
ab3261194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 3=
72e312e302d7263312b // Ignorable since it's generated by ima_init(_core)().
> > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000=
000000000000000000000000000000000000000000000000000000000 boot_aggregate_la=
te
> > > >
> > > > Therefore, init_ima() could move into late_initcall_sync like v1 di=
d:
> > > >   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yu=
n@arm.com/
> > >
> > > Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to move t=
he
> > > initcall.  Hopefully others will respond.
> >
> > Is it not possible to look at the code and determine if it is safe or
> > not?  Or is the initialization of TPM devices at boot done in a random
> > order with respect to the initcall levels?
>
> The TPM is normally initialized at the device_initcall, except when other
> resources are not ready.
>
> (Abbreviated) AI explanation:
>    If the TPM's first probe succeeds at device_initcall with no deferral,=
 IMA
>    finds it fine. It is only when the TPM is pushed onto the deferred lis=
t that
>    late_initcall can execute before the retry succeeds, leaving
>    tpm_default_chip() returning NULL.

I really hope you are using AI only to phrase a response and not as a
substitute for actually investigating the code and determining what is
happening.

Regardless, assuming you always want IMA to leverage a TPMs when they
exist, your reply suggests that using an initcall based IMA init
scheme, even a late-sync initcall, may not be sufficient because
deferred TPM initialization could happen later, yes?

--=20
paul-moore.com
