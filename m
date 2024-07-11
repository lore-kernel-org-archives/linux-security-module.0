Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2212376E5
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716659; cv=none; b=FIiXx8Wsd+bsSdkqeTdxQD4/ZDXB4apk5UsSsKYNYnvngQNANkS/Fx1LnTYJqwMSd3JoSrwSDht6Fr0LYQuoxJXOqvP99hHXezJmb//lYFHPuCXys+d3lVfhcsCvY10+dA7D/82Y87NDSkWjmaFXXyH2wL7e/sgJrLpZl3pxD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716659; c=relaxed/simple;
	bh=K1w5l8Y//PhMcedP3Cm0V+lDmIZV7La3l6whEkpZHzQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WnJppTIGrK7qtQoOSDvaIEN12O7ivmHYNb+gq9zLHkxSrGoHWjLRjN8kdablo/nZ0U6NeNp8NKHjC4NftrI+vLYwuha5u6u24FSEqgmceLmMwyoCnrtdlH90fme7n1tvCLWtziT5lhscspXPboHpipqS93cu+dBv5wgWNJaoTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGJuvdkL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGJuvdkL"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e057ae54529so1804827276.2
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720716656; x=1721321456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msCm8CX+WX5GOxeP91DNZNWiX+pAPQ691iIHw2FfXrA=;
        b=rGJuvdkLoSyzZBYO2pPW3B5iqz/uQEJ54S1PryOsSodt4qp7GDJMoK6mMMMHXDl30r
         RBzNLscYbGOK9o3O5e3ptM83xsW1sFUca5QkNddyu9vg98yk9YgIIvfsHehKneTKtUVd
         4BB8rCKv6cXjO4Vh3CvwEhF5wq0cT4GW1XsPm/vLSD9G+PQ/6YULPrsTyrkFz1ykp4TP
         oB8nGldA0vnKu4fc09kLnhhPvS+vHUMvc6OLsk2KWda09mp+xWsFkueIQF6uKdrqMjf8
         0B2DC1gmIFh5lzokPKdxt95EwWH5amCxC/iMtjz/86kfdoXiZ+QhJ729Er2Kl+J8UISz
         9MrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716656; x=1721321456;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msCm8CX+WX5GOxeP91DNZNWiX+pAPQ691iIHw2FfXrA=;
        b=i738PZY4i2sgJsggkS7dpXldlwjh/L/FfNExbHbwq69UzYTZwqryUedpQXlJvNMjUu
         OgnhtH2Cq17kuUyHBjUdQx7cx9MjLBYlBKgnpAS9fnCDbH64WOYPoNAJx9UIBcO169F/
         R2lgOC14UrFrgZkaP1Tw7ivwiNt/+sV5EXbVM9mnXy6KfoQgQRITLlgOx0GMwl5nvO8X
         gBvqosXWyYQp2Ca6wD18xkh7b/kq1qY/a8zkPGvRaJTwjGw0ZRJMjMxJdODMpRvSsq+Y
         d4ADnZZeKNM2Bi1GGyZebbfcTyRkOZypVETI6C9ZkZAV5Bkvwi7QG7cuzTtK0Y2ABjz6
         dcBg==
X-Gm-Message-State: AOJu0YxLMT8XS8rj6Oxjx1SXpxq5mGXaICA+Kt6YovEg69jGTuwpknTg
	4qdTpm6ysDgNCjDFn2pxMypKVIaY+O+geSBSSrQXYUM4hhI3fwDgg+/eYfgz5HC6jBvs4/Ut3R0
	okA==
X-Google-Smtp-Source: AGHT+IHrSMEPVC5m0GewN6uYjbjYKXXFbVc1qhRmTgrwyTm32kQG5R9yRZkrBtT0ddWq5OqHApdqNt2WDTU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:2411:b0:e02:c739:367 with SMTP id
 3f1490d57ef6-e041b17ba7emr249159276.13.1720716656646; Thu, 11 Jul 2024
 09:50:56 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:50:54 +0200
In-Reply-To: <20240710.te8ceiPhav6e@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710120134.1926158-1-gnoack@google.com> <20240710.te8ceiPhav6e@digikod.net>
Message-ID: <ZpANbqlDVzFgaBZ8@google.com>
Subject: Re: [PATCH] landlock: Clarify documentation for struct landlock_ruleset_attr
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Matt Bobrowski <repnop@google.com>, 
	Alejandro Colomar <alx@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 04:15:47PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Wed, Jul 10, 2024 at 12:01:34PM +0000, G=C3=BCnther Noack wrote:
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > Cc: Alejandro Colomar <alx@kernel.org>
> > Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > Cc: linux-security-module@vger.kernel.org
> > ---
> >  include/uapi/linux/landlock.h | 42 ++++++++++++++++++-----------------
> >  1 file changed, 22 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landloc=
k.h
> > index 68625e728f43..6f1b05c6995b 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -12,30 +12,32 @@
> >  #include <linux/types.h>
> > =20
> >  /**
> > - * struct landlock_ruleset_attr - Ruleset definition
> > + * struct landlock_ruleset_attr - Ruleset definition.
> >   *
> > - * Argument of sys_landlock_create_ruleset().  This structure can grow=
 in
> > - * future versions.
> > + * @handled_access_fs: Bitmask of handled filesystem actions (cf. `Fil=
esystem flags`_)
> > + * @handled_access_net: Bitmask of handled network actions (cf. `Netwo=
rk flags`_)
>=20
> These @handled_* lines should be kept close the the related fields to
> ease maintenance and consistency.  It looks like the Sphinx rendering
> would be the same.

Done.


> > + * Argument of sys_landlock_create_ruleset().
> > + *
> > + * This struct defines a set of *handled access rights*, a set of acti=
ons on
> > + * different object types, which should be denied by default when the =
ruleset is
>=20
> > + * enacted.  Vice versa, access rights that are not specifically liste=
d here are
> > + * going to be allowed when the ruleset is enacted.
>=20
> They could still be denied because of other access controls or parent
> Landlock domains.

Done, reworded as

    Vice versa, access rights that are not specifically listed here are not
    going to be denied by this ruleset when it is enacted.

Now it's more technically correct, without having to add a lot more text.


> > + * One exception is the %LANDLOCK_ACCESS_FS_REFER access right, which =
is always
> > + * implicitly *handled*, even when its bit is not set in @handled_acce=
ss_fs.
>=20
> I wrote this sentence but I now think it might be confusing.
> LANDLOCK_ACCESS_FS_REFER couldn't be handled before it was introduced
> (with Linux 5.19).  I couldn't find a better way to explain it though.

I think the best description we have is in the "Filesystem flags" section
further down in this header file, where all the individual flags are explai=
ned.
I reworded it slightly and added a cross-reference to that section.

>=20
> > + * However, in order to add new rules with this access right, the bit =
must still
> > + * be set explicitly.
> > + *
> > + * The explicit listing of *handled access rights* is required for bac=
kwards
> > + * compatibility reasons.  In most use cases, processes that use Landl=
ock will
> > + * *handle* a wide range or all access rights that they know about at =
build
> > + * time.
>=20
> ...and that they tested with a kernel supporting all of them.

Added.

Thank you for the review!
=E2=80=94G=C3=BCnther
