Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F333E0C45
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245340; cv=pass; b=BP+VjQK1XH8H7HweKKZX1Uph8oD2U+sceZAUw86IYOzwRuDiA6qeU74Fj897r+ETQVkshtHXfQKT3RgQMGmKUUseH+XxLny+13zeyrm6Ee0UhygMP6mmTZ6qCtCggo6gAUrADB9T6KWY3d9Svgg6tHSmQ56MGXhwbHzUoTnJEH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245340; c=relaxed/simple;
	bh=owVe3Qfob2UO8yuqdH2PqAC+rPmSIbbd71zfyNJWtfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmgdbhs7s7mDrYhgvSBBfUF1gh8xodzdpvTI5Csjv7uL9M9LTAwj1TXBLolJbtpGIcWkax2pkW0lJh2UjZqkPuNDHiltW6DK8zEdSsgJ0uiyuC8cLF2gfEkGHo8l1xCUv3oQtskRlNinb/JJFGwnSrS1Y8NTPJFm6cgSBmPmUQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e6c+ElXV; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e6c+ElXV"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3599019ae92so6164730a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 09:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245337; cv=none;
        d=google.com; s=arc-20240605;
        b=PSTroBTzCKlk/YuItrvAyh1kpz2satruxZ0rZJKfgmsnB6Nj0Sl+BeGMgH8sDsB8G9
         bxQajUP9/94UAF5dt3HxF7yH7vFQQBRoqYjuRnp6u4P2ptnJ9fzCaoxk9OjZDuRG2uvQ
         LMuyiZSnCS8H5r6VY+u8JgaRezJ7LCiZyt/0HBKG3M13AZFhL4jA4F/6kiZKu2Fjv5b+
         l8kg+iJrje0+JJo31PgyHDbEyQcl+aEgDneb0wSaob2vuAwoGYt+bOgt60WvTwOK7BaE
         6N+p3a8yTQwIRYZnD+BS7DGMiO/jsnQPkeg6g2r3BcqOsWIu/TWA6TcXt6aMdeaZdNiP
         2bBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JZDNJFGDP5amVq7p/dFv6sOGOZTvq599aR4YcZO7qtw=;
        fh=cS8MtpM9nhZMjOphG8mcstQkVy0AyA7Kf205RPHW5aY=;
        b=ay6diC5nPdC0PEjAoCZ3el+0TB+3N9llmuLJXPlynJTLZmAwrvQ7dArZDGEvvlDzGX
         ivysDhzwKq6u73zm+YdxfELiRjmIDl5JrFEb/DV47BeE+zOx8cU9KxHu2PN2jXxEPMGj
         5CqRptrtHdOHL+5Cds/5JLF+q3fVeGt14pImAQorsrv9FuJ5ZE47xk6v52lf4YH0oDf/
         peP1VRReUamKvNEgvibYvFI6AwxIJgYwxnB05+ElM6iMgfJekZxzshjJDVaYtErM4siY
         mzGP8hgZN64gee0yWBk88Ez4Cm6O97sfunDUZIdGPp995qZQpZe5JGs8eFimARleYr9x
         MHkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773245337; x=1773850137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZDNJFGDP5amVq7p/dFv6sOGOZTvq599aR4YcZO7qtw=;
        b=e6c+ElXV9/S8dBAt4s3Y0Qdq9+tZ8d5cWILHAnHHImVT5PIIkJUyCZiacq7jRwg0wO
         3Cebb97OPazwIb6fjRP+vY3CtMSNoYR2RIKBrDAwtxeicH+/z2rbTPh7Os6MuY5k4bsk
         ma028J0ookNSr0KijANIvgZg9rIgryyaHdtXthB65JBFV5watPKOGnOo8nJM04Fvkhcu
         1sUQwoIi9bTkdmnd5BJfx1eZGuBrZjPCVZAWLHDskfYdbIiO+mBd3Ciep3WaOeYu4bZ3
         AOcYAN3ypG4b0iCneKQdTkcp00UtTnkzuS2zWuf4D3tjbFYHt0mKsjvS4pJXtGlYQIpi
         h/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245337; x=1773850137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JZDNJFGDP5amVq7p/dFv6sOGOZTvq599aR4YcZO7qtw=;
        b=Wk4E8mAg4c4Vv4wMzT3bUWraUB9/HJmPfQ40bg9/zad6b6+ZF30QLBK0Z7kHWn4tMB
         wd7I7bUJIuSkDr3MKdMgnNHiSlINaaoIn2cM6WQ4GyDL7UyEtjG3dp2572Yd2TI6zslV
         7W4Gq0uOg9EwVk8neox68gFyYRy4uN9wqNZh3OgqOLn4T2MnAP0MmaoIXyRPdDkwY4ZE
         uTfG8CHEIJO2/RZxw194PVqDDgKDbCU4njv25+VuZ+yIirxXKkU0O7ooSu7hqOZFVCHd
         wVNWvvlz0Nnl8AwFvfNVPittYcNvxDIpjGFO4V/S2+GdF1OzaofpRqUACKwy8zij/aEU
         PkZA==
X-Forwarded-Encrypted: i=1; AJvYcCWHOkQzALXOhKU/5VouIyeWxDi+ygxYgfCOKnsQ2Ne/z8JranTbh0uE6LAb4yHUaRP5UU8UwgWC7gqXnE6IMyyyl75MdjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5p9BAEGAfwOZoUPDlEEnFghp/LQb1Nqix6yjG7f4GPHJXMZ+C
	dxSw/TyKCmQQa3ry5nLhIQHFSBtHj0fPsrD9mkB/tOz7ff6nF3fDCYWwShhqraSTyDGFg7cjXFt
	eK9e4ycBXiwRVD2qgVuCkaaWnOJ9/0i3hT6Pohgst
