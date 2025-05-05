Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8AA5680
	for <linux-security-module@vger.kernel.org>; Mon,  5 May 2025 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478737; cv=none; b=EJbfdLl52ziDKu2XcWc3qSzmcS8MFkHzUq6GxNa9e4eq69e1YNoXnYyiMPcOJhDUAgN8n/KH72XECswVlgbUbv82xpVnNLPeXXkG9M41hxRUhijC1DIKLA3hwIUAxWJS/J2zMJS9IOl6vrB1dhTfD3idWl7gX3EUkke0mDN3OQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478737; c=relaxed/simple;
	bh=M9AptAdHAeMqjMvMAiFvV1CmZyqfOVsCn543KGhPel8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnkpNGc9II1s+TB8PB5rjbLNKZ9M1K1dgsDXF1M+/CCYK7v8FU+4Im+Gq4HM1V7cfOG5dm+jvhzSetnxPv8nI6gGzTJSV3dzO1cOrCY6aGbdSLhVWRP8aVzpNqEgT87eNjVygkC6T5P3ou/qmPi+8/fKm56jc7GnQjBvqeZWKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Lx62KAqq; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Lx62KAqq"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7080dd5fe92so40968237b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 May 2025 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746478735; x=1747083535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i3tnOydfyAZEylu7fam7l96lA84coFWdm6VQOnR01g=;
        b=Lx62KAqq/cClsx7zshWIzQKBERJ72kY1nyad2WypjnAK/Fcl0t+Cudk/VDHjZ9m/aO
         rDpsYBMnyccjKsNTALaBilmYVI3WZhdY08PJ84kocfvnpjaSec/dKsDrD5M3WKflAf06
         RoiEOirDb52jrO1voIpfhV8JfzhDrzFhX2ru5JS6rW23+TbmYOQzL3b1EzgsxhcpMJbl
         WA2rkhFqzhXIQf5TZf8h/eHf5V/VNs9FBlzSIbZLsILzpu/+mEs//B++tjD6dg5rUVUe
         CHigK9nZAqhonFRT8EzuLz0RPHCs+dvymqk2iBq9KfcsyBBYVlVTaQK+59MODyuJFZF4
         ++dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746478735; x=1747083535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i3tnOydfyAZEylu7fam7l96lA84coFWdm6VQOnR01g=;
        b=i6ij2bIK55un6Cqa8wJm2gYMRWoL9D10HmDzFjdfHRKEThh5g5BFLhc+wjInj6rnkJ
         37puGiXm96QK+03RJ19MOpTsF2PLMZL2iWgyrVPYG/hG3qZRARH90K9Yqjw+D/aA2x/4
         /caWn67Li0Tl8tGcze7usT+gddJDTOJJcVH3jPdO5qXQgjP6NiROhcimx/ZChZP4ZS49
         ZZbBuG0ZJQH0M4KuK0ogkEO8LNQYTSs9n7o3DNJp4drH+aAwnFBYLQAafyo+hI3sGUfq
         V5+5+qt3oUWOAwnqw005StYNQsfCOO7KPYBZNvbg79G8S15JEzroGbsAN+gy0EYOX3mh
         g7fg==
X-Forwarded-Encrypted: i=1; AJvYcCXCHAlPEvjUiXMuhMkLvnkI2bCOVO4YU9GvtIBZ+XsDLMWr4/ZuLvCBQkpTennmabvj83fkCs3HzEU6L/4gZRYOW9U7PTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyavs2tkvotX/pfbUMdoMs68HA4t58VebUnN3tLCODMO2p2eku3
	vVRVmrR1T4I68Fgc3NIa72iwNLI+/QqS2AtMEOF1azuKRKDX6OowPkoUJc6rYtEZjtMIfVsFBHU
	f4UXOpkBdQ7hS6n/z5QHmjXtkm4rBZuqp2aBQ
X-Gm-Gg: ASbGnctWzYiE0PpAyeUMxSFLSe0D6YlgpazSTdfLthwyaoo0xjJ8JfIRY1nuaMxV3LT
	tw4SGy9RhXY+qrIUNV/HdfLaMjKNa092rsNRDPYGGkh5Ub9Dh5ThY+Uyo3oyKxz6QgBVOulxKi2
	39RMY1+ZxqYTEy2I5HWRlHYA==
