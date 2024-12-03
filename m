Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F71BCA1B
	for <linux-security-module@vger.kernel.org>; Tue,  3 Dec 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267184; cv=none; b=je2mjbY2iWX30dj4DHPA4WmSdkVUyLAiO7rgbU9GbWO0nAZrfZB0KmmO/MC2ux3G4VTvi2FrJwo03h/+80c5nt2i47Q+DxR3O4NgmwJX6O+Lj0bRHAonRZoPmo/YXCEV/DQA49EaKTdk5NEPPLPsGZa3/ADJQJWbaGZITckfgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267184; c=relaxed/simple;
	bh=NMt5FHakGGrLgWcGUNaUqZSdXY0qGjmeoTtt/KCHmDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY4jUh5x+VJbaK+TMKZqzQmqNSo5c2g2dTRVe7DMcjFsBXTS6gzqEdb4wzcgGBpZsyWEfkCtffGWaaXVylZrV2JfRWHcjRTez+HPJBPn/akKA/7R+9o6orfKwLR04CSlZ7DOPc7obrq+2gt1fLNVl+/d8VOVJcZM1se3nByDshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UnDKdj9b; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UnDKdj9b"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3983f8ff40so4216228276.1
        for <linux-security-module@vger.kernel.org>; Tue, 03 Dec 2024 15:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733267180; x=1733871980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fK7RVJHUThEMc0d1xgheqh1PFa7iPVezswqb0VcBGYo=;
        b=UnDKdj9bdRDtFZ/sJBf/BdyitT0J+vpHPBdyWxyrd63KkvQ7OFfCbXlr99qzjpjFUY
         B4BeyZ+N5+6uiIrTp8yL1KiJF5UOMekvEEYwp/iChSxwRnIIUi9RQZWp6rHoYy3kYd2A
         VWfGpOmDBFewMSNlC2kZMUkJG0sEM/aatu/NWCI+Q14YKrBpni012c3uzXI9XnH5FIYd
         Jz5ngJtmW9hGYfT93hUqhwyYPDSr0F0tB/ZH7JnmaQIpElqIvUbTD3m8HWAeRS5eVgbK
         nk4Ba1xXhOAcqbt3uo3BGyLp9STY24AuxZBy6tSS3DLxBGX2/HLjPn5zzOQtP0DxJrei
         Jirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733267180; x=1733871980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK7RVJHUThEMc0d1xgheqh1PFa7iPVezswqb0VcBGYo=;
        b=m513uoBF7g4Az2Zv4UjmhYAEXSArOSvhBWSLsF/XcU6nvSp2EIT5cqU5MYM3IdhrvA
         a4fIFTPmBU9ekWlbc20/jWtOwD0kQKb8VjaOIbtfXzh6gJZF3UA8Ea7kxWTBhTnZPGF9
         HxXrM7G0AwTlXgdG3d/d2R8EfVH1gKqRLUvoZCNxibr4YxDNrZFaRhDLhEq29QbZKp6/
         mKE69735LDOq+I1uHTXm3iLgqt0aw6KhdQ6hhnSw2DvYdT7VtxwWFPzMuSnJW5J39o0C
         xnZ19fXm5/9eIvzAgjoBPLQg1ywc7oIxkBKyovB2e2gMfxbbdwmYS3MbX24oXkFr+c7j
         vGRA==
X-Forwarded-Encrypted: i=1; AJvYcCXUrUrbajE41rqLK2G0uttA004m5FhXFI1fK3aV6E/Z1QsSoaZakr5/AaYcaYrzqezP5q2mS6QWzegB2av1jv3T+H0dCeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMlqls74qg8qge2ZIEoHO3/EDauig1zJQJKUk4r+XECNnAZg1
	hUvSnqriK1+svuE0RrQk9cvzBTniouSjcIwjA0pKvt2gT7sUeTpE64X84Xbdbn28hALUwVNMJPk
	mfg+JkADx98jOXuLfO3dqDXZNIQfWqxk+r34p
X-Gm-Gg: ASbGncts5X6FFKKkqULmsY0oF7FV3jJyxTjZInYZnjO3kvTWcwrBEAM4SCt4zcgxO05
	4rGYcbdEfflIyF21SuQhc/HWIhzX+aA==
X-Google-Smtp-Source: AGHT+IEuEOuxjDip1FYkS74Bf282KPMLzr3hanbnB3o+CCi8fcmxdBf7Fsrwq9fD7FfLcZ7M8nFs7Mmo4roc0JXpqig=
X-Received: by 2002:a05:6902:2b86:b0:e39:852f:e7b0 with SMTP id
 3f1490d57ef6-e39d3a290f0mr5704596276.13.1733267180396; Tue, 03 Dec 2024
 15:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f16f8d81-3894-404d-baeb-febf2fba16f7.ref@schaufler-ca.com>
 <f16f8d81-3894-404d-baeb-febf2fba16f7@schaufler-ca.com> <CAHC9VhTfKfAeKKbe3P-ZxP-0Y01r0GF6pPvt=2FxvQzAeTGjag@mail.gmail.com>
 <6bf287dd-36a6-48e4-b847-3030fe3f7bb9@schaufler-ca.com>
In-Reply-To: <6bf287dd-36a6-48e4-b847-3030fe3f7bb9@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 18:06:09 -0500
Message-ID: <CAHC9VhR8Pay3cePZVdvVwks36d7pfGNLUhUxSs5xPCuRcVtbRg@mail.gmail.com>
Subject: Re: LSM: Replace secctx/len pairs with lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:54=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> On 12/3/2024 1:59 PM, Paul Moore wrote:
> > On Tue, Dec 3, 2024 at 2:29=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> Paul, do you want a revised patch set for the lsm_context change,
> >> or do you want to stick with what's in dev-staging?
> > I figured I would just move dev-staging over (I've already ported them
> > to v6.13-rc1 in my tree), but if you want to send out another patchset
> > I guess that's fine too.  Although looking at the related patches in
> > dev-staging right now, excluding the rust update from Alice, there is
> > only a kdoc fix (me), a signedness fix (Dan Carpenter), and then the
> > two fixes from you.  If you like, I can just squash your fixes into
> > the relevant patches since there is no authorship issue, and to be
> > frank I'm fine with squashing my kdoc fix too, which leaves us with
> > just Dan's fix ... which I think is okay~ish to leave standalone, but
> > if Dan's okay with squashing that I can do that too as it would be
> > preferable.  Dan?
> >
> > In case anyone is wondering, yes, squashing does take a little bit of
> > work on my end, but it borders on trivial, and it is much quicker than
> > re-reviewing a patchset.
>
> I figured that it could go either way. I won't resend. Thank you.

No problem.  Just to be clear, do I have your okay to squash your patches?

--=20
paul-moore.com
