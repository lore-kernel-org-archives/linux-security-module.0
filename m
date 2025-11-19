Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B081EEA31
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512183; cv=none; b=eRV8pZAe+dlLo6QzgkRynjR0EhuvQ56duHKUsSfmu4BQ/0YZ0+9EnLOOvzEHb+PLL7EbNStd1cGauq2XM83LhQfZo8eilce1cIbkhJ9KvLenNa0N2oiH/FdjehU6MhsJi4WkoVReNuQhb5mGBw1Fkedq4jKuBh8H487XDRTImgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512183; c=relaxed/simple;
	bh=iv70GJ/6t+yXrEnyDf1Alh2RYkQ56sSWfuxhfLt/iFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfIgBTJSkdeONcIlt/ei95p2CgMfb2CmxYpnKJZ8sCJVnmp9dk6Cyi6+LfGavJVf9OyiJDAcO7li5SfkFUQuvenKNwZN4PV/hGZ+Ks465nxULiaxY3eaE9ajlAThI5JmjUG76R6/ylyYrs07f9a8QCdfdFl5tg+jIbrb5Kn3qBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VfV+Jh6j; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VfV+Jh6j"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343ea89896eso6129952a91.2
        for <linux-security-module@vger.kernel.org>; Tue, 18 Nov 2025 16:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763512181; x=1764116981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2ddrBpmpU3vDOG4lPvhDfPGJypzJaN9aZfBj3Tz9as=;
        b=VfV+Jh6jhbaT8MXcRei+azPhuroJUvB4S5ljodj5OtREZYlzVwEKt5kRxk4BFkY1aB
         K3cHaibeAbCp7siCbDrLERu6rt/GRDnj+9/9T03BC+cchfeFUfIPaKjUx3eyXC9CFDMW
         IKp+CZzjw1JG2J5kk9xJHX6Niye4M2ahZL0JixIAfAXLYTOx8d7QjkQ5ruXcKwUpZKyC
         W4t4GNuQRDLzCMERkOvU/+SrwOH9mvTO1+FU9X7mG4VLyBT7/4jHdwE28Hw9t31PAJL/
         cUcMiO1GQHsl6VN916lbb61MjxTDInW9fHtyzwGIzH2suNBtQVr5duClHj176FJys7w5
         9Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763512181; x=1764116981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V2ddrBpmpU3vDOG4lPvhDfPGJypzJaN9aZfBj3Tz9as=;
        b=Ubziy9hu9cN5TXgRAea8DS6Y8ZdkkmjAEZqMm0QI+S/lOJeL4wMZp3imHblgU+C5Vk
         llKFnQjdHH0snWj4dvLn3sYxfbSl9Gy5nk1DpNpbvsPsyXTRkdz7lNxFuCEEWiLQ3yRV
         M5x1N6s78I0PNQRIWqDx/f6f0GO5vuqW9JOdyfRaV6bCHgOeqzsL4i8NFWW7bAycigrh
         oYLBV57jn9aSsOOEFklSSQKb4rf+vly31Kmaq4Dhgkq9AniUYVu9qqwj8xNl7EGdvI+I
         BtAYy42rG19QzytHtIYaoSJ3+XYITy3YRt7Mk4ECxxvDLr5UPlQBdTevdZMn6nwI9urL
         JX4w==
X-Forwarded-Encrypted: i=1; AJvYcCVwqr4K0zxbUMjaSRLzqQR/UM2QZBCb5fObjElVOlpLQ97afKGQS2rpcMN7XPpTLfszv0MWtbaA5EwekRYbZ8GYhW1hOVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlv5dSdo81gUfgsxnz00h9BswGd7b3dz0QCDa/ryOJhhtjhG1U
	xE72A1EL6uJBy3nIOXZjQKJ/4cxcFoXO8VIrHm9tG2Lmu/nILiWK66lhTRujLcgOeSv8vzOKz2+
	RMnwrue6EGwV60p4aqwqcrtWrQkQCKalUtXjNAwva
X-Gm-Gg: ASbGncvWBPjtU6dtw4drsg3aIMOyu2VLr8sup6cIVXt31PrDLrLIcbSeTcwVk4aVLIY
	R1wCfVz6vtuKL4JIG5JLQTqg5zC7L6Kuv0h9SHWA+bNVFeobSv4mbG9t+9lylrIZj36gGRPdvZl
	+uacs/d0cKTdye1GrDF8QNy/AYEMm2q0UJN3ab7Bn93sJqdEJ9idlkgXFFunZ5ugiUgpK4KMRjV
	05OaQQUjltcUM2XBj9kFiTu0c/LG0i2CrqXVLWIGNHa5wytAhNBvQ6nVNkoye0ZFU/ChNY=
X-Google-Smtp-Source: AGHT+IFvw1ERLpx0hajCyVXBBFu8extoIb/B9KfZKwli5EQuQHm/5Uh2QurIsaL77j5/LzlYsi/RlPQItBHSKKQKeR4=
X-Received: by 2002:a17:90b:3847:b0:340:b912:536 with SMTP id
 98e67ed59e1d1-343fa74d20cmr19178928a91.31.1763512180957; Tue, 18 Nov 2025
 16:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRegH8P4cPlzzlX9@mail.hallyn.com> <aRx/1MvvBqu5MhKv@mail.hallyn.com>
 <CAHC9VhQu7gSVO-QZFE_iaCB0qBqB3surdHQo4Vg71zc890uEhA@mail.gmail.com> <aR0JrOvDxDKZPELd@mail.hallyn.com>
In-Reply-To: <aR0JrOvDxDKZPELd@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Nov 2025 19:29:28 -0500
X-Gm-Features: AWmQ_bnF2lsvWYT7r_TEvqlapFcK8P2wR3ew87ID9HYHtWCPBpo3k2eM1LHWS1E
Message-ID: <CAHC9VhRFDgDRtU3ApMycg6giJGvdaUhkiGhRx9ZUqpSGaTyesQ@mail.gmail.com>
Subject: Re: [PATCH] Clarify the rootid_owns_currentns
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org, 
	Ryan Foster <foster.ryan.r@gmail.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:05=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Tue, Nov 18, 2025 at 10:47:06AM -0500, Paul Moore wrote:
> > On Tue, Nov 18, 2025 at 9:16=E2=80=AFAM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > > On Fri, Nov 14, 2025 at 03:33:19PM -0600, Serge E. Hallyn wrote:
> > > > Split most of the rootid_owns_currentns() functionality
> > > > into a more generic rootid_owns_ns() function which
> > > > will be easier to write tests for.
> > > >
> > > > Rename the functions and variables to make clear that
> > > > the ids being tested could be any uid.
> > > >
> > > > Signed-off-by: Serge Hallyn <serge@hallyn.com>
> > > > CC: Ryan Foster <foster.ryan.r@gmail.com>
> > > > CC: Christian Brauner <brauner@kernel.org>
> > >
> > > Paul, Christian, let me know if you have any objections, else I will
> > > queue this up in caps-next.
> >
> > Seems reasonable to me, but it would be good to fix the parameter doc
> > bug that the kernel test robot identified.  I suspect it is just the
> > extra vertical comment space between the top one line summary and the
> > parameter list.
>
> Actually I think it was probably the use of - instead of : after the
> parameter name, but I went ahead and changed both, thanks.

Ah, yeah, at least one of those was it I'm sure.

> Pushed the below patch for linux-next.

Thanks.

--=20
paul-moore.com
