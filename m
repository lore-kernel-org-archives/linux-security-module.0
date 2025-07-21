Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9323B61C
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140889; cv=none; b=rceUcpN2z+XgI9ct7t+pA4dxAAdduJUeF2yNPLUbLbShOkGl8dmDkubRx9ndGIAeDhKR7V/xyKbl+dfqbMhEDjCfDGPbouZ3VQwQCaUqz69tujeb9S7iK8sgNO6qLVTLS59f6/c1N7ZQY1FozXekfhPtw9VYwxGtOeZt4tiULEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140889; c=relaxed/simple;
	bh=2CurineEqHX+7NKWaNMui0MCdrtqHlaGr+HoSBz9zsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXHbfKFQp9EHE1ey6UpnzI9WpMqivb1G380j90CvOX9j7JwPWPJTprFQM14wgBiG8Hftvf5M1NEjgdVVD+LbgGd/Mij6D5dDNflfCCnleBkUPKpmLGXXVU+n2OlGoijZ+wJkwdv4NM3KPO/A5lgYNzWRIuJNLmI1dIQHPYb4mfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dP4py0a+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dP4py0a+"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8d7122c3a5so4093698276.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140885; x=1753745685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8BWEenObk1rz4p7yLYXtPBA0vfYLsBEcPbdz1dokJM=;
        b=dP4py0a+zBZgXVQvRhKF0LG/Nmi/hqVV6bp2qb/FpJtljfGn1+TPFwC6UKXGsQmqfp
         SRO0tq6OQMz0EZ2Ku6OMPd9UzRCLuRchaYAazCMIyyb5Oye3S7miucsnmaEaG5vOCEZc
         sOWVcFQfBaqTdN6e/IwhHmc+juRlhu5lqG113D23vD4UIQlDrYTjWRlVlpeCmn7FZWJ6
         B6/p67+LZ2B+fS5stmtbUB3a23SFp9ewVS6hA03YM+qNKG5ZXx31gb5oLMuHWga9lDB7
         cFfZkMHe2ZGLZYAM1BjLFbgdx/0yqZXq/Pw7aG9v8K0A2yUzs/EhmejziBSs2Re7HNGj
         XCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140885; x=1753745685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8BWEenObk1rz4p7yLYXtPBA0vfYLsBEcPbdz1dokJM=;
        b=RmLgo4UOCnZ2nazrQmYbIks2K0noLeHKuz5GaQLXMzkLxKJfZK77GnOcIqEltId1E0
         Usx/CC/mD2sR/i/tynCNGStRxgpj4E+MWHYHPbdd8ZPk6oI/VvwF+hhZIB84ABrp2z30
         u9cNIyEalegI6kPzs8ciWRgkGRqsGozksdU0ywOICi7eWg3ZbnnjGNukvjCnLqaLJV6m
         dmVzO81I8GTZf21TUPgcETogTGi63ZQ25v+pVmHVDE2/qdjvHLYnPcA822obtvdBDXZY
         Qa6kBdVNYLXwW+loOGxDc3+d33pIR2IDvVm3iCjYfbEXya0C/xwOpGTY4NDL4FMNwMnV
         1guQ==
X-Gm-Message-State: AOJu0YwZXpW3MKZQx3tuTmddjs9VHZZcxo+pJufftgkt+4usd1oILTL6
	cDOhsBZUE2oOdvJyCeI2qx1nAACn+M6HzkEq2fc6L23vJ+qGXrMI5rnPMxPaKVktjGZDYHc51+8
	OpIVBHnqyMBde+gBkQPvIrYgCB4j/2hHcMF6apHAdwoufurckpcA=
X-Gm-Gg: ASbGncteERll31LfNpD8Xbm9KeZz/l3PxhP7SITckhkifZHldhjOy71XTEsKs20L8Oa
	tHlT1XLcz1Sz/hTp935pgS08JLdhB93ecx2oa4/7wcKY2kNdbS4F7E8jYihdE6azZ8xX0Aj4Q7h
	E22vxoztmPsYIsjGP84lTnsF6r/jrHA+6suwufkrKBFswWyMuwtEUE/vHfscrD3ZPFfTs3pyAK/
	KpgmNE=
X-Google-Smtp-Source: AGHT+IEbg3yJC3dxGDA+JUibq+JWrVJwqo9892gqJhB+FMSYOvlZxIusmc4Rt5djWNPGAjtSmSOrxLTj/6Q1jEpRXPs=
X-Received: by 2002:a05:690c:48c4:b0:717:c1cd:3443 with SMTP id
 00721157ae682-718375398ccmr285616697b3.38.1753140885325; Mon, 21 Jul 2025
 16:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-67-paul@paul-moore.com>
 <CAHC9VhSY7FoQdSo=VvzZCs=_WQhOz+HKjV8jXe==-4wOCvpVjQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSY7FoQdSo=VvzZCs=_WQhOz+HKjV8jXe==-4wOCvpVjQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 21 Jul 2025 19:34:34 -0400
X-Gm-Features: Ac12FXxhmUEw4ux0NFNWPfm6MZ_No-FNPXdK9lAYBiDJVQT0JYiCod7HVfzsW0A
Message-ID: <CAHC9VhRYxY=2kPzHb6oCaEx7njzQBZmJK8PWhsr2W_LNYpkvNA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 31/34] ima,evm: move initcalls to the LSM framework
To: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 7:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Jul 21, 2025 at 7:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism.  There was a minor challenge in this conversion that wasn't
> > seen when converting the other LSMs brought about by the resource
> > sharing between the two related, yes independent IMA and EVM LSMs.
> > This was resolved by registering the same initcalls for each LSM and
> > including code in each registered initcall to ensure it only executes
> > once during each boot.
> >
> > It is worth mentioning that this patch does not touch any of the
> > "platform certs" code that lives in the security/integrity/platform_cer=
ts
> > directory as the IMA/EVM maintainers have assured me that this code is
> > unrelated to IMA/EVM, despite the location, and will be moved to a more
> > relevant subsystem in the future.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/integrity/Makefile       |  2 +-
> >  security/integrity/evm/evm_main.c |  6 ++---
> >  security/integrity/iint.c         |  4 +--
> >  security/integrity/ima/ima_main.c |  6 ++---
> >  security/integrity/initcalls.c    | 41 +++++++++++++++++++++++++++++++
> >  security/integrity/initcalls.h    | 13 ++++++++++
> >  6 files changed, 63 insertions(+), 9 deletions(-)
> >  create mode 100644 security/integrity/initcalls.c
> >  create mode 100644 security/integrity/initcalls.h
>
> ...
>
> > diff --git a/security/integrity/initcalls.h b/security/integrity/initca=
lls.h
> > new file mode 100644
> > index 000000000000..5511c62f8166
> > --- /dev/null
> > +++ b/security/integrity/initcalls.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef PLATFORM_CERTS_INITCALLS_H
> > +#define PLATFORM_CERTS_INITCALLS_H
>
> Ooops, the above two lines can obviously be removed, vestiges of the
> previous revision.

... and replaced with a more appropriate marco guard against multiple inclu=
des.

> > +int integrity_fs_init(void);
> > +
> > +int init_ima(void);
> > +int init_evm(void);
> > +
> > +int integrity_late_init(void);
> > +
> > +#endif
> > --
> > 2.50.1

--=20
paul-moore.com
