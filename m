Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3D33EB06
	for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081808; cv=pass; b=d8bEnyB1QSNfgVXK45Ej/HMUkmyKRLif2K6jHkydANspsVjx5dW8wMSVZwO2pASjopzxLRhXqOB8rQQYHf9ioFEQSM5RTEr+hcprWBS2VAhzstk2m5UoxJ/auxGLTYmARagFbE71d2j9rp9kuoJC4MW9u4t9oqZPwQPJT+8trl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081808; c=relaxed/simple;
	bh=PnxSfTGJD54jJaS0qmt8X/NOj0X3sFgFp335BaX6BlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP1onBUpBBgLlwpnxq69gGjFSyNzYRS2utEgfUpP/zMaxWYasGUu5HUDWkom+KfAquwDS01r+1cW02GGPI9U08VlXaNct2LR2CsZ+5W8SwhhrNhnK9/xYt/gIqOrTAhmXI1heoICKLOKWKaxjAuTI7VvaGTsTnizv5GR4O3PE1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ciq9dS4E; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ciq9dS4E"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so342991a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 16:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789081802; cv=none;
        d=google.com; s=arc-20260327;
        b=ado54KKZTPbVRETKj181b+zR3cYYT8i4tZJvk6j9w6W49G+Wjes3m7MqtD8wb81z/O
         MK5Lfw9FQl/jq/3VzX4xt01OUp5lwJILd1qK9jAm4k1EOx6fjwfuU1XGAduV4y58cV1E
         xpBfzMCepFmqe+b31RjAm4778QapSwVSacXTd1snIwoJCth+JtBS0uqqw0O76eIRdi3s
         7kVst7bi78l7+dF/ACzOMF7k+qmDsOFB+RHEr8yPF7CDr/3Eev+pkU1f/+mG3mzr1tmR
         LD617pGGZz6W4aQuSrpRh3v1HZVSF3sKLXXRYwXdY7vjWbAhbXLjoEdEpIYMrDlwryV3
         mxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L8sMxb6Uw8z6M0MXXSleWX5vN1RUfOts+cADzDtTadc=;
        fh=GxARcsWe2GQ3Rxpk4dtdex3O7HB0Dlx66Ed/T2FIRs4=;
        b=ZhVJt7dFEECOFIG0TbVGOVTVI84Wn1MPeAQDbie0jxHQa2Aa643yPKm42ANAh9qK0R
         +Q8OSaC6HBfIgS+2z2pbll54JMB6HjOiGAXqLA3Un/1CT4nsH80NUtlMLyB3EX3j8Tsz
         uauCzNHAQdQGZ+eZbcKiDghgstJ51LED2F8efFVUFKFD8h/cl219TLrzjT+9H+s/W+Hr
         mqZTmNIgUbZJ3CL4in3b3pMfJScrh8Mdwbezy5i34OoWvikr4pl54dQ/SuXlfi5jNAlo
         8Hw41BNnRl8fWXF3zGPLJ0NNXdArfWFmblx7JtdyH719JF8cJDNUlG8lzTalIl28mdHv
         tZrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789081802; x=1789686602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8sMxb6Uw8z6M0MXXSleWX5vN1RUfOts+cADzDtTadc=;
        b=ciq9dS4Eqz5hX+ydh5aF6tMZODwh1Wu4ZDbvj8bPJNa8T1AbvoWIjsyeez0EIPEc3t
         9D0PDSb+dOow0piSGo4UVZtE7qL+fG/U5noB1UWmKPi2WoQ3U1Gpu5r63VfhfQjLvjMT
         yrzdKWksXkcUGyzCmesQMrc/uCyuK5k8zx/egQ/1dyIuWktTFfOYG5JaAmdMfd3dxVoW
         vUjTEx4x4/Jzb45pCnR3x3WMrxyYm1nK4W+mazpea750IFE1cL2CkqQN1pik7oNUji+u
         q0MMqdQ5UWruaRbzaA6MGLOPZoQ22tiRO+cCntZZ/KxgK5AHErDYY6stdvma7h6A+jOB
         rhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789081802; x=1789686602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8sMxb6Uw8z6M0MXXSleWX5vN1RUfOts+cADzDtTadc=;
        b=r2LN75sUN3o767qCbqreXGeCQxJxKkNWSue7Pq27RCg822KFt/LSckCrZudo4le+qI
         MsGQuvhBUU+f9d2lw63UDj0gRFYS+kknYonXJ63M6C4AcVghki73on/Q01/OeKlggcE8
         ymxwPbc6ehTTXZ4O1veBXeEaFiaBZkPoccPyr6XwzfwpBBUyZq1ZyMTwyhaNurN4N6ot
         0SlTtCvV5Ql3Zv/X/lN3Lmnw/v67mik1DWILOUcYUfc9Yv42I01r/DKvJEXNjEQqVW/q
         BCn6Ctkp/e/I+Q5+mzjRBQfj4cJQ3XkzZbmmUmMElxj4KvBFKTEr3afA/pWQuFkTQqBS
         2hUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzG0dFlFOJ2B5pNDEDKk5/fc2huxuJsCV1ZMjZrvj9xaftApW+r/PC6/AITlH17LKWv63jiUXXnZAC049DSF9uJVajPunQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ldsf5Hz6TKanLCJCGcYwm513pSdf7fKR+QqEDbLpUREfc2nv2H
	UriVmgSEanmuJDeAFz8KBwP7YtTHCggA4iASUdO/fhU+XKw/DI913M/IXaxQfNFwlnmq+zOCZEM
	gDJ28QofiLyzxvyAqk9V05qkobn0TN3230WNNtJLh
