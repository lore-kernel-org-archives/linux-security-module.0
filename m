Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001DE1F875A
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263785; cv=pass; b=EPCtHQepN9t4qyvxFeAMX9V02z1GfDVP4KSMf/ZWEwwi6jIQ6k+MPZkaf4snlR6RCm5ulv0tw5hc5l1Yfo2YGQ6mgiwWXvIg07E4l60YJEUR0/sxJRapxB4dOTplrQ3PgDj0ij1T89YqQpsFs/sUoi3yzjg++9n6Z/FHZ+5ELaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263785; c=relaxed/simple;
	bh=y12TOxC/DHbDZOOJ8qaNO6Cgbald7GkbfWW6KgFcfhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8Dwg8zAz/6Lm+VV8Sn/oj0R7gLRU1LJBmjdi5TT5qkW8PQ5QPbmrbSJXQWs2sChr/UT+QaxHZW92wr2yjXhIolzAAqBj9uce+DhT5sxeAYR0EHsSUwm6s5pAkxxozmkeWmYtsfl2Dye5nxounH7PrdwA4U6kMaeYqZw6E4Q8gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CN98guDg; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CN98guDg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35a02ed9cbaso176264a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 14:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773263783; cv=none;
        d=google.com; s=arc-20240605;
        b=kRGMqqJTthAnr9mgimx885pa2raHiaZbq+TShRE9RQNhPF6qYk1FAad/6SrNDA6E3W
         cSLZXxyoZDcXJOPhO3lyWt1WK/byHuI6ZxCONCNcwB6yhOVkc75jheIELrVNYkUunMJ0
         KyyEhB4hPqgs8+u9iC1YzB4VMe1C0cbVKx5X8GA6zc2Efc6rwo99rNR6NPSHuUtWBKlR
         9zuMqPTmZQ0reGtxRQ0gB4oMaRm35AwBb+um/ckUMa/J/zG+VcOAH2urhNh9JJ1zE5RJ
         sm9Lq5dHWDFleSyu6UelOGFQ6QJbgZBkFH8YSLqNS3UwIfwDPZKkFSVVzV3nEtxaKtl3
         UQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pf5daXBZojaIQjI4nids0CduVFOk5/mSFDjIjbXY2QU=;
        fh=F9lLXtLgZ4JqwueWG4bLmoJ8wn4w7jly8aQqPtxepd8=;
        b=V8S28BMCQyjCJr/3giXCDNXLqAkbrWXQjo9Itnlt9u4XtScixhSFR5mY2u58+rltnJ
         4G3DjEWOGw5XMzY9ds9O4xnld7dIwLu7GfXN3GkNp7M0T96eI8V6V+ALIc83Q4QF4IJJ
         u1o9E4rhuuD5QvwGzUBMsm+rAw76cmhSw0nOFle0LN5bYqtjvqzV3zLhJX63jW0TWYlX
         iv6x5wfP4OPwqzcP0hv9k/eX+MBvvD0rjNxroeHMX2jHYMa6W3iw8nxvXPognS0BAOIr
         ZMg33f+fjbrWySrNAugrhTcmpj3OB7p7iQ8bQxI9ELExV4XMbqjG7fJR556LDBK7f6Ql
         clRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773263783; x=1773868583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf5daXBZojaIQjI4nids0CduVFOk5/mSFDjIjbXY2QU=;
        b=CN98guDglEvUJVhUwGc/DtQWfmEwJ6hvHnsIJeNEUiape86TNl1kBug/JTvBIFXKYx
         Fn3V9Ev3cSJM5piKWhIr11wHOa03tSIC4ZbtX8KllJyWAisUhxn9u0I9Zpc02vfXsYkD
         FD+oSzAt5yCLfY053yUJG7XI/XRY+RmJBlGiNxNhN/qbjx5h9GXjbSRSzPJE52qhA/fa
         tDfF+qHPnXh5XiP6RSBnequR6ZBLwH0uyxXE8x0/suNxH+dKBY3EWOw/LL+R8OzRW9dg
         TC6Oiqk4zVfzCBeOwu6W2t315z5qbu4jF7zd0jpLE9V7t+NQqxeJyfCRMwBGS2EblCQ3
         lcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773263783; x=1773868583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pf5daXBZojaIQjI4nids0CduVFOk5/mSFDjIjbXY2QU=;
        b=Hbd+xo7F2ogRv2fmdqJ9jLAWyft4B28be4WP9WNVXydMWVYgiWAGof1z7TYLXPiqB3
         i09OXhLgp5eeKYrkDXjiEWFjWWMAWsZETW9tuT2biXUPKlA/edB6ToeUl/amx+IyxbeU
         oo/Wa6SOTNAMNneE4L/SB2UXHXic26EMME8uxaFcIGqZhVelQgqpDEflIzGsAuxb6HBp
         tP+9O8JtKAKZIbw49Dm+GUlF0qZzhqPTFAg5TTh3jm6sUTpyWzkmYDoah7eZKR5DqPMS
         E37XCtibRdj+eJ0xVZNYM8jaQN9P73RGVtH6jv8X86wWu3GxNbUuulJkK0aEj8ByxHv9
         nYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd9MzqdvtWv3CfHLBv7+bXn9/4MkJGumr7qW+xyjYxtX0SWoFNuhTKmb3F4neEF2HoxeBYQsYHr1ohJ2CICEU2jPWat6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmodhhUDs03WnEXQGjGRtqZ6KmMcb2jKkYBNqZwXYxX5SR1ZO
	p544rv5QHmjhvItFYnLcUA/BI13U/wgXMKCqjxjFoFvHnkaYvbDQKyxBoThmCH/qj7TUCVHK7p1
	UyTgRvmNyZp31eBTcqxmbbWz4akYS6b1tq6AIfLfIlw8Q9gv2993AUA==
