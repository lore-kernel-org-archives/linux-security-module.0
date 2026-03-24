Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DF3DEAF6
	for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345722; cv=none; b=Wks+sRh/qBeJYpquGbR3srDUfSHltxfFEHs/8echrGpDaCYCBqfj5Jk2/CaigASKa7DqmuAaHhKx3yM78q8sIgA9lk9gccHcuDpPOYNapJDihUjHsiXnabk97bC6xdCW2RbNHfRJmsqtWt/zRsvla4tFYsf7tQfqnS3JWZtI6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345722; c=relaxed/simple;
	bh=sZF6W5pnPzP+wyKmMseusXomgd6GQmLbbV5WkUEMd8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXsxSpdNSYq8epthYDoTfK/MuYxKxn0RuRXWwB9s1H4lG2fgwltqdsLhgQ2MWokxz0gZ3kU7CwpBhjo5Eg8u720aEw1jhrNPn76zFTkeeHtk7SFggnqygJFaKVH/9p1ZeXq0mPuL45dEf4Za5deRlFHjhc0eRDpBmGEhCENUFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fM2tPDmZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fM2tPDmZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66966a394ceso4580034a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2026 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774345716; x=1774950516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/gtLyXDecs+X4tic85y8h+OwTvn7U+74QopiIkPx+as=;
        b=fM2tPDmZS1gA5XfwTQthhy9UmzMZimx4lvPmcC3mY8Vuv8AOyHv8eDyqES1gQC7uDl
         jwGjcEwuIL5Bv/EPQkoRDlK1XZF//9os8+MilXB4pDiwVNGbhNoeCl9wHaZ9uvCPSU4o
         ib6GdBEfxQVomXn8GPw1aCZKCs3yQMLdu9w774R+SPkDCl5EaRhg8LXsR89l1Q+cQJAG
         1nCpdk6UQz+2Li/anEuWzIksp/9l2LRttJkeeOVmz4o+fkbGRY+mwGPdgjI7+Pp9tTYi
         E0+J/cmUgiJnK+LP+u+2U4BAWzdYpc24Lb58XnRJj0q9SmMXWQqJxbtCBdhEfrp9ywxZ
         Xa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774345716; x=1774950516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gtLyXDecs+X4tic85y8h+OwTvn7U+74QopiIkPx+as=;
        b=amGFYSRWbicyT9oNuBTHQvsb+4w0ZoFjYuI/YqE9vsJ6aY2NFVTEAfbZvKf8UZ1fOo
         LmtvvKyQCGOXcqa9fwyf3q3kjBY4XRsp3MfuzB4z+3GQaD3CZ61GJBvTiTRkeGN+3hqk
         OP7VFAa1vODIE9IrKWlwDSvDDCW99hIkscc0i71DjquxUDqpQlfY7qJZcSO9FA8VCBcT
         idX1F97nOypk4zeavai4rZo76jKYMp1losWj/L3q5TSH2Pkw4hLYnkfNOjhlcAAm47nB
         vR/B9unEK7705u53BIhNT3Uhhkx6nKWlfXG0uqWzkNZq9vShf/wus2RQ60a/1XsRYWT/
         3Vyg==
X-Forwarded-Encrypted: i=1; AJvYcCUxl8ujiJ9uEVPWju1Usj5AFrY5dxe3UqNJgsO+76zENHpjHeHhbw4nO/jTUGY0zbfLv9ckjgtNVLGvSCdLz9AizLZVMqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2m6Z3fVr7SB114zs0asqY36BLEhP1Er64ji+0DMP9VMNxE7yc
	VtQ4KwEM7qC712JuzWeRAq7ZZpz993lO0cDNxZQMj9qGMwoA6nbZ4ZapqVQPw+aaYA==
X-Gm-Gg: ATEYQzwqcqYKAB7CMzo1rBq+U6eRZhfV9IDpLFBu/2LQtgPbk2pJSLnrDghqPVtxXi4
	23kbzfZ4DSCJ3uodN9CV7nvEMjX2FFRhVyuuxCDi7bAndwcq4VRIWRSzauds1dgcEWe9OnZsmZw
	ZGE8WDtlqVTIrRk9+15+EOami419DvP1GHpMv9vcp2bK9xDr22DORGHRvPpLTie0NCu6DCMzqRh
	Lm6jBSvYeKC7EpLomzNi/UiR0Bsc3JlJ4quEdzH4MH1aloGo4INbWSZYYJO2SVXFoIbyrAyP3Q2
	rnAxV4NhF5kO4V/ZuaiOUUIk1DJoLokG+DQL1Ge2EYMprT6o3u3KzXub0hJm6kCyc9eOgYiLc9D
	LgrR8A83INCpxB4jzUqQbVJFMN5I6UVu7vTGVDn2ACKV7KSIpJlWJZO7EIz2lj/yQma9nCiCPol
	d6iseQyQA0ByhCvREFULGreI25QIRSi+zASRKBUz+dqnblAVBCs8AbmKmpgQW6fPyt
