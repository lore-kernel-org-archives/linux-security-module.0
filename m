Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E92155C88
	for <linux-security-module@vger.kernel.org>; Tue, 17 Jun 2025 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198108; cv=none; b=Q1uzTPuk/g3fIzNOxDagJkbHRieTb8iJ12otOyBj1fzbCi0etAwdL8YRopzayNPULBYIpwjsrnlPODSHLSrYnFjG0oZdHtnmYKA3XR1npIKbUVlEBk9ciLXAFwt5q8vT4ugEvJ5Q0ttSMrU84kdAPU0RnprP8We9282oCRXQc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198108; c=relaxed/simple;
	bh=/mYTzxg6CtQR32uh8MwzHBLrlTlBO7KyZxoetMiPKWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iz/zmoBwUIJCc+GAxhwxg8nVV32jmKwGuc1L3uBOGeWBt8mdhQJTMw6Sl2THRswV0ZnI3k4YjGtxaTh79qcgsPOnZqgcRExaZh2qbj+k6H91zfSsP0mgZ+TQryYJhu9zcDI+YhbJE6x2jwIY/vYST793b7VhbH/b5Kb8OzU4ywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X+ShCHgI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X+ShCHgI"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e64b430daso65996077b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 17 Jun 2025 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750198106; x=1750802906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4vJCjrmBrSLO39iV7NzZFlcItrd6ObhJFBBcu3I7rQ=;
        b=X+ShCHgIr5yTpToi8P3oTNtfQnCI/ML+XvZqUKEEmB1WlIYKoFN11XS5wzOtM4CqNZ
         DpvX42qLSnvUii+KMVBh11AbBlROowIE8xue0xGj+TIAV88h45mB143AOvN7mrbyyYfr
         c5yhzvvu26xIken4/NZjH5UqvHhbEn/Ju5NU34tmp3JxkGu0XS/wxMuJ22qqTogLROvs
         V7y0kBPZngsk9/KizbK0vvRTE/XLmIyzpR6zNvh2WorITQ5oCwidlBpGyzTokA09uhX1
         J7Fvv3xJ/VqtYgZQKB9XPJ0dt619lN3MCJ74iPmIqfIx7DDVAXVmj21UIDFCaHakiRtF
         nF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750198106; x=1750802906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4vJCjrmBrSLO39iV7NzZFlcItrd6ObhJFBBcu3I7rQ=;
        b=eM9f2IR0Jzl2sh+6HfU1eGXG4UuPFrF1mDbgRGmdyuZ8Z6MUevCYFNjdGAWpAAaz08
         C9MphqC44ZL4EZ5R6QOLMvgeR6WYJqWr2UAa3f+wMr9GAoohaNRh0dGvqQinTTaqCSFw
         nhB6uWW40a6W0EzDTJOk2vuWUDGr9zzslAq5qHoZu7kaNd40h9qpMgkQjS/7Ct87u5FC
         XQQxjOSWxLBRhEBAxxYvhGQ9BHMi3qgOJj3W3E7I1epX4UOrElIsatYcCQLF6r+Qub+s
         Hrl3qOfm7xSFaZ7wxMLXRc0jMeSMbVqZcn/Dezhz/RNYwRiRInsmWi50U6AqIDgJ7MCb
         i/pw==
X-Forwarded-Encrypted: i=1; AJvYcCXxyBjHVH1svV8kUQF356veGEQ0GAcN1ersTfpVMjBtJIoJxijusM3zRlWOWOFbmb4hP0mOk2BpzU1NL9pgwUVHoG5M6uM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2knliKJqB902fcxgi1WLn06K2mOR8KI5xU06wpDuMyiF8woJ7
	59wHvQGJCrbcsgIxcIoQ/RyKz8a3o6+WYRd/M9dL7NdTKDM54zeVR2ctvPrPYeRt7qB/774+Sp9
	lRLXlh2WaDpbqgkyDF26ltnHaQld794l3h2zrgHo4
