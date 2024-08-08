Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854391442E8
	for <linux-security-module@vger.kernel.org>; Thu,  8 Aug 2024 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150162; cv=none; b=uheToW5CJZJ/Rliv62uNWiieXKOnCezxuTm4ofioQLrYrbvjE6pcWhXVNT8v54c012eopMjYu06pEQqTQ/8lin521hJmzyJKSUbZUBoXg6GNHoN9eaepjbI1AfIjLurjcdHpiiY6YDuVJSgW+MwAUh5/6GRzCWqmtt06T5/2ZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150162; c=relaxed/simple;
	bh=5fyWCTMF87sSrSOG+02bIogLgiJIUmr+yrtFrIc8DNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRIquuAv2t2OuANtlajBnRfrpoxQMQN9ZVx3GFPQhDgrNxOEUGi3ysbSd7Kt9D62Pp4U/QjjOVFRg4wGMfdko6NKzKnD/UqOGb3LLhPGVhk2niNukCswZOdGVUQXQUtKPtU3UTyDwct+/GiQftU8B1u4SOe6C/yL1GX19+uGLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xj0xR5h0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xj0xR5h0"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0e88873825so1375519276.2
        for <linux-security-module@vger.kernel.org>; Thu, 08 Aug 2024 13:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723150159; x=1723754959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31etNWpvhkl2loNVcBVHnptCNEhnuZUXotMLP3mpdfg=;
        b=Xj0xR5h0HviwCZGmxmD6Dm6Rfar/NGap3HOffyIaeJL/rGMcRwegKpj0LjYo4yeMLC
         k4cXNHsIKVEUEFjGuH5bzOzXjr8Pv+BF3ICm5WrGEkjEPWd3yWG99AkZ155YTVIWOeiE
         c9UCCDKhNz4cWcGFJBT5ORyUDwm7eNCAlVer3Ww8f+csajVOdW1j66cZlu22LxRtM+M4
         pbbA+zrwt0nl8DD99cuZqShwbLwkUiuKN3EOApkNbUTwcZlouV6yFRUer0ib6PfH5qAJ
         tD72HpDxYFqGqpvmA0J09qO2p2jxiq9SyCITg1DrlewcqKvaAA74or+vM46a2PFe8MZH
         sJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150159; x=1723754959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31etNWpvhkl2loNVcBVHnptCNEhnuZUXotMLP3mpdfg=;
        b=rqYnVmzUxbk7F/OlFC/wxLndbPb3aqh94qoBBf0HfepI4DRnvSxA+UiIiCOb52p5CF
         A6mkcd1rnG8naIebpogOtnoQgDMPePz1Re53e8KQHo0vV+vMX0DvmZNCxF4sTSbL+pto
         6hSkn/qTn9P8ojeyKts/NDA3lQbRUeHXoQpd2PWvo0l/yd3/cczMlxTSLWbGSFP4srUb
         X3FIxPnpqAL3umNnj8DljsSoieOTi6feFhFiT0LYWZMeF3KiSMmblISN9/8DWIEsNRKT
         ugBCM6iwh1TpR21jjDV4gKo/YEteeDHthxkRNrogqCYiVBh3x4HVV3+Bdsi53MvecjVB
         IIRg==
X-Forwarded-Encrypted: i=1; AJvYcCVGYONBicE00cDfkfce+YGJmOKzWt9Fz+M01md9LBC0aM4IUWqayYu+fDxgg4QbQ7n4Tr3Zj8bh0bINzVp6Aqw5nKGUA/Jfj7kPQite1jtSARUas6U7
X-Gm-Message-State: AOJu0Yw/DJWDEm4b8Q5l9EaFypVC1CSjobjZDUvCa2IXfblpe+YwygEk
	tGDC5KTyCVFhJ1yQa13maDyrHWJ3liArvHPULuc/o1/uljd5+oPwgSn005VFnsEumnqaWSvo8NF
	h/5WHXKQG/CzLF3gZKuwMjbV7JtrjSklhuKuj
X-Google-Smtp-Source: AGHT+IEUOdK/Fx/dEBbY87arC3ssO9rofH7XLSqG1jlUSOkkWvk2CfFONdiaN7t+2htvv0kuVq/0NDbcCXMb4MK8rvY=
X-Received: by 2002:a05:6902:993:b0:e0b:1519:e0d3 with SMTP id
 3f1490d57ef6-e0e9da703eamr3259095276.6.1723150159404; Thu, 08 Aug 2024
 13:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net> <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net>
In-Reply-To: <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 16:49:08 -0400
Message-ID: <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Guenter Roeck <linux@roeck-us.net>
Cc: KP Singh <kpsingh@kernel.org>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:00=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
> On Thu, Aug 08, 2024 at 01:32:37PM -0400, Paul Moore wrote:
> > On Thu, Aug 8, 2024 at 12:43=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> > >
> > > Also, there is a backtrace on ppc (also see below), but that is unrel=
ated
> > > to your patches and only seen now because I enabled the security modu=
les
> > > on that architecture. I'll bring that up with ppc maintainers.
> >
> > Thanks for all your help testing this Guenter.  I see you've also
> > already submitted an AppArmor fix for the endian issue, that's very
> > helpful and I'm sure John will be happy to see it.
> >
> > Beyond this work testing the static call patches from KP, would you be
> > willing to add a LSM configuration to your normal testing?  While most
> > of the LSM subsystem should be architecture agnostic, there are
> > definitely bits and pieces that can vary (as you've seen), and I think
> > it would be great to get more testing across a broad range of
> > supported arches, even if it is just some simple "does it boot" tests.
> >
>
> That really depends. I already enabled some of the kernel security module=
s.
>
> CONFIG_SECURITY=3Dy
> CONFIG_SECURITY_APPARMOR=3Dy
> CONFIG_SECURITY_APPARMOR_KUNIT_TEST=3Dy
> CONFIG_SECURITY_LANDLOCK=3Dy
> CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=3Dy
> CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy
> CONFIG_SECURITY_YAMA=3Dy
> CONFIG_SECURITY_LOADPIN=3Dy
> CONFIG_SECURITY_SAFESETID=3Dy
> CONFIG_BPF_LSM=3Dy
> CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,bpf"
>
> I can easily add more if you tell me what else I should enable.

Thanks, I just added a todo item to send you a list.  I appreciate the help=
.

> Userspace is more difficult. My root file systems are generated using
> buildroot. I run some basic tests, such as network interface tests
> and TPM tests, but those are just simple scripts utilizing packages
> provided by buildroot. I can add more, but I would need to know what
> exactly to add and how to execute it.

Of course.  As far as I'm concerned, simply enabling the LSMs and
making sure the various arches boot without additional faults would be
a nice boost in testing.

> > Out of curiosity, do you have your test setup documented anywhere?  It
> > sounds fairly impressive and I'd be curious to learn more about it.
>
> Not really. The code is at https://github.com/groeck/linux-build-test.
> My clone of buildroot is at https://github.com/groeck/buildroot (look
> for local- branches to see my changes). Please feel free to have a look,
> but documentation is seriously lacking (and README is completely out
> of date).

Thanks for the pointers.

--=20
paul-moore.com
