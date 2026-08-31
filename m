Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C483A7597
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211390; cv=pass; b=VVIOpoH2VQ4sWLwYyl+hokFKSaF80dV0utJw2NkT0Ye05mTswH+RrFTsk7dw00nBHMBdrXaFz+1ElPtNDK2rEPkR5OtTLJt6gspU5wYZ2Ei/BeUuh5hALa+5hVeEIDIXBHcL0GTae4IL1K48H67DxWim9YncLpP59xW/LWdka/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211390; c=relaxed/simple;
	bh=+1ctpOnlda54PidlZ6bNmCPQ+W0TpdPhm/i6KN/wKa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByttGItsmFJY9+XPvbfVoDNz7vya9BvSYSilqNz9Lb9ubDg9Ui1zkI7AK2xamlSttByEZcChJzBeCaAHjpow0Yk8hVyYfA2rkSCymu+CbwNU+zXs4+ss93nhIr9ZjcmGdEpqoCMOMWO/bryJjUWHIyXYTwB6ml9YDMxFkOyaiBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hg4iWkiR; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hg4iWkiR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d91ded8174so1054445ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 14:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788211387; cv=none;
        d=google.com; s=arc-20260327;
        b=FGtwJ2VygiZYM4wTGnobwgMRK6Z3j5T/x4lqjlZq21Z3mpvE7MdEM579N6ZuaHCIfm
         obPqm4kpcaIE3+9xGn7856s4vJ7GvaDRdJSzVQtlEXTL8MkN43duk6O83YoLeM9+ZywO
         /kLdxci0456ic6e48S7Y3BwkfOZAnq2jVRLeiulBfNQIH1j8GphdmWOxtxklCoia/ndq
         Ir/h6CrHzCUvL9fFydcnBgiW+1GRhnMcLuC21p/0t/g2n1eKsAanJYkK/inUzu0dDwah
         V+1Bq94AYRiUZTWq6XtAbFAnG8ArGoyIwjTHOENBb+GRE4I6setkJ6iGTdOFRnM+Pod6
         zOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TFINHJ5jZ8ERlFnthoEvZPB9L54815EikMU7ng1wOz8=;
        fh=joOPqi3T1qFSev3+hfK6B+j2U7Gy4rNPdUBq/fCS6K8=;
        b=LRTd+GYUSbHhITnfFdfv1SusWow7VWI1JiFawSJl1Me0NtyLosrvcrh8R2oVhAzHYm
         dXx/A4+pull81N94BnsMWqlm5cuApuzXepz9GS5HdtEkbP6cvz1958PZiw1AGh66CcmJ
         PW1XlOI/l40yN9bi9bN9RXcs1MwlZ0IlpJdypxh9VTg08XGF0UV8x+SUQpb7sAnENCPx
         3YlChjM02RhZQLqZqrtSNAgqLZiBV9sIbG0OZShKSsqHrTfUpqg+1TwpsrKKrDLGYwmS
         O3iw1BXVKYNV5G/jXh1meH9gEBblngoeiFKbJ3VL+6xvC46rYLx+D16p7VOo4KmG4/PE
         VZBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788211387; x=1788816187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TFINHJ5jZ8ERlFnthoEvZPB9L54815EikMU7ng1wOz8=;
        b=Hg4iWkiRhdIY0QnmPFpdDDHe7bhXyeMl98uRZihvaS06q1MXAaZFnAoaIgkx2NY8Zk
         MnLJneA+ImYjqm19LJuThUmwetBxKkPOSmTlT0pykqhl+YfAeB+5RjETqQLEdj6DZ1CV
         g+C7sS2dIfuBeeS8SVco2iPeOro23T6aNAuuCEA3BHxUxgLloJn2jDsdPB0kXpFgRN8L
         tjiUh5OlWjaBGMoJc0NadY4Qyw7D8r99FpgjO7kMUcG5/nD6xFE3JhmWzGlC9DdbZR1M
         PQzrDgaPLTZ45MGummuL6ffnkuGJEV4zjUGRCS5nnHn2JKGmLDQBEVQxxznWIk2v4/WE
         Pvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211387; x=1788816187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFINHJ5jZ8ERlFnthoEvZPB9L54815EikMU7ng1wOz8=;
        b=YbA1oQ3H1t2L1vM0gkhIQjx3GjfNkMPeVOgrXD8ZelOOu4XmkA0L+huZEKwcZ9BMKc
         um5ww2axzUb+PHGSXFVLfg7/7hqbBgCVPKzgS7V6XLaZoWljuWeCdA5DNNv2ip3nO46j
         5LAVfcvFkOGz+kqoXWC5swi5z0pD6UYll5/cB85l0w3999sSvHMBKJopODXXhXN7VbpY
         HwxlsV01+N0lr7kar/rS+E8Zdgk6nlyte5ntZ4xCmNcY25+sHHaGiAv3GWNs1FokYTK2
         kkSIIPJRDZ11XqoF4zRPcdjkWdCT7Xuz53HE87uqLXm/TADU3qtMtY3FWuYYx2T/sx5C
         TDsw==
