Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6139FCF
	for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241338; cv=none; b=ZZ+dMSqgB82hyAgZd5cmHUFfa2ldRbPqG8cMhVjia+XnFz23zKw5lh0tVguHQRb+jigbEvvSZ6wbpDHTA/aXmRbZ7t9K8ldiLmo7m9UiwwMVa9EwAB9rcCUoET0Qu0VnIMggfc9gTMIQQArUF//RH/vjXkYpeNmFGXF1ZAPKdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241338; c=relaxed/simple;
	bh=riN9yEBuNtNzONajYBwh6sAZPE4QqYH5QbyiGeLCaDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TruuMmli8qRBS3Kp+Zb1T3ppIzybn+LrM06s7cMqfeeavlRUMFQGFbYILXKPsvZt47BjuqRJwQd41ow+dYlBQUuvPYyN9eKq2eJcpdddSfRbKZjWslAd9ZBmEJJrVhmSE11uwa5Z7P9AVJuwCzCxEIU2W2ZqIuJRZQS2JcUYwk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QCUw7yzR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QCUw7yzR"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6db449f274fso8579067b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726241336; x=1726846136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lk0Y3JO9bFT2rOSc+FQeYL2Qo4I6uDbO35BsUfq+tVI=;
        b=QCUw7yzRDYLnhlzJEuusP8SLX9xw3tT0MjQElEQU4Z/aCgzTIxTZQIHqiwOxutOawl
         qPX7fuuZli/QUpj8d0ccq2k4aRWw9zBJrZw91cXqRh4/sKAIJG7VMS5nLZLB54P4VVup
         btuMqF/iKzEb1pBSBJZ12l56v4twl5y+VFmPb5dmSB6o2FDaHrxeeBV25oKiX6Vwq62F
         dkWOqNDDJ+5PjTGfSqIfyxWTE5iZWxQLBLUiQpPZpRDQKu7d5dWVZQgz+y7Q1QKu2zHo
         tcNpnV0gyWJ9fMLXhObVf2b6o2ygc1j+Gjv1JxcxIFDKFVsX2Sl4lQlHE3nfsOIcHUiW
         zoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241336; x=1726846136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lk0Y3JO9bFT2rOSc+FQeYL2Qo4I6uDbO35BsUfq+tVI=;
        b=wOr0uDXjEDi4ussHFZp2Jgqci7VzCV9bWDYOIGiriBDQG6jbEAN3Gf43/wvtgc5Zfj
         vJUACeY4EC2CIOmjWx/gNNwJnObQcXMSRx+ygPc0lOl9x/ygG6QzRBV9/nYe/nn+w3Ls
         fBO6Nc7QSNIdrXcS9nt1FI3ChFwuYK3Drqc3NQBaVzeAgBpVDUNmVtH427pX4TljZhLW
         lR8jC1Ergzof8DEo/2aMgtB6O5AS8bEI7VlwuZHWNeBpI24H1bifNDFwuvHimyubszSd
         XVzf6H8lDLPFNtfbpsNRIHahCL19K7wwd5GeVNOoLqigFEyty47ODjT/F1GiDHgVQw2O
         18Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWHGLYuc3pbP5qs79AXQnwjko8PkEDsnx1K24ju3ZYUB2FUViNBuEabGx0DGM4OlIxAvyq4dz3ZdNBsBTX/quY5sA6reYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMawI/XhR7tLfgxylZsPV17h6wua5wPOLlpojOuAtSvXhthZs
	/nNYQroTmvFGvRRqJVp1CGOFMtx3irJEOEc8osnlUUyGT1fB3Upi2o4T0FCnfiECzylmd6niupK
	Q4tPPLoEhUUZJ862z6JCk2RH006sdnFTMF3wq
X-Google-Smtp-Source: AGHT+IHkyAZMhhI3xawaismvgjOH5IUCaVGq4I9wy4w7xrhz84JE2lvx2d6PCjxruhRMh0T6OScjZIHtazMnuY9ZfhM=
X-Received: by 2002:a05:690c:60c2:b0:6ad:bf4f:1bc3 with SMTP id
 00721157ae682-6dbcc5805a9mr31430017b3.32.1726241335733; Fri, 13 Sep 2024
 08:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com> <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp>
In-Reply-To: <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Sep 2024 11:28:44 -0400
Message-ID: <CAHC9VhRz4T+Ad6z1u+b+XJoXi7eORax-5KuAbH=O5BOTQAhA7w@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 8:28=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/09/13 10:29, Paul Moore wrote:
> > Linus,
> >
> > We've got a reasonably large pull request for the LSM framework this
> > time (at least it's large for us), here are the highlights:
> >
> > * Move the LSM framework to static calls
> >
> > Based on some of our exchanges over the summer, it sounds like you
> > are already familiar with the effort to convert the LSM callbacks
> > from function pointers to static calls.  This pull request includes
> > that work and transitions the vast majority of the LSM callbacks into
> > static calls.  Those callbacks which haven't been converted were
> > left as-is due to the general ugliness of the changes required to
> > support the static call conversion; we can revisit those callbacks
> > at a future date.
> >
> > It is worth mentioning that Tetsuo Handa is opposed to the static call
> > patches, some even carry his NACK, as they make it more difficult to
> > dynamically load out-of-tree LSMs, or unsupported LSMs on distro kernel=
s.
> > Many of us have tried to explain that out-of-tree LSMs are not a
> > concern for the upstream LSM framework, or the Linux kernel in general,
> > and that decisions around what LSMs are enabled in distro kernels is
> > a distro issue, not an upstream issue, but unfortunately Tetsuo
> > continues to disregard these arguments.
>
> No, this is not only a distro issue but also an upstream issue!
> Because the upstream cannot afford accepting whatever proposed LSMs
> ( https://lkml.kernel.org/r/8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.S=
AKURA.ne.jp ).

I find it somewhat amusing that you are complaining about the LSM
framework not accepting new LSMs in the same pull request where we are
adding a new LSM (IPE).  As a reminder, we have documented guidelines
regarding the addition of new LSMs:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md

... these guidelines were discussed quite a bit on-list some time ago,
and are essentially the same undocumented guidelines the LSM framework
has been following for quite some time now (I will admit the doc and
testing bullet points are likely new).

[SIDE NOTE: Eventually this doc will move over into the kernel tree,
but I still consider it too much of a work-in-progress/draft to merge
into mainline.  We probably also need to do a bit of tidying up in the
kernel doc area relating to LSMs.]

> That is, out-of-tree LSMs cannot become in-tree and obtain stable LSM ID =
...

We've discussed this many times before, obtaining stable magic numbers
(e.g. syscall numbers, LSM IDs, etc.) isn't possible until the
associated code appears in a tagged released from Linus' tree.  Of
course there are workarounds which we've discussed, and Kees even put
together a toy LSM demonstrating these workarounds.

You've heard my stance on this several times in the past, but I'll
repeat myself one more time for the sake of the wider audience.  My
focus is on the upstream Linux kernel and ensuring that the upstream,
in-tree LSMs have the best framework possible to ensure their proper
operation and ease of development/maintenance.  While I have no
intention to negatively impact out-of-tree LSMs, I will not harm the
upstream code base solely to support out-of-tree LSMs.  Further, if
improvements to the upstream LSM framework are determined to harm
out-of-tree LSMs, that shall be no reason to reject the upstream
improvements.  I believe this policy is not only consistent with that
of previous LSM maintainers, but of the general Linux kernel as well.

--=20
paul-moore.com
