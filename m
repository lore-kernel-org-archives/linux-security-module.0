Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9E1C8FCE
	for <linux-security-module@vger.kernel.org>; Fri,  6 Sep 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637071; cv=none; b=bTyNR59IzoAUbw27o9350JbMEfWyU8hlZWpdz2Ic7JFQy0fKei9nADXpX0lmdPEjHm063pSr8Nq6EZ3bkFyl4BvbJiprq+VXWT67ZxfeKtR/IgEkx3iwtFLSKLyPNx9+rO1qyxGnBHif+VHLAufgVR+2C5PGHsdRr9j47txcLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637071; c=relaxed/simple;
	bh=YYfsMooY6JRsFx5MjH08AaUAn1lLYbeFUCeUENE/piI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZWsfjhi3boXs+GXeYna3FlGWAGeirOUNTXvG4byoMMW5Let8iu7w5SSr82CXRSjmurmcU4ky0/iwFeK7Q60WfHpe6OVzqyg2J3ph6JwBz9rGl1MBdCDdxfYn7p26x7rWx+6lVhO18zLHtoquQihv994dYdl3qbG9oTa/xvxnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ALci5JqW; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ALci5JqW"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3df0df4814eso1474843b6e.2
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2024 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725637069; x=1726241869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51fSNS3rM+FuqMEGUJ3gTvDTMw/vdesIgPrKMZDJNvk=;
        b=ALci5JqWuhD1I2/5kkz0L0xD4hnsp+NlgaWZubGzpCFsrFWi0aUexPk83NYHY0AQ8j
         0pJbEaeg9JMNFAWDAPx8hHI2srcpDmFvERykR3rTQe35wzN0UJ58TJrwY/V7AQ5L+28Q
         eIPhvWjV/dczc02mDYH0ALMOtl+cvfClV6GYRmZ0hIl5a6VUia5o+G5Vrm/JIYf1AJ+s
         zgLC/vM9KyOG3tnPg2SAWfJA65d2QXwcUegaJ6h1l/sumLzWYfolWZUixlIgElfVwFx9
         YSQjktZDSxd30HkAIDJO74Geu9KYTvS8qoFJDzWf9+R56zm+Cosyb5xlpVVEuDqiZigl
         neEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637069; x=1726241869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51fSNS3rM+FuqMEGUJ3gTvDTMw/vdesIgPrKMZDJNvk=;
        b=OO1uNM7dDtXQaReYMHXlTq4yN7OiV+L7ZwuXNRPcw0r9OxVubumkuTtmCX3idy1uEA
         7qzJxYO8UfBCrRq7/loqZkWPXpj8shn64yY3KbVzZI8bznto9LxhLABhhrSNLdJy1NKO
         sYKH7ansD/CdPk1+wWJVF27ll1wD6yGiKneujHDHGIMdUxN7Z3UZAka82umCOW6pTE8m
         7jftkclodL8XIboUBL9SGkEcHMAeA0wCIHG27Nmk5+8NwJIVxVEZgzgCbdQLZ4y0EU5r
         PXiEwEnI3Pn8DZmSN23u5JEH+FkAHonqjpaZ0xu3gMS2ZXiCvfrT9mzpmOXdz1kVcX0f
         swzA==
X-Gm-Message-State: AOJu0YxhZ06XswjREi2ynIu/T5aN1DN3Cft7EDp+xZVZt2hgyx6cxnDF
	PoRnzvLcsvCQ4yMacuobUXv2xuOp+XkVCCq5GwHHsD9+mTVFIdYda6JEztzi7l9V9cUXJ1hxeN/
	W8FeoPB9t0eamB0NKcmtSXG1xRtBneS/PPwRz
X-Google-Smtp-Source: AGHT+IGCTXLw0gynr5maKctmKNni/hD/6+szND2YFDicURbzJQ4hM6uz31CTQAhYHzSUA20t2HKgRIzxt0IIRzb3xIU=
X-Received: by 2002:a05:6808:2e85:b0:3e0:1222:b195 with SMTP id
 5614622812f47-3e01222b388mr9953931b6e.20.1725637068660; Fri, 06 Sep 2024
 08:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809122007.1220219-3-masahiroy@kernel.org>
 <3447459d08dd7ebb58972129cddf1c44@paul-moore.com> <CAK7LNAS4Q1_4T2vafu6wTYsmFsY1h+TA8irqDAqwfoSyw7X=Rw@mail.gmail.com>
In-Reply-To: <CAK7LNAS4Q1_4T2vafu6wTYsmFsY1h+TA8irqDAqwfoSyw7X=Rw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 11:37:37 -0400
Message-ID: <CAHC9VhSz+kwYOnkfWPHOmoKCRfOjm3_L5xMLeSGVNxq5g=ikww@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: move genheaders to security/selinux/
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 11:19=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> On Tue, Aug 27, 2024 at 6:22=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Aug  9, 2024 Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > This tool is only used in security/selinux/Makefile.
> > >
> > > There is no reason to keep it under scripts/.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >  scripts/remove-stale-files                                 | 3 +++
> > >  scripts/selinux/Makefile                                   | 2 +-
> > >  scripts/selinux/genheaders/.gitignore                      | 2 --
> > >  scripts/selinux/genheaders/Makefile                        | 3 ---
> > >  security/selinux/.gitignore                                | 1 +
> > >  security/selinux/Makefile                                  | 7 +++++=
--
> > >  .../selinux/genheaders =3D> security/selinux}/genheaders.c   | 0
> > >  7 files changed, 10 insertions(+), 8 deletions(-)
> > >  delete mode 100644 scripts/selinux/genheaders/.gitignore
> > >  delete mode 100644 scripts/selinux/genheaders/Makefile
> > >  rename {scripts/selinux/genheaders =3D> security/selinux}/genheaders=
.c (100%)
> >
> > As long as there is no harm in keeping genheaders under scripts/selinux=
,
> > and based on your cover letter it would appear that there is no problem
> > with the current location, I would prefer to keep it where it currently
> > lives.
>
> 'make clean' is meant to clean up the tree, but keep
> build artifacts necessary for building external modules.
>
> See the help message:
>
>   clean           - Remove most generated files but keep the config and
>                     enough build support to build external modules
>
> 'make clean' does not clean up under scripts/
> because tools located scripts/ are used in tree-wide
> and often used for external modules as well.
>
> So, scripts/selinux/genheaders/genheaders is left over.
>
> genheaders is locally used in security/selinux/.
>
> 'make clean' will properly clean up security/selinux/genheaders.

Your last sentence is confusing and doesn't align with the rest of
your email, please clarify.

Regardless, this sort of explanation is what one needs to put in the
commit description, a simple "There is no reason to keep it under
scripts/" isn't sufficient.  Patches like this need to provide a well
defined reason to justify the code churn.

--=20
paul-moore.com
