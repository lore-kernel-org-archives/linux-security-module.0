Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6F155382
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728145306; cv=none; b=rR8BA+DMtQMAT55HJ6owu+GmP1kDlkM3z1btfERvoIHUAu5hxmKNbSZWAJJ3UCRE4l9khQROSw9JV6uQv6BmpgbhcWFNFw8LSIX2VJC2Tj4wpF1dE8TIEQ2M3N7bMPzZHONTW6VfqahUPMvIdcDV8Icv8QQqzT8JZpNlCbUjE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728145306; c=relaxed/simple;
	bh=CieQIkKd5QiUkyaGk0l2c7XAKqDRw+lQNSg1vGYK8aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xcm4SbL1y6Fh95XtEmBhkwYOvXJJXqzCotlQ+gJOavJtXyCdIyeCns4ZI3ccVNJRVnnSFc5Wax8iY2jrlAk+foyuQk6h/SJc67WIu6tmaAy/JWomZuuXyHlqz0zKS9IrdYglMyDn6liU70INk6cAlGG0bGbHS0Bc85ynZB2ZWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dJMf8OMe; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dJMf8OMe"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e25d57072dcso2732803276.0
        for <linux-security-module@vger.kernel.org>; Sat, 05 Oct 2024 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728145302; x=1728750102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=na9IuPyEFt8kAzX30ydR0TtAKYYtK7o2TPoZ/aH8lhM=;
        b=dJMf8OMejIjPyOMkBAfZnomtTkPoKB7wRfSDpuTaCB60Y03a1VMgjfLiIImpSpptGj
         AWI8IF0JD8v4y5fmCGzkRlqWBkkyOnLVsf1lSllVs2mgdIQnJ/6Z9Fj4bDdAoDjIMk3j
         q/jn41lixwPsvijHDW6gG1SeWTDuHVAXf/FTMFdcqhMk/WwjDlRUY0LKo6lPrC8FHHXO
         Y0D7FdUxGTu8ZnNLeNlK90rSbPeuKMyEHcoPgJOg1rh+I+V68VcNvBbWFxKZEI2FtbOk
         22aKlFrpq7VlEFL48XYLldSQrmi0c+SDRRY5u6v0i6vuV2qq52wOlTetWIUygY+3uHWN
         gabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728145302; x=1728750102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na9IuPyEFt8kAzX30ydR0TtAKYYtK7o2TPoZ/aH8lhM=;
        b=OW+1eDJJN/Oo0UIXt+mSylHqGBJpoguqDNlrBjwSzULpwbcJmQzXXIKnRnPBNHWJYF
         YVRBEQzoBmGtRdRszd4mRnEvz/yquhQbziClLzOPCn6YXWii9lmDZAQ/o/8KeH82tv8Z
         uz8UtlfYs4XhkHAWwgkT9uRH7BWqGThaCdW6BsPxldSjdgHw1tRkTJUHW20N6gcCIdFv
         tqubFWeM8//ThZ5n2epcJ5R2W03khQdxF+QZCbPTzoC+LSeXw5G0RtYVw6+EW19sfyNV
         iKj6NPdZ+mRF5y4pcXMK7x1LGhOvKIb+WmFW+j2Dhfc9xv87zPw0GkFHXMu+PNp05eHn
         GUmg==
X-Forwarded-Encrypted: i=1; AJvYcCXp5bly45ag9PxHDSwXszqAtpGAQXHawd2aUnK45xA9T68goVSozPTza1lvmf8ahPGb3nDoaWTlI/3oaRJRHxgVhf8jtv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7IEdQ0O+uq64yu6g9tVv4azRZKZD0OdFcpcmuh1l3uTQEFHv
	EHNAefL+BLWwU9coHmJDtzv8Ok39e27Mr8CrVR7KhXiY1pLUVuD/i4HqAgsrBZG5t4L4XjZDcW1
	ddUhsLhBQjv77DJkvvTnFz7EVGjrMIU6TEKDIMc/bl/WSg88=
X-Google-Smtp-Source: AGHT+IHsjoNiUXK8FiI8rxIVKKnYGdEQlV97/yqrXcDBKtN5zyf6URnWHAcg5LXsgLAvyYNircrJYmKEgy7LOQ3e7uA=
X-Received: by 2002:a05:6902:1688:b0:e25:c0b4:f363 with SMTP id
 3f1490d57ef6-e28936bf5dcmr4937740276.6.1728145302343; Sat, 05 Oct 2024
 09:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <20241002103830.GA22253@wind.enjellic.com> <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
 <20241004184019.GA16388@wind.enjellic.com> <CAHC9VhS0aeDB2GzxJPHN8_LDk59gT_RuRKwb26K+3SzX7SQ=3g@mail.gmail.com>
 <20241005023357.GA20577@wind.enjellic.com>
In-Reply-To: <20241005023357.GA20577@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 5 Oct 2024 12:21:31 -0400
Message-ID: <CAHC9VhSoPK7zMQjUNiHG23Je-iSmxOSdRFvp1ikqCeCxkS9zWw@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 10:34=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote:
> On Fri, Oct 04, 2024 at 02:58:57PM -0400, Paul Moore wrote:
> > On Fri, Oct 4, 2024 at 2:40???PM Dr. Greg <greg@enjellic.com> wrote:
> > > On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:
> > > > On 10/2/24 03:38, Dr. Greg wrote:
> > > > >On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> > > > >>On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wro=
te:
> >
> > ...
> >
> > > The third problem to be addressed, and you acknowledge it above, is
> > > that there needs to be a flexible pathway for security innovation on
> > > Linux that doesn't require broad based consensus and yet doesn't
> > > imperil the kernel.
>
> > The new LSM guidelines are documented at the URL below (and
> > available in the README.md file of any cloned LSM tree), the
> > document is also linked from the MAINTAINERS file:
> >
> > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-l=
sm-guidelines
> >
> > The guidelines were developed last summer on the LSM mailing list
> > with input and edits from a number of LSM developers.
> >
> > https://lore.kernel.org/linux-security-module/CAHC9VhRsxARUsFcJC-5zp9pX=
8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com
>
> We are intimately familiar with those documents.
>
> Our reference was to the need for a technical solution, not political
> medicaments.

Seeing that document as a purely political solution to the challenge
of gaining acceptance for a new LSM is a telling perspective, and not
an accurate one as far as I'm concerned.  The document spells out a
number of things that new LSMs should strive to satisfy if they want
to be included in the upstream Linux kernel; it's intended as guidance
both for the development of new LSMs as well as their review.

If those guidelines are too restrictive or otherwise stifling, you are
always welcome to suggest changes on the LSM list; that is how the doc
was established and that is how we'll keep it current and resonable.

However, if you find yourself objecting to the guidelines simply
because they are trying your patience, or you find that the technical
reviews driven by those guidelines are incorrect, but are unable to
properly respond in a way that satisfies the reviewer, then the
upstream Linux kernel may not be the best place for your LSM.

--=20
paul-moore.com
