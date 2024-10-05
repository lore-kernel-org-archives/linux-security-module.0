Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE51156F44
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144218; cv=none; b=YUlNwfcWcp0ZYIyY5HRrVSlkRJpapdPDDhd65QYCts1W6Qe6n1Ycw+f/P1ZXluEPa6kegbUlb6Et/txVEbetXl96AI2kRd3EBdmUfYFa26UAJ4i2bdkwlJUSrHbEh/UHo3JmuFzbAUMDSrvHRiPdmkDQ0PpdDI/RHf1EXEwuvkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144218; c=relaxed/simple;
	bh=afLfDz2LMbMFzCD0MAX500Y++/4ZAEd5aGdOtlCfVLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okmN90pbDhcySFN29fmMV69Vin3W8wjQLUHAPzzHXQMrzC9Ri5gtSWyDLZ5s7UxluaK7PmA1snYc2kEVy45vsAk4trB5QC45XN7MndGATdFTDB6szCHhuuGFQ96DtcxLD7+ntBi6DfvF8bd57BZY+1MJ32DRIvRJ2CSVyYx3+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P39vyas+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P39vyas+"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2e427b07dso1686317b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 05 Oct 2024 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728144215; x=1728749015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afLfDz2LMbMFzCD0MAX500Y++/4ZAEd5aGdOtlCfVLg=;
        b=P39vyas++zjRnLQc/qE3vNOpSKQXYvjwbPf0ZRQ0CuC+oQdQ9OH9219naRhU3pYXFp
         HzzFIwfKK9psmKekcud/Z/GhDyvf4ciDa5h8BYG8n0OpMqMNeEEECM68DKjekG2yzKRA
         rPmxTFbEvHLfOgfDIqhw/FlUPzEgIGQlvXml3fFGOtRq6yVPRq8I9UXuPspi0nvyZ3nN
         6wi78kZ4ljAaoK49mwY/ENr34yPJMjAoUy3sGMoeS7mFvd0vEPLaLhT0KK6122TipQ11
         +EeFmb7iF9Yn/H6q16u611ErDKXIVb83dNssCZvULsZ8hfNTWjYV1P77nZDmrxwQubKg
         Wm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728144215; x=1728749015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afLfDz2LMbMFzCD0MAX500Y++/4ZAEd5aGdOtlCfVLg=;
        b=OAOjm/Obvaj4YuNuu0IC17KdAREmUqXSQ4AIOLfJtD5wIY+1XwxVW/+7j+9RHJ1z+w
         cW3IECEgWDCQj0FeZdMDLdgymG0TU6P61xNeOkrqsfrENTLsLzhdgTr0+LHfbYaFCcJs
         tz3sYfefP3dRJ+8Cq6y1vmByLhc9nZohGRPWtHULMRX+s5tb7Rnc1UC2WFEDgqeTTvxZ
         sK236DlYns445PXjwtUF3yhRB7KhwN0R2EctBgWnF+WyLMivVnKjZB1lfVjKsgQiapPV
         LkYfiEbJ76nN9QRbcAtH4iTA7O9gV867NGQOdboFtSv7Ik+rtp5wkGxHUzkjNRrip2yV
         8jQg==
X-Forwarded-Encrypted: i=1; AJvYcCVBcY2bMr08ojaxm5jowaEyDrscVEk63O5h0hO13ih43HiZ5zp9LAAlJMyhxOTnYf7hdKjwSWguUV1aJtMuYnN90wQ4wYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERET5VxdrKRWTgJYTUm9BjJQprd7M7TkVYHpCYWidjQ6/+5Tv
	JEEl9wgcZGhFkwyfOOmcHJ0WeLLnkVQLc2sD+SwLkba3chsNe875vp9JF1gjJ9JRuiWIMFPkaUE
	sbjnBcfuw8naLQKXDpkGZw5YoVNtCbrV6d258
X-Google-Smtp-Source: AGHT+IEdpMf02ohYl8IhwAq+Ru4wGZW5LUDHwBhGAhrwPR3/SE2UTgRkrrKq7s6/EhFWBhahRlsnUl3DXE9lZ5Ft2U8=
X-Received: by 2002:a05:690c:4706:b0:6db:deb7:d693 with SMTP id
 00721157ae682-6e2c72334b9mr34986467b3.22.1728144215581; Sat, 05 Oct 2024
 09:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003115721.kg2caqgj2xxinnth@quack3> <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3> <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3> <Zv6jV40xKIJYuePA@dread.disaster.area>
 <20241003161731.kwveypqzu4bivesv@quack3> <Zv8648YMT10TMXSL@dread.disaster.area>
 <20241004-abgemacht-amortisieren-9d54cca35cab@brauner> <ZwBy3H/nR626eXSL@dread.disaster.area>
 <20241005.phah4Yeiz4oo@digikod.net>
In-Reply-To: <20241005.phah4Yeiz4oo@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 5 Oct 2024 12:03:24 -0400
Message-ID: <CAHC9VhSwx9DAEB2SS3_Kfa_03UJf92Embi8Oo9yspsZvRi0MUQ@mail.gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert sb->s_inodes
 iteration to super_iter_inodes()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Dave Chinner <david@fromorbit.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	kent.overstreet@linux.dev, torvalds@linux-foundation.org, 
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 11:21=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Sat, Oct 05, 2024 at 08:57:32AM +1000, Dave Chinner wrote:

...

> > Actually, it's not as bad as I thought it was going to be. I've
> > already moved both fsnotify and LSM inode eviction to
> > evict_inodes() as preparatory patches...
>
> Good, please Cc me and G=C3=BCnther on related patch series.

As well as the LSM list since the LSM framework looks to have some
changes as well.

--=20
paul-moore.com