X-Google-Smtp-Source: AGHT+IH5QFwkEBdaCejbeVdKUcvp+pWvZW9QjvyAmPS12WP6DSDKIMwt3LxBLGu+ryHCFyQxsgfyyZlCehaBTFMjWPU=
X-Received: by 2002:a05:690c:4d49:b0:703:c3be:24ad with SMTP id
 00721157ae682-708eaed3298mr114599647b3.14.1746478734947; Mon, 05 May 2025
 13:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTiABmrJNkTYSfTQkjAS5u-GJdYxd+zJ8PcryScBtsXNA@mail.gmail.com>
 <295201ef-5299-4bf0-b0ee-6e1e2a74174b@I-love.SAKURA.ne.jp> <cfcbf519-2d82-44bb-9d3f-b9e743f1911e@schaufler-ca.com>
In-Reply-To: <cfcbf519-2d82-44bb-9d3f-b9e743f1911e@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 May 2025 16:58:43 -0400
X-Gm-Features: ATxdqUHTbKSFltO6kvSd-okDssrV-VYb_yl7vKynbaxXZ70MnePVJ2NjzZsrGSg
Message-ID: <CAHC9VhQNfjdhCpM60SbatdHb757s5Yi7ezjHNN4ddCgUrziEwg@mail.gmail.com>
Subject: Re: [RFC] LSM deprecation / removal policies
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 3, 2025 at 1:09=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 5/3/2025 4:07 AM, Tetsuo Handa wrote:
> > On 2025/05/03 5:01, Paul Moore wrote:
> >> ## Removing LSM Hooks
> >>
> >> If a LSM hook is no longer used by any in-kernel LSMs, there is no ong=
oing work
> >> in progress involving the hook, and no expectation of future work that=
 will use
> >> the hook, the LSM community may consider removal of the LSM hook.  The=
 decision
> >> to ultimately remove the LSM hook should balance ongoing maintenance a=
nd
> >> performance concerns with the social challenges of reintroducing the h=
ook if
> >> it is needed at a later date.
> >
> > What about BPF-based LSM users? Since BPF-based LSMs cannot be in-kerne=
l LSMs,
> > it will be difficult for users of BPF-based LSMs to respond (that someo=
ne wants
> > some to-be-removed LSM hook) when removal of an LSM hook is proposed.
>
> That's dangerously close to suggesting that the LSM hook list is an exter=
nal API.
> It would be really inconvenient if hooks could never change or go away.

Unfortunately, this is one of the challenges that out-of-tree LSMs are
going to face.  As Casey already mentioned, LSM hooks are not part of
the kernel's userspace API and thus not part of the "don't break
userspace" edict.

> >> ## Removing LSMs
> >>
> >> If a LSM has not been actively maintained for a period of time such th=
at it is
> >> becoming a maintenance burden for other developers, or there are serio=
us
> >> concerns about the LSM's ability to deliver on its stated purpose, the=
 LSM
> >> community may consider deprecating and ultimately removing the LSM fro=
m the
> >> Linux kernel.  However, before considering deprecation, the LSM commun=
ity
> >> should make every reasonable effort to find a suitable maintainer for =
the LSM
> >> while also surveying the major Linux distributions to better understan=
d the
> >> impact a deprecation would have on the downstream distro/user experien=
ce.  If
> >> deprecation remains the only viable option, the following process shou=
ld be
> >> used as a starting point for deprecating the LSM:
> >> ...
> >
> > What about users using the major Linux distributions whose kernel's maj=
or version
> > won't change frequently (e.g. some enterprise distro has 10 years of li=
fetime, and
> > would require 3 or 4 years when updating such distro's major version) ?=
 Such users
> > likely fail to know that deprecation process is in progress, and likely=
 suddenly
> > be notified of removal of LSMs one day. I agree that the upstream kerne=
l may need
> > to remove no longer maintained LSMs, but it will be hard to make an ass=
umption that
> > any reasonable user has already seen the deprecation messages.
>
> As you've pointed out many times in the past, users of major distribution=
s are
> unlikely to mess with the LSM configuration.

For a variety of reasons such as extended support lifetimes and
out-of-tree customizations, it is impossible for upstream to support
all Enterprise Linux users, this is why a large part of the Enterprise
Linux distro story is support; Enterprise Linux users get their
support from the company that provides the distro, not upstream.

With all that said, you will note that the guidance documented above
explains that the upstream LSM community "... should make every
reasonable effort to find a suitable maintainer for the LSM while also
surveying the major Linux distributions to better understand the
impact a deprecation would have on the downstream distro/user
experience.".

> If Redhat came to their senses and
> replaced SELinux with a combination of Smack and TOMOYO very few would be=
 the
> wiser. :)

I'm sure they would enjoy seeing such a feature request bubble up
through their Bugzilla ;)

--=20
paul-moore.com
