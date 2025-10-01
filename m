Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98892D373E
	for <linux-security-module@vger.kernel.org>; Wed,  1 Oct 2025 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339412; cv=none; b=b0M+e3Unkuw5Tfg7JN1tlh7g5JeitD3QueJjRnWEHCtCyUKrBQz5idguaXaveDR81XeD4UpUE6jDaqkJquGpm5QMzmSQlbQAiG5chopf+kexCi/2siKUIvkBS42feRqdO18BDUgr/mXYvM1T3qrBAKXH+1VsOwWEAMvpPUx2t4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339412; c=relaxed/simple;
	bh=vsPlh3ofkK40nD4oh1txivgwz7LE/MFKAz0pnaqBHqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOBXuCR3uVYCMnfKCO2EhqrJ6UR4U9fCyDtFncHm4tHca8b08LYNOGq3wLl++O6DLCM2Tuk074z0OKSPtLxYTpPehAp+oJ+XjreS7D9zAeU0wt0O7LSAQznGj03iZdjEAgld8zbrdsKWvg9SHl/b3H+RkrgMSctp1RfhMo/83k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fm3qY5s+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fm3qY5s+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-330b4739538so164184a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 01 Oct 2025 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759339409; x=1759944209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hQfDadg9cH7O8JL0PpNR7NVHIctIuiLaAsHpbAddsw=;
        b=fm3qY5s+8wWO4eAdfuZJs4cL38y6ZwEBiwT4USBxxkJ+laN9Xrm93Vpjrv0HfiS2uj
         8iK6+CODxcTQ3P8o8/5XpFQymaqntotNEvejtaPZJmT4oojAC6rfwNXyujabWytjUtOZ
         wWvAmBTUyk8GznLViGsHtyHb48963nk+1mZHz/bmAMkWKIhhzgDdJrxqaGbUylGwPdd2
         Y03K4fNrHaKCIwNBvTpvXUeGOgdCW6LfMaVtdz7iy+CNkz6oNf2yLeH6zJOANE4cbE7X
         6NTOTn2lmZrRC4DlGfT2cWuN+iY/WXxgQyQWP+6a4NA2haeOYEkVbQUEV2AWTWXL0zOx
         wKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759339409; x=1759944209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hQfDadg9cH7O8JL0PpNR7NVHIctIuiLaAsHpbAddsw=;
        b=qkVCkkN5HzJUuBvau4cEq8ivYgz273vwiL21/yUuw+wA4dN//IAL7nLAGZhTNkNmQL
         nerRpdhraVg/oO6Ezd8pFOmJgddmLS6/Ig+4uWLLJVf7K46/aoMp0bIWpiGD35jKctk7
         AGsG4bFtqDJsxsfAUlLtNdsrTGvjhuP42b2fZ3yR5ffS0cpojjwY+lXNBc0HcEExVWkM
         5cEow5Ksi+Pl+PM7UjvMdy81Ec9r3rI4yTxysgKKtimAtdwMh8H/0w1KjYQDQBUDDDx/
         p/UL9IzSfy9BX53W1njux2Sy8t2t6IJDYERJN7vsPdthXiDQ6wacknWYYJD66w8f6CP7
         PQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCUV2xySBbb9lOIOp1t/unF0SkKLVEZcl/vVzy0iXp5Kg1w0Kaw7D+aRp09aznJIVykSNFL+ZOTvA5YJQr9/N30wDvHOtNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+1cmeXM4zq3w4bk4+85MpBz28KGySe4Ql+5xalx+T6otYJIv
	AjUmlCuCyqle8a8slnz57WdV1fFLtnOlZ6QIhS45vodLHQFRk0I11g021Q6HlYMBpkd9TmCXMP6
	SIA7puRV8nTcGWiq7srAupvnqj9Q0WYiRz90RXkpC
X-Gm-Gg: ASbGncsT0TboGrzbfaKaap5iEoVXtjhq+ucX95Yv8XDIDka3yNdrxwoj5HcEFSJuGcy
	OewRIaqalSGz669QtZTfZZ8jTuKDT4a4UI2923jl4XdikXj1SLItQ4TQ4sEZSu1qEJFV1GYk/I7
	eHZ0TF9S1tcGyBEQKLv3yA70rcx2NhL3HKKq8kjGgppfDE1qCOAvmRKvqBP1kQ5X7zsEsZ4TFRW
	uEug9FQ/eCtfiUEPviQaFvz8jF6hq0=
X-Google-Smtp-Source: AGHT+IHSZpNdumcu7xIxIOcapGWuz/GigghyCRMIZtfsERkgF2wZnurn0K11mwecCIE33UU46PIqzjRqwrvw1Ko9E4g=
X-Received: by 2002:a17:90b:3ec3:b0:330:6c5a:4af4 with SMTP id
 98e67ed59e1d1-339a6f78dc3mr5280266a91.35.1759339409237; Wed, 01 Oct 2025
 10:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-67-paul@paul-moore.com>
 <CAHC9VhQCmFJQ1=Eyu1D+Mcg2FVDByrk8QcwV5HaZdB95esiA7Q@mail.gmail.com> <74178ea117c18f88b4c3607e5a2afb81fc80e428.camel@linux.ibm.com>
In-Reply-To: <74178ea117c18f88b4c3607e5a2afb81fc80e428.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Oct 2025 13:23:16 -0400
X-Gm-Features: AS18NWDnvYZXYq8VCq1DpUw23rMeksImZdWvaJeTivtSGsqMbGTbafCRdUufbxg
Message-ID: <CAHC9VhQRqq8_=5B9RYoAEH4FKgfqXx2MEGuEJNiho-mXo-mLRA@mail.gmail.com>
Subject: Re: [PATCH v4 31/34] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 1:04=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Tue, 2025-09-30 at 16:11 -0400, Paul Moore wrote:
> > On Tue, Sep 16, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > > mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> > > evm_init_secfs(), to work around the fact that there is no "integrity=
" LSM,
> > > and introduced integrity_fs_fini() to remove the integrity directory,=
 if
> > > empty. Both integrity_fs_init() and integrity_fs_fini() support the
> > > scenario of being called by both the IMA and EVM LSMs.
> > >
> > > This patch does not touch any of the platform certificate code that
> > > lives under the security/integrity/platform_certs directory as the
> > > IMA/EVM developers would prefer to address that in a future patchset.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > [PM: adjust description as discussed over email]
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/integrity/evm/evm_main.c  |  3 +--
> > >  security/integrity/evm/evm_secfs.c | 11 +++++++++--
> > >  security/integrity/iint.c          | 14 ++++++++++++--
> > >  security/integrity/ima/ima_fs.c    | 11 +++++++++--
> > >  security/integrity/ima/ima_main.c  |  4 ++--
> > >  security/integrity/integrity.h     |  2 ++
> > >  6 files changed, 35 insertions(+), 10 deletions(-)
> >
> > I appreciate you reviewing most (all?) of the other patches in this
> > patchset, but any chance you could review the IMA/EVM from Roberto?
> > This is the only patch that really needs your review ...
>
> I've already reviewed the patch, just not Acked it yet.  I'll hopefully g=
et to
> testing it later this week or next week.

As mentioned off-list, a review-by tag is worthless if you want me to
hold it for your ACK.  When I'm asking you for a review on code which
you maintain, I'm asking for your go/no-go on the patch for merging;
that's an ACK.

--=20
paul-moore.com
