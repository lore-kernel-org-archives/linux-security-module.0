Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567A5186E29
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288054; cv=none; b=gxdotZaSVoaMhOKNPQJ56YzbNONCsLAUayOmpywfGeD1CwPoGFZ0Z+iRZIzdRvxjqwUkZWwVQpn+uwG6pElg07mjGlGrkxPKQF2GNIVaFvZ3D+KNBCQ5VWqawL0j0fijiO3BuH4Vvr8hPvEGRYouSJ+rHOVawoixsc3ch3iDi4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288054; c=relaxed/simple;
	bh=ip6QqsuG0pHnfbAyfa6dsIrN1gFjiBwuIjZD76kRJOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hp8lKFlSpXaPMHKC17UNBVynJhmiZegAC5aGVeZAWQfKEQeJsNcnbFYMHlH3jd0p8B660/ljqXtIprIAvAucg9OFs9agHJwtz4AqieYwut0LVCHSy/APky3F042zelQ3wEUMT1VKwHrA6gwNr1oNR6Scd122HGzsyrAJZRoWQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=K/bxPj7O; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K/bxPj7O"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-664ccd158b0so24924727b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722288052; x=1722892852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP3trbxQRYaJJkhRF9dynqI4/kbI0CSReupaRV9vwpA=;
        b=K/bxPj7OAXzVdeklK4WuSAU6JssREw5/8doIVLHXknjCoyPZDbAqMQH5hNP+QW+oAF
         hDxZIcA1WfLvSD2jH/XotjaEmPtCRVnZMF7agB2pgLS+rW0shKTftx8Di6p6/Mo0BzdT
         L3U8C1IQNNY1wkGEfzCCCLbH8+31pMVBGkpLEgKRe88xcNLtO4TsY+oNdCMNx57NpwZz
         3xK6BS48aqO/bxp2vMbrLn+7UsJGXbvDtFhCoTNTiHe07VhwCT/zE5JqJV3tgsJ0CEmL
         okI3ZJZkH1RiLt6HtriNADPfRpIc1E4N76YppILEA+EJv2G+3raR+S9+jn1xLrT41kta
         xOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722288052; x=1722892852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP3trbxQRYaJJkhRF9dynqI4/kbI0CSReupaRV9vwpA=;
        b=BtOkq8mpnnGJfDWAZWKTAxfwn2qOD9IupVHvb0OXoZkQL+WgzzrFsHHyRtUsE8YaCA
         zgEuQ7N1JWS7xYrnrx8YrtmDAH2nm3adMN+rS8Ix2l50vehTbL+6uxTvQ3yk0JCKng47
         2WNzpZ544snDdOhGlNmqCNDz5VhjCKss3O41YbRCCuzH4Yh4jzhCZYAeqHverMZHL1fX
         1gCbbl6XuXPoza8H559Ajp00i818hL2T5v+gtVwXShbalfIh+UYbGZw82AjM1EKpIPuw
         xqbeiqrczP8GbLDo5OAif3AMr8hKyx8eFn5JtjlVML/Enpz/tnaRk9EDnq3rK/LmJZoa
         8SIg==
X-Gm-Message-State: AOJu0YxnzSy2ArkjeMy+6o/s5EDQwUr5552EnVnp3qAkYTThZnQROHPW
	D3fcKefpWopNIWw5kuh2LUa8RvYY7XElUzzVIobKlU3Wv29STwKrgz9Uw2DaUbJVHWGxZR5+/D3
	4r+ZMaFwaISnO3zjLn9502jywE5a62wcERxuU
X-Google-Smtp-Source: AGHT+IFKQJ1MCs2DetgvPbGqfmqfqsgy4n5L26D8Q/bBuBlgu8I4vixR7XcTRgdrIboO0lDF5c6WCDYBk5RiijOa6E8=
X-Received: by 2002:a05:6902:a83:b0:e03:ae8d:6a41 with SMTP id
 3f1490d57ef6-e0b544ade69mr10325565276.25.1722288052374; Mon, 29 Jul 2024
 14:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710213230.11978-1-casey.ref@schaufler-ca.com>
 <20240710213230.11978-1-casey@schaufler-ca.com> <CAHC9VhTLnxKUdJCYUejMiEsn5cBmMMS4aiHt_Gq8qKvpqx=YLg@mail.gmail.com>
In-Reply-To: <CAHC9VhTLnxKUdJCYUejMiEsn5cBmMMS4aiHt_Gq8qKvpqx=YLg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 17:20:41 -0400
Message-ID: <CAHC9VhRX=-qTmGRLG2LTvgW1gq51Z3kzUSc3LUcyQ4eYWkL4-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] LSM: Infrastructure blob allocation
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Jul 10, 2024 at 5:32=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > When more than one Linux Security Module (LSM) can use the security
> > blob for a partincular object the management of the memory associated
> > with that blob needs to be done by the infrastructure rather than the
> > individual modules.  Until now, this has been done on an as needed basi=
s,
> > with the blob management remaining in the modules until such time as a
> > new configuration of modules requires sharing the blob.  This piecemeal
> > approach makes adding new modules that use blobs more difficult, as
> > moving the blob management to the infrastructure isn't as simple as
> > it might seem. This patch set moves management of the security blobs
> > that is done in the modules into the infrastructure. Making security
> > blob management more consistant improves mantainablity and makes the
> > possibilty of general improvement of LSM blob managment easier.
> >
> > No effort has been put into pursuing the possible performance
> > optimizations these changes introduce. For example, sk_security blobs
> > might be moved to use kmem_zone_alloc(). The option of changing the
> > blob sizes to being compile time determined rather than calculated at
> > run time has been considered for future exploration.
> >
> > In the cases where infrastructure blob freeing no longer requires
> > any special action on the part of any security module the hook
> > definition has been removed as it is no long necessary.
> >
> > Security blobs for the xfrm subsystem are problematic as the only
> > security module that implements them (SELinux) has a variable size blob
> > that has a published external API. Management of these blobs by the
> > infrastructure will require significant consideration and negotiation
> > with the maintainers of the existing code.  This has been deferred unti=
l
> > such time as another user of xfrm appears.
> >
> > Casey Schaufler (6):
> >   LSM: Infrastructure management of the sock security
> >   LSM: Infrastructure management of the key security blob
> >   LSM: Add helper for blob allocations
> >   LSM: Infrastructure management of the dev_tun blob
> >   LSM: Infrastructure management of the infiniband blob
> >   LSM: Infrastructure management of the perf_event security blob
> >
> >  include/linux/lsm_hook_defs.h     |   8 +-
> >  include/linux/lsm_hooks.h         |   5 +
> >  security/apparmor/include/net.h   |   3 +-
> >  security/apparmor/lsm.c           |  17 +--
> >  security/apparmor/net.c           |   2 +-
> >  security/security.c               | 184 +++++++++++++++++++++---------
> >  security/selinux/hooks.c          | 157 +++++++++----------------
> >  security/selinux/include/objsec.h |  30 +++++
> >  security/selinux/netlabel.c       |  23 ++--
> >  security/smack/smack.h            |  12 ++
> >  security/smack/smack_lsm.c        | 101 ++++++++--------
> >  security/smack/smack_netfilter.c  |   4 +-
> >  12 files changed, 298 insertions(+), 248 deletions(-)
>
> Thanks Casey, these look good.  I'm going to merge them in
> lsm/dev-staging now with the expectation that they'll be merged after
> the upcoming merge window closes.

These are now in lsm/dev, thanks!

--=20
paul-moore.com
