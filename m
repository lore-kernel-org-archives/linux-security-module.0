Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC33806DB
	for <linux-security-module@vger.kernel.org>; Wed,  1 Apr 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063625; cv=none; b=nmgnvKWGaxHpj2HLk8kAqtg1FvsG96ruaK06CbyewndUaT8VjIDPn+7lWiIc1x/PeFIOR7eosIdSxCA/HdBdxifpM7qSn/LX7nbBZ2juslP4+Z4wjuIs+EoFCiXkkCU4AoG8R+ZqcFucNNMYtkyhqHF+xNZtf8q6MX73n20+HNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063625; c=relaxed/simple;
	bh=qACuUW8MJQK15d3swLXJQrq/Dz+q6uksea/sKvV6CG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klO7p3qt7A4taVKCqt/ditBjxTqGeTgI0y57Q3eUk4edD6wQ6NPskhhh7o2oJ6SXIDOCcALXM6YYpEnmLvxHsm/ljS7K9VypNmIWGCgaPMt8NHqYN8j2L0zhOz19/CH1bQEjUzwng0L6oylRxYgrybY9yiqREa2g6q+pQKuU20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCY5/QBP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCY5/QBP"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso16618f8f.1
        for <linux-security-module@vger.kernel.org>; Wed, 01 Apr 2026 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775063622; x=1775668422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fJpwqdjWjQodjK2dvOM09fqMSUPEuijecDw3AHC/yLY=;
        b=eCY5/QBPOE6V6phd/RpkFYQ5VoXTOGKt1VnwTW/6zE0Gg3d5ap0tTOzCu+iKezOAmp
         FIWHL1BoYNjA6JB0o9CdGj3G9O7IABF0mU/OpPPUBLpvGsec2oXufDQBNFd1QbHNVSrL
         JR47nIZEXTba9HtwFa4oRLULBwJOM6E1fh9oDeySbs4QGUBqu9ldAOzilKKA+ZY0DmHP
         Vv5kCC0OqbrZtfH3mvSN9ynYHl2yRVAM1Ylws577spnaujboXtrXl7i3puwV7Lj8k7K1
         +xB2jxzqnCAdosx3p8oPRD1v1GXhYdkqKEZKEtaslKDbLKxLmhM1q3hx4MhM/STYdRiJ
         Dlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775063622; x=1775668422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJpwqdjWjQodjK2dvOM09fqMSUPEuijecDw3AHC/yLY=;
        b=Pnb4n9IO4RYQdZr1eAvdZrobQU9KoGFrvxTA/L4+iyWZG6N/EmFaY51XdrqoJit980
         UmHcb2ngbwr0lruKukVmzD3prarYl+tKX8MFbiUuFgw8G8i+rx87baXCK+FfULRBT13F
         Gft1YCorGS3z4ZwypA4F5XWfA7SzHaR4YoDe/go6BhyfuvU2aFoJ3/YHEVaq+aAqPjgt
         6M1OyYw2U0zdZKQJh+RU6h7uSNOQ2TnYul8+zY2TafyXV5cCMVgOhRf+uE3oFLqzdFF6
         TN69QDrRmRIJPqtn6uUHsvI/eJXjTHAQj8dh/xGGk8e4uyY9nOAspY6n1aN00Lm+YmhP
         0zSw==
X-Gm-Message-State: AOJu0YyymmrPZ0J+xDXm4eGEPAVJXThSi7kJ4Oq1WSYlHTQ6DHRpMpyP
	4BpfClw5fM9jkfZ/V7Lk+EYMWOCk5+VtWm0dC0Tj2fVdU4wwdp2Dg/ZSZ5r2n8IfWR568iJJk9L
	NoUJfp+Xk
X-Gm-Gg: ATEYQzxxyElrjFR6k61fjb7K1lXMeSz9vzdHzWvl8f6udiyCqSiGmF4+3RVwYZdB+yI
	z/Hq0Yg+H9cq1LSshkuNolC4F5V9Uox6edR/qQHhrc+IsTcJ1U2+p7YZmYeaBo8Mf9e+pDqqlak
	dZS8PFJf2NlRGEFZak07EClrjW2BCXGhOC9g2HEAgmtqoSVERzqMiGPBhM1lRJhJxIao+z59mD9
	kL/kY2hHo4JLqZ8n0P/dR8N+YWl55duzwpJ8BdKGVizqKthqdkoOhXirP9x9c/EM89U1Xlp2fMN
	aJyHCNN9Q1bza4O38usok7z5BUMQxwvwR5V9pX/ZL05o+Le1UcirD1DoLiOvFXQsC+n1WYtxYww
	VdQvNys76kBJyBpvhHqzcuJEWj5qNTpiVsQOrbJzCL9YY54qTAJ3iME9zxjsGFBx9bSKX9h+fMM
	Al5Mw5kmk1rCcnUV86Ob25cLBru8+DF/jrytgJOaE6iX+utroQE4CuKA==
