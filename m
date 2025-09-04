Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38B3002C3
	for <linux-security-module@vger.kernel.org>; Thu,  4 Sep 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998154; cv=none; b=nxSPI0FelKSuGUE0L631bjLfaoUYS5pXn2PPJ1XSxgcpqRTosmmjKjv7zykY6inMOBIp/1659KckG6qrryROwAbTvCB99zm1sYkVqSgleRmJXMrNJZd3WYjizk0CDDDoXAYUZfbK5ozEAyjkKGYmDaYh0f19WRPrExqjasc7L4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998154; c=relaxed/simple;
	bh=rQOdX11fY/fHZi+K6bP2GDUn5CrvijThfPeD38NULhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3Kk6fVK6zAvS78JhUtxyJIqYx3/wqulyNFc0MRvqMKmW6+S3pG1FfGwI0XmthALgzvcHyls87QP0GlBzL3vGy2GN7xRtGmmXNPGDOja8qnRT5+DFzZyGjdn2+3vvfJHvzmR7FhaZmR+BgEASOU9FWgtNYckhHhPDB5zVvTEsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aFgTvYM4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aFgTvYM4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b70820360so932660a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 04 Sep 2025 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998152; x=1757602952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxzYkAAG6UMXz1rkSuT85nC3lEMgcvO7jfMiH2T8sZ4=;
        b=aFgTvYM46urrRm5ftnbSp3MRQ9PEZy54WdzIwcXg5Nlt3jwlWh+22oAN/md0qmjnyS
         ui52aM00/N4PDSUgCeXUgC86RfpBAOQZBqeLnLBuMMI3b2nU7F83J8yMG9NM1oyOWbsV
         m223mZEJES0Awb4MNGeNpSAiR6uZLPgFd9dDm6YpD66sW/2ONtPd/DMqBU4GFKQ+PpjO
         lyI1xsNzySudvDIN1nwM9b0JxyWND+H3L9q6XKtU1W8xbxPW0n0DiJwyTH1g7YW0NsVO
         tOITLXiwSgnDJugc4lzJlcwNakhYqzakp6j/1pf6B1GNOk1ZPqE7lhpTAA9Kr7EYD/32
         ZMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998152; x=1757602952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxzYkAAG6UMXz1rkSuT85nC3lEMgcvO7jfMiH2T8sZ4=;
        b=qH/KUrwn+OKy2i6KsZKpxodmSKzOfT9VQqn8vyZ9F+od5TkCKnu53x2dpJ+kvqqJYV
         jinu2lCADnjFqQFCbiHVHRWczHpp1u2o1nb1QJPqPw0IJINUMkWcILxabqbAnSZM5km2
         heW5ZVppKo9aHQco3zEZ42EJNxZALLJAod7el1yM1fZUhO0CgF1kBLObd2T5fy93pBza
         V5H0ctFRcVqH4WpDtX5Mq31miyzucpIWApB9GvgnSrtECHmOMpDRT3z3jb22QCj7sA9U
         mxYICeZHaZrVpbpS/Fs5nztoSs9B3xsHuxgry2Jk/MGncaYS0jBeqNkKW2gugv3msyim
         IBGQ==
X-Gm-Message-State: AOJu0Yw3BHE4JHqGTz2VycDkX4XBEIjoR3pZxaODMxRRwsS7j8vAMBfW
	VC/zQqILCXgEvgIkH0r95oYuVL0Xtwi2i49znc+BOeV3z7Q8Ft/l0ez92NkfXFIbBX/gqzhqA0+
	zJpwOFWXwDz2bvujZgmAPLS2jLALFu/fNgZOBLHmdktC9QdT0mXo=
X-Gm-Gg: ASbGncuMqn4a3pjjAdDeVwYbivRP5+ywC6eHMVk1nnIEerY98u7N2njQUlOQ8gYvxJ8
	IB4fXhjeqgm7TJSNLNT+TKg5/HxmV/U476tIYfpUp75HY7T4xG5OP1r5ewaS2ZfzMIFeFGwzEH5
	K72qd+7COQuM1QT33Q/cNjIDmtq0/ipdnZV4BNsqtTArcn6FihJlannmOzDzLbI00BEMdZgF8tE
	u09pGDDZeGGtK6oRg==
X-Google-Smtp-Source: AGHT+IEAZoSNI5gmsQNLG4iinYBMixnV3r+PQLV6m7zWI3vUPz0UY1/ZKtvhUIgn9uhbzTEGs0/nEBkt1LBYLBY/o3I=
X-Received: by 2002:a17:90b:3f8c:b0:32b:656f:5a66 with SMTP id
 98e67ed59e1d1-32b656f5bebmr7026394a91.27.1756998150183; Thu, 04 Sep 2025
 08:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-63-paul@paul-moore.com>
 <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com> <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
In-Reply-To: <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 11:02:18 -0400
X-Gm-Features: Ac12FXwxDMTMo82EEp1hf0-OQH3hr6NRJdWpeIuq7lmxwN7eWIeeqwp0bLdTBH8
Message-ID: <CAHC9VhTJp91zfyz4C2jU8WFDH50V0mnEVGLcZKGhaVm6XQ_L8Q@mail.gmail.com>
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 5:53=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/09/04 5:32, Paul Moore wrote:
> > On Thu, Aug 14, 2025 at 6:54=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >> Reviewed-by: Kees Cook <kees@kernel.org>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  security/tomoyo/common.h        | 2 ++
> >>  security/tomoyo/securityfs_if.c | 4 +---
> >>  security/tomoyo/tomoyo.c        | 1 +
> >>  3 files changed, 4 insertions(+), 3 deletions(-)
> >
> > Tetsuo, does this look okay to you?
> >
>
> Yes.

Thanks for reviewing, may I add your ACK?

--=20
paul-moore.com
