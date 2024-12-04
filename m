Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFC154433
	for <linux-security-module@vger.kernel.org>; Wed,  4 Dec 2024 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341517; cv=none; b=tSqGgwQa1aH7dk9R9R5JcTxHmaZp5YXiS/aA4wvE6SWiM0CqYLUHFUEUDhJ+sPvw7HHm0XVSLvi2FxEq5q44f3nl04tbRFc7iYjycXya+0mBfXC/AoqHAozpTQ9l8eQ8vu6a85M2fPiIe0oYMaEjId0tXRxK8dK+KdRDX1vqLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341517; c=relaxed/simple;
	bh=UAkwa2cB6iXtXZ73Zwtwfu2Ebwdp/3xHmhRhqzDlhcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH0zEf6yoCxOQj5MZx2f+1tV+0vCk1DhgxmgLoalljrXWhh+o5UUa+DXDoVEZG+QSAoMCPTzCk1dYEyxZ4a/bqW+M2ikSbdWfgYhm+5WF7dWYwrF0LEK1u5nlFiFDkrH7WFqjidv0YC1g8X8hxrMRYLY281D1fAesAO3b8tPJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hi7+YswQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hi7+YswQ"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3971be41d8so126624276.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Dec 2024 11:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733341514; x=1733946314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP4SSjgJ9EZghLG63HAk0V11vB5Y1HI8YOM2R0ZNk4U=;
        b=Hi7+YswQSDQ/MEUFGeED3pDFF5CSTp55iTsJTIDOgojnwzmgkftsFkBBu/ftfi5frw
         wbfxKgFh44stMfIn9AeieGZfOtcy3fFmQY+nVTsPjSD6su3W7JHpQVZVZZKEjc6YNyx7
         Jits2iY+KjDjYG2qI32z07v1+pIl/IAXp9dRc+zGq0kfP8kmtjpCvM2e9+CL1zS2CRg3
         4G8ZpsB54fQK4wW4qz6vrjPHUKwqzJ9CkEY6nq11Qftt1iketYNdvcKmT0Lo2xsyq1p8
         WR4zHBC0TCUzB5e/Or7W1YgBOjvesVlw+XIEqO9+c2owIhbVvKyA5H88omwM+n1uaCH+
         DmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733341514; x=1733946314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP4SSjgJ9EZghLG63HAk0V11vB5Y1HI8YOM2R0ZNk4U=;
        b=ugWxkEP6UHN+pM9ZPxvnzsNnYVFyE1CO9hIUk7jhqxih2o2cofJ/8liGg2P2jFUuz+
         UIWIVN7JdluklBusYkVpJonvBe6RKf/Fubx75Y3nkFQd5102sY1k5S9XzwSxUy0X/c4W
         aMJxzqbiO4qhlImrb352mH8cArrxanFDXYvCsjoLNVFaAxkCl5GPrVdTX53zQVzKG/AB
         2duTd4tnGpodllGoYK89QukOfXqi5DAmwx91fMU6CFieH+ycf9cyGr30BFNhLEvmbz06
         Irhcx+WMyvqqxWPYzpKuPOu30CwWwRMyTgkXhjYvAS19bnEaUfTQCr4jxua17Iu9BJbD
         TGQg==
X-Forwarded-Encrypted: i=1; AJvYcCWKqlNNtz7YeEhtMzWEhSuNGMzYQJEcTVZmr7X+nti2aLbGmf8X8LotTrMvbPpnOSszPsmyMzCaiYx6iO8O8PFmTRvKiJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDsrz0hy3M0JttqUG/yOSQ/XmCxBDKmS5wIwy0ZBG6BRGMBQ1
	QauZLeq3nllajn6KZPlsw56/KWJ4rcxQsmbDRcSv5IYgxwg3PrcBJTBzDdUCIFt9d8anJR98Gnw
	EXVc67fh+SNN5Am8Z1AfUrVn/m/sbklRPRNla
X-Gm-Gg: ASbGnculY5LTxOpY6oSXJdxfOiT6dGv6pVRUY4g6ILU/8+WWnLFOTJwjhv5bDiP1QwP
	mVy0Oib/HnMb/p5ByeLZ8VKh9lRIzmQ==
X-Google-Smtp-Source: AGHT+IEWqnyl0K8M9qISW0xNz4dzRz38cEKi8U1ZPf7D5pKO8FFHQ2DZApWu+/YL2nCRQLrf55oafMFNf/PH5hQZze4=
X-Received: by 2002:a05:6902:1022:b0:e38:8263:7990 with SMTP id
 3f1490d57ef6-e39d438ff2fmr6780032276.48.1733341514392; Wed, 04 Dec 2024
 11:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f16f8d81-3894-404d-baeb-febf2fba16f7.ref@schaufler-ca.com>
 <f16f8d81-3894-404d-baeb-febf2fba16f7@schaufler-ca.com> <CAHC9VhTfKfAeKKbe3P-ZxP-0Y01r0GF6pPvt=2FxvQzAeTGjag@mail.gmail.com>
 <3a3c35f2-1228-47f2-b0ad-5d861917ce11@stanley.mountain>
In-Reply-To: <3a3c35f2-1228-47f2-b0ad-5d861917ce11@stanley.mountain>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Dec 2024 14:45:03 -0500
Message-ID: <CAHC9VhQJxBGOx9hjYoKrQdzzebL7j5Y6GLrqjXvo8AULnFqdgQ@mail.gmail.com>
Subject: Re: LSM: Replace secctx/len pairs with lsm_context
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:25=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
> On Tue, Dec 03, 2024 at 04:59:12PM -0500, Paul Moore wrote:
> > On Tue, Dec 3, 2024 at 2:29=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> > >
> > > Paul, do you want a revised patch set for the lsm_context change,
> > > or do you want to stick with what's in dev-staging?
> >
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
>
> Squash it.

Thanks Dan.

--=20
paul-moore.com
