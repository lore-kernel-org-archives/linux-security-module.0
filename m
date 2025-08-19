Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F72EB851
	for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629474; cv=none; b=F6aHbxgzbKnxyegcNl0xHAg7S6cJDZQ2IzDNJcQHPv+mHvW49eRS6lNfvWeIin+5RtWKX/+BNWg8LoldRMuYrJasJfVauaBM/O3HB2di11Yn8HLRgwvxIZbzWN0OO7/0YsqiINcXk07ejbPr5SwOkW96sKEAt0VwLare+947+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629474; c=relaxed/simple;
	bh=r1k9nnCNAdKmeh6GTLl1wxuKCYS4pFVsoHZPAB6Exsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNBrBTGt4B1mxcK7ozheKqvKTkixNCntlONICJLESv6mXr0khLouXSfQLhxBzZqetmxtPzcORd3sEZJY82M1Ygn/A89Xfb5ou4xkkpYGvdUaw/kr4MLqHZslvKMHyc/FSqpY+59aD6ThuHq5s62cECIjMrG+3NZi+JqFnwT4nNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P88q/T24; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P88q/T24"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-323266b2368so3729308a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755629472; x=1756234272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YVYGjOB6s9N63HNI5ovYcbPzuwn+q5vb6MM0sVwzNs=;
        b=P88q/T24BqKcvO/81K52M1yPLenAKqA1RH3O2068mdeRZCgy8rR+mbsliDGTbKbVWV
         NU+1bYcjN8X9DjsRDqzvLuPsARsYbflPU5XG3G8UiW8gy9PeHKCWPK4kDswhuiY8lrIA
         kGuCpDi/BSzC+/Rs27/pqPkY2W74h2R5/TZUHI6uxSH46aJ1Tl2zS9sAQyAcLIUY4wct
         7YJoC0xERxSCX8O6dDXhRnIfRz8Fum989rpZmQi2Mp2AEWnlkl1MAFMYpDg3CDSxF457
         hZGSIDuwHGKDCCHfWSNZ1hmp3FK/SVMTVGRZRIjL3jWo26t1IGdtcXDgwM8heQzsGywB
         MKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629472; x=1756234272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YVYGjOB6s9N63HNI5ovYcbPzuwn+q5vb6MM0sVwzNs=;
        b=bJkAX4F6+055OdJTKnNL9f61JW2WUK+LmVjdSfUSTzrCpruHIydErPo9KdXKC8wHKj
         Yc+miq/8PBomSYlu1rwlAOcfFom2/OiFfVCiqpYq9jBE30rXozPdWprIrTGM/snXg151
         R6CbmyUeEcaxm2C+QYAMz3cTHLk+BK9PkgVtQjJ60WnUhhhgwY/FM3QH8Cho9h89m7gm
         En2XKXV+Gd7EkK5zslOnhhzdWmWdsEYrmpWkC7hN0CFeUCyBHVlmTM9ZLi20duaP6bse
         usxIsCkw/cYH6A3vJ8RJO9VoZYtim7ytacVpOhkoE3v+UN4PM0kOsYng8UCBbGcbs5Cj
         pZYw==
X-Gm-Message-State: AOJu0YzXSMpPrbC8F+0eT+TbKc9WXRIJ3fuUrhx9jt6hLHwOj59IM9b4
	1SRlA+SsocM+3X9kYHIQaa2UrsIOhSuL/2vUlo1YWNfA5U0Jkb3A3HxzFe6Mz7BYLamnaHMBzV8
	WzbySOheviYJ3OmcDvob5FDE9/BoHIHNqhXGllpMM
X-Gm-Gg: ASbGncs816v85sNTpfwOhkk0i99dVSGEc8icdo/iOTeWrrvGr+XzSkO7bs//t1OX3Re
	pfpWdx5UnsIIDQ3SStRyv4nlRpZ/24ec+bFHiSfv6yYhCxX7j2theTooW/dxDvIw2e2MkxvZTl7
	OTVwsbNw69I6RHe79vK4DSB0OfLEYIsCdh1fvU1uSxN6TffopZ7s/iHWnVPkWVF6sUK5U3BviN9
	L0gMwQ=
X-Google-Smtp-Source: AGHT+IFY7UtpC5fuNWLZMOhqrMliLhtKfzIXXOEZkU111XWgE3UzoMhlgcKvZdXaJuBdcRjpTV0bhvlqenEx/LkJ4y0=
X-Received: by 2002:a17:90b:584b:b0:31f:12d:ee4f with SMTP id
 98e67ed59e1d1-324e1423ef4mr305616a91.23.1755629472117; Tue, 19 Aug 2025
 11:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 14:51:00 -0400
X-Gm-Features: Ac12FXxeXbd4coDV7cLQr6EYlH6Fye0jDGN6ekKW7rnEog0z23VtdEs2Q4BujjA
Message-ID: <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:47=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> I think we want to be able to unshare a specific security module
> namespace without unsharing the others, i.e. just SELinux or just
> AppArmor.
> Not sure if your suggestion above supports that already but wanted to not=
e it.

The lsm_set_self_attr(2) approach allows for LSM specific unshare
operations.  Take the existing LSM_ATTR_EXEC attribute as an example,
two LSMs have implemented support (AppArmor and SELinux), and
userspace can independently set the attribute as desired for each LSM.

> Serge pointed out that we also will need an API to attach to an
> existing SELinux namespace, which I captured here:
> https://github.com/stephensmalley/selinuxns/issues/19
> This is handled for other Linux namespaces by opening a pseudo file
> under /proc/pid/ns and invoking setns(2), so not sure how we want to
> do it.

One option would be to have a the LSM framework return a LSM namespace
"handle" for a given LSM using lsm_get_self_attr(2) and then do a
setns(2)-esque operation using lsm_set_self_attr(2) with that
"handle".  We would need to figure out what would constitute a
"handle" but let's just mark that as TBD for now with this approach (I
think better options are available).

Since we have an existing LSM namespace combination, with processes
running inside of it, it might be sufficient to simply support moving
into an existing LSM namespace set with setns(2) using only a pidfd
and a new CLONE_LSMNS flag (or similar, upstream might want this as
CLONE_NEWLSM).  This would simply set the LSM namespace set for the
setns(2) caller to match that of the target pidfd.  We still wouldn't
want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().

Any other ideas?

--=20
paul-moore.com
