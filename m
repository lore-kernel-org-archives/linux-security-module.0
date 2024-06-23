Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2EE1805E
	for <linux-security-module@vger.kernel.org>; Sun, 23 Jun 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719172688; cv=none; b=E4BBCyx+Sza/C3SaBTbbyv8WRB9HPOEe+zoTK/aDu6+ctYiT/d2rPD98sQWzdxSF14T54/vfcFdghCk4UdDRaIkTqUnzvAw73jpFwnvWfm5/bUIE6X0FSl0zj5iZZA7wdgMtewdE2ncUWj45SyDnmh9ouaByAo06/ztTF7uOnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719172688; c=relaxed/simple;
	bh=zDU2UcQI5rojl2mKeivQSF1G2P6Ava3nXMNTFcgcyfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nc8iFhHVyg2yyLbl4fWKOTg7ercgtPOKQJKQqcSpR/U8jjBVeTWWEpvZ9xofJa3SGREX2eQ96nNWZNzneCituEAyMeorV7iyWePKyY5r8NRuW46e70vx/5/nctGuNVEv2XfuMS8TwjL4YiiFph3KPmabvGnN6CB7J+eYle9oV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RValyZn4; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RValyZn4"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfe81d54db9so3380602276.2
        for <linux-security-module@vger.kernel.org>; Sun, 23 Jun 2024 12:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719172685; x=1719777485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L935TfPsSs5fPfvxhR59Cz899DgU7q+IitpDJf5wbbw=;
        b=RValyZn4iVnbWl9hHRLL4pyUeAvXuj1PO+Kxpb9DetuciuRcvDxQzAIkQYfoYIrpPQ
         8PHbOhB5XwZScxys/IONgDItF6wpC1z8iJbrlFSD4LMIwREdQbGD0//LpJRGaYtJziME
         Re03ghb0Q/1+7yVBMHKVDMhDdcusZnTee4Tgi3zMeRc/qsiuDncsmxOX06qV6oIgpZBY
         iMEuh23yDLpuGOpr5Uo6iqf4tsrNH/5wX1l4tiXEDQxkw3oa1EVHolVkpKsoYjx6Fzdw
         JJmqHd+BFhovxVdB5R5SvSKup8K8nH0mCjyH68TR5EgY6RTLnYXdQ96faBlOP60QtGLc
         PC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719172685; x=1719777485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L935TfPsSs5fPfvxhR59Cz899DgU7q+IitpDJf5wbbw=;
        b=LtVo0P1cJtFI/F71iBdIxD347rTtXd2kkFoORU3KePm0Hw5l9xu3l22PCgzjXJmXjH
         mVSIfG5wIYg0oL6BOU2iesXHA1kzXmBJ+t1LKp3MRxBzWTAqBuh0T3DUmBnG8Sy6JTBt
         ZQ40FBDNhXhXp//Q1dTYAAz66UYuqYNE+WZC3HU7P0mqSJ7ApxUxtONb3LLy8bsAuPXg
         0wOlmQogKKEyk6w98cDRYP4RQDhLg3Ez7D5xKvY8Z4t8tY0nPfVwun2KwbBes5nJ/HmG
         /ya6ySnTLxFkXC9DdfrXBOQBewpuk3p8VB9tfJNnOXkQSJ5mutCL3Dja65WiLadf4Sfh
         reAw==
X-Gm-Message-State: AOJu0YyYPvBFnMzkPAEWS1QfVMDeE0RUH73hOxCqEd7Z38V6u2R6keR2
	oRpA9aZbyZBwtDLWJTF30LDUN5Bd12cXXqypLl9CrvgaUox6Gs9G0mxr1WJdgKpKiMape5SOHRt
	tGMMTDO6RcnDrcZD6aW+6jP48mWGVyH1Yvx1h
X-Google-Smtp-Source: AGHT+IGCoHamBCvZArDMlOqMLOKeuW3LhZTZRSKdsazoc6q3eCJaQq1HPmh7IWp4Sz2/keVwTbtL8KnzfMVsliNNFbA=
X-Received: by 2002:a5b:dc8:0:b0:dff:2ef1:e3d5 with SMTP id
 3f1490d57ef6-e0301101c58mr1994522276.63.1719172684789; Sun, 23 Jun 2024
 12:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-3-casey@schaufler-ca.com> <CAHC9VhQnzrHPRWKvWPSuFLWHhcXkwqeAfXsFbEdBBOMcACZorg@mail.gmail.com>
 <aae5d7de-d3ff-4a67-a8f6-fea293bee0f6@schaufler-ca.com>
In-Reply-To: <aae5d7de-d3ff-4a67-a8f6-fea293bee0f6@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 23 Jun 2024 15:57:54 -0400
Message-ID: <CAHC9VhTK0etXQ3X4g4E-v_d3f50waoatbC2ihJ8vOV2RmwMYPQ@mail.gmail.com>
Subject: Re: [PATCH v39 02/42] SM: Infrastructure management of the sock security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 6:24=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 6/21/2024 1:31 PM, Paul Moore wrote:
> > On Fri, Dec 15, 2023 at 5:18=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> Move management of the sock->sk_security blob out
> >> of the individual security modules and into the security
> >> infrastructure. Instead of allocating the blobs from within
> >> the modules the modules tell the infrastructure how much
> >> space is required, and the space is allocated there.
> >>
> >> Acked-by: Paul Moore <paul@paul-moore.com>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/lsm_hooks.h         |  1 +
> >>  security/apparmor/include/net.h   |  3 +-
> >>  security/apparmor/lsm.c           | 20 +-------
> >>  security/apparmor/net.c           |  2 +-
> >>  security/security.c               | 36 ++++++++++++++-
> >>  security/selinux/hooks.c          | 76 ++++++++++++++----------------=
-
> >>  security/selinux/include/objsec.h |  5 ++
> >>  security/selinux/netlabel.c       | 23 +++++-----
> >>  security/smack/smack.h            |  5 ++
> >>  security/smack/smack_lsm.c        | 70 ++++++++++++++--------------
> >>  security/smack/smack_netfilter.c  |  4 +-
> >>  11 files changed, 131 insertions(+), 114 deletions(-)
> > I had to do some minor merge fixups, but I just merged this into the
> > lsm/dev-staging branch to do some testing, assuming all goes well I'll
> > move this over to the lsm/dev branch; I'll send another note if/when
> > that happens.
> >
> > One of the things that has bothered me about the LSM framework is the
> > inconsistency around allocation and management of the LSM security
> > blobs (the `void *security` fields present in many kernel objects).
> > In some cases the framework itself manages these fields, in other
> > cases it is left up to the individual LSMs; while there are reasons
> > for this (move to the framework on an as-needed basis), it is a little
> > odd and with any inconsistency I worry about the potential for bugs.
> > I think moving the allocation and management of all the LSM blobs into
> > the LSM framework, similar to what was done here with the sock's
> > sk_security field, would be a Very Good Thing and help bring some
> > additional consistency to the LSM interfaces.  Looking quickly at only
> > the SELinux code, I see six additional blobs that would need to be
> > converted; it's possible there are others in use by other LSMs, but I
> > haven't checked.
> >
> > Casey, is this something you would be interested in pursuing or would
> > you rather I give it a shot?
>
> I'm happy to do it. Would you like a separate patch set for this, or
> should I add it to the stacking mega-set?

Separate patchset please, in my mind this is more about improving the
consistency of the LSM interface ;)

--=20
paul-moore.com
