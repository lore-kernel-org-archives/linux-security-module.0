Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B31F03C8
	for <linux-security-module@vger.kernel.org>; Wed,  4 Dec 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343654; cv=none; b=Q181Re3PZMmUaPdQrDe2oFqz/6WBG0udATsfrE0XwP1AqfSOZv5TBgF1To34+nMyoWuGf7Y9K5XQdYxmct2++cSfffjbVCrXMR4lW12iurx8e42FnbxSCXFrnRhSk/u1XcZvUs+W+gia/zFJYo3MVsq3yDsvJFXOpbZAhu7U1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343654; c=relaxed/simple;
	bh=qvmU/VAVN0pvhP+IwnYOoDWxB9kfEGI58cN9BjeqFTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5H8e9ujct0PQuJ/Zhx7L816lAt2PPbNTW6BSCczRLiXlqTt2fq/I8bQVJcH7OXHTtSfb8mREgSBNsijskcCuQ/uE0rXCSl44uEktC+zMNZN+DaCVoUnKDeqEiZM2XVZbiYyTY6IuwjAEuTySk0DP2YiV+lQa4OHpaMBuiAuQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DsbWMXPW; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DsbWMXPW"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso251683276.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Dec 2024 12:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733343651; x=1733948451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLVo1t0oglaNriHIRqIrOTtgfyInHa0criF3pQMsL9c=;
        b=DsbWMXPWB7LyGAUEY/s9BtHUKNNv35HOoN6wwzyPaSle7wgArfU66800LgjRatcZVL
         R5OlJqK1EpuEqJUxnSNqsiOwJJzHGRdyQcWXdvXvGC9P/aqPC8Y154APZDJLoYQ0xfo3
         sjxatG4nj7gicxY9zUtWfUXX+emd0FrBNXf8oq90FAh1TcvbaQMKraKrBHqZ2LACfcC5
         OnK9mBmbrS/H0EyaVzMCp7zhDBTp73pWY+Vz7pZ6erHioE/A9nWjnYMgnK5OgfibjBV6
         GCG/e8DbzTLPL6W/jm59i4pd1CGLxw8RvIXTpMEYyyNLKwIyUMwaQwWn3T8Y41b9IL85
         VbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343651; x=1733948451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLVo1t0oglaNriHIRqIrOTtgfyInHa0criF3pQMsL9c=;
        b=VH5YDBN5khTL8Kslovv7hKA9kUnXCjkKfa2IOTShhBaqRr+UuYCQR+T///L3Q1KKTe
         /J6NGa3zi6GVtm4SRQpRcwkk9bocwq2OePuWO+slZhqq0wyX0yOKfoWC8gPeZYzFx/yp
         /44lCl1YmNwVgAXmNR0J85/fkmQzevN4c8xmnB6zRGdTBPJBna1f54syXzDdLmo2zzfd
         hk+Lsu1pAUmm8IrgG6KfS19Q3rEMPs1CNb1fV4qqXsGrBlQjS1QgsSPK9hGor4RzC0Rx
         hwwYnkOmxwlgcor4mTvJVmlEB38IoROLJIRgpXmkf7DnnL8ZnjkXkjxmAhaiAEYU0Qt8
         iCwA==
X-Forwarded-Encrypted: i=1; AJvYcCXr3Onxa/CwxmfFgpPwv9K4/vw7mtSpDKqgU2qf2VPEp7FRjLMruENsv6khFFTvLcjSEwX9b/5Y/PZ0+qnSumOn6o/wtL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ZAX9+Z05rJ5ge8OnY60sNIqrK8JWQ4vM8+k7YaSwnEPDVc8d
	F68QOZ27c2sFRM8iMyhyosG5PpfKOBQzKb4GHwXzx4kGDEvIej2hSiQJ78qlbjwaF/RSTHh7MzF
	G2w+wuYRdCaxj6YsaPqYHHtRVvFKkn2tbxePA
X-Gm-Gg: ASbGncs5iXbof+PbYfSzcGZORJW1VyMHyOuTOZdKM9s9S4gV9SD6nPJktBc3LxvdB9C
	LiSeILutpUBK7EkY6mUkPNMa7os8zXg==
X-Google-Smtp-Source: AGHT+IGtVlwm84qT6rzw7pFpty5lCqYBj1sQiR2A/cPp+IyhVfhXcyQ32GDnNhOfrYx+lZ2qHzOiPX1sC1xsOA9pfII=
X-Received: by 2002:a05:6902:2782:b0:e39:73bf:f731 with SMTP id
 3f1490d57ef6-e39d438da25mr7742955276.50.1733343650945; Wed, 04 Dec 2024
 12:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f16f8d81-3894-404d-baeb-febf2fba16f7.ref@schaufler-ca.com>
 <f16f8d81-3894-404d-baeb-febf2fba16f7@schaufler-ca.com> <CAHC9VhTfKfAeKKbe3P-ZxP-0Y01r0GF6pPvt=2FxvQzAeTGjag@mail.gmail.com>
 <6bf287dd-36a6-48e4-b847-3030fe3f7bb9@schaufler-ca.com> <CAHC9VhR8Pay3cePZVdvVwks36d7pfGNLUhUxSs5xPCuRcVtbRg@mail.gmail.com>
 <c8f5b77c-71d6-4cf9-9245-997ddffd72ec@schaufler-ca.com>
In-Reply-To: <c8f5b77c-71d6-4cf9-9245-997ddffd72ec@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Dec 2024 15:20:40 -0500
Message-ID: <CAHC9VhRxr0B9w_ntXRbhorfwZyJSbdJAJb_gF0E=GRrK2kCf1Q@mail.gmail.com>
Subject: Re: LSM: Replace secctx/len pairs with lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:16=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 12/3/2024 3:06 PM, Paul Moore wrote:
> > On Tue, Dec 3, 2024 at 5:54=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> On 12/3/2024 1:59 PM, Paul Moore wrote:
> >>> On Tue, Dec 3, 2024 at 2:29=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >>>> Paul, do you want a revised patch set for the lsm_context change,
> >>>> or do you want to stick with what's in dev-staging?
> >>> I figured I would just move dev-staging over (I've already ported the=
m
> >>> to v6.13-rc1 in my tree), but if you want to send out another patchse=
t
> >>> I guess that's fine too.  Although looking at the related patches in
> >>> dev-staging right now, excluding the rust update from Alice, there is
> >>> only a kdoc fix (me), a signedness fix (Dan Carpenter), and then the
> >>> two fixes from you.  If you like, I can just squash your fixes into
> >>> the relevant patches since there is no authorship issue, and to be
> >>> frank I'm fine with squashing my kdoc fix too, which leaves us with
> >>> just Dan's fix ... which I think is okay~ish to leave standalone, but
> >>> if Dan's okay with squashing that I can do that too as it would be
> >>> preferable.  Dan?
> >>>
> >>> In case anyone is wondering, yes, squashing does take a little bit of
> >>> work on my end, but it borders on trivial, and it is much quicker tha=
n
> >>> re-reviewing a patchset.
> >> I figured that it could go either way. I won't resend. Thank you.
> > No problem.  Just to be clear, do I have your okay to squash your patch=
es?
>
> Yes.

Thanks.  Everything has now been moved over to the lsm/dev branch and
should be in the next linux-next build.  Thanks again everyone.

> I may have introduced some formatting (e.g. tabs in struct definitions)
> that you dislike. Feel free to "correct" any you find as well.

FYI, the only changes I made when going from lsm/dev-staging to
lsm/dev was to squash the patches.

--=20
paul-moore.com
