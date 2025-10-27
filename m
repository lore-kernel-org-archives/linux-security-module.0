Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128122E54A0
	for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596695; cv=none; b=mBFaXekIr+n5RxMhqYWVnUjh8MbSHz0s7ewzEG31pQ3MPCURHDArLPCJ3xens8jRIblUjILV5RYtxvjtJMC+arR6kAazy2t2lcpzpHCCyryvfqtdOUW2CY1p40DpR1D1EpW8r+T2rCbTVN5uRBAdbRmgi0XHw58jimK/Zr4+pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596695; c=relaxed/simple;
	bh=O26YNzEdJ3QPI+0VWzw6KhHngkhD5YgkTZsq/NIar8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkaeHojQuZWf4UldK/m0gWp2K5LRnnzYk70bqTmns5biUEcYwa8CFQ/dr4vPCW4YY5NmQyiHLKyibbqcnEo17fk6YCcime5RqI6AfvBHWJ+F8DgxM6RZzCYn38uBMPMDHFFhTi1PyNUN9ozNuIgimk6E+cZLsS4NEnAiRlDJDHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IE1kYpNn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IE1kYpNn"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290dc63fabbso49108105ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761596693; x=1762201493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgWagJo2YU/oFmsKHPKceT2jMbhn9OwgubjxZ/WaMPs=;
        b=IE1kYpNnASmzdMHFZ+P3Oh9wrlZ75TdhMaxHCviyH+A93AEvjG/WfIwcHkBHOv/NQv
         d6V+YZYSnTkMAEgdcykGmrnE1UKlqEBkTLYyC0jOJExxp0IR4NaEtS5wapNAWMF96UpS
         ExWDDtIHsW3/8i+fjrYQB24GQwR1tfWYorQo7gsNhI/yC9R1LaOL1S1q+hsjVup5zMeJ
         46TQ1NHXKRLOzkgjnkAVTIJ7V/C771lZXFZ+oEz22j6Gnk1LA5xCE2Se3jXDybNrdopI
         nJSZE7L4JCiUrbGi/+4Nb2ymSRk7AHYnnNMLD96YT6sy1qwVRWJ7PAILRVLDy31qHy0K
         kzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761596693; x=1762201493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgWagJo2YU/oFmsKHPKceT2jMbhn9OwgubjxZ/WaMPs=;
        b=WmM7eqesVl5IP4O6sIee6JLm41FxyAVkbDFlkSUMQo8K7BlCm1NRgtLTpfmYtrs9UQ
         qmajAgFq9j+UGhN/8AMm7O0Q3r2c4TeYdvhJMA7K0MRsJWe60tG5bf9CCNMPmGEyiC+M
         j2SY7At6v+UddkhWDIDBXueZ6zD4Lytzq6y4a0hQM+sJN/y6BRG3NGTAd3ebg9UfV9dl
         owlCRooMm7gfd2DlJlZf96vVSe1Ovy3Zm+mJxJe+OqDL568nWWuMtgqM2XW1CPGw+aJy
         Dd9dXpcSvAKclmWDgCe/0YX64izpIQpS30yAhLEkeu4ckSMGnJczMPPvL4kgMBqYATdr
         7ULg==
X-Forwarded-Encrypted: i=1; AJvYcCWEPxWCg1y8/OBS71DjwcXX8OC0UYoVOy/sJOuBbdnnLL2LLnwrpocjAkEdyRE//psrNzFzpN1jU/VBCHyYtV8IXzvS5hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHksUEa7H8yhlRw4uIoBUPIIcMbssAIomqbRi7xxJ81ol/xmwY
	InOIkq2iytIghacwdsJ6w5hHeYLybNQGoFxvfmhPESmKqc/PQo5U8SO6RhJthkIO5zQdMxobAGV
	j9qcz+dU7OW+6PiXvSs2Ip9fBtTqo9E/KVJ8CLdsZ
