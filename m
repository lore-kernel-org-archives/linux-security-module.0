Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144A221721
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253298; cv=none; b=iFptgyCbAJ86ifqn9mHoEquseUee161oBX+6DJGUu7YCmi46XTa+vv0vDWvfBC6U+RsRWRTANuuFQCdJJKtbRtHfpzhZBkXclD5/k/0/U/HA7M92vmG5b4U+iCtMc6jd5TmJOSZxQBMGBwCUyA3WnZ/fnjLGooMCy7n82E9q+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253298; c=relaxed/simple;
	bh=A45b1oEv23OA3aZJAmnzMvvACXFNruWICI1qbWH2eFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM4H0nHYz/E8FlVjLvsz1DxQQDQWYFnht3XEy9M+IAi/Jq1YwgHDDWynYEuzTBB1d5WTo7DKa7VShAZQkK6YQfCW8Xwn/kb1wZa1Xm9FR8knKRWS7ZSpqQUYdjZe8XDDuSZCT4XF2VzLUbMjOCm4zxhxWtxmxoOUACdYjFFAPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZWhGu1Q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZWhGu1Q"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490ac357c55so6084705e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781253296; x=1781858096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xv285O01uVstqTw3npGucpK3QpwAZAkITRm8UoC/VdM=;
        b=WZWhGu1Qv9uknEb0OIzKbHAAj1cSiXjyrvopLEowTRJYVqdg2RMZ7mK9GXRFM3wAsF
         UWK6+6aUBqsIGb0lXaOcBbrKcLWmLn1NjuFHUwZi6/2fjXHGyDtEFfTsoWeIKuDfZJoN
         J1ydV2ErRPKm5s+iBed8sbliFBApO0BGnYuOpDzvtj5t2I4d9oQBxhnclQ4DLurzrQ9E
         oOfb01fGpIWFBlZ2i6fu2dbnQzOBeqOyToqxDGXmOrkY7TDHeOtj7YVYwscoeXQe36vm
         FKhowUZTMfu5Qa3lcyL36qJ7x5Kc0FYy7ohpfGMTsvrz2Z1ldlZwcvbp6RnIvk9S+5//
         VghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781253296; x=1781858096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv285O01uVstqTw3npGucpK3QpwAZAkITRm8UoC/VdM=;
        b=Hn4UmqOivgrScUAGcOKVA7Txpjfn9Th1i4Ro4/rA6ylcH55M6P0lJmYLgbz+Dy74ou
         PBeVZW1jHCAhF70raYzeOj3vHRW4+wuROPx5tv2KwhaODT1q+x3gsi3cvN7L6AcOiie5
         8/nGyY6Eq1m6f5vhtIjl8yTHgauuCpvbiA3xpnKMawKhZBobBLEfp/JU00c1j2eU8olQ
         lR9uAmEjLLCimJHYkbk4+jHS3gncLpX8WQuEt42S7jxEGV3LR/S2yxnp3gnoQzFOZOVk
         q448+FvmQ7yJz3pqB4JsDsZkcibK78ifvpNrBUtiDc6o8ls0h5llZ8BLuXYYnNHbN6vy
         Ec8w==
X-Forwarded-Encrypted: i=1; AFNElJ9O5bn2fId8Xi54ZL6/4OcIbrVts6lgnH9gEvgy+WzehZXN71xBMdE2Evux9W/HAcWOK6s9xvSEmGH0LHHtnJVAYPWwXsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnWaanHYgioBi1krUs7CJtVRU4o/NqNgSNGpWIGK3Z4buv/jT
	h/AhJuj327uP7fJKR5Lto5+OgPn8IBE5VVFrGza3MEcmLaKxPcqCA6DdRgNDUElKaA==
X-Gm-Gg: Acq92OH/neeQiyZ2i0Ny72ORIMir7oU03L6VE9wC2HcioIkFMbmJXrjwis0trc6sHAy
	QyJsUKz44kpCT/FJVyDvoVjgouHn0ijVHlKkq1t2JPkf0r2IweKH9jPhe75ogpzqUd1t8hYHZ+A
	rftFJq4GCmlZtmXMBc7Yf+ZGVY8hL+w70cGYGyNfKtZJEl99Q5EWNNkAXTaEnpWMzAmm/812vQ2
	Ysmv38se5Z5n97ZBVYnJEi/4h4tEr4eiJ2LnwsS2TYr9yBH+HrUE6+i1SNYBPCgeFETkk1gQb8X
	hxwleN6IRyiPUgQxx6F3n9o6JJ8gMK/AbEd7nUlr/3tkKhcctGcDo5SHUPOrw3VoH/mug8h1Pim
	YfqDFNAY+OKrF9EwojN0+EA+gMAxM5Kr9ckrKLT9Qgca2BEtHKHTtCcUts6GQPUF4lOugMFtXv1
	JlTl2n+TlyeDUAVejA/HlmRXMwf2xsZ1s9pJLHiuSfVvlD9Aw+nGRtEveaiSlOQcZI
X-Received: by 2002:a7b:cb8f:0:b0:490:e170:b80b with SMTP id 5b1f17b1804b1-490ec506d68mr13822625e9.32.1781253295063;
        Fri, 12 Jun 2026 01:34:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:3693:710a:2834:5702])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f3basm3578685f8f.12.2026.06.12.01.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:34:54 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:34:43 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 1/3] landlock: Require
 LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
