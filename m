Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB8248871
	for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023188; cv=none; b=gkysMG8hi1Q/msZIgVvVpIJHH3eSaHMbw9FOI3153/66AVIM0Pq134E/7zClQWyXZ8MFOmTnzxTU8EP1hNObpSOX+h+NcgEpQgZXeip8Biu7ELnhUpAicjWRyaC/BaTctOsv6soc9O/S5y9AqxRmo2NCiuMfNIHhLOEZAC2SKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023188; c=relaxed/simple;
	bh=rBOd0N7sw7lqSgPKAUfjO0c8aSqpEDqRGYRlPQCZwgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTLAKw/XNb4fkTlmBE6MOiFlK5p18zyuxwoiP+A78fvMA45AGjDF1GiP6qeUij2pTA7E+j1Q4nBRV7xSviLIXCeyqVPBt8R0Gtt8+1sLCTX4vVIf26uSqwol39JUy3FLbKEqdjZEg22Q6afnBEfpYS1U70hhqp9syEO6CKxht3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P48Zh9Lm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P48Zh9Lm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so41807266b.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743023184; x=1743627984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzdIojrDdHs/8zIWGqiZCIGtqwEg8y5P2tmcwYv1zsk=;
        b=P48Zh9LmXKaZAC9rc/hQ2sqJRmu+2qOPwx7mpUqyx6WZkqsbK/CkFNJjc0aP0FFLl8
         CnmojlsHb3djFefTT6neNGyG/dUtQGyXi8AfyBqPJvnFx/Fl5sTT+5+I1ZfPvG0oa1qY
         jR2G9s0pRx3vrFmsDZeuxdzh3wbmTqBHeY94A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023184; x=1743627984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzdIojrDdHs/8zIWGqiZCIGtqwEg8y5P2tmcwYv1zsk=;
        b=MNhyZyGAOFlhWoXPbs2I/FL7Lod+JGHPh2U58+krunjAkOLmab5hoJPtFYcm6JUMoz
         EiqnZlcNeFpolTBjVl18O6QIdQpE/iLc3t58jW6yp5Itlbm94zFIZ+qXeJDbq9IBhHwI
         nARzInw5t54A39XYirhI54L0lJYYx62k18ZUO3ojRjIuLJJF9JrWS9jru20iXTTomPBW
         Tis4pCFvtqPrAwOA+d8TaDH5qMC6z+XvhnYc0YetUytjvkWqWYuIm9iidJfYQb5OFonQ
         vDvPPvimtNzRjgj2YSDSOIdi2sICOw5aOgvG8B/9/Fnn45a1mY2lWHzLV3AWnP1SQ/e7
         kw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOIsJUr6HnVAEAVqJUdwSUKT27N4f/IRcaUG2ktUzuBZ+QfJ0z9c+K/vTH90ykZg4jHa4cQ75K8LJh27rwXL3/mU7cGSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPSdaMV11gLC2SG6pKdwgHUrOX9BnqM99dG0w7VlEOBnTmh1M+
	KH4Pctr02LUX6ugciHwwx6gKJIBOpxpTw6ObyD3CiwhMCaBmnTHuZLBf6nIMxvs2SJjmsZZ0B+c
	uWgc=
X-Gm-Gg: ASbGnctb/CaYhGB9GeBHJvxFO3nVYCwkNnqzzxjs+d8ukn14afaBnWy2Na35BI5CX9B
	+OID+nyeqqitHW5DZSgUxbOskObbsWJwg0/WKpiy1otVnckdNFF3AMQ+d4vK2yHMI7mtpkKrbx4
	VFNzxdB+cqtodYen5PyinloIoRapHXTLbOGIhHGY+FwXMO4OoDGxGeChZGjucheDpck0f1BkcwW
	Wptrtf3elZABttznXpcdDQ3GmAzZkbWkNA3jpGUcfKFESOXjJSh8P+UY91am92OQWUhxJ7wMOYE
	1W0b3MiyioTMmf2XKXABsqdOk5kUAWXnLdoaAJxVBSSvsDKVL7c9Posv0dngSJ9Hzc0XSN1vLaA
	NCPeGdNak0E/KbiMnJd0=
X-Google-Smtp-Source: AGHT+IFNAIuVHzecs9McfburqnCpG4Hlg80waTkhMsgH+D46d126mzZSnGFLeF/uL7UKTwCMuMZMbg==
X-Received: by 2002:a17:906:f59b:b0:ac6:e42b:7556 with SMTP id a640c23a62f3a-ac6fae428f7mr82757866b.11.1743023184335;
        Wed, 26 Mar 2025 14:06:24 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd47f44sm1088663966b.163.2025.03.26.14.06.23
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 14:06:23 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac29fd22163so42439366b.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 14:06:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwrQV018Mekg5M9xxzh+7nd+EXLhmVHLGjvJ6C2ngPNRFeFSPHHYuMNnXHf2RW9inlFyMMV22Ob/xkwSlbktrVXgxkyO0=@vger.kernel.org
X-Received: by 2002:a17:907:1c27:b0:ac2:cf0b:b809 with SMTP id
 a640c23a62f3a-ac6faefb3c6mr77839666b.31.1743023183362; Wed, 26 Mar 2025
 14:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com> <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
In-Reply-To: <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 14:06:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpOP7o7v4OvVtYDIcepm7xWCMUr4sx6jgUkuQxGuRmvGQLwQrHUGSdEb-s
Message-ID: <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Paul Moore <paul@paul-moore.com>
Cc: "Cameron K. Williams" <ckwilliams.work@gmail.com>, "Kipp N. Davis" <kippndavis.work@gmx.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 13:48, Paul Moore <paul@paul-moore.com> wrote:
>
> Looking at the pre-patched code one can see that SELinux only enforced
> access controls on kernel module loading

I *know*.

I've looked at that commit. It's why I'm asking.

>      Moving forward to the recent pull
> request, the LSM hooks do have the ability to gate these additional
> file types, and for a LSM such as SELinux that aims to provide
> comprehensive access controls, adding support for enforcing controls
> on these additional file types is a logical thing to do and consistent
> with our other work.

Again - you're explaining what it *does*.  I see what it does. That
was never the issue. That was the only part that the commit message
talked about.

What I'm asking for is *WHY*.

I realize that to you, the security side is what you do, and you feel
that this is all some internal thing to selinux and may feel that I'm
butting in where I shouldn't.

But to others, these things cause extra overhead, so it's *not* just
internal to selinux. It affects others in bad ways.

I want the _reasons_ for new policy hooks to be *explained*.

>  The fact that these changes didn't happen at the
> same time as the enabling support for the other file types is likely
> due to an ongoing challenge we face where we sometimes fail to keep
> current with all facets of kernel development.

You are still just talking about what the code does.

I repeat: my questions is *WHY*.

*WHY* is that policy needed at all?

As you correctly point out, it has NOT EXISTED for a long long time
already, and the code has been the old way since 4.x timeframe.

So my question literally boils down to "WHY SHOULD IT EXIST NOW"?

We've done quite well without it.

And I do not not see the point of allowing a driver module load (which
*is* a policy, and has been for a long time), and then disallowing
loading the firmware that the driver needs.

That's insane. So explain to me why you added what looks like
completely insane policy hooks.

See what I'm complaining about? I'm literally looking at that code,
and I understand what it does, but it adds policy for something where
I do not believe policy makes any sense what-so-ever.

The whole "any policy, anywhere, any time, for any reason" model is not valid.

We don't ask for permission for core kernel functionality. We don't
ask permission to do things the kernel needs to do.

And new policy rules need to be explained.

             Linus