X-Gm-Gg: ATEYQzyntjW+X7NJnE6SVog2VCgwiNfKyWV9Wgl+dYSqe1rxrCfoFHbNHLHiSwFtMFF
	nqUc/FpHyxqlxCvZQVntZhr1QXejiXPe7Ejuk6tMM/kcSmIDoX6MOx0YZwxrtQdLkN1ABB43aYm
	pC9DUd3f3nTm2nyjif80hneEmEaew7uzdBU2aoBv4Ha4baYdNMC/InhUUxMvq9crEL96jH0fmT8
	29VKGrl6hJGWrWC3FcaddktmWHLrcDsTqKjXt68Wc4zjVna8Gww9E2V1IWzydMoIJhiuiU7gDwz
	NLBc+tI=
X-Received: by 2002:a17:90b:3cce:b0:35a:117:9521 with SMTP id
 98e67ed59e1d1-35a11a1f587mr696872a91.10.1773263783369; Wed, 11 Mar 2026
 14:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0102019cdb4c6011-735b3e40-8c94-4c16-ae3f-80c912784e51-000000@eu-west-1.amazonses.com>
 <CAH5fLgiQm=2YYvmG54o-MEt2m8x5V5xZrtmsqEUtuB9OZ=FPOw@mail.gmail.com>
In-Reply-To: <CAH5fLgiQm=2YYvmG54o-MEt2m8x5V5xZrtmsqEUtuB9OZ=FPOw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Mar 2026 17:16:11 -0400
X-Gm-Features: AaiRm52fjaUJAiq3au7DuQIBA0ujBOBbAQbSxuKE2SXCSBOuAdeoDFE5e8KbPRc
Message-ID: <CAHC9VhRRXLrZ80Gj+Kn+x7o4v1Y5oh0HAdWBLTX-t3SVHRDB0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rust: lsm: introduce safe Rust abstractions for
 the LSM framework
To: Jamie Lindsey <jamie@matrixforgelabs.com>
Cc: rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	linux-security-module@vger.kernel.org, ojeda@kernel.org, jmorris@namei.org, 
	serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 2:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Wed, Mar 11, 2026 at 6:09=E2=80=AFAM Jamie Lindsey <jamie@matrixforgel=
abs.com> wrote:
> >
> > v2: add missing Signed-off-by tags, fix short commit hash in patch 4.
> > No code changes from v1.
> >
> > This series introduces the first safe Rust abstractions for the Linux
> > Security Module (LSM) framework.  It allows a complete, policy-enforcin=
g
> > LSM to be written entirely in Rust with no C boilerplate required from
> > the LSM author.
> >
> > --- Motivation ---
> >
> > The LSM framework is a natural target for Rust: hook registration is
> > unsafe by nature (raw function pointers, C ABI, __randomize_layout on
> > the hook list struct), and the trait system can enforce correct
> > implementation at compile time.
>
> Hi Jamie,
>
> What is the intended end-user of these abstractions?

Building on Alice's question, I wanted to mention that we don't
accept/merge example LSMs into the upstream Linux kernel.  I'm
supportive of using Rust to develop new LSMs, and I recognize that
developing a meaningful LSM in Rust will require significant
shim/plumbing work, but that shim work needs to be done in conjunction
with a real LSM.

In case it may be helpful, I wanted to point out some previous work on
developing a LSM in Rust:

https://lore.kernel.org/linux-security-module/20250416213206.26060-2-kernel=
@o1oo11oo.de

... and if you are serious about developing a proper LSM in Rust, here
is some guidance for developing and submitting new LSMs upstream:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsms

--=20
paul-moore.com
