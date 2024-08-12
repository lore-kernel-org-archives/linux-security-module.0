Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C0187FE6
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482750; cv=none; b=fcQ8FMGNON4PV43w3HM0/6bD1ckJy8HEI4tJqN2hheRRaVj01gQ0UgWy7O6rm59IS5Hu1SV6AjWciYJW1vErKL87jOHcmEHo+WD+IAAKfNdnx8CCQXX2WCDuqp+OSstXH2ll08tu7Y7F9CFEk0ME/8z69pPx/aoF2Uq1v/2Wr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482750; c=relaxed/simple;
	bh=8yHdW4ydlVda22NnDC+U1b2MHPLhbwDjGEoQoIRmfJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNzOEPX1O4iHHWvne5u+r/KVosfl2pfBfzBGheZrnjPnFOdv1xETcQJ53jvFV3JK7xM9IMO42lyrN8Uf7qDxRBmocqNJX5+8G/pMUSW426trklGF3GPbtkVA/gDUbDnLdMAuTWEztsF68MLjkRr2lalR6tu9Kv+aJ8zLJYV0YlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfesSTZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfesSTZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F548C32782
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723482749;
	bh=8yHdW4ydlVda22NnDC+U1b2MHPLhbwDjGEoQoIRmfJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kfesSTZwHTrBiFaLuPDwvr27ASE5jekpBUPczFc5xSc18MS6m12L6U+74J1wTa8Ad
	 L1dMIYAYkmdVCEQc3FYCB0jvOPHFbfJIcJsTflp52ekfrNzVKsDm1e8eg9sim5Ddg7
	 lEFHlL6kCYE+3z02avS6Pt1cZszNSdnkhICxc+Thglr5x3QlJKCJo6HmKoh7qI62zj
	 e/Og6B+nLsfU9tis91h/ETCYyoW9+hqK+qVU/44xn7W7LhZ/W+4EWcCZ+DBDRrrtw4
	 bn+P4k9WNwRRroI/Z83HjEVU+cLOfZfGOE4luWaUdAYzvrgnMqKUiQr+qfY34iG41U
	 OLXcmSlxo/yVA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f189a2a7f8so47215811fa.2
        for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 10:12:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFmdYBoi1k7764RQwoRJFXcVfRWjlfq0ji2Id9WwFurHC9m1O6hRfnywQ4l8V536Fjh+9z07lZaonxV+rxqC8ZQSGBL15oKFozcykgsS+9zu/4fcsK
X-Gm-Message-State: AOJu0YwCBC/Lg84pQuUPDHjZdmmdrpaZ4dqxUVCswYXNmqdRv5/dKAY/
	5w8H8MlrEgw1IY19LGw3Fm8cLjRLXE8zdhPUBNwkASqfYqJbAk5OjrBOdUaeqorOtQirWU6ArHC
	qvK2/i9VyM0U0q+Fo8ilmhPzw4/7odPwkVUK9
X-Google-Smtp-Source: AGHT+IEi4x2lKyzSlBdDqyzNvP1WkxgKGyo1LKUTYnu8D717dYjlPG7KYanK/LSOMd8pZXkQOcvI64ymMk//DOzcflQ=
X-Received: by 2002:a2e:a550:0:b0:2ef:2c87:3bd7 with SMTP id
 38308e7fff4ca-2f2b7178548mr8639581fa.37.1723482747964; Mon, 12 Aug 2024
 10:12:27 -0700 (PDT)
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
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net> <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
In-Reply-To: <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 12 Aug 2024 19:12:16 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
Message-ID: <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Paul Moore <paul@paul-moore.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Aug 8, 2024 at 2:00=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
> > On Thu, Aug 08, 2024 at 01:32:37PM -0400, Paul Moore wrote:
> > > On Thu, Aug 8, 2024 at 12:43=E2=80=AFPM Guenter Roeck <linux@roeck-us=
.net> wrote:
> > > >
> > > > Also, there is a backtrace on ppc (also see below), but that is unr=
elated
> > > > to your patches and only seen now because I enabled the security mo=
dules
> > > > on that architecture. I'll bring that up with ppc maintainers.
> > >
> > > Thanks for all your help testing this Guenter.  I see you've also
> > > already submitted an AppArmor fix for the endian issue, that's very
> > > helpful and I'm sure John will be happy to see it.
> > >
> > > Beyond this work testing the static call patches from KP, would you b=
e
> > > willing to add a LSM configuration to your normal testing?  While mos=
t
> > > of the LSM subsystem should be architecture agnostic, there are
> > > definitely bits and pieces that can vary (as you've seen), and I thin=
k
> > > it would be great to get more testing across a broad range of
> > > supported arches, even if it is just some simple "does it boot" tests=
.
> > >
> >
> > That really depends. I already enabled some of the kernel security modu=
les.
> >
> > CONFIG_SECURITY=3Dy
> > CONFIG_SECURITY_APPARMOR=3Dy
> > CONFIG_SECURITY_APPARMOR_KUNIT_TEST=3Dy
> > CONFIG_SECURITY_LANDLOCK=3Dy
> > CONFIG_SECURITY_LANDLOCK_KUNIT_TEST=3Dy
> > CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
> > CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy
> > CONFIG_SECURITY_YAMA=3Dy
> > CONFIG_SECURITY_LOADPIN=3Dy
> > CONFIG_SECURITY_SAFESETID=3Dy
> > CONFIG_BPF_LSM=3Dy
> > CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,bpf"
> >
> > I can easily add more if you tell me what else I should enable.
>
> Thanks, I just added a todo item to send you a list.  I appreciate the he=
lp.
>
> > Userspace is more difficult. My root file systems are generated using
> > buildroot. I run some basic tests, such as network interface tests
> > and TPM tests, but those are just simple scripts utilizing packages
> > provided by buildroot. I can add more, but I would need to know what
> > exactly to add and how to execute it.
>
> Of course.  As far as I'm concerned, simply enabling the LSMs and
> making sure the various arches boot without additional faults would be
> a nice boost in testing.
>
> > > Out of curiosity, do you have your test setup documented anywhere?  I=
t
> > > sounds fairly impressive and I'd be curious to learn more about it.
> >
> > Not really. The code is at https://github.com/groeck/linux-build-test.
> > My clone of buildroot is at https://github.com/groeck/buildroot (look
> > for local- branches to see my changes). Please feel free to have a look=
,
> > but documentation is seriously lacking (and README is completely out
> > of date).
>

JFYI, I synced with Guenter and all arch seem to pass and alpha does
not work due to a reason that I am unable to debug. I will try doing
more debugging but I will need more alpha help here (Added the
maintainers to this thread).



> Thanks for the pointers.
>
> --
> paul-moore.com
