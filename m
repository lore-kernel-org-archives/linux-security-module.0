Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03F326952
	for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513577; cv=pass; b=b8v0054jfCKKuw7+6xSmFQHUPNbCIAFpaxMFJwpQT0Aqa6YIpLcIDespc57jRqzu/NPKfXab1Vv/1GwbUKosm1Df0Qt2XlyLar32x4IHDNkHCJ4eepA5lTM9U0M1IWk2sC0tvj2wXD4Qifha/51U1FvpmP730bZFSCSAwq19kRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513577; c=relaxed/simple;
	bh=wCltqn8/Hl8G0vgjRc710cwschMrkh2GOvzpWxuuG24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djH6fnefRnsr3zuawN5fMC+ezU7bFTQHzzsnu+cojSQ+BS7LO2vcCqvwmMBI/G1rDu4RKOKM+5069uTrnItIA8SnjCPwjPMz7Bbx2dAyw5xA5AJtq8GMCHRos7ezAx5y2G1bMTsT5gdUucjacpELHJEnpor5q4LTlggjzAjX3nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xu9dwnvE; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xu9dwnvE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so655191a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 13:46:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768513574; cv=none;
        d=google.com; s=arc-20240605;
        b=YG+mhqfsls4PSnHr2Aku2GLPnkstHulogpz6fsIpFLvD23LACDH9BKKnT71yvmWIgk
         8w5tVicSQP/Jq9iISLNKKDKiieW5mR4Nuao4m61IMF8q6ni+EHsdtrtUCx42ZRBLr1lS
         7DkV1qi4pkmqSfgv09m7qR2pq6WeYrRmj/UrZ8G15g5HglmwaAfqJIloTbtiCWIX32Yi
         cpuNv96lb27oKwY4RDCRHDDMDvyTPwKZ6bwn9KmnpRz0bXAthQltn/fDyDW1WCs8OfLT
         lklpuSpTM35xIgeDrC0LQYyHCUP6Rie32oL84aDfZ3Y/MURzlxNrUQKMtddKLsgdzCLf
         pArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jpqW6jUC08Agms46wNEL22NM+f7LJMOeXvVcL3y7MTU=;
        fh=3NGHV4JNp3D5eTAW79CtmjsL8J1Rlkn3Lq8rzO3jtFo=;
        b=VfBT8bWEE4gynZMOKzsQdTpng6xKdR58F/gjEOQJK68YIBObqEWH5L0CatxpCiOlhl
         n27PRu9T4N6DTsV1q2dENNiHVd5eOdMiDFrhqGs7gY9M2cSkRRRWJqrRdaPleFxUQ20/
         AyK72+CMgDl/XGLgK3WIYnty2o3iAihf9kMoaotmzslXvMNQoLQoFnRBPCS+C9u6O/Eu
         NmmDbiBZzu+F7gtWFxPEbGtiOUaI28UKFhXLHQqPcqt6lxVnqIwcepM1Ntlsnaki88Jy
         yHoEKB4keNw3+1aC/BG+gWfF+gFbWM6X5HEZeCokdKav0BaeTghH1n/hkNtV+qZVruZH
         N8qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768513574; x=1769118374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpqW6jUC08Agms46wNEL22NM+f7LJMOeXvVcL3y7MTU=;
        b=Xu9dwnvEArMkb5bE+rpzG8QjcmUEzo53cgb8pekpYWZJY5SZHZ8tTCY+wPohgfo7tp
         PQz0BVixmrmuDpSs6Yt8fQVuXKJeZgVyPRv8kkdtqeTsn4U8OVQCNS23cjqHCVbKrMFU
         PUlE8hIn4qWyIBrAm6pSwnTVW8odL4BeENxB0mptBVFfsfYlzuF4s+b+TUo1wPjhKnXA
         nydwEHq/1dVpD4NmdfkwI9GsJfxg3GZNJE9XqPPLA+pMpUklCJEBF426CLPBFE/lFheo
         L2YE/twEQFlmZESpbGEQMJ8qd/19rsyi3l8bja961RqnwKIa9xpXSIc9uuCxSjIB/lEx
         MBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513574; x=1769118374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jpqW6jUC08Agms46wNEL22NM+f7LJMOeXvVcL3y7MTU=;
        b=kVVHnZ1DUt03n3u7tZvyTJ34EY+M6z0ePfbLax2YKpxBpjSMO9M4p09ejALpSpUP4g
         VnpQGwytOfCkHGoULucfu16oEBRYV/24BCCRxVjp7AM+oNLQ9CYp7oPoMP1HjgRkT4u6
         5hjh+lYuVOkkPrOgkOt92uhxaBhXcp99/1GpYv3sJ8rRRwB2dsS3ZvZVUnS8xKjNdyyC
         g+Zt4HzATe47yg5HVZqfEptA1oN4o6FlPFyB6UUTSYqHlQdPeH4E8AuF09M3DSd4GHGR
         kAQoBTQrIinJLT8HAp49BHrXP6ZB0+OePug4VBQ/+MZMnIUqFI1w32oFyutnL3/JfSyb
         chdA==
