Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3CB665
	for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 02:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575112; cv=none; b=h0ByvYcy+REjVDh5N1OdvduEDAxrU4CYberPirnjnNPUIq7C59SKxK3jFpwkcCeK8DC+LHbAbFvLqKeElQNzTKetJsUxYH7Pj8zHwFe5npLcFOjJJXIBiSBVd5nZdnVKrSSvXyLqpbVL4D/vlY7RWHe+o3Ov5zY7+Dz0Q0IeOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575112; c=relaxed/simple;
	bh=jEp4g7oPSs1tRVVjVHxyfPWRnm74PQ7DID33RpDXw14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXgaRLx19wuQ8dleZ9B2xzpLYVZZRSiZ8/pYMlPiGuvTMZkSkHxH1RLPqlY3LmmLQCwYUzs8BvAdzxSpiTvYo7jhG+6ITGVN5Pqg3XS8pdjJzXqUVcaW1sODQo8rKkXjTd8HoefiyJn5mmkjj0/zvkMVd4Bqeqi7uhlkTfWLJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bZkmI4mo; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bZkmI4mo"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef9b8b4f13so2767807b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 18:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734575109; x=1735179909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tWGECUIC18zUy1upfbB2RzIPoTH3nwy9UxQ9Kxd9Hs=;
        b=bZkmI4mokwdwL8mj3Dr64zHwyQhvJ06RVi7SPHR7ZTQdFhwfIKpTMUn++4V/XkwwlF
         MXR3r4GXF7ogduy0GzIfps6ErhtZow2GNMt0df5vgYLRuw6+5qJUjJ2X28fX7piIbNHo
         PFsZU+xW8h+jQOQsgFsNNHFpEBUAwFYMPBf/6vKdJt81iL5EdCxD8dEc1ZhmBt9Ku1wm
         87q8kvOZNSkSt+hSb5QvPbcNpyu3lqa93qOQMACNiDWklDHx2C883Vv2YaSLcJ23CkKj
         MIUogHSZiIXtlWIkIauAqhWO4T3MUw+neg80BE3lZC5nIWnERgTJtGc5Gm8+rruVMlf/
         6PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734575109; x=1735179909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tWGECUIC18zUy1upfbB2RzIPoTH3nwy9UxQ9Kxd9Hs=;
        b=EOPtPvxLNJeKRJw0hsZUh6ffHYehu7L2TmNxX7rvYfQqU/pOVqMREHne+t9VYw+vkK
         N1EOwdmU4u6uuJvqFd3mws2DIT0hw0rMT4YdUsBLIsGsX3cb58DIxxcKss95KEiYYXyH
         b+Owv5R00ULoXNAU1qEULleBhw5qu5X13cs//A8SqklYCaMxLhjp32k2NYjhmc3LfbWo
         GtDPwyQC7NVVS4AhHL/gn0twxMfsCs4gZ2TeCYai2L6ywM9r195KbYAfjtw7svmH2DO9
         VvQMF8KhJAfDGgIDmf2+NC1BnkfdtwHeWsffRssdJLndD3/hxiM3Bekl3V7+hrpEcc1S
         VOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZZFSwvR40HvHmnvgq+Myf0leSBUCLCYbywQX/s42cB7WLGkeSJGbRzRk5AN24Yhr4aM2G8muH1JUS0I3pwK4cd1k7+BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjmjDJnL8XjHBPB0DYKIN90Y2ROlDeWdSKV2LBlLYFQRb2zWN
	TvoT2qjgWt0s5AKOoxdjYMiSeOAuC7ZahzRjoVqT80DhNuBi454Eh0NOgknvjj+BkYFHlmp/cYs
	wgWYr/EHvMgJT7+FXG/4oD6uOTc6j0L2ZfRsW
