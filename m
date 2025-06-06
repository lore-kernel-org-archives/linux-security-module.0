Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83712221278
	for <linux-security-module@vger.kernel.org>; Fri,  6 Jun 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240729; cv=none; b=Lzaz/8M7EMBz+LixTAm5jp1ipHcLo0MQC4zPpilv6Ze2a1kLHxomU6wXPMQHhJO6k8oshsUsBnNhbvYL445mDmBuDO3W4hnVYjtNsLwUaz4LG2kM+QG6ir2CX3hJBELny73I5jzu0FlEBpuc5yBbVL8fd6hMz8AOZe7bCDYmmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240729; c=relaxed/simple;
	bh=edmd3k+zgj72dSkbPpfVzGZVgd9IrfwMOgr3J9lsdsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLApbwFZdQfXSP00zlqawBLnyhfgB8DtoNdVrjyZ+Tc2YQEEU2rqiDDwEuuOT5JklZ1GbZXBRdoaHrmhPsvNqQfmEZNQeXfVfDJQcsyRZGGbBoRY6Vah1XgyKyLJbj7hpLOTWq5WZE9Ez45zPiWkgBNoo5NoUmgThTCAo8XJOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IqK3RYXQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqK3RYXQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60780d74bbaso1248370a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Jun 2025 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749240726; x=1749845526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bi4huScXEuwcATCpBBfz3oiLkQXMs/V3hVRnyG0yuA=;
        b=IqK3RYXQy6bK+IjtOmtmx2Z9jq4FN6vGjm98kt1gtLK/M6vCcWEesQlnR1YVvP8G9v
         SWS7CqX3PFGNoJjwv3b10OcFspYK8LR1cqL68ZfHKDyHsm/UML1jH8pAtBy750gadC5J
         DFLmM3BnAVM37GN75XF5oQH91tdwaBovV9D7Yu6sjvCli3jjul5rHo1BuL1B9bsPdO42
         ot9erikKfKKyNg9DxsmpUZed0oY9GzlDEtTdiRMbfCvbgLjoghLRWgOW7Q5Eq7dNIDnA
         lQDGCHqEtH46342X2cgk4TifQpXyqMGZ6gcaP7SPCg7ajNWYUQqZv2tgS8bXcJ1+SJNK
         bemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749240726; x=1749845526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Bi4huScXEuwcATCpBBfz3oiLkQXMs/V3hVRnyG0yuA=;
        b=ie2g3up5tqCayGlaJLmu6AP2y+PdKfGhkcpB6NnS8EY/w3CkQgF2NCmbT4CuUfaWWk
         +PDNKWYoTvHjd20xe6RkeCtLgYhWaN9hVR/DZtbx529c42a/6GPFrDoSwxdZMlsNtayN
         W+z75sFQ9dOrYIVi17jn6a+aBzhqyjEBLiydClZ+USopzJPJ2aKhydlzVOtFPHbuiJON
         EzSGhipwvGLX5404dZxsC9IWhvevUOqBHXl1sQC4G0j0/63PAqiaYV5oNstef6VVQWst
         rnTs5DWhiMeRas/onaWO3vGEOfAsxfokoFPm2t/HcLO7p0T0lRvxfqcpl2dnySM//fst
         +Jog==
X-Gm-Message-State: AOJu0YxPCE8UpFeVn6iNWambOirJRwfzrYCEvVcBKTNOQKtn5ck/cXpp
	EIlraUSyTmBNFt0vySCVHf0Pjs7k0dTVgXrk2I3HZcAyii8LYrO5Mc5q1o1oh7FIFl0v1JUJUs8
	NMGXoraF0QSYpz5Oy03enP1dtaNrOeVO8ifh890VlhiCrjWgHu+sp/d+J
X-Gm-Gg: ASbGncu5E00eXnZuoz9cACVtKvNHgWGwFp12rKGX7kNqM9tREjwiZEgtpU5An22WUIs
	ehDl0Olp4GLChLvxt2rK7g425Bfh0WaSPxsA9ZssznSm3J+/CVqViQnPeLnuVmf7HOZ+NFLR2ew
	lrTQcnaNLQKwPBHFQD9cXlI6314mapUJz1zD0aEyYF2o6DX40m98nEoaNTfv26jpHUXHzvkeI=
X-Google-Smtp-Source: AGHT+IGQr8/MzWbjbAPA7lWtOWohCwSPQ2KlMe0xrCCl6hpd8E8/SA62GN3Hn7UD9QrXoH/5D6ZhY6HDgpcFSpZPyMY=
X-Received: by 2002:a05:6402:2356:b0:607:1ebd:da75 with SMTP id
 4fb4d7f45d1cf-60722a7fe2dmr7697737a12.15.1749240725749; Fri, 06 Jun 2025
 13:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
 <b1bf0aaf-0290-41a3-8bbc-a61c6c8b2e74@schaufler-ca.com>
In-Reply-To: <b1bf0aaf-0290-41a3-8bbc-a61c6c8b2e74@schaufler-ca.com>
From: Luigi Semenzato <semenzato@google.com>
Date: Fri, 6 Jun 2025 13:11:53 -0700
X-Gm-Features: AX0GCFt2HhrHxuqo5uAdrKl9E1qCXyiFux43tFJVA9WV4_sSapJxouYj-TNBi0E
Message-ID: <CAA25o9T3AQJ-zNcb3VuhCwbKQGSFtSBbeN_BRYv0L8M-pQKugA@mail.gmail.com>
Subject: Re: adding CAP_RESERVED_# bits
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 11:32=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 6/6/2025 10:57 AM, Luigi Semenzato wrote:
> > Recently I inquired about the decision process for adding a CAP_DRM
> > bit to capability.h (to become DRM master).  It occurred to me that
> > the process for adding ANY bit would be fraught with controversies (to
> > say the least).
> >
> > So I looked into maintaining a patch in our own kernel sources, but
> > that was surprisingly messy due to the build-time dependencies of
> > capability.h and the way we maintain and share sources internally for
> > multiple kernel versions.  This would have been quite simple if there
> > were a few reserved bits, such as CAP_RESERVED_0, ..,
> > CAP_RESERVED_<N-1> with, say, N=3D3.
> >
> > Would this also be controversial?
>
> Imagine that there was a CAP_RESERVED_0, and that Fedora used it
> for DRM master control, Ubuntu used it for unsigned module loading,
> an android used it to control making the battery explode. How could
> you write applications so that their use of CAP_RESERVED_0 could be
> considered safe?

Sorry, I neglected to mention that I am thinking of embedded systems
where the vendor provides both the OS and the executables, with no
provision for installing additional executables.  ChromeOS is like that.

I agree that major general-purpose distributions would not benefit
from this.  So the question is whether it is worth sacrificing those
bits for easier security setups on embedded systems (and being
able to do it at all when eventually all bits are assigned).

> > Thanks!
> >