X-Gm-Gg: ASbGncsFVjwhkKWDYxfc6A/bv9i3ZKW2t5XiMNaJJnakU8v9usMbO9U6Fb75lsY6sEZ
	j4lzmq0Ly9dCF01n6LiZGFMzJkWCchqzPXLueS5FVqLTok/uBkbvuQ5fyBtZci5V/TKGhAKLxIE
	rwyftYAjJ2M6S+FxJKj5TuVS5lQiD0bpqUMsmbUjiK9o3LsecyIR+J2rKtzoJ0qM32g67YbPvaf
	AOX7VK2KUHrho/sOwy1Nx2marR3y3AFtDY2V+/th2OfRcChUeTu81jjWYks
X-Google-Smtp-Source: AGHT+IFDV3g6ErN3yxsEWnHW1/CkPBxwftrCLJfB2QJuWDrssPOc1igql1P21JcoH56S8Ml7SDBpIHdU/bMeTDi6Uzk=
X-Received: by 2002:a17:902:f601:b0:272:dee1:c137 with SMTP id
 d9443c01a7336-294cb384b88mr11688695ad.13.1761596693344; Mon, 27 Oct 2025
 13:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
 <aP6OJTTWPQBkll56@mail.hallyn.com> <CAHk-=wjE5t6=eO90iXqEsw6yMGfE8Y6=THP0dqXUJHvNQ7=gMg@mail.gmail.com>
In-Reply-To: <CAHk-=wjE5t6=eO90iXqEsw6yMGfE8Y6=THP0dqXUJHvNQ7=gMg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Oct 2025 16:24:41 -0400
X-Gm-Features: AWmQ_bn8BYWuSBwc_rGyFbpuoo8trBAKKr6VahOoiHX2AiPEdC3J7WklfW7oY2w
Message-ID: <CAHC9VhTTaMe3ezEiXUwLfgCMrp7-of_K-9HmHk-TKApq4sGbfw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>, Serge Hallyn <sergeh@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:57=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, 26 Oct 2025 at 14:10, Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > The keychains are all NULL and won't be allocated (by init) without
> > copying a new cred, right?
>
> Right. As mentioned, 'struct init_cred' really should be 'const' -
> it's not *technically* really constant, because the reference counting
> casts away the const, but refs are designed to be copy-on-write apart
> from the reference counting.
>
> So whenever you change it, that's when you are supposed to always copy
> things. So that  prepare_kernel_cred() thing exists for a good reason.
>
> But the pattern here in nbd (and the other three usage cases I found)
> is really just "use the kernel creds as-is".
>
> They don't even need any reference counting as long as they can just
> rely on the cred staying around for the duration of the use - which
> obviously is the case for init_cred.
>
> > Now, in theory, some LSM *could* come by and try to merge
> > current's info with init's, but that would probably be misguided.
> >
> > So this does seem like it should work.
>
> Yeah, I can't see how any LSM could possibly do anything about
> init_cred - it really ends up being the source of all other creds. You
> can't really validly mess with it or deny it anything.

This came in just as I was logging off for the weekend and I've been
kicking it around in my head and I can't think of any *good* LSM
related reason why this should be a problem, however I do have a
somewhat generic concern about potential future issues caused by
someone choosing the wrong access pattern and causing an odd bug.  In
theory, a const attribute should catch a lot of that before it starts,
but that assumes we don't have some casting somewhere doing odd
things.

If we care about this, and I'm not sure we do, or rather I'm not sure
how much I care about this, we could create a new cred instance, say
'kernel_cred', that is purely for things like nbd where no changes are
expected and it can be accessed directly.  This would limit the
direct-access pattern to just kernel_cred, making code
inspection/review easier and leaving the door open for WARN_ON-esque
assertions in things like prepare_creds() and similar*.

* This reminds me that we need to talk some more with the keys folks
and see if we can get rid of the ugliness that is
key_change_session_keyring()/security_transfer_creds().  Jann had some
patches for that, but if I recall correctly there was a concern about
backwards compatibility.

--=20
paul-moore.com
