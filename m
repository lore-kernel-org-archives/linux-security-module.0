Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09572FC02
	for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458237; cv=none; b=vFOvXP96V7adPVg7Z57jctsO8N4q19FKgGXbjeKP2wNQg+SfhvmuAyjkIArJRUMsl+TK1KkPI1AguAeugdhArf4qcptWih/327Hjm5WlUL0IB/qe1gC4CHUjS95UMYsFpxumZeq92jabJDPITg1t5a/lbPQJyJy5UrsHM3RyTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458237; c=relaxed/simple;
	bh=PSPZw+wHimajiosB/jFZPzF7tlBsNhUEtnL0t2l2UTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4QfO3BIjIdOm3rHTvcR9N97lW60JRni6kscHDyhlt1k1MG1kkHCiPWP4BN7Epg+y5lupE5jzHLAMg9s0aWrZWy+sjvtgAJYSVVeozrHUtq7Rz4wwBdVJJQdOtPMgnBMR0Wzxng90uEcxrjZ+M3BG9JudPbuaa5z58G3APV4dIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NBfkzSNJ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NBfkzSNJ"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso1304433276.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710458235; x=1711063035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FJHO5YC8w5/nCa0SdcrtkcjPivtz4GqNfWWtZkV020=;
        b=NBfkzSNJwus7mZn2lQW/cXxce/p1NLtle+EdknzUaRrW6Q+a/GA8NSd3UFJqo69iHs
         8wu4+Sx0LXtkzaSCWjFAsKAvJUCQ6zrNUi4Zu+1ICoUD/lJZjnvakuYBOu/lhz0yU38Z
         QdrCW3zu05PZyUZSJtGxuBqm0tZPslIWZt1yzMw1Yy7iuDpM5gbzabqaIVjnlY9idaiU
         G6wVelT5CqqCyygw3rG/p26WZ57WkeJfEbDUnhZtCaUuogTWW8aggij63mlcv1+Pfwmb
         4QDfKcNjQE6TI2guMH5k+rh/1KJPu0/zdZ+mJI8D58v/V+fbLWeutgOyRXgd9feTwwdu
         9VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458235; x=1711063035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FJHO5YC8w5/nCa0SdcrtkcjPivtz4GqNfWWtZkV020=;
        b=Yt6rghBrz77Tya6cGB5ICg5447VsQB0GyZaRUIHwzax6eF16DLiPiC3s0oTakp2kU2
         0XKjEtgs2cbpViaf76ZNJn+pmkdv0EGMiiwwBZrks14BYxeQCkUE/kTC3an0yLuyE+AC
         1QlrWIMdsmhfFBTDdkZ0Cdev0Mb2vlb4QZtqjJ4XAJiFLpcSP+v/PXnjRlPzGjApCpkf
         9wUlNK2S/k1NKobW5n0YopsiaAI/tWPB7yva82Frxw1SPHCYdEMDhT5wSiJcBW7V/9Q9
         lxz2fWG30FGkiOyl43h0iJYkwCximu2Lf98dPFq4GJbVepUDSsDLWshZAPNakU7ulVQL
         vQMw==
X-Gm-Message-State: AOJu0Yxq55Q81wnv8x0JVM0K8IBVvwGr2Zf78oEkg2pxoo9WH0fvvPOu
	gkW/aS/PvwRMa/LZa8xRKZSSVjY+WOAMK9KN8Ti9UpY7oLimvPi0/HNL5/lwoQ1s7WGWHRo1Gs0
	Kcp9oe81ssxS8gJcFg+OtAs0bKPFpb5HoS7KeLx8w1VsPINQ=
X-Google-Smtp-Source: AGHT+IFonUub0kn+4pEzuRAJ9n1AIEmnrW4hZeaxsDQsnO7+hwiraDkkWgcWmSKNTcDZiKzY/gn6Akg9rQWnFLXuyJs=
X-Received: by 2002:a05:6902:564:b0:dcc:2f94:591a with SMTP id
 a4-20020a056902056400b00dcc2f94591amr657211ybt.12.1710458235012; Thu, 14 Mar
 2024 16:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com> <CAHk-=wjXK3ZDtCM754mQVWzcZdQd50dBU5Y+AoATWcCGCMWzgg@mail.gmail.com>
In-Reply-To: <CAHk-=wjXK3ZDtCM754mQVWzcZdQd50dBU5Y+AoATWcCGCMWzgg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Mar 2024 19:17:04 -0400
Message-ID: <CAHC9VhRJW4k+tpkQSFYp6jeD9fRokGBRhsrNbTxScZ3Y0jJKbQ@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240314
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 7:05=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, 14 Mar 2024 at 13:31, Paul Moore <paul@paul-moore.com> wrote:
> >
> > I would like if you could merge these patches, I believe fixing the
> > syscall signature problem now poses very little risk and will help us
> > avoid the management overhead of compat syscall variants in the future.
> > However, I'll understand if you're opposed, just let me know and I'll
> > get you a compat version of this pull request as soon as we can get
> > something written/tested/verfified.
>
> No, attempting to just fix it after-the-fact in the hopes that nobody
> actually uses the new system call yet sounds like the right thing to
> do.
>
> 6.8 has been out for just days, and I see it's marked for stable, so
> hopefully nobody ever even sees the mistake. I can't imagine that the
> new system call is that eagerly used.

Thanks, that was our thought too.

> Famous last wods.
>
>                Linus

--=20
paul-moore.com
