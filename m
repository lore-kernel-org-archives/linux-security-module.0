Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE213B5B6
	for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078615; cv=none; b=bNiQEZJBEQzI7D7l5ZzkObc2VbA6qrA3+8OCWbenZJ4jXcSrPnhp95GbJ0P3KPIEsMd+WVe883sFf3WovpKQAsa0S2rCj5CuEFghy7qY/3dYjIHm88tdnczfA8duFTFg9LDMHsRBXacStV/VeiwHypQaadwmsLqp4QmG+CRNGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078615; c=relaxed/simple;
	bh=MZ3iBxt+5dqDGRLllZnI1LCFqMjWc4P+6DjlVLb7tec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAsxrx9/uVnGSoxQ06/ZC3hVwZuAnPTUNSboo5j6vlInCpITQGJiT6EWUgFrBvoHKnm+orYXoOlAlHqPBT8jufn/+KR0lN8BVC8hg9o9LCc1J5aBib1N8cCSSH23XBNHXVIPdsWJoigOsTElXSpgGL0P1nIDgz+6kcH1IT4aXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NXX2KmNJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NXX2KmNJ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6518f8bc182so42799167b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721078611; x=1721683411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEnN5uN5cY/n5JR2WvewER9KhzgBlk/5MGdM2c3D0Yc=;
        b=NXX2KmNJ7XU27sXhjJ8PJIsoTnyK3wa5INopVtIOP0mYPdCFJNFHpaVo+9DFlPi32d
         oXhtBjRw2T8cbzOY6m/jzxLIC3RLGogKIJya0ioPV0o6zWBrZPqpJMRaC01DvwYHAFPr
         r3PUj6NypGQ7NcGsN6A8c64SqEq4TeCPkFNsXXtZ6gruPb/71jY1Ky9KgrnDWqx/3cY4
         0VHWtezWuhm5ewCgmKpCmD4d2AVQ0F1VcMolMYZMlRwYrlU1VRe9tJk6xgJpcGjJaqrw
         1VjiKMD89kcDlKw6tLuxgKjaoHGmF3wMIwteSQ6rJEJNiutW9z1GQgQl6+eVnU9H3TIH
         Q5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721078611; x=1721683411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEnN5uN5cY/n5JR2WvewER9KhzgBlk/5MGdM2c3D0Yc=;
        b=A+8JmQi2yINH+GVt/f+Qx0Y+D0uYF58WB9gTAEiIUumnpH6aTpDkw1ykggHZg7Rqda
         leGCJLSlggECZodoweT2ht2bTMD4xXvEYjXxUVlECXpjFh3tnpkkOb/yLG7L0Ytll8Ym
         +/oMG8MGBaz+W5yzYRAINUdiMZPnIuu/3FeH/7OHAxkDwvMKE9UHq9cyXhxUNiDHxCUZ
         8ArqcIJ/YGdFK8eAQKJgmZoUCnGQ2NNgeDfA1w1Fd/hpSPgPLYWSGLjOCBZ29M5GGkfY
         zbaW3pgRr09P7g44R/p6NIqUVIxIiMPsQrtx9eDQNBhulN2xoH8sQRHNvk0qh1u/WjBx
         DKmQ==
X-Gm-Message-State: AOJu0Yz3ujh2fpUe+4DzJEA/DJYieOK4Dnu31M4Y2h5rWMZiF6u4w/rl
	PUEi3i3VgHulBR0KBEMT4ussJUQ02T2Sr2Cbo6daEDHyGHKN6nhlitOtcq7/2nMNOaC7Eflo8Pe
	hTP50OyQst6K1/XemqGgoJjmr0re4PG09jHlFYOT7Xnzu6CU=
X-Google-Smtp-Source: AGHT+IH+Qq7dAFzyGYGImGr7Ipjqqk01sz7FXkA4fwUSm/bl+/PzFE0JSsAaoOe8H4FstSfodQ/izKPDYhsurwMH0q8=
X-Received: by 2002:a81:9e50:0:b0:65f:96e9:42f4 with SMTP id
 00721157ae682-663890c272cmr1039547b3.15.1721078611496; Mon, 15 Jul 2024
 14:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <20240710.peiDu2aiD1su@digikod.net>
 <CAHC9VhTxz6eFFUBZYJ3kgneRqKMSqaW63cXuQvVs_tt88GU_OA@mail.gmail.com> <20240715.uax4chahCohw@digikod.net>
In-Reply-To: <20240715.uax4chahCohw@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Jul 2024 17:23:20 -0400
Message-ID: <CAHC9VhQtENHOpx+CpeFT6jySqvK-Hc40iFkc0H4RMTwf_g58Vg@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 9:35=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Jul 10, 2024 at 12:20:18PM -0400, Paul Moore wrote:
> > On Wed, Jul 10, 2024 at 6:40=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:

...

> > > However, I'm wondering if we could backport this patch down to v5.15 =
.
> > > I guess not, so I'll need to remove this hook implementation for
> > > Landlock, backport it to v5.15, and then you'll need to re-add this
> > > check with this patch.  At least it has been useful to spot this inod=
e
> > > issue, but it could still be useful to spot potential memory leaks wi=
th
> > > a negligible performance impact.
> >
> > Yes, it's a bit complicated with the IMA/EVM promotion happening
> > fairly recently.  I'm marking the patch with a stable tag, but
> > considering we're at -rc7 and this needs at least one more respin,
> > testing, ACKs, etc. it might not land in Linus' tree until sometime
> > post v6.11-rc1.  Considering that, I might suggest dropping the
> > Landlock hook in -stable and re-adding it to Linus' tree once this fix
> > lands, but that decision is up to you.
>
> I would prefer to backport the new hook.  I can help with that.  In
> fact, I tried to backport the removal of the hook for Landlock, and it
> requires the same amount of work, so it would be better to work
> together.  That should also ease future backports impacting the same
> part of the code.

Okay, let's get the initial v6.11 LSM PR merged (I just sent it to
Linus) and then I'll post the updated patchset and a proper patch for
review.

> BTW, while trying to backport that to linux-5.15.y I noticed that a fix
> is missing in this branch: the default return value for the
> inode_init_security hook, see commit 6bcdfd2cac55 ("security: Allow all
> LSMs to provide xattrs for inode_init_security hook").

Likely a casualty of a merge conflict; I haven't noticed the stable
kernel folks doing any manual merging of LSM patches that fail an
automated merge.  You can always do the merge and send it to them.

--=20
paul-moore.com