X-Forwarded-Encrypted: i=1; AKwUvBwm9DvQNkGurzbrSDKByXplM/ZbkxSJWsgYyuZL0l3AUAldOCt58UaGBN0wdG7p6mQmIslq4GWZi2pMe7QojTKFlfJB54Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kn5W7/VDPhuy9BfWTQvWKV7yK1Hom7Zq+jqADf60EeQ/VFfmV+
	JOrJhB71zwy2nG8OeV8s1p6cnnU7jqpE0mvm/p5YNNNezWZ7BH6uAUprnxV9fipjsQzwlzahMhu
	Wii5AfpViMhEP+TVVuyUS2SGrKSWjZbyfki/BQ51DZgJQ+47qdfOGFA==
X-Gm-Gg: AYBFou0HkeumciF5ag+KpSMZPB3mqyF6e3/b2M9QaTgq7kBid2hlwf5d50ZWTrJI36J
	vcy6AoDXpnA7N8Fc2idQ1o5sU1yfEfAAOi6dCDCbI9BSg1eFr2siavcFU+4Xr2wfU6fIIOT+zLm
	EzdPxrN6lCFkoMCsrrt+w//j15zWBPPIkXjJNGHt18Bv6dHcsi0YkzH+TGlJrOPLbqzQwE1spm0
	qvx2YKDZyHo9kjm27///J6ZbVSVvyJ/lWHTNoteQHlZw2sXRqsUbVVIyBFrbzT2PbvkCaUNbMlm
	gGBdkDjnDNHITAK1qgwGeAXNDGCWQdat4ux5NcamgHgl
X-Received: by 2002:a17:902:ebcb:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2d74cfcdb1emr492271905ad.0.1788211387554; Mon, 31 Aug 2026
 14:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com> <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com>
In-Reply-To: <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 17:22:56 -0400
X-Gm-Features: AcwNN1UgSvn7xJ2VonI3rUNXxETiZFahKrkwjH9zjPk8v2KgPZyHugOYt0cGY20
Message-ID: <CAHC9VhTYYbmKVXzMrCv=sLi1c+6Wdvum+TmpGNPZysaNHDyTHQ@mail.gmail.com>
Subject: Re: [PATCH] cred: clarify that task_struct::cred is only for the
 current task
To: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug  6, 2026 Jann Horn <jannh@google.com> wrote:
> >
> > The `cred` field in task_struct is currently marked as __rcu, but that'=
s
> > not true: It can point to credentials from access_override_creds(), whi=
ch
> > do not get freed with RCU delay.
> >
> > What actually protects task_struct::cred is that accessing it is only
> > permitted for the current task (except for setting up a child during fo=
rk()
> > or tearing down a dead process).
> > (There is currently code in Smack that violates this rule, but that's a=
 bug
> > and causes UAF, I have sent a separate fix for that.)
> >
> > Clarify this, remove the __rcu marker, and remove RCU helpers from all
> > accesses to this field.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > For context:
> > There have been at least two UAFs of struct cred that I'm aware of, bot=
h
> > caused by wrong use of task_struct::cred:
> >
> >  - https://git.kernel.org/linus/a3727a8bac0a9e77c70820655fd8715523ba3db=
7
> >  - https://lore.kernel.org/all/20260806-smack-uaf-fix-v1-1-26426d389a26=
@google.com/
> > ---
> >  include/linux/cred.h  | 17 +++++++++++------
> >  include/linux/sched.h |  8 ++++++--
> >  kernel/auditsc.c      |  5 +++--
> >  kernel/cred.c         |  2 +-
> >  security/lsm_init.c   |  2 +-
> >  5 files changed, 22 insertions(+), 12 deletions(-)
>
> This looks good to me, with one small nit below, but as we are at -rc7
> I think this is best kept until after the upcoming merge window so it
> has more than a few days in linux-next.  I'm going to merge this into
> lsm/dev-staging with the expectation of merging it into lsm/dev after
> the upcoming merge window closes.  If anyone wishes to object to this
> patch or add their own review/ACK/test tag before then, please do.

This is now in lsm/dev, thanks!

--=20
paul-moore.com
