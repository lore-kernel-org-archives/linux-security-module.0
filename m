Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2A14262C
	for <linux-security-module@vger.kernel.org>; Wed,  7 Aug 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070725; cv=none; b=J8qZO9DP8luNbbRnNiZnAae/HBnGe3Qy3lKcSC3iBsPlEpADxxkbz3VO6oO8tiQWld+2Re25mmYIyFkNVCvo3gUHBJEDDOiPsktWKnuBs9sMOEzVT0sNHpOCIOWG70RUbYvME5mSvr1ICGK60cfLkLTHXs5qZQehoPXDPjxikyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070725; c=relaxed/simple;
	bh=TimWbGbKEBpeOmAdJ5yVwLShHbXvcyNTmCwEzBis98k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sofhwsSM5uj40Q7oKBzP7EMVNCBH69K/5l6BHk3/D6RkF4R1bH6REShsu7c+zP29RQBKfIFZflV2MW384ZiDNpb08zrWRnmOBmk6l29yBiWFPEf0ws5buCb2gFJhsclEMfTVCMEjOIOfMl8SLXoUCj3CqdIwEib6FlEBJIZKjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2HiNuHt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2HiNuHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E01C4AF0E
	for <linux-security-module@vger.kernel.org>; Wed,  7 Aug 2024 22:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723070724;
	bh=TimWbGbKEBpeOmAdJ5yVwLShHbXvcyNTmCwEzBis98k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k2HiNuHtGuYaGO5qSxswEBF9PgJT9EwsMhwRgxaLibyqPqPQcTJkK+l/mtVXaGF3/
	 oa0G570Wn4VyiLNtmTjXqB3U64ZCWEP9Qr7uymuwBDh1tiNtc7LW35C/I5+qa5jf+7
	 f5zzpf3ocpFbHW/Ru6sJXLzG4XxJoYtnZbj3OmrAggd/aXU2pwJOSlL5Srex7rOepe
	 GS5OVORxUT64zrjn54V/fEcdgJfSgBuFAT9TcE6fkyuRNxAYPxVtfrs0t270jwSm5H
	 UkIsHKu9xTO+vI+lHvV6llWVCZSmxFv/TXr3GeiF289p+guMQL+xIyyLvdKOXwiaSa
	 EvEi/RqLvwZHQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f16767830dso3182201fa.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2024 15:45:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXednOyTR8O4rCjZaqQL3Gbg+skoVHXTA4QD2dzM++s9xJAiAHftfMwA3yL/7UsyPToS2KuRuZQnC1N1tyuRQ7j0gyyLhJL5zJVV6YnlsyeYgEghcFi
X-Gm-Message-State: AOJu0YwI6ZbatqMN6FDEhDrekNyt4HxSqbn+YhUGy8tSylfp7OF+QnQY
	CBjW0L/8qFjg0z7o/Nc75ZLYALt7CvIDYJev3JbPplp2II9M3AI5lgG7X89Q4D7hP4uX8CF+GJ+
	pBo3iuzOnwp34Hf9cDusw7qhx4X/2QpyOYtNE
X-Google-Smtp-Source: AGHT+IHbIhEey5jtlYEQxpjmKc6VHQuykEyvScouTVZYeKTNFVE/BpVBGzuoNqq963ui64inoSQhGzztCqZsX8rAvaU=
X-Received: by 2002:a2e:8096:0:b0:2ef:3250:d0d4 with SMTP id
 38308e7fff4ca-2f15ab5c7c8mr127508701fa.48.1723070722908; Wed, 07 Aug 2024
 15:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
In-Reply-To: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 8 Aug 2024 00:45:12 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
Message-ID: <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Paul Moore <paul@paul-moore.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Aug 6, 2024 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Mon, Aug 5, 2024 at 10:20=E2=80=AFPM Nathan Chancellor <nathan@kerne=
l.org> wrote:
>
> ...
>
> > > For what it's worth, I have not noticed any issues in my -next testin=
g
> > > with this patch applied but I only build architectures that build wit=
h
> > > LLVM due to the nature of my work. If exposure to more architectures =
is
> > > desirable, perhaps Guenter Roeck would not mind testing it with his
> > > matrix?
> >
> > Thanks Nathan.
> >
> > I think the additional testing would be great, KP can you please work
> > with Guenter to set this up?
>

Adding Guenter directly to this thread.

> Is that something you can do KP?  I'm asking because I'm looking at
> merging some other patches into lsm/dev and I need to make a decision
> about the static call patches (hold off on merging the other patches
> until the static call testing is complete, or yank the static call
> patches until testing is complete and then re-merge).  Understanding
> your ability to do the additional testing, and a rough idea of how

I have done the best of the testing I could do here. I think we should
let this run its normal course and see if this breaks anything. I am
not sure how testing is done before patches are merged and what else
you expect me to do?


> long it is going to take would be helpful here.
>
> --
> paul-moore.com
