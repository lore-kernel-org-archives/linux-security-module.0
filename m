Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DACC1791F4
	for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004745; cv=none; b=uK3IkZC73wdbQ5z6oTJWeahkz0EDKSq/ucY/dX0PMS75x71nIaE4zcD3ZjCQOpZIzBHy/MpolMEWtHxQp30dZ5WTo9JXMZol1VdxWY9tdprAWS6Nd6FM88cU/c9vgHBVWoVgSEHI6C00EXEpaQve3KRiD+ugI5Lq60nqKTwEUVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004745; c=relaxed/simple;
	bh=X9WSMFU/wNIJq2RKIpQCKPYG8Sq+Ik2gDt2GAk8E5kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIXTxEuDQWCWeh20+se46j+MQGz4UL4PlC6uNxCq39o/lYoc+jNmwnm9tuk1pKPfozlZPY432jh31Hs8DmOPu9vPvgGuv05jSIi/ZNBvsAbl9TmcQFPsyutUeg0qT87/VEJGCTwaZRRFpdvSRaI6cjluwvxbLADOcbwi4MGyirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZZQtfcVr; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZZQtfcVr"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso2591092276.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719004741; x=1719609541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCD4r20mrpTxmvcMRXNwOiX5qAdOlLJEKmqvDoOzpPQ=;
        b=ZZQtfcVr4rAIifpUrpBSrSr0wwaRMF2r56zZSDIge/Es78JpQj6HlQD55SzUo35QoB
         qDMSibqzG1qXRU0vaMjAI8RI37Et6X/cDpJxKcFGuboY2D+A2qohA5fMrRkD1k9PDnwt
         V+rZDtpnIAURXlNJN3xcvt87/P4UKtKJemWv/yS4CpVFmExYLSi5Q+sm7ddasog0Zvpm
         R7LsaOTz/0u/XZdSRrB/mY8bd3Wz9j2mes60YF45yB6AABSYbjUKk715qtvByOMINFdV
         epc5CRpGY55ykQMR8Iy24GgxhU/9j4MRr+Wsu7DYSM2bhnn99KWdw0BTXIDpBX0oqkzx
         OpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004741; x=1719609541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCD4r20mrpTxmvcMRXNwOiX5qAdOlLJEKmqvDoOzpPQ=;
        b=VYVeuU0wSKnRM9ALagveAlkvdqbR2OX92ST0sfimyJUvxZHgzHMMbRO8y0ZRdiJ4ih
         9VTOPHmt7JGEgMHXK06uFsTCieDKNwtU4/MBSZUy4LvdROPxICfqFqX0DBD1d7DVedXf
         38JlYmMuaNmIXFL0SrWa2oyEBupCl/6PyVbxpFJ9woYv2XSKNKvJnYr/3jfbmNKlmJlZ
         bzNc/ExSRJzIUNL6qB8D4zC17iYaeZumo368fJ3HUfnMw9goDwfrpuLHasr73XD6ZP1F
         ZphmnGi2qvbAfZwhFzXuLJIV6i91dEvyIUpAIjFGc7FBy/aiito33EBDruPwYTXSQg7T
         EH1w==
X-Forwarded-Encrypted: i=1; AJvYcCWO2LjuTFWfIraUntmXyMPRhoyz0LRusVZxQy8tsk0K8d44kNAmaUlUy7SpnB9N8/BPY6iYeAhSLsz4DpLA1fYSwwPDlBJjboxfH7Hy4E/fl7RQdY8k
X-Gm-Message-State: AOJu0Yzx67dUOVFRl/pHeUcERb5vs2sFAa9Bc+wdGHmwxtkw+M7e9OY4
	HfJcA2CsF3J+dCnvLwqW5FztFgen0peEik+y5aV6oH9+vSo2C9LNWZwv6Gm6syCad3NdAUl2Lyq
	aejxq24lgu9qyjETuUVVLoLXYLWsfVMKaLh5M
X-Google-Smtp-Source: AGHT+IFe108rxfdI4dceOPLQyYzs1eDja/U43G2YmMGoBEVShtoTYQzpQ8euwTVDfc0m+2FKogi3L+jAlR4yzx48SCE=
X-Received: by 2002:a25:5f50:0:b0:e02:b9ac:1486 with SMTP id
 3f1490d57ef6-e02be22e5ebmr9441533276.57.1719004741560; Fri, 21 Jun 2024
 14:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com> <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com> <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
In-Reply-To: <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jun 2024 17:18:50 -0400
Message-ID: <CAHC9VhTPE-dcwVWeMf=S8ci2J_h9Cm4B54knaskFKBOaYSEWiw@mail.gmail.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from security_audit_rule
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:27=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2024-06-21 at 15:07 -0400, Paul Moore wrote:
> > On Fri, Jun 21, 2024 at 12:50=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Fri, Dec 15, 2023 at 5:16=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:
> > > > Create real functions for the ima_filter_rule interfaces.
> > > > These replace #defines that obscure the reuse of audit
> > > > interfaces. The new functions are put in security.c because
> > > > they use security module registered hooks that we don't
> > > > want exported.
> > > >
> > > > Acked-by: Paul Moore <paul@paul-moore.com>
> > > > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > To: Mimi Zohar <zohar@linux.ibm.com>
> > > > Cc: linux-integrity@vger.kernel.org
> > > > ---
> > > >  include/linux/security.h     | 24 ++++++++++++++++++++++++
> > > >  security/integrity/ima/ima.h | 26 --------------------------
> > > >  security/security.c          | 21 +++++++++++++++++++++
> > > >  3 files changed, 45 insertions(+), 26 deletions(-)
> > >
> > > Mimi, Roberto, are you both okay if I merge this into the lsm/dev
> > > branch?  The #define approach taken with the ima_filter_rule_XXX
> > > macros likely contributed to the recent problem where the build
> > > problem caused by the new gfp_t parameter was missed during review;
> > > I'd like to get this into an upstream tree independent of the larger
> > > stacking effort as I believe it has standalone value.
> >
> > ... and I just realized neither Mimi or Roberto were directly CC'd on
> > that last email, oops.  Fixed.
>
> Paul, I do see things posted on the linux-integrity mailing list pretty q=
uickly.
> Unfortunately, something came up midday and I'm just seeing this now.  As=
 for
> Roberto, it's probably a time zone issue.

Oh, no worries at all, please don't take my comment above to mean I
was expecting an immediate response!  I try to make sure that if I'm
addressing someone directly that they are explicitly included on the
To/CC line.  I was writing another email and it occurred to me that I
didn't check for that when emailing the two of you, and sure enough,
you guys weren't on the To/CC line ... I was just trying to fix my
screw-up :)

> The patch looks ok, but I haven't had a chance to apply or test it.  I'll=
 look
> at it over the weekend and get back to you.

No rush, enjoy your weekend, the patch isn't going to run away :)

--=20
paul-moore.com