X-Received: by 2002:a05:6000:1842:b0:43b:50d6:4f04 with SMTP id ffacd0b85a97d-43d150e99a9mr8423551f8f.38.1775063621195;
        Wed, 01 Apr 2026 10:13:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d433:27f3:1afe:42d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d282esm1334013f8f.18.2026.04.01.10.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 10:13:40 -0700 (PDT)
Date: Wed, 1 Apr 2026 19:13:35 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Document fallocate(2) as another truncation
 corner case
Message-ID: <ac1SP3cGuEeIZFmM@google.com>
References: <20260401150911.1038072-1-gnoack@google.com>
 <20260401.oor1chahp2oF@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260401.oor1chahp2oF@digikod.net>

On Wed, Apr 01, 2026 at 06:30:28PM +0200, Mickaël Salaün wrote:
> On Wed, Apr 01, 2026 at 05:09:10PM +0200, Günther Noack wrote:
> > Reinforce the already stated policy that LANDLOCK_ACCESS_FS_TRUNCATE should
> > always go hand in hand with LANDLOCK_ACCESS_FS_WRITE_FILE, as their
> > meanings and enforcement overlap in counterintuitive ways.
> > 
> > On many common file systems, fallocate(2) offers a way to shorten files as
> > long as the file is opened for writing, side-stepping the
> > LANDLOCK_ACCESS_FS_TRUNCATE right.
> > 
> > Assisted-by: Gemini-CLI:gemini-3.1
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  Documentation/userspace-api/landlock.rst | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> > index 7f86d7a37dc2..d5691ec136cc 100644
> > --- a/Documentation/userspace-api/landlock.rst
> > +++ b/Documentation/userspace-api/landlock.rst
> > @@ -378,8 +378,8 @@ Truncating files
> >  
> >  The operations covered by ``LANDLOCK_ACCESS_FS_WRITE_FILE`` and
> >  ``LANDLOCK_ACCESS_FS_TRUNCATE`` both change the contents of a file and sometimes
> > -overlap in non-intuitive ways.  It is recommended to always specify both of
> > -these together.
> > +overlap in non-intuitive ways.  It is strongly recommended to always specify
> > +both of these together (either granting both, or granting none).
> >  
> >  A particularly surprising example is :manpage:`creat(2)`.  The name suggests
> >  that this system call requires the rights to create and write files.  However,
> > @@ -391,6 +391,10 @@ It should also be noted that truncating files does not require the
> >  system call, this can also be done through :manpage:`open(2)` with the flags
> >  ``O_RDONLY | O_TRUNC``.
> >  
> > +At the same time, on some filesystems, :manpage:`fallocate(2)` offers a way to
> > +shorten file contents with ``FALLOC_FL_COLLAPSE_RANGE`` when the file is opened
> > +for writing, sidestepping the ``LANDLOCK_ACCESS_FS_TRUNCATE`` right.
> 
> Interesting, which filesystems?  Shouldn't it be fixed in the code
> instead?

It works on ext4, and I also see mentions of FALLOC_FL_COLLAPSE_RANGE
in XFS, F2FS, SMB and NTFS3.

I should mention, it is not *exactly* the same as a truncation, but
you can remove a chunk of the file from the middle, which also leads
to a shorter file.  For example, assuming a block size of 1024:

  1. Make a file with 2*1024 bytes: 1024*'A', then 1024*'B'
  2. fallocate(collapse range, 0, 1024)

Resulting file is 1024*'B', and the file is shortened to 1024 bytes.

So this is not *exactly* a truncation.  (The man page says that an
attempt to remove the end of a file results in EINVAL, so you have to
take it from the middle, and it needs to align with block boundaries.)

But it's quite similar, also shortens the file, and it does not
require the Landlock truncation access right.

I agree, another way would potentially be to call the LSM ftruncate
hook.  I suspect this would stay compatible with other LSMs, because
the LSM ftruncate hook is a relatively recent addition (but have not
checked in detail).

The implementation of fallocate is vfs_fallocate() in fs/open.c - I
only had a tentative look now; it checks that the file->f_mode is open
for writing and calls security_file_permission() with MAY_WRITE.

I always saw LANDLOCK_ACCESS_FS_WRITE_FILE and
LANDLOCK_ACCESS_FS_TRUNCATE as rights that should always go together,
so I suspect that it does not make a big difference in practice, and
that is why I am suggesting to just document it more clearly for now.

—Günther
