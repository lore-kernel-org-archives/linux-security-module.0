Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A07BA5F
	for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2024 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714344; cv=none; b=fEOyp7dOdZubNVumFbI8bfvZLNfNQrD2WETOU26RYiNRVmQfMrc1ayrn61nrnpp7nWb6RrfGImlx6S1Bbs9qdmSj8E1I/dNAsquN9T477on1CvnYe0wG15a73cJJ7AqqZsjj+X5a6yR53IegTz6eOjOtdyhOmkZf4hOFXCVZ8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714344; c=relaxed/simple;
	bh=1PYz49sSx+NRllGM0ls7hUrlumcBxA4K0yn9xcML9vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpdKosUd9UJFbWVzGdlXCWCPn6k4hUjP27Msu5S89eIs80WQ6Jou+uEagyExHJBnvkuQ90OmmKdDBqY6yqKTbsisu+IWh8UUbKmi4vDXQ8A9bYqTBzFvaaR3KKHG6JX4Oh42InBD7KfSgXhLcPMxY3OVwGidLr+/yJ6jmc0X2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MsB4hn8z; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MsB4hn8z"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-617dfcf80aeso47329967b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2024 18:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712714341; x=1713319141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PYz49sSx+NRllGM0ls7hUrlumcBxA4K0yn9xcML9vc=;
        b=MsB4hn8zFw5lLyXXAgrQrozcKYxToYhH3wvPDs0cp9rZ+2StXcvnEpRuQnTRvIsEtU
         PgFWkn73bFoD2EcN7GVL3rPoPbSqvTryuniTbZqLxmiQg6qgHSUihN29GtprJIy661bT
         CMphKjIjv5s4MgBd0RBwCm1FP+OGe0Fmx1kLbpaGCw6dp07qWEiKt6owJNarx4pu6CE1
         iJyj2ML0Py7VmS/YXJ6ZEdoXsuP92CbvsprtUyDrriyjLgfaioJ8XympZibqGIwS2mOQ
         MGXbLI5opjnxRNiP1eOA73APf4LHFunyY6CSGrX7pGUdUbmcKysZFROeCHBcrzXdefpj
         QvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712714341; x=1713319141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PYz49sSx+NRllGM0ls7hUrlumcBxA4K0yn9xcML9vc=;
        b=qUzUZSsKQAJhSJePcSDG7ES6ikJsU0yMD+qX9eW/FVCDU0OUh5zKJEFSgNTIUGRVH7
         lip1ko5ub+1fZL+mljWKS5HcR2CLj3kzzYH3An0GYmmx1ygFpy92/XbcmZG0UoPthw0n
         OTjb7sCWA5QkrJ6YrxjnCjh69cij8MDKj7d6QFKSGsn+BqHHQ4X3P8s1GacVEoXh6IYI
         5YKUXO4ymVuzGlO7kadr8HtgDu8tUzmdsL1KB60HWR2DTtirfYpqTGirOosdLvDSk9a3
         ky+FG448f1VUs3VnZniWvCVPqvoTnc+LP8BPgLztfjMD1CohSPMDo9hnOOX3ul+ONJ9A
         4MTA==
X-Forwarded-Encrypted: i=1; AJvYcCVKdgw0ktBIFMyoRYrd3MF5LbEwcWH8kHNCpDhOEIrfrkQN82ePBp9km+HyxJEBG/RVpirgTbb2VNudNenLUvaW1WzMblYUsQbxIN9ewGB81ygesPvE
X-Gm-Message-State: AOJu0YzfSBZOBLENNAL02doOtU/A6MXIjPQ47+Ljc1SIeWEnfA7Iydae
	YS5foMR4CSb8JSu/nEdeIOBBrNJhKHpy91n0zk7JZwiE2XteJCxShDD9c7GGuo2GIXqBqle2pGp
	SaaUuSIOw5mh3PdYnIpSd5sgBgnVdHxpazq97IF4l6Zxud8TBfA==
X-Google-Smtp-Source: AGHT+IEMjCkoCdOOwgxQEXQvaj3b39y4C+BJdwAc7nA4SjXcpaY1r8Vx5yiKeDWw7zVBTCLZMScriPYj6ZX+Bzq4SV0=
X-Received: by 2002:a0d:cd06:0:b0:618:1ce6:b618 with SMTP id
 p6-20020a0dcd06000000b006181ce6b618mr1425559ywd.12.1712714341435; Tue, 09 Apr
 2024 18:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
 <37ee8a6c-ecd1-4669-8e60-df6adeb0eab7@schaufler-ca.com>
In-Reply-To: <37ee8a6c-ecd1-4669-8e60-df6adeb0eab7@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Apr 2024 21:58:50 -0400
Message-ID: <CAHC9VhQfTRCOCO4hQtvRBd-UdwVKkG-5g=Ng=oo3vTy8C-u6SA@mail.gmail.com>
Subject: Re: Hardcoded security module suggestion - stop the stacking insanity
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	KP Singh <kpsingh@kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 7:34=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> The question is what would be acceptable? I've been proposing LSM
> infrastructure changes for a painfully long time. I'd be
> de-f***ing-lighted to hear what would be better than what we have now.
> While I can't change the brain dead behavior of 21st century hardware
> I am perfectly willing to re-write the entire $%^&*( LSM layer if it
> can be done in a way that makes you happy.

Relax Casey, no one is rewriting the entire LSM layer. Perhaps more
accurately, I'm not going to merge a single patchset that throws
everything out and substitutes a single-LSM approach to satisfy a spur
of the moment comment triggered by the latest hardware flaw.

We'll sort out the static call conversion first and go from there.

--=20
paul-moore.com