X-Received: by 2002:a05:6402:4396:b0:665:3cea:9864 with SMTP id 4fb4d7f45d1cf-66a340a3108mr1300744a12.12.1774345715225;
        Tue, 24 Mar 2026 02:48:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:b548:adac:2e4b:638c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668d219abf6sm4568731a12.20.2026.03.24.02.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:48:34 -0700 (PDT)
Date: Tue, 24 Mar 2026 10:48:29 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: "Panagiotis \"Ivory\" Vasilopoulos" <git@n0toose.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dan Cojocaru <dan@dcdev.ro>
Subject: Re: [PATCH v4] landlock: Expand restrict flags example for ABI
 version 8
Message-ID: <acJa_56LtPeeH956@google.com>
References: <20260304-landlock-docs-add-tsync-example-v4-1-819a276f05c5@n0toose.net>
 <20260323.sheiHaR5uRoo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323.sheiHaR5uRoo@digikod.net>

Hello!

On Mon, Mar 23, 2026 at 07:56:21PM +0100, Mickaël Salaün wrote:
> Thanks!  I pushed your patch in next with a minor fix.
> 
> Günther, does it look good to you?
> 
> On Wed, Mar 04, 2026 at 07:13:04PM +0100, Panagiotis "Ivory" Vasilopoulos wrote:
> > Add LANDLOCK_RESTRICT_SELF_TSYNC to the backwards compatibility example
> > for restrict flags. This introduces completeness, similar to that of
> > the ruleset attributes example. However, as the new example can impact
> > enforcement in certain cases, an appropriate warning is also included.
> > 
> > Additionally, I modified the two comments of the example to make them
> > more consistent with the ruleset attributes example's.
> > 
> > Signed-off-by: Panagiotis 'Ivory' Vasilopoulos <git@n0toose.net>
> > Co-developed-by: Dan Cojocaru <dan@dcdev.ro>
> > Signed-off-by: Dan Cojocaru <dan@dcdev.ro>
> > ---
> > Changes in v4:
> > - Make warning somewhat more terse, merge comments.
> >   - Remove some sensationalization. ("Don't copy-paste this just yet!")
> >   - Apply Günther's suggestion (v3 "recycled" some phrases, was long)
> >     - ... but also retain some of the wording on ABI differences
> > - Provide a brief overview that contextualizes the example further:
> >   - Clarify the difference behind ABI < 8 & ABI v8, to avoid
> >     misunderstandings on which option is the default.
> >   - Make "linear reading" easier.
> > - Based on Mickaël's feedback: Avoid cans of worms w.r.t. use cases
> > - Link to v3: https://lore.kernel.org/r/20260228-landlock-docs-add-tsync-example-v3-1-140ab50f0524@n0toose.net
> > 
> > Changes in v3:
> > - Add __attribute__((fallthrough)) like in earlier example.
> > - Improve comment for LANDLOCK_RESTRICT_SELF_TSYNC (ABI < 8) example.
> > - Add relevant warning for ABI < 8 example based on Günther's feedback.
> > - Link to v2: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v2-1-60990986bba5@n0toose.net
> > 
> > Changes in v2:
> > - Fix formatting error.
> > - Link to v1: https://lore.kernel.org/r/20260221-landlock-docs-add-tsync-example-v1-1-f89383809eb4@n0toose.net
> > ---
> >  Documentation/userspace-api/landlock.rst | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index 13134bccdd39d78ddce3daf454f32dda162ce91b..64c7138a788d74f99da0a71428da392b3d873bf8 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -196,13 +196,27 @@ similar backwards compatibility check is needed for the restrict flags
> >  (see sys_landlock_restrict_self() documentation for available flags):
> >  
> >  .. code-block:: c
> > -
> > -    __u32 restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> > -    if (abi < 7) {
> > -        /* Clear logging flags unsupported before ABI 7. */
> > +    __u32 restrict_flags =
> > +        LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> > +        LANDLOCK_RESTRICT_SELF_TSYNC;
> > +    switch (abi) {
> > +    case 1 ... 6:
> > +        /* Clear logging flags unsupported for ABI < 7 */
> >          restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
> >                              LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> >                              LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
> > +        __attribute__((fallthrough));
> > +    case 7:
> > +        /*
> > +         * Removes multithreaded enforcement flag unsupported for ABI < 8
> > +         *
> > +         * WARNING: Without this flag, calling landlock_restrict_self(2) is
> > +         * only equivalent if the calling process is single-threaded. Below
> > +         * ABI v8 (and as of ABI v8, when not using this flag), a Landlock
> > +         * policy would only be enforced for the calling thread and its
> > +         * children (and not for all threads, including parents and siblings).
> > +         */
> > +        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
> >      }
> >  
> >  The next step is to restrict the current thread from gaining more privileges
> > 
> > ---
> > base-commit: ceb977bfe9e8715e6cd3a4785c7aab8ea5cd2b77
> > change-id: 20260221-landlock-docs-add-tsync-example-e8fd5c64a366
> > 
> > Best regards,
> > -- 
> > Panagiotis "Ivory" Vasilopoulos <git@n0toose.net>
> > 
> > 

Apologies for the delay, this must have slipped through the cracks.
Thanks for bringing it up again.  Yes, this looks good.

Signed-off-by: Günther Noack <gnoack@google.com>

—Günther
