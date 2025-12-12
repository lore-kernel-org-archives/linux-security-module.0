Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE629405
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765561040; cv=none; b=J/TVubO7qPir+bzJgNy4dR7psqrQLJQX/ZgaYVQKY1dclhz6RpwHCZPce1Ujg6SedBc33T3DYNOfMkXTPWv5rrMXls+Pi1eITMze55pWO8+/JsTRiX9oLGCBcT1UEcruJwvS9TZC0wTJwWt52DdOLoc/i6D6et1loK5OzWtAiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765561040; c=relaxed/simple;
	bh=kmyTb8f7ANdM+MsWC7PFfaExOUyMyEDbvV487N0FAPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a445E6p5Hgoq10AsMZCK+k1lEwTfwRRXGb4RUB9dtqnigriWnqC//PhKLfjSm0naK1GflgcmuEc4SBQR1RJmazZrqi7IsJcUyvcgFBHKG9lqB87TgLDg/p+zHr63NM4ZP0uCWKWivDBU6J6TYMFVAQaPzeasu+VJXuEP22wxNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxKK8Oje; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxKK8Oje"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0834769f0so3986295ad.2
        for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765561039; x=1766165839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdnLtOwah6v9l9FVNClqavGt3Tmfq0zzKYByX343w64=;
        b=HxKK8Oje7b6AOcYX60W2oVZSQoH6U/gQwL+qZV7odkvkxv8ilJQVG+fCwbS08JrDXr
         Zg9chxV/ztoOwMiveAH+PxLsPQVvedKneoOrccC8ynFbnwyhfKRLpg0PDPNeGQ1t2SqE
         dKI499nwdcVLBQqa2xqt9EV/DxHQijIhZMwCyAhrGR4N0ybaLqdchazYITr91vRfKAqC
         jyvAf/IZl2plkMluuyOq66UV1l3BfkLajLuAIEOy5aP1cDqPEu6F9MrSbgZaifSy4XT3
         adVdB7d77FL+w+C1mcQTn9zZTsNnHkSoxTB5uXm65bfMuFJlJqwLU2P5MD2zSa63r44J
         Xk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765561039; x=1766165839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pdnLtOwah6v9l9FVNClqavGt3Tmfq0zzKYByX343w64=;
        b=OMzn3gZ3sNnVYUqTNmiIHXCQCb1sUrUvtKHX+qxYQp5oORJShJK34cIin8YBECScUI
         AyEB0YQ7wHVtTSlE9YU290JKgpyt5A9QdOAs5NdAFtuC33jH6xfYqxEhdM0jA0H0Aai8
         rka32eM+uzqCbKjm2SvLEYla8b6ef+OW7l2VJd2BGgk99LinzZC1+uFl+zZjipnrU3uH
         aex6XnyHYxjUrPIMUrXQZ4Y2fZZ7ukgh9/KudG0BdW7stiISs0GGJ3sCVXfO3RUsIL9a
         3gqAXfQk21yhyf/ftPjMCUKxVTxoEGWC0fqc/Np///lnwypgdMEFBh8mYr3N9WKcjbrD
         fmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHahRpQSgwFDsOUgRg2q9v1WfPqe5ZYJI3HSo7UJTKMMiLxPPApG2JV1hhX78xhYJBhFTOirdiMJ2h9JZaNIg2/ywz/Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2kX0P+7RvSY43uVbcEceC+t7UhNzOaNtWLSGTW64P/Vt5E/4V
	TnjJ9gH0OwHXN5UtYDCwExJsVdiHHEVW92ogVpQWWt1AGE7PnbUS93HTYmsL281RThE6bNetlps
	v12FuZ8DEaW4omrVyAttrgetTrqdCJ8T7JQ==
X-Gm-Gg: AY/fxX6s1rwLJFOAxAGjvaYKOSLIQWu+KH8ePhVjfb+4KYleEmwnwPTCWMOmDYz/zbl
	56cbdQ16ccIlpnpJ3rTYJKIMEFL8qCax6RVP6yTf9IyYDpuFU1Vxa1qqnyn6dEYOxe8DoSSETR4
	Zvq6OGOWD7bNSkY8D0o9g0wmLqDuhbmdsS19R40pMmhFTkUuoKDIVYVdNeO02aNexviP1VbGpio
	r1HAliCItbwto9iXzHF76turgytV0zQF74fzNknRdUG2ByFUaY0Z4XL4hztJ/Op3uiYKKI=
X-Google-Smtp-Source: AGHT+IGYKOTXkkxRK6ORJ8UCcxfc9Ya7mDAQKSGRaM33sRkgl8cWi1l8hPqy/Tz3QCm7x01bPFn9stDtQMg5XG2aaow=
X-Received: by 2002:a17:903:38cf:b0:295:7453:b580 with SMTP id
 d9443c01a7336-29f2448ae69mr29789345ad.58.1765561038651; Fri, 12 Dec 2025
 09:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com>
 <a3d28a4b-ee63-463e-8c5c-2597e2dcba98@schaufler-ca.com> <CABZOZnRQ=b4K5jpNM8Z=Zr=+66COwLpC8gynzw88==mL0FCrOw@mail.gmail.com>
 <CAEjxPJ6CbZC-=onSGgELygnt_hsqaN0JS_jJFxWn+hYt90s2Ng@mail.gmail.com>
 <CAHC9VhSU5yLQkCchCMUx+OLk+_2YY=1fjzth4s+_ELwgXg5t-A@mail.gmail.com> <CABZOZnRgYd687neqk5e8vQu5y7cwPwbht2SHS-4=q0y3MWU=mg@mail.gmail.com>
In-Reply-To: <CABZOZnRgYd687neqk5e8vQu5y7cwPwbht2SHS-4=q0y3MWU=mg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Dec 2025 12:37:07 -0500
X-Gm-Features: AQt7F2pX2gUCnr_ztyjk-SimVbQ_Tu5P26h7Ve3gR2MmWKJDOwxo60n0Z1hcNXQ
Message-ID: <CAEjxPJ5O2YTPaD9S=UXw-KzTtQyXPuvZ_WXDHGX1Of1oxjw9rQ@mail.gmail.com>
Subject: Re: An opinion about Linux security
To: Timur Chernykh <tim.cherry.co@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	torvalds@linux-foundation.org, linux-security-module@vger.kernel.org, 
	greg@enjellic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 12:22=E2=80=AFPM Timur Chernykh <tim.cherry.co@gmai=
l.com> wrote:
>
> > While Timur was
> > added to the conversation by someone, I don't see any mail from him in
> > that thread.
>
> I probably missed this thread.
>
> > Beyond that, I'm a bit lost.  As far as I can remember, and both lore
> > and my own sent mail folder appear to support this, I've never
> > commented on ESF.  At this point I think Timur may be mistaken
> > regarding my commenting on ESF, but if I am wrong please provide a
> > lore link so I can refresh my memory.
>
> Sorry for misleading you. My mistake, I should have checked the thread
> first instead of relying on my memory.
>
> > In this post Timur provides links to his ESF project on GitHub, but no
> > patches.
>
> Am I correct in understanding that any proposals and questions I'd
> like to discuss with the maintainers and the community should start
> with patches? Even if the goal isn't to implement a change right away,
> but merely to evaluate the idea.
>
> When I proposed the prototype, it seemed excessive to me to prepare
> patches for something that could be "finished" at the idea stage.

It doesn't seem to require much more effort than creating the
prototype and publishing it on GitHub. "Write for maximum efficiency
of reading" includes avoiding the need to follow links to adequately
evaluate a proposal. Just provide enough code to show what it is you
want to do and why that can't be done (well) today.
