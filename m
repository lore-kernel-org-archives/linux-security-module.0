Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF54D4A06
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743036207; cv=none; b=k3zrtz5COL/nuh6KhM95lifBpF4MLRhpjyco5uFBC96Rgkyyj+aEKu1eNnmXtB3DvRfg5qVn51bQZNXMP3jhh3Kb+5qXFbFEwd1MB7YmHc6yJWtbKznnCNfp9MpQ1/1owwvYw9RHOKr+iRrAs77VkeWz5/NLG0+eT9hgJXb0P/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743036207; c=relaxed/simple;
	bh=ZRIq5Khg6Aq51ijIbZoX9tnJGrHj5zAm9JiOUOAN7GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDRhtGjNXfObRlUHysyw350iLdnNQ440aomeHDP30QJbpCG4MoIFtH/mBXOKRCW3sxfK3ZslUIMVF/RkrYF4Aw/wSNPYVa/3kRJ7orA8OIBsZU8EPNdbKKDuCLGKEGPeL8K44RmucwHmAgbxI4H5KL3CNC8mMHSEGrD5aXYtzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bYx+M2L0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bYx+M2L0"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso82028066b.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 17:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743036203; x=1743641003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSEHvwzqc6+vX4GGSMAkuMZSYs/NqElnjSu4FwXASbM=;
        b=bYx+M2L0MxVP0sWVxHHZDYjHj3OInTySgvHZgZp92f5IJTNEelBV2aJY3yb2WdAfFF
         5EaZ/vmu2Uj8NpvPcYBZlvMj0fjlPgoYlRqXVdf8K5HhriVivH9eqyxLJObj98vXOw2F
         RNaE3Y1C/AO/bgsuwlj1IyDzdGLZsEYF6WjnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743036203; x=1743641003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSEHvwzqc6+vX4GGSMAkuMZSYs/NqElnjSu4FwXASbM=;
        b=anJFm1AkGhh0p1p8waDZfx/1AfqX16PSd5hdcnUO9/9NSz+TvaMiILks21n4iEIBrw
         iVfJlwJmLM2aubol6ME3zuWYcmQ1tAlTcYYeGmTpyokSc8Rbq5/4OFOHGPhCHfPPwufr
         lraJ73cV/wyU75f9+28wM7bSx+butzTgOReJ4HOAdQ3LtjotsnKMKKXosJ227Cqd9o0e
         x9OTxK5RAGdUIxqvztArrkqBwQcpPQReyEXqp6/4Ppby2vQKF1P/6ZLkp2xWI2qDSnnv
         yXVJiNxcr/fL69VwJjWFB9vfHumvwP60ZnBwEvXDR9MYxRw3i0v6eICJW4nfTZVIHQBs
         vACg==
X-Forwarded-Encrypted: i=1; AJvYcCUIwFg3jvmomoSdTH696oWQp5YsZCAesgrVIfX0jOFxstvWxR5OowIhhQL2JSrPk5pI4H42JdgOS+XBAgPZ0PIwOFj1MbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHiEEplNo6eMc+96xxzRuFVPf8CoMOcjOuQ1RTfOnpL+iqCaAu
	MuQZSIadVqaVIOVa5FRrlnDXNrykh5jT2SSu7vRVyCl5H3T3ReqLJaM7AjnV21Fy2PID7MmeL0n
	R+U0=
X-Gm-Gg: ASbGncv30BIJ9vQDw/iBFwnIZn/VULju55aCDZ3E5sJnJlTdSTeqnrTkq4sQU9qxk9m
	MKmbPYmWfORbBF9L96jVu1Shx0SGPDfXZFX6myXrUq5GdaUAQPZ4AFBkWbbP4k/qu+2JevBMm0D
	H4dymQ7sH53In8O2j7vuzMjob40sQDCtVsqdFtxP3JnSnOBkENoiPRqRdbOjTl2rVbSszxWnofT
	A2X5EfS97Zqtqnno9YSqEJv6e7C1CxKjnYSZ0ieQYrsFaxgwj1AJiYsXZMDxVa6P74/yzuS5Z2M
	xVqOvl8+WfQOERZ3eP3++Lh238IzsYH4xuAS/r3DkhzqBQPSxN76exx+mB9P4VCkCjk4fYTrnD+
	8K41HrYNxFWQWCq1X4lQ=
