Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBD1A0708
	for <linux-security-module@vger.kernel.org>; Mon, 24 Jun 2024 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266875; cv=none; b=GJ1E0mx4LzVPicsabPfrfU/kMLWb/9h8/pgJKjIdoWfE/xJ10b8k+FN0N5sUvptpeSSH6fAJRB5RfTzHHvQO67keV06dSJ2VhTwCol5xSDp7rGhAPyopMvXvSPyi0CKnATDGn2/ICDEWNXCVuof1hITz+PVSqf+4RLNiOqaA1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266875; c=relaxed/simple;
	bh=opT9chxOr5SNeIuK8SI/neAZbgaJe17hZ4b9hMCiFJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxZSFlDBbMXvyLnMLhCTmc/KJ12S6S59ZrEG9WOShXC5Qulb3Vd/CTwtUGd5dMw/2Qaqr6t5evLPjuoA3gQ0js1Jx/40taF0PtR21zleLdgDqfHHuhbt1QHVIcgk15ytlT3flMGoyvp+WXgSxgZDKkXUJbmUDR53NEkcBgPCft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FEVYhuYo; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FEVYhuYo"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-643f3130ed1so18234267b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jun 2024 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719266872; x=1719871672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fszxPVkXOEv4ipvfMeUYMBaHCtHM5VmJKexolLOZC+U=;
        b=FEVYhuYoJJznA45oTekzWcNv7XJDGavcA/3HwyVgrfL4jS6mmMVPiskJvI5RJ6Vy8v
         835pLpHtMZwIG4ctHgGh5977YNimJwPzLU3Q6D9CD96dgHYBQuNpndXkc9C6dOQprfbu
         uLfkbG9J5l4SsJmeLMd0IDwLPY7IUkUn/yZLdX2v0YlP5wZ4R5SEYi0NHV5v7IaP/1hh
         qb21VWUfuXQ7zMBb1ytR9XmGkkj/rGAQwpWV2E/F1XnOkLhYu9684ZosLUNnTi4nYhqD
         N+ngFu0+ZpgoldrlBq1FR3OMWGBb7U1wiGxbcbTGixxf/p49QvEcKbQ+9KsnuZto4bSe
         97IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266872; x=1719871672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fszxPVkXOEv4ipvfMeUYMBaHCtHM5VmJKexolLOZC+U=;
        b=aBOPbpGsIgCKPkANIS4XcTx0ZVWugTDgFl7f+eP2W6EqAYLjk93vd4WC8hHUtUnN65
         a/5D9sfszWGUsGl92ZgXAgvBdlBnYNv67CI6Dly/f/PBX1ej4fgeEAUPX2mNAliqY5oM
         fue7JDjHNnn0upgiZkS63DAGGyOmrblewN+sPU51Lnzb+3jVjqdlMWywAH/r3zRnoyp+
         GRtF4+pI9csrSNlOaAevwmLVugEq8QHY2ZfKxhzmLHFpko/qg6dGfFCqL+G3b/WBSUXC
         Y8NK4TWfz15v1yg427On+up+62jTMDtPOP16c+frqibDobtav2XX5Kiza+L83AMVtTnT
         uXGA==
X-Gm-Message-State: AOJu0YziYSWUvIwJpniweIxuYBtIc11E6Muy2M9Lu/wsO8f9qknVnnvl
	rDi22uomErKb1Wue+960cTuIkwubUYgJgpvh2PQtr+Zyfbkl1c0pLQmit+xQt7sBjmVqNZX5fql
	Uaq4/RLfD8o5C89OMLS8Y4quU7uz+8Cb9O8Vs
X-Google-Smtp-Source: AGHT+IHOVgf6sPtvz7xkzuxIJIFBk7OeedDuU5iG83zGwr53aHKkAXP3cmaTbi55yIsmL38DOo+j8by+9wv8qdnxftY=
X-Received: by 2002:a05:690c:f93:b0:633:8b49:f97c with SMTP id
 00721157ae682-6429c6db0bcmr54456627b3.37.1719266872555; Mon, 24 Jun 2024
 15:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-3-casey@schaufler-ca.com> <CAHC9VhQnzrHPRWKvWPSuFLWHhcXkwqeAfXsFbEdBBOMcACZorg@mail.gmail.com>
In-Reply-To: <CAHC9VhQnzrHPRWKvWPSuFLWHhcXkwqeAfXsFbEdBBOMcACZorg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 24 Jun 2024 18:07:41 -0400
Message-ID: <CAHC9VhQeWF814h8+ho3uKuz+NvvFApwJo4FkdmoRvYpuTcrk4A@mail.gmail.com>
Subject: Re: [PATCH v39 02/42] SM: Infrastructure management of the sock security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Dec 15, 2023 at 5:18=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > Move management of the sock->sk_security blob out
> > of the individual security modules and into the security
> > infrastructure. Instead of allocating the blobs from within
> > the modules the modules tell the infrastructure how much
> > space is required, and the space is allocated there.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  include/linux/lsm_hooks.h         |  1 +
> >  security/apparmor/include/net.h   |  3 +-
> >  security/apparmor/lsm.c           | 20 +-------
> >  security/apparmor/net.c           |  2 +-
> >  security/security.c               | 36 ++++++++++++++-
> >  security/selinux/hooks.c          | 76 ++++++++++++++-----------------
> >  security/selinux/include/objsec.h |  5 ++
> >  security/selinux/netlabel.c       | 23 +++++-----
> >  security/smack/smack.h            |  5 ++
> >  security/smack/smack_lsm.c        | 70 ++++++++++++++--------------
> >  security/smack/smack_netfilter.c  |  4 +-
> >  11 files changed, 131 insertions(+), 114 deletions(-)
>
> I had to do some minor merge fixups, but I just merged this into the
> lsm/dev-staging branch to do some testing, assuming all goes well I'll
> move this over to the lsm/dev branch; I'll send another note if/when
> that happens.

Everything looked good so I've merged this into lsm/dev.  Thanks all.

--=20
paul-moore.com