X-Gm-Gg: ASbGncvI/LluftHOkDQD7+vv76Rt4JSWYI0zOK7TZ+mO+R2rHSJJ7pYz2KxZx5BUaSm
	pWvm90UTDf02qgE+xAS7J0AsTT/bqLvlZcSxJ
X-Google-Smtp-Source: AGHT+IFSFeyjJ3n4aNzgzvRsbG5qYDWf7HOFTcBXnm090pcCmjjK30AFiOncVrR3rfCI6RBs9cpO1mGJaUEf7/sRnjQ=
X-Received: by 2002:a05:690c:6e03:b0:6ef:c487:f401 with SMTP id
 00721157ae682-6f3d0e33a0emr41575887b3.25.1734575109007; Wed, 18 Dec 2024
 18:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215165352.186692-1-linux@treblig.org> <CAHC9VhRyf8Jo54gnz2Nu17eHFOEqeXd3B5_HoXbz9uLYDba=HA@mail.gmail.com>
 <Z2NIpSZ9iY0q1EAl@gallifrey>
In-Reply-To: <Z2NIpSZ9iY0q1EAl@gallifrey>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Dec 2024 21:24:58 -0500
Message-ID: <CAHC9VhTmqMKkemeyWK3d6tyPGSus9ApMpZzTjtrmgHqbC_au+Q@mail.gmail.com>
Subject: Re: [PATCH] capability: Remove unused has_capability
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 5:11=E2=80=AFPM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
> * Paul Moore (paul@paul-moore.com) wrote:
> > On Sun, Dec 15, 2024 at 11:54=E2=80=AFAM <linux@treblig.org> wrote:
> > >
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > The vanilla has_capability() function has been unused since 2018's
> > > commit dcb569cf6ac9 ("Smack: ptrace capability use fixes")
> > >
> > > Remove it.
> > >
> > > (There is still mention in a comment in security/commoncap.c
> > > but I suspect rather than removing the entry it might be better
> > > to expand the comment to talk about the other
> > > has_[ns_]capability[_noaudit] variants).
>
> Hi Paul,
>   Thanks for the review,
>
> > I would suggest that this patch would be an excellent place to change
> > that comment.  Without historical knowledge, the comment will be hard
> > to understand after this patch is merged as inspecting
> > has_capability() will be much more difficult, and including the
> > comment change with the function removal will bind the two changes
> > nicely in the git log.
>
> Yeh, how would you like it? The existing comment is:
>
> '
>  * NOTE WELL: cap_has_capability() cannot be used like the kernel's capab=
le()
>  * and has_capability() functions.  That is, it has the reverse semantics=
:
>  * cap_has_capability() returns 0 when a task has a capability, but the
>  * kernel's capable() and has_capability() returns 1 for this case.
> '
>
> For a start I think that's wrong; the function it's above is
> 'cap_capable()' not 'cap_has_capability()' - and has been for 15 years :-=
)

The code in security/commoncap.c is fairly mature and stable, and I
don't expect that many people spend a lot of time in that file, I know
I don't.  An unfortunate side effect is that certain things that
aren't caught by a compiler can easily go out of date, and stay that
way for some time :/

> How about:
> '
>  * NOTE WELL: cap_capable() has reverse semantics to the other kernel
>  * functions. That is cap_capable() returns 0 when a task has a capabilit=
y,
>  * the kernel's capable(), has_ns_capability(), has_ns_capability_noaudit=
(),
>  * and has_capability_noaudit() return 1 for this case.
> '

Two things come to mind when reading the suggested comment:

* I don't like the "... reverse semantics to the other kernel
functions" text simply because the majority of kernel functions do
follow the "0 on success, negative errno on failure" pattern that we
see in cap_capable().  I would suggest something along the lines of
"... reverse semantics of the capable() call".

* Most (all?) of the capable() family of functions, excluding
cap_capable() of course, return a bool value, true/false, instead of
non-zero/zero.  If we're going to complain about the existing comment,
we probably should get this correct ;)

--=20
paul-moore.com