X-Forwarded-Encrypted: i=1; AJvYcCWbywmVK06fDmC/sqbXjJO1dNFjyVRIcyBm//Anx83ifiuiulkIv371QBYIX9zrIi7P2ORBA4bfnYPCVsN767S4LveiN1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Q9EJlX6j3w/WL0aW5oZ+NgipJMBYoRoWtmUR1MkH7vQCx8uA
	myDfHYiYb94OMYbInb+VTSAF6QTMFR7jWkPLbkCCqpiaFQhcaYVLnBaeJO1hjjOlSiqMwgLs97N
	eI4zRsbYZx/bNBXaeMyqGg4g/Cl92QXbBQT6zXdCz
X-Gm-Gg: AY/fxX4zCTIuBUgI2QKc/HBnpeEtHf6tkCYHIVee2+Z24QlwUbGCkd5q6JPofrgfvk5
	LagiVt/7N62d2JFzXOHVVl+HLTLTfcI9DCCZrBPHPdbV99LkjxWBGfUie+9li/v8FKJbS1HtSsy
	cjPWdQyfkb3Ym6tinPaw1n2YMA4A+rQPgiUOAKu7vMy7Yd+g/54wCA1/OQjL6qfOkwNLupy82/7
	MFFlp07wCVlpSh0id8v8yzduURog0Ae7OB4gEkf2AtUwVwbU/lsh7OoXYbQNYBH59hS+sA=
X-Received: by 2002:a17:90b:2e8b:b0:34a:a1dd:1f2a with SMTP id
 98e67ed59e1d1-35272f6cea7mr694689a91.20.1768513574119; Thu, 15 Jan 2026
 13:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110143300.71048-2-gnoack3000@gmail.com> <20260110143300.71048-4-gnoack3000@gmail.com>
 <20260113-kerngesund-etage-86de4a21da24@brauner> <CAHC9VhQOQ096WEZPLo4-57cYkM8c38qzE-F8L3f_cSSB4WadGg@mail.gmail.com>
 <20260115.b5977d57d52d@gnoack.org>
In-Reply-To: <20260115.b5977d57d52d@gnoack.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Jan 2026 16:46:00 -0500
X-Gm-Features: AZwV_QjPNfkUPuGxlKsWJ924hm4lRMsf1wN-yV85wF6ZyiOd4KttUE4QM1-_fwk
Message-ID: <CAHC9VhQHZCe0LMx4xzSo-h1SWY489U4frKYnxu4YVrcJN3x7nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Justin Suess <utilityemal77@gmail.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 5:10=E2=80=AFAM G=C3=BCnther Noack <gnoack3000@gmai=
l.com> wrote:
> On Tue, Jan 13, 2026 at 06:27:15PM -0500, Paul Moore wrote:
> > On Tue, Jan 13, 2026 at 4:34=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Sat, Jan 10, 2026 at 03:32:57PM +0100, G=C3=BCnther Noack wrote:
> > > > From: Justin Suess <utilityemal77@gmail.com>
> > > >
> > > > Adds an LSM hook unix_path_connect.
> > > >
> > > > This hook is called to check the path of a named unix socket before=
 a
> > > > connection is initiated.
> > > >
> > > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |  4 ++++
> > > >  include/linux/security.h      | 11 +++++++++++
> > > >  net/unix/af_unix.c            |  9 +++++++++
> > > >  security/security.c           | 20 ++++++++++++++++++++
> > > >  4 files changed, 44 insertions(+)

...

> On the other side, I see the following drawbacks:
>
> * The more serious surgery in af_unix, which Paul also discussed:

Not to take away from what G=C3=BCnther already mentioned, but my concern
about extending the path beyond the unix_find_bsd() function for the
sake of the LSM is that history has shown that the easiest (this is
very much a relative statement) approach towards acceptance of a new
LSM hook is to keep the addition/patch as small as possible while
still being useful.  Making the addition of a new LSM hook dependent
on significant changes outside of the security/ directory often
results in failure.

> Overall, I am not convinced that using pre-existing hooks is the right
> way and I would prefer the approach where we have a more dedicated LSM
> hook for the path lookup.
>
> Does that seem reasonable?  Let me know what you think.

I believe it's definitely the "path" (sorry) of least resistance.

--=20
paul-moore.com