Message-ID: <aivEo6bV_phFFJg5@google.com>
References: <20260610092318.3868884-1-gnoack@google.com>
 <20260610092318.3868884-2-gnoack@google.com>
 <20260610.uoMee2quoo9k@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610.uoMee2quoo9k@digikod.net>

Thanks for the review!

On Wed, Jun 10, 2026 at 03:38:56PM +0200, Mickaël Salaün wrote:
> Making MAKE_CHAR not covering MAKE_WHITEOUT is not addressed (see
> previous discussion).  MAKE_CHAR should not restrict whiteout creation
> *if* MAKE_WHITEOUT is handled.

(This is option (3) from your reply to V1 [1].)
        
I am skeptical of this approach, because it complicates how userspace
needs to deal with this access right.  Consider the following
scenario: A program wants to install the policy:

 * DENY  MAKE_WHITEOUT, MAKE_CHAR
 * ALLOW MAKE_WHITEOUT             in /foo  (path_beneath rule)

Then, if the kernel ABI predates make-whiteout, with the usual
best-effort fallback (clearing out the unsupported bits), this ruleset
becomes:

 * DENY  MAKE_CHAR
 * (no ALLOW rule)

But this ruleset is incorrect, because it denies mknod("/foo/x",
S_IFCHR | mode, makedev(0, 0)) in /foo, which was explicitly allowed
in the earlier ruleset.

So in order to implement the best-effort fallback, I guess userspace
libraries would now have to take into account whether there are any
rules where MAKE_WHITEOUT is specifically allowed, and if so, they
can't restrict MAKE_CHAR either?  I find this a bit complicated and I
think it's foreseeable that library implementers will predominantly
get this wrong.


Let me circle back to the other options you mentioned in [1], quoting
them here for reference:
> I see four options:
> 
> 1. Consider whiteouts as regular files and make them handled by
>    LANDLOCK_ACCESS_FS_MAKE_REG.  This would require an erratum and would
>    make sense for direct mknod calls, but it would be weird for
>    renameat2 calls than move a file and should only require
>    LANDLOCK_ACCESS_FS_REMOVE_FILE from the user point of view.

It would be weird for renameat2 calls to require MAKE_REG in the
source directory, but the weirdness would only affect
fuse-overlayfs-style programs and could be documented explicitly for
them for the case that they start using Landlock.

Normal programs that just call rename() on an existing FUSE-Overlayfs
filesystem would *not* require the MAKE_REG right, because the FUSE
process would do that on their behalf with the FUSE processes'
credentials.

> 
> 2. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right to handle whitout
>    creation (direct and indirect?) and keep LANDLOCK_ACCESS_FS_MAKE_CHAR
>    handle direct whiteout creation (and don't backport anything).  It
>    looks inconsistent from an access control point of view.

MAKE_WHITEOUT to handle rename(RENAME_WHITEOUT) and MAKE_CHAR to
handle mknod(chardev (0, 0)) -- This is a bit inconsistent, but it
does not make a difference for any programs other than the ones
calling rename(RENAME_WHITEOUT) (i.e., overlayfs-fuse), and it could
be documented for that one use case.

I find this a pragmatic balance, and it does not require special logic
for the best-effort fallback either.  Could you be persuaded to go
this route instead?

> 3. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right and, when handled,
>    make LANDLOCK_ACCESS_FS_MAKE_CHAR not handle whiteout.  This would be
>    a bit weird from a kernel point of view but it should work well for
>    users while still forbidding direct whiteout creation.

Except for the best-effort fallback, which is IMHO prone to
implementation bugs. (see above)

On the side, the implementation of this is also non-trivial: In order
to check for mknod(..., makedev(0, 0)), we need to check
layer-by-layer whether the layer handles MAKE_WHITEOUT and then either
check for MAKE_CHAR or MAKE_WHITEOUT.


> 4. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right and make
>    LANDLOCK_ACCESS_FS_MAKE_CHAR never handle whiteout (and backport
>    MAKE_CHAR fix with an errata).  This would be consistent but backport
>    a way to directly create whiteouts (e.g. with mknod).

It's mostly theoretical, but lifting the mknod(chardev (0,0))
restriction for normal mknod() calls and calling it an erratum seems
surprising as well, because it would relax security guarantees for
existing programs.

I also pondered the alternative of creating an erratum but
intentionally *not* backporting it, but even in that case, that
surprising erratum still affects older programs which are deployed on
newer kernels.


Revisiting this discussion, I'd lean towards option 1 or 2 -- could
you be persuaded towards one of these?

I have a slight preference for option 1 (using MAKE_REG) because it
would be a narrow fix that could be backported to older kernels as
well and would not require a new access right.  Given that the use
case for RENAME_WHITEOUT is really only for FUSE-OverlayFS and given
that FUSE-OverlayFS anyway needs MAKE_REG permissions there, I have
trouble imagining a scenario where a separate access right for
MAKE_WHITEOUT is needed in a policy.  It seems like a pragmatic
choice.


> Specific tests should check that all
> these cases are proprely handled.
>
> There is no documentation update related to the new feature.  A note
> should also explain what exactly is a whiteout and why it is not
> considered a character device (see previous discussions).
> 
> The sandboxer is not updated.
> 
> There is no audit tests.

Acknowledged, these were missing.

(I was initially hoping that this bug report wouldn't expand into a
full-fledged feature with its own access right constant, but it is
correct that this is all required in that case... :-/)

Will add this for the next patch set revision if it is still needed.

—Günther

[1] https://lore.kernel.org/all/20260414.Lae5ida1eeGh@digikod.net/