X-Gm-Gg: AYBFou0Fqy4aKw6d61GNDoj4lTR+/2NQ7H+arQDJvQ69dveVhHUBFuygcThFYK1ly9s
	7ecJ2Kyc5TgASczs6RAECmzEJ1SylCK6JRexbjRh7yJS4b/K7M4XcWbyeSsS8Kx/hF2mVO2FO1z
	ChcQY36+cuR0+S7ff9s0tr3nSvjZ0vHE7Z4P3AqsUWEyJTxkMxV7VhBdH9+ReO1yLTnNaSSyMPQ
	WsM4qRVGRwCCqNLJY97Wq+WUrq+k0s64VuSOH2BdJqjMSsFoTx1bpaMzdhNFU2bIUc9fz5/+QDq
	GpXdfZRgw7USbJYIVTFy9d1p9h5ndZb6oPQNxlHFMSm3MSeouISREpRawrzHvWpnYVY2ZEjypOO
	xo4VYwZofUzDe5XYs7M7k7A==
X-Received: by 2002:a05:6a21:e58d:b0:3d3:ae0f:5269 with SMTP id
 adf61e73a8af0-3daed38e31cmr2162731637.21.1789081802270; Thu, 10 Sep 2026
 16:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726161400.3010511-4-mic@digikod.net> <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
 <CAHC9VhS_WP-bLgMGiFAfE1MT76iKvVJ-OV5r7xju-KMdrfjssQ@mail.gmail.com>
 <20260909.quahcia8aiF4@digikod.net> <CAHC9VhSRV_axaGM0hTZngQY36Jw1ULy_sHHsik0_HCSdVv4P+A@mail.gmail.com>
 <20260910.Ooph5bing9zu@digikod.net>
In-Reply-To: <20260910.Ooph5bing9zu@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Sep 2026 19:09:50 -0400
X-Gm-Features: AcwNN1XD4jUdsWX_8lOn0Nqg8RhgpbaV_W3e5S49NjErQsIEe7OI26lKNwsad-4
Message-ID: <CAHC9VhSJ3jRybaU=6y2kOKA=KpGE8r=QTMPwdD3KptGcB7msTw@mail.gmail.com>
Subject: Re: [PATCH v3 3/12] security: Add LSM_AUDIT_DATA_NS for namespace
 audit records
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 4:12=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Sep 09, 2026 at 03:49:11PM -0400, Paul Moore wrote:
> > On Wed, Sep 9, 2026 at 2:35=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Mon, Aug 31, 2026 at 05:26:20PM -0400, Paul Moore wrote:
> > > > On Tue, Aug 11, 2026 at 4:16=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > On Jul 26, 2026 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=
=3D <mic@digikod.net> wrote:
> >
> > ...
> >
> > > > Micka=C3=ABl, if you would like me to merge the remaining patches i=
n this
> > > > patchset into the lsm/dev branch just let me know.
> > >
> > > I'll send a new patch series soon because this v3 would not apply
> > > anymore.
> >
> > Okay.
> >
> > > I'll include your lsm/dev patches to keep a consistent patch
> > > series.
> >
> > Please don't as those are already merged.  If you want to stick with
> > the same patch series, which is fine, just note that the first three
> > patches have already been merged into the LSM tree.  It's not uncommon
> > for patchsets to add or drop patches over time as both the patchset
> > and the surrounding environment progress.
>
> Yeah, I know, but at the same time are there (merged) users of these
> hooks?  Anyway, we should of course avoid to have two commits for the
> same patch in different branches (even if that would not be an issue for
> Git), but having to handle several origins (e.g. the lsm/dev branch for
> new hooks and the master branch for fixes) might lead to an unpleasant
> gymnastic.

We discussed this already during an unrelated offline conversation,
but for the sake of others who might be wondering, that's not quite
how things work in the LSM tree.  As a refresher, here is how the LSM
is managed:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#kernel-so=
urce-branches-and-development-process

As a quick summary, the lsm/stable-X.Y branch (the current being
lsm/stable-7.3) contains patches that go up to Linus during the
v7.3-rcX cycle.  When relevant, patches in lsm/stable-X.Y are also
tagged for linux-stable.  New development targeting the upcoming merge
window is merged into the lsm/dev branch.

The lsm/next branch feeds into the daily linux-next tree and is
composed by cloning the latest lsm/stable-X.Y branch and merging the
lsm/dev branch on top.  This enables linux-next testing of patches
bound for both the current RC cycle as well as the upcoming merge
window.  During the normal RC cycle, the lsm/next branch is updated
whenever there is a change to either the latest lsm/stable-X.Y branch
or the lsm/dev branch.

While one might imagine merge conflicts in lsm/next requiring manual
intervention would be common, after years of experience I can say that
they are not. On the rare occasion when conflicts require manual
intervention, they haven't been very difficult to resolve.  If we do
arrive at such a situation we can work together to sort it out.

> Another concern is to ease review (for both humans and bots) ... which
> might require a well-known base commit, instead of a (transient?)
> merge commit.

As documented in the link above, lsm/dev should be a stable branch
that you can use as a base for patchsets.  It will move forward as
patches are added, but it is rebased only under extreme cases (e.g.
filesystem corruption, etc.), and rebases are typically communicated
to the list.

--=20
paul-moore.com