X-Google-Smtp-Source: AGHT+IGY9pIA8YxzBMWSRgqtN7b+Ajlti05TwiNah62nfNCAioZfb3dBaIPSB4d+753TlwvIYFh60A==
X-Received: by 2002:a17:907:3f8e:b0:ac3:f0a3:582e with SMTP id a640c23a62f3a-ac6fb122392mr159750466b.41.1743036202866;
        Wed, 26 Mar 2025 17:43:22 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd47fd6sm1120894366b.162.2025.03.26.17.43.22
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 17:43:22 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso72552466b.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 17:43:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU43jzBnjyVMX9zPfthtXSavwemRdF3qomcMSCGXnJxR7g7/BXTLN/iDjH3f+08op2sR+ARnTh1AyGyusiIG2QorYnWz3o=@vger.kernel.org
X-Received: by 2002:a17:907:2d89:b0:ac3:4487:6a99 with SMTP id
 a640c23a62f3a-ac6fb17334cmr105428866b.47.1743036201761; Wed, 26 Mar 2025
 17:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com> <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 17:43:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
X-Gm-Features: AQ5f1JonWSEl5Zs00Hyi9Ae5fBcyzdZ-fy95HrSDL7P0Ss4g7AbqUZAXwxAg-nE
Message-ID: <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Paul Moore <paul@paul-moore.com>
Cc: "Cameron K. Williams" <ckwilliams.work@gmail.com>, "Kipp N. Davis" <kippndavis.work@gmx.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 at 16:03, Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Mar 26, 2025 at 5:06=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > That's insane. So explain to me why you added what looks like
> > completely insane policy hooks.
>
> In the security_kernel_read_file() LSM hook, the SELinux callback
> examines if the current task has the ability to perform the designated
> read operation on file A.  Loading a kernel module and loading its
> associated firmware are two events inside the kernel with the current
> task loading data from two different files, each with potentially
> different security properties, and we want to perform an access check
> on each file to ensure it is permitted under the security policy
> defined by the admin.

What this tells me is that there wasn't actually any real ask for
this, and you're trying to make up arguments for a silly patch.

First off, "loading a module" and then "the module loads the firmware"
file are *not* two distinct things with distinct security properties.

The module DOES NOT WORK without the firmware file. So the argument
that they are independent action is complete nonsense. If you don't
trust the firmware, then don't load the module. It's that simple.

Second, your argument that there are different tasks involved is true,
but no, that doesn't mean that there are "potentially different
security properties".

Why? Because as mentioned, loading the module very much implies having
to be able to load the firmware for it - but yes, the firmware loading
might actually happen _later_ and in a different and completely
independent context.

In particular, drivers can do their firmware loads at various random times.

Yes, one common situation is that they do it during module load, for
example, in which case it would be done in the same context that the
module load itself happened.

But it's *also* common that it is done asynchronously while scanning
for devices.

Or done when the device is opened.

Or the firmware file is reloaded when the system resumes from suspend,
because the device lost all its context, so now it's reloading
something that it loaded earlier in a very *different* context, and
that had better not start randomly failing resulting in basically
impossible-to-debug resume problems.

In other words, the context of actual firmware loading is pretty much
random. It isn't necessarily tied to the module loading, but it *also*
isn't necessarily tied to a particular other actor.

So any argument that depends on the context of the firmware load is
bogus a priori. Since there isn't some well-defined context the load
happens in, any policy based on such a context is garbage.

To put it bluntly, your whole argument for why separate policy makes
sense seems completely made-up and has no actual reality behind it.

It also very much sounds like this change was *not* triggered by
anybody actually needing it, and as in fact sounds like just "let's
pattern-match and do the same thing for these things that look similar
but aren't".

This is *EXACTLY* the kind of thing that I think the security layers
should absolutely NOT DO.

You should not add nonsensical policy hooks "just because".

Security policy needs to have some thought behind it, not be some
mindless random thing. And there should have been a documented case of
people needing it.

This is literally why I was asking for the reasoning behind that
patch. The patch looked nonsensical. And I have not at all been
convinced otherwise.

                     Linus
