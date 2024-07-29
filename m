Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C818D4AF
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287819; cv=none; b=arqsBUuD8zMzyWzHG3/XQkmQdNqggFmMCjnMOYpX7ZxHpiU4Pon2PJANbJ15JHNpmw5f9owh2WYE3TFv3yq5gpiGBZRYEUKlG7TJz8qTvp2sRAOHidxzkiXAdaxD288/B8W23HHoJ+6OtP7TFc9ovUuU3X5Un2tvFKBMLCWxAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287819; c=relaxed/simple;
	bh=uIJLnIGDgHiwOY+EWN5WBZVqPwL+D43aRBBbMXmgfZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqBM70uO+RrxMr0WTisgLX5UZfpSHRojRLCUj5rAczS0aOvYIDkbZZM6NHlmi7+GoPZTj9056rzp3neMfEilw1KglVDG5wm/AMsX0IjYHvekv4RV02pNf07W4NntRQeys1T7T3VS9h2kE/p4kIpmPK5IT8FpbGy3ibRAFkSSZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZhU5ZkBx; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZhU5ZkBx"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e04196b7603so2313516276.0
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722287816; x=1722892616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fALvn/G9I42sSFKWi+Di1wKfzMY+rQ5ZRHFmVfS90lk=;
        b=ZhU5ZkBxboFE0Romau32/vctNoFWlPUBNl6xrtwsXIMUV+a88FOOGc44wLCr4BXLdx
         GS7nTi5AxsiamV8yEqFy0YDfw4zMVzb7jwhOBFqavV+jt+ymoUcCL23G3qrEkpA2WX/8
         ZppMHVFiyybOa9TTO0VX5Yp0wpoSdXIdJ4RFuXNWnDQSMgN7hjWR1NzYZHi6E9fLlCkB
         9n1BqTedcvHnoqclVcEBY76vWZ86qZu0WV8WoC/VS2MMpA8baWxCC8TifQjDzy3AX5CG
         qdhtgcnqPDoZoOyevOt4HJV6McY05f/ZlPbQvLXzc13s0IlW/cmDlPtOQwp5BntYF1Cw
         0RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287816; x=1722892616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fALvn/G9I42sSFKWi+Di1wKfzMY+rQ5ZRHFmVfS90lk=;
        b=dVizC3FM1VFaLnE9QV8x0gWjQmW1zvBi3OPAMSbyVlfin3HwCIXd4sA2F4MwFnaZwQ
         Ju1VKjfU7PmJl6vbk05QllZpaPI7hayotDLpSa4iV4gRvRkQ/eSlkjmALL4CIoKN5m6Z
         fuRwlAGpnw0finQ7amoj/xIc0y2nl5a9uPaCn6XxNW3jRu60XJJXfTTg7i7TL7/0kHnw
         sAKqN1niyPnOF/12Yq423mUOYyMfq5iWe4Ilgt3ypBV5MiuUHeuGUgmUYH00inKhlDm8
         ixeITy4uAARfEMYbnE25I8woR1kWbkgj2mBMxCNCtGOEl/WzXolFEFqJKJXe7AOETbHO
         rJuw==
X-Gm-Message-State: AOJu0YyDYJ69aACj6WOzRJcp6GTBxYf6+kPGGKwBYur1G9jyflOmOpV5
	UsHIPDdCq+AJXColygVp3SL/3avhnnZmuLgcU8RgtG6u+bD4BOTGY+IqAzxNJ9IefBJ58Qrgnav
	dsV3pFXbYpTT4RgPGXnnq/Jos9cNOfcIF02hM
X-Google-Smtp-Source: AGHT+IFabk8fk0C7XzqlqZkwYX25Z9yQwQ+VHu0bzqxh0S2HEvaTwSRhWALDsTMypjabqfygtPhITuNexJK850TcmJE=
X-Received: by 2002:a05:6902:1029:b0:e08:7950:5d2c with SMTP id
 3f1490d57ef6-e0b545e3cb5mr9954293276.49.1722287816722; Mon, 29 Jul 2024
 14:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710000500.208154-4-kpsingh@kernel.org> <b23e0868802853a9ab17e17fdc35c678@paul-moore.com>
 <CACYkzJ6HGdW1Vqs_KPtGLZEyX4NO8ZpreJfhoCoOwsWDdmAueQ@mail.gmail.com>
 <CAHC9VhSKrgzzpxZ4SemHcuSvHMegVzqQRqv1hs=EG1A47MBnyA@mail.gmail.com> <CAHC9VhRXoDtuKyNnQav+qNeqh76-YYSo2V2r6dDYYrk9E0oPaQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRXoDtuKyNnQav+qNeqh76-YYSo2V2r6dDYYrk9E0oPaQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 17:16:46 -0400
Message-ID: <CAHC9VhQ6cdwMZbQTSJ=1K5U58xQxQb=Tq4AvgmyQHPKB4a861w@mail.gmail.com>
Subject: Re: [PATCH v14 3/3] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Jul 11, 2024 at 9:59=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Jul 10, 2024 at 7:15=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > > On Wed, Jul 10, 2024 at 10:41=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > On Jul  9, 2024 KP Singh <kpsingh@kernel.org> wrote:
> >
> > ...
> >
> > > > > A static key guards whether an LSM static call is enabled or not,
> > > > > without this static key, for LSM hooks that return an int, the pr=
esence
> > > > > of the hook that returns a default value can create side-effects =
which
> > > > > has resulted in bugs [1].
> > > >
> > > > I don't want to rehash our previous discussions on this topic, but =
I do
> > > > think we either need to simply delete the paragraph above or update=
 it
> > > > to indicate that all known side effects involving LSM callback retu=
rn
> > > > values have been addressed.  Removal is likely easier if for no oth=
er
> > > > reason than we don't have to go back and forth with edits, but I ca=
n
> > >
> > > Agreed, we can just delete this paragraph. Thanks!
> >
> > Okay, I'll do that.  I'll send another note when it is merged into
> > lsm/dev, but as I said earlier, that is likely a few weeks out.  This
> > will likely end up in lsm/dev-staging before that for testing, etc.
>
> Quick follow-up that these patches are now in lsm/dev-staging, I'll
> send another note when they are merged into lsm/{dev,next}.

One last update, these patches are now in lsm/dev and should go up to
Linus during the next merge window.

--=20
paul-moore.com
