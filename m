Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624CB196D9D
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746664; cv=none; b=EX2rND5S7O/8OpCkz67UqOsygOePbtGUR+lkpYECmPjqik5Gp4FbvuC+I/xdl/blxPL5TMUD+0RDsGfy2yfafwThxYZPIgocnIFjBPXzpIuOWQqq4jH/MZhfYghVAtlzIhdqCapux0kVOHfypErEltNaeRtVKQ7n/LaAcalrJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746664; c=relaxed/simple;
	bh=61h5rBrPviiMwicPin2i5vek0VQxFAt2lP5ZndEMZW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWWqRiquyGlywHsnSML5A+LCeEgL392y0HTuc2pmczjMttCOLzxUnTHSXLH0nJckSY4oqYDaeR+cA1SZV/BBHJNG2tC0KqN+iEK6sXz+YlPQ7C9iTuzjQtyr7bhpxY3m9oZ7SEd5ILSSZX35rsf6MU8Bl0ejG0LwMwqiY9fuAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gpf4cdHy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gpf4cdHy"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so437623966b.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 11:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737746661; x=1738351461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91OTZbAGTnp/LTnkn1ceHIXEbI5XOua7HXaenk7Yb14=;
        b=Gpf4cdHyjWD8rfEZpsecqAuw9IMc9izs4iwJ2srPShfLD3ZBDsZzHj/WxJ8IqMqtgR
         9+5iOVrgBi84H+tW6nv+0uv5vgtn4JxU46aRngsy9J1JQToEVPAdnFrT2OJiuIrDuMiw
         /h7Vc62CDUSmz4gvoTXGGxKXXf65yIobMZnS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737746661; x=1738351461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91OTZbAGTnp/LTnkn1ceHIXEbI5XOua7HXaenk7Yb14=;
        b=ceztdRR+eahDv3UXDWY6ZMcMF1OqAPjkPq+Cy10FOqztfxgVYPPPiogllHNBjsocwl
         dmyPv28S7bVOGCNK3beqSLV5EDR3RXsgmyU5Fpkurk56cEa79kf1Us7LlGEKq00kglqB
         auoF2AEWq/1SQZH+h8T7BoS7XCnl/x+wTrSz98ThRna6uLCcnyE7tVNz27zn0CfdvUAv
         q6kYo6WOGCripyWXvifoGSKqTP1GnzTdIRe1yI1zQN8S1nox05hB2UTDVmg7aEtew6EH
         Z5s41ZnVQAvwD2bXTUrsJLH9lFN04QiMeUv1C29NHwB4UZGwJq+tOPQBpFD5n1FUwHxp
         czbw==
X-Forwarded-Encrypted: i=1; AJvYcCWKq+S7DEB7UtYlB9bZYaPZiUsExmhq1wpxS4UuKpn2qILe3XPJzspJ838eFlFOABccXmagOi453V1pDJb4fq3zX8UnTm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCRVt0ESfLSIa4GDg6GLFxg+GXc81FLXvAPI9y7odODznIPuH
	1uTn6cwRAbBJuLQU0032iwmmxHdLae4lNU3yFLPv0ecJxIXJOHGuANSgf6UUleufKav+5cKfvXB
	8zsYPAUxcurpNpXOE4FDna+jBaBSFc16Eqcpf
X-Gm-Gg: ASbGncuRUpGQP7RuhLNMUBHDEFpjJcxKFszQaKyrdsAfQ6yP2ZBirdwZnDUQoE1hZh1
	HuMd5wgSTSvx7nMPFUamLglvKAorY2GQJxKgFBsBhdyCMlX8rYxOeG1PQuAsrwb0=
X-Google-Smtp-Source: AGHT+IHRnbHSHCv5970x796LIdkl6qm3UsB1Bi8kNn5rEUwlH+vMpKxC+C+Z3GZV4lc7XF99RV3fDkwhkj6MetH+uuQ=
X-Received: by 2002:a17:907:60d2:b0:aa6:82ea:69d6 with SMTP id
 a640c23a62f3a-ab38b10cfbfmr2730213166b.18.1737746660636; Fri, 24 Jan 2025
 11:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com> <CAHC9VhRektpFHeUirRP8MH3NkmHWyy4BLcrDpy9zJH=ZJD4gRw@mail.gmail.com>
In-Reply-To: <CAHC9VhRektpFHeUirRP8MH3NkmHWyy4BLcrDpy9zJH=ZJD4gRw@mail.gmail.com>
From: Micah Morton <mortonm@chromium.org>
Date: Fri, 24 Jan 2025 11:24:09 -0800
X-Gm-Features: AWEUYZmC4dOl5YaZqOEeY9HHUhXuJcqrgJQGgDOTM8YohPxUeAOFZxS_fcKqKzE
Message-ID: <CAJ-EccNAzKwJt_wyRDWCrfP2dkBExsWumBGoNbfxG506erCoRg@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: check size of writes
To: Paul Moore <paul@paul-moore.com>
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 7:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Dec 18, 2024 at 4:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Dec 17, 2024 at 1:27=E2=80=AFPM Leo Stone <leocstone@gmail.com>=
 wrote:
> > >
> > > syzbot attempts to write a buffer with a large size to a sysfs entry
> > > with writes handled by handle_policy_update(), triggering a warning
> > > in kmalloc.
> > >
> > > Check the size specified for write buffers before allocating.
> > >
> > > Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D4eb7a741b3216020043=
a
> > > Signed-off-by: Leo Stone <leocstone@gmail.com>
> > > ---
> > > v2: Make the check in handle_policy_update() to also cover
> > > safesetid_uid_file_write(). Thanks for your feedback.
> > > v1: https://lore.kernel.org/all/20241216030213.246804-2-leocstone@gma=
il.com/
> > > ---
> > >  security/safesetid/securityfs.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > Looks okay to me.  Micah, are you planning to merge this patch, or
> > would you like me to take it via the LSM tree?
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > I'm going to tag this to come back to it in a week or so in case we
> > don't hear from Micah, but if you don't see any further replies Leo,
> > feel free to send a gentle nudge ;)
>
> I'm going to go ahead and merge this into lsm/dev, if Micah has a
> problem with that I can always remove/revert if needed.
>
> We may need to revisit safesetid's documented support status, but
> that's a topic for another day.

Sorry guys, I missed this one. I usually just check in weekly on my
linux-security-users filter in my email inbox and see if any
discussions include 'SafeSetID'.

I must have skimmed over 'lsm: check size of writes' thinking it was a
generic LSM patch rather than something specific to SafeSetID.

I'll have to adjust my email settings so that emails which directly
list me on the CC are sent to a specific folder for me to check more
closely.

Micah

>
> Thanks everyone.
>
> --
> paul-moore.com
