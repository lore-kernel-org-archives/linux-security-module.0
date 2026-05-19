Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412A405C4C
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148907; cv=none; b=c5pTECdLsIdoeaQ2gPALNW9/LxaLqN0FNN8RkjMEMZVhGeCkCjcVYh3Z1XzH39CRo7b7fSodg5TWs5+F7WaoAE+mv6GCTZTh9TOOQzeMmdr92mJlkHmooMhFjLL+uUb9wEPzhyeS6cBRYnjXGmTgEtv+/RMouMPb6p+1hGtPc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148907; c=relaxed/simple;
	bh=2+e1SUcxfcvi6vWOPyhbVFkUNQqDp3uISw4CdRaGhRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4castg2JWJ17QMhkJrJ+Jjmazb6mordwJGXlTM2fvm7ZlFRPhLVtd9hI5yAV0CdJm2r7PxUM10uZ0ybJB4MSu+AJB907ujRBUtjYGBu/gYtUgE9FsPSMbrak9tMpb/30078tEYMjDPfcjrj9UMAdENXriL1fvtGOrPaQwIUVtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7BJ10pi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7BJ10pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB447C2BCF6
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 00:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779148906;
	bh=2+e1SUcxfcvi6vWOPyhbVFkUNQqDp3uISw4CdRaGhRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N7BJ10pic5fKBuGwkH4W2GT5Rlx4GVM8/1QGU7DcJ+O7Sm/wpJNTQ0Fm3t5sZz+Gm
	 p0hcwh1oyJk5RdIwvsxuWmFC6rMjqnyN2fnzmcy1CclfcWUuV7YZGhx1LrzDFQsUrL
	 Kf+GK7pmfqAXZdurkHjUX7C4vZK6fnBNsrrW192JdL1mfJWewgHLNqR9LzbI7ey4sY
	 vi8+egEVgiPPJbfhENtbe/aTYBRsG7xy8BeOHqyEPF8PMxIEmFbpEdd8fWJ4X6sqcH
	 OiKIWhllogJZKszpbzP1f+v9iCDW2m715qvZQcz70eYYO1lf8F+b/TcCqq73zz4wlV
	 xEBhL0DBOhYCg==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651bf695701so2817140d50.2
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 17:01:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ZtyTR4GsVXibhAWA8cF2brgxOCQipnjYfbZltGlfhneDr2sYWD36yl5LfKO29w/1w8FjjjNaNSq+82E7b6YmTW2OZy3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgQoTp0HGHFITXIMKOi508urhKsJoVC8IqPmb/8yBHjGKJ83O
	Mr5BdwdOchLEKIA/Lxoe3GdXNc05oX8jb64aC3vHmDI+Is4vep/YlDpiX113Q1CxR2ESg3lkX1z
	KhAFZuIsXk9GE5lyb8XJOlDLUVpYjr9s=
X-Received: by 2002:a05:690e:482:b0:65e:b97:771c with SMTP id
 956f58d0204a3-65e227e7bd1mr13339338d50.42.1779148906026; Mon, 18 May 2026
 17:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507070547.2268452-1-sashal@kernel.org> <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com>
 <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>
 <CAPhsuW5jQOzRTi1ea+=UPhx5W9bkBdivPagRE=O=nx0zf_vb8w@mail.gmail.com> <CAHC9VhTGDOJZDzEA31qc0S6FJpYNC4oD__HQ-65wqqwhng=V9Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTGDOJZDzEA31qc0S6FJpYNC4oD__HQ-65wqqwhng=V9Q@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 18 May 2026 17:01:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Js0Z6tU30RphbUjWsJXETkxaGOArfGZpDjNPmZFUpuQ@mail.gmail.com>
X-Gm-Features: AVHnY4IL2lsZOJsqWb6wqsR0gdm62QzQkBQ6U-S8bY5vWnYIgYDO7Ymw7EfHCoc
Message-ID: <CAPhsuW7Js0Z6tU30RphbUjWsJXETkxaGOArfGZpDjNPmZFUpuQ@mail.gmail.com>
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation primitive
To: Paul Moore <paul@paul-moore.com>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net, akpm@linux-foundation.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 4:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, May 18, 2026 at 7:23=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > On Mon, May 18, 2026 at 2:29=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > [...]
> > > In my opinion, making killswitch an LSM is more of a procedural item
> > > that deals with how we view a capability like killswitch.  I
> > > personally view killswitch as somewhat similar to Lockdown, which is
> > > why I made the suggestion.
> > >
> > > The use of kprobes, while an interesting idea, presents problems as
> > > allowing any kernel symbol to be killed introduces the potential for
> > > security regressions.  As a reminder, some LSMs, as well as other
> > > kernel subsystems, have mechanisms in place to restrict root and/or
> > > enforce one-way configuration locks; while many people equate "root"
> > > with full control, in many cases today that is not strictly correct.
> > >
> > > Yes, kprobes have been around for some time, this is not a new
> > > problem, but killswitch makes it far more convenient and accessible t=
o
> > > do dangerous things with kprobes.  If killswitch makes it past the RF=
C
> > > stage without any significant changes to its kill mechanism, we may
> > > need to start considering more liberal usage of NOKPROBE_SYMBOL()
> > > which I think would be an unfortunate casualty.
> >
> > I don't think we can use NOKPROBE_SYMBOL(). There are functions
> > that we don't want to killswitch, but still want to trace.
>
> That was exactly my point, but we need to figure something out so
> killswitch doesn't make it easier to cause a regression.

killswitch is making it easier to fix a CVE. It can surely make it easier
to cause a regression. AFAICT, the only protection here is "it is only
for root".

Thanks,
Song
