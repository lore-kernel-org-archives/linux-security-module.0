Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E485276
	for <linux-security-module@vger.kernel.org>; Tue,  9 Apr 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685746; cv=none; b=IUy/qe4uLbSGmtJwmGRe17wxKRSu2qA9I6fMqkGuSEAQ7BdmJgRcfgQWbsMYCZb+9U01nwcWo2xRp/L88U1HDzot3ALIpaI5O+fMZdflG5467e0eG4+l+JLAzLRKwzi0UeyjYB8igXB07ctGtl94tAC4C/ssN6q0XWIiWrj4qNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685746; c=relaxed/simple;
	bh=zPBR6FHUzVb88yfdMV8TqZpEmnE733LQx0Nl1VdnHRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAj3y6IRdbZOnTEetT52m6QsjxB8o3WUvLHciQ0pk02IRoYqkUeFO3/hjmp3XP97Me4ynFnHCO8I+7AL36uzW3mOJDhWZP2D8XF+HLLi80LXK6PCtZ2nCn+80Fz7gH6LRLL8B15/7B1eZfuFHJeIjo7MaI8c3MMsVOR7ORbkXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J4xjdJ+l; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J4xjdJ+l"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4266673bbso21655375ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2024 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712685744; x=1713290544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9p9W4olTCJLNIY4LFgRiTPMoiQu0jWjisFAK+GzZ+k=;
        b=J4xjdJ+lUYZMe8NHWX7xPQ3rgURTYdqAWTjFtQUT+Ey22WbJKS7WGKnQUlHzvQVDiy
         fUs/ARDyaxp3dwXSzJNLjmYKwSYbcqG3RubUY+RhOgPI8tc/BUtp+FKdkqvkOC2nH6tc
         93Nmi7oYfmcXLnKaQUOUoR94Qi88BiNZpUWHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712685744; x=1713290544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9p9W4olTCJLNIY4LFgRiTPMoiQu0jWjisFAK+GzZ+k=;
        b=UaVpc4K/O6PlY0GpKINezbLZqTUmIleveQRHfbVYnWT6jzMp4ZQ6jxTAzXb5avKKjP
         ygD6K6UPqO16904ix9b4s+/2EOnolzBk1UmGh3VrnSUplGcJz9SvHIeJ3KKN6B5GP01e
         dVYwJnx2lXkLWXYUnPGca+amJyX6l/mNrkRlDWLD9xy+SmsFfgD6caUpQe+sWEb518h8
         MuUgCI+FdVmZKSG5rVt+p0dFndLmZa/tn4AW2fXQqDKvHBhlksNpfM0C7flVWDBoHN6R
         Ho+Bgv2G/X5+awvzK1RM1glt3fCjt0+5vSNZJMssAAYxt1lU3amM2Ei+aPmXaJNriDj5
         b6mg==
X-Forwarded-Encrypted: i=1; AJvYcCXjvuonNMppbma/ZdiotFIYMI4o27OVCN40W84QWMs59357p/6paxoOhDnr5OlnyzZsLWo5mJZgHN+mPK+0qH6YSn0msmmBI9FwXi0YPz53asXC2dA3
X-Gm-Message-State: AOJu0Yz6r0jXDRg2jPalLqU4A3Yb/sSKKdgoP6rXWjeR1buKi8y3B0R3
	erkEV/E8mfuP8fkjYCe2fNL7XxQpge+g+akkPz+/DDI/royRovmpoiiHxjoWYkpo5v3IFsg7DiY
	=
X-Google-Smtp-Source: AGHT+IGopdIid603eguqrNNu1GdD9GXS9yW4mDzXlgXfTQoJ20EcnkQ45prc8FAv+RK8Mfp+xkUSNQ==
X-Received: by 2002:a17:902:8ec6:b0:1dd:7059:a714 with SMTP id x6-20020a1709028ec600b001dd7059a714mr505020plo.30.1712685743288;
        Tue, 09 Apr 2024 11:02:23 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b001e2b57a6e22sm9132315ple.305.2024.04.09.11.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 11:02:22 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:02:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, KP Singh <kpsingh@kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: Hardcoded security module suggestion - stop the stacking insanity
Message-ID: <202404091041.63A1CFC1A@keescook>
References: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+_xXpnHfUv=FwGWcce4XwqwKvtq7LcxK6WKmbf4eGGA@mail.gmail.com>

On Tue, Apr 09, 2024 at 10:22:42AM -0700, Linus Torvalds wrote:
> People, I know there's been LSM work on the whole "multiple layers of
> security modules" for over a decade, and it's been a design decision
> and a target, but I've complained before about the cost of the
> abstraction, and we just had *another* hardware security issue with
> speculated indirect branches go public.

There are 2 aspects to the LSM stacking: providing non-overlapping small
LSMs (e.g. lockdown, LoadPin, Yama, etc) with a "major" LSM (e.g. SELinux
or AppArmor). This has been needed going back a decade as core kernel
maintainers did not want to be bothered with all the needed knobs
touching core kernel internals. (This is not an unreasonable request:
userspace _does_ need to be able to apply policy at runtime, and this
goes well beyond standard MAC systems, e.g. LandLock.)

The second is providing proper container support for differing "major"
LSMs, which has been in use for many years now (e.g. running a RedHat
container using SELinux inside an Ubuntu host using AppArmor). This is
what is conceptually considered "nesting", but is nothing more than a
special case of the "non-overlapping" case above.

The general "LSM stacking" work, while it does add a certain kind of
complexity, has actually made the many pre-existing manual layering of
LSMs much more sane and simpler to reason about. Now the security hooks
are no longer a random sprinkling of calls tossed over the core kernel,
and are now all singularly well defined. This started years ago with
pulling the "capabilities" checking into a well-defined LSM, and continued
from there for things like Yama, and has now finally reached the last,
and perhaps most historically invasive, LSM: IMA/EVM, which is finally
now a well defined LSM too.

I don't think it's sane to demand that LSM stacking be removed. That's
just not the world we live in -- we have specific and large scale needs
for the infrastructure that is in place.

> So I say "suggestion" in the subject line, but  really think it needs
> to be more than that: this whole "nested LSM" stuff as a design goal
> just needs to be all rolled back, and the new design target is "one
> LSM, enabled statically at build time, without the need for indirect
> calls".

"One LSM" isn't the same as "no nesting". And "no nesting" is both not
acceptable given the users of it, and doesn't eliminate LSM "stacking".
But "without indirect calls" is totally doable.

> And yes, I'm aware of the random hacks for turning the indirect branch
> into a series of static direct branches by
> 
>    https://lore.kernel.org/bpf/20240207124918.3498756-1-kpsingh@kernel.org/#t

I don't think describing static calls as "random hacks" is very fair;
it's used pretty extensively in the kernel. Regardless, this series has
needed to land for well over a year now, even if just for the performance
benefits.

-- 
Kees Cook