X-Gm-Gg: ATEYQzxGIgPuMaTyVmHL1D6cjsCGPWXlvq+bnXoTj5wnRZdjCTpGN5y93nSq4eKNb2T
	HTQ3kwmz14ECF/iu3liVVn6GuEKrg0hb/8BuKJBSbhH6k2wFNml67+OP+c4fbZyRHjDk85WZN30
	2RqAm6q0KP0CHkiZ/lI1Yu4bz4RwNNwNzNXjOMQS7hMKiPsZzREJ5DUqDkxZlW5kGZccSxGOqxh
	4/cIUa73CorFH21uWapN9FPk8jclNRUinQSFNGl1Rw8+M+KHwqNG5cromXL8Bb1xewgksNCf/3w
	HUUc7dc=
X-Received: by 2002:a17:903:3d05:b0:2ae:3d7d:d905 with SMTP id
 d9443c01a7336-2aeae81490amr32213615ad.23.1773245337226; Wed, 11 Mar 2026
 09:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZcPd3OKqxwCZV-5@suesslenovo> <20260219200459.1474232-1-utilityemal77@gmail.com>
 <20260219.de5dc35ec231@gnoack.org> <CAHC9VhSu=YtE0dMiEtUQgz0pFy5K8cuHh_EWprNtFTDAxhss_w@mail.gmail.com>
 <abFhawSTjNoa-KaH@suesslenovo>
In-Reply-To: <abFhawSTjNoa-KaH@suesslenovo>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Mar 2026 12:08:43 -0400
X-Gm-Features: AaiRm51y1oanFGZp0hATWZweBML1M22bqKd3H2ES5tayYiLT9l2hp1VRACvAC4Q
Message-ID: <CAHC9VhSA=jaKTXg-Tmzzpaj9STGMXH3ZMgQm_XvicimRqdW0+w@mail.gmail.com>
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, brauner@kernel.org, 
	demiobenour@gmail.com, fahimitahera@gmail.com, hi@alyssa.is, horms@kernel.org, 
	ivanov.mikhail1@huawei-partners.com, jannh@google.com, jmorris@namei.org, 
	john.johansen@canonical.com, konstantin.meskhidze@huawei.com, 
	linux-security-module@vger.kernel.org, m@maowtm.org, matthieu@buffet.re, 
	mic@digikod.net, netdev@vger.kernel.org, samasth.norway.ananda@oracle.com, 
	serge@hallyn.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:34=E2=80=AFAM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> On Tue, Mar 10, 2026 at 06:39:12PM -0400, Paul Moore wrote:
> > On Thu, Feb 19, 2026 at 3:26=E2=80=AFPM G=C3=BCnther Noack <gnoack3000@=
gmail.com> wrote:
> > > On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> > > > Add a LSM hook security_unix_find.
> > > >
> > > > This hook is called to check the path of a named unix socket before=
 a
> > > > connection is initiated. The peer socket may be inspected as well.
> > > >
> > > > Why existing hooks are unsuitable:
> > > >
> > > > Existing socket hooks, security_unix_stream_connect(),
> > > > security_unix_may_send(), and security_socket_connect() don't provi=
de
> > > > TOCTOU-free / namespace independent access to the paths of sockets.
> > > >
> > > > (1) We cannot resolve the path from the struct sockaddr in existing=
 hooks.
> > > > This requires another path lookup. A change in the path between the
> > > > two lookups will cause a TOCTOU bug.
> > > >
> > > > (2) We cannot use the struct path from the listening socket, becaus=
e it
> > > > may be bound to a path in a different namespace than the caller,
> > > > resulting in a path that cannot be referenced at policy creation ti=
me.
> > > >
> > > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |  5 +++++
> > > >  include/linux/security.h      | 11 +++++++++++
> > > >  net/unix/af_unix.c            | 13 ++++++++++---
> > > >  security/security.c           | 20 ++++++++++++++++++++
> > > >  4 files changed, 46 insertions(+), 3 deletions(-)
> >
> > ...
> >
> > > Reviewed-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > >
> > > Thank you, this looks good. I'll include it in the next version of th=
e
> > > Unix connect patch set again.
> >
> > I'm looking for this patchset to review/ACK the new hook in context,
> > but I'm not seeing it in my inbox or lore.  Did I simply miss the
> > patchset or is it still a work in progress?  No worries if it hasn't
> > been posted yet, I just wanted to make sure I wasn't holding this up
> > any more than I already may have :)
>
> Good Morning Paul,
>
> Can't speak to the rest of the patch, but I sent this LSM hook for
> review purposes before inclusion with the rest of the V6 of this patch.
>
> G=C3=BCnther added his review tag, but I was asked to make some minor com=
ment / commit
> message updates. I sent the same patch, with updated comments/commit to h=
im
> in a follow up, off-list email to avoid spamming the list. No code change=
s were
> made, just comments.
>
> I don't think this particular patch will change substantially, unless we =
find
> something unexpected. But the way we use the hook may change (esp wrt to
> locking and the SOCK_DEAD state), which is important for your review.
>
> So you may want to hold off your review until the full V6 series gets sen=
t so
> you can review the hook in context. There were some questions about
> locking that needed proper digging into. [1]

Great, thanks for the update, that was helpful.  As you recommend,
I'll hold off on reviewing this further until we have the full context
of the other patchset; we've already talked about this hook addition a
few times anyway, and based on a quick look yesterday, nothing
particularly evil jumped out at me.

--=20
paul-moore.com