X-Gm-Gg: ASbGnctyCy52oXGVZjj0fJXIt3i+b6Y4GPVn4wwQiFHcTPmSP+q95Ey+V0a9lNmUx8E
	nKN8eW0lPe2qz/cgfyQzMMv1EAP5T9R/P4EZybYvpgmTXeh/NX9bJPTrTNAWMwbkZDB0fpSY+Qp
	9a0xIkmJwbWLP39JWlG6ciaKiP0SIXayIohTFgSHZaVbY=
X-Google-Smtp-Source: AGHT+IGwW1UHz/hRl6pSyfGRD+X9hQGPTwJ2Tw3sKSAZMuO3OWn91irFM1KDT9fmGsWQBJVniHk3cZOaFXOWnoLpKOE=
X-Received: by 2002:a05:690c:6910:b0:710:e656:bf4 with SMTP id
 00721157ae682-711753a1b8cmr246673237b3.2.1750198106114; Tue, 17 Jun 2025
 15:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTPymjNwkz9FHFHQbbRMgjMQT80zj1aT+3CFDVY=Eo5wg@mail.gmail.com>
 <20250617212334.1910048-1-kuni1840@gmail.com>
In-Reply-To: <20250617212334.1910048-1-kuni1840@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Jun 2025 18:08:15 -0400
X-Gm-Features: AX0GCFs2n21OIMosxNuh5u-k4VakiFIc4Hd77Hs8oJ6xLt7VXM1jxWGbGU6RRGw
Message-ID: <CAHC9VhQ0trrgHyJxQOqAQAeN2bCsCx0JeXQgj_xeQbcckCbdZg@mail.gmail.com>
Subject: Re: [PATCH v1 net] calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, huw@codeweavers.com, john.cs.hey@gmail.com, kuba@kernel.org, 
	kuniyu@google.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 5:23=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Tue, 17 Jun 2025 17:04:18 -0400
> > On Mon, Jun 16, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gma=
il.com> wrote:
> > >
> > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > >
> > > syzkaller reported a null-ptr-deref in sock_omalloc() while allocatin=
g
> > > a CALIPSO option.  [0]
> > >
> > > The NULL is of struct sock, which was fetched by sk_to_full_sk() in
> > > calipso_req_setattr().
> > >
> > > Since commit a1a5344ddbe8 ("tcp: avoid two atomic ops for syncookies"=
),
> > > reqsk->rsk_listener could be NULL when SYN Cookie is returned to its
> > > client, as hinted by the leading SYN Cookie log.
> > >
> > > Here are 3 options to fix the bug:
> > >
> > >   1) Return 0 in calipso_req_setattr()
> > >   2) Return an error in calipso_req_setattr()
> > >   3) Alaways set rsk_listener
> > >
> > > 1) is no go as it bypasses LSM, but 2) effectively disables SYN Cooki=
e
> > > for CALIPSO.  3) is also no go as there have been many efforts to red=
uce
> > > atomic ops and make TCP robust against DDoS.  See also commit 3b24d85=
4cb35
> > > ("tcp/dccp: do not touch listener sk_refcnt under synflood").
> > >
> > > As of the blamed commit, SYN Cookie already did not need refcounting,
> > > and no one has stumbled on the bug for 9 years, so no CALIPSO user wi=
ll
> > > care about SYN Cookie.
> > >
> > > Let's return an error in calipso_req_setattr() and calipso_req_delatt=
r()
> > > in the SYN Cookie case.
> >
> > I think that's reasonable, but I think it would be nice to have a
> > quick comment right before the '!sk' checks to help people who may hit
> > the CALIPSO/SYN-cookie issue in the future.  Maybe "/*
> > tcp_syncookies=3D2 can result in sk =3D=3D NULL */" ?
>
> tcp_syncookies=3D1 enables SYN cookie and =3D2 forces it for every reques=
t.
> I just used =3D2 to reproduce the issue without SYN flooding, so it would
> be /* sk is NULL for SYN+ACK w/ SYN Cookie */

Sure, that sounds good.

> But I think no one will hit it (at least so for 9 years) and wonder why
> because SYN could be dropped randomly under such a event.

Yes, you are probably correct, but that doesn't mean a brief comment
as described above isn't a good idea.  If you add the comment and
you've got my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
