Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F03A7F58
	for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908608; cv=pass; b=VyDEG2CWOPMLxoTbwUtcxbPjGjV9EtgAz2ywFSRyFxbZynMIP7vsaqZg+QoGa65+jfoxRBfNufQLDFGWjJLf/K+9fRiZkeCRFcftiKzuxb6nW5OoNuaXRZMekSSTUhhp6pkvajE+IM7d6x412lo7iI7mf4k7zVe9tCOrX+ermrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908608; c=relaxed/simple;
	bh=l+d+824D0TVlC1tm/EyppYDUfEbpFuoakJjTbRH9PUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtTCOYurPoWNVHWURepxLfeHQHfSY0+UQ4IN4h1lbYkRYXprqev4zN72EpYsnWE5DzQJkMn0MHMETljHBmhqueH/ozFORniw8HziswlO7FVIdZmTIcLB5pZv++EdL/iJeibFdhCWjwMYEuiC70DrDPzEPGMJZvqYt3tmV6ULuH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAWwU6ia; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAWwU6ia"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso7291466b.0
        for <linux-security-module@vger.kernel.org>; Thu, 19 Mar 2026 01:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773908606; cv=none;
        d=google.com; s=arc-20240605;
        b=YReAVoyRpsbMxOVn+ym01TTplH/vosHsV889fzrd7/zdAZxGqUBhsy674xIec+9OlM
         H/gvvB4Rd3xXw3rGXdBFe6VhEVviXLntn3QaqHz7Oov7Q8sfdwOeOcnAnR9MmdiDGJBq
         PJUz6VOeqstB6P/scmi3KCS2r3XWIy2m5RTUtjtPGzJOrjtH/LTBdXPEf8aBmWlks+Tp
         qb6RPiB1V8YkVT8WCKHZDIU4VankWoQPEijDfQJmDybEiSkZfL6BfQeN98iwxxZxlCSF
         5mwdKgPWF6EjaS7GdfS8wo2tL+XTnjecCkZ+3wF3cdRe4GHCii/6BRH74k2bZ17+uwpl
         b4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bjUr6MGV3U2zzmMZUFw98rgTx4QpGsGZjMQDA4j0k88=;
        fh=sM+AmZ/EVgI4vvHEqluDJeP76eNtLr9PSYhxEk8wOl8=;
        b=S8vW7pJNTfkcEhCRux0RPLiIIfJ0i+BcmwSjWoNpYs9aBatN4/Xq5Mpn5wrHg+6TVh
         Vswqe33IJ/G08gmGa5J019O+s937ONB3WnWFZJpAoA9DrfS43uzmNfoAPHkkqd91dhN8
         fgDp3dAaGkyP73uRRUuwTTQBG1M2UK2PvU+hU/z1+2GwsA+UfD7YwdGdqcUpcfZ7lTtp
         x1bFwHiLkYLEZwe7PcKb8VseOyILmH9g859mPAv6hUvPwR/hfs9W0awWS9VS5lLa44Fn
         68Fj1q/4jCEC+xjWxq4PTB3SIM0vl4VSrWWYnY9JGoqeeAayJ2uoJOlVNo9jSvw++CAq
         Dw3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773908606; x=1774513406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjUr6MGV3U2zzmMZUFw98rgTx4QpGsGZjMQDA4j0k88=;
        b=aAWwU6iaF9o7bGaLOzYpuTs5BHtXbRQ0dQNb1WnEhFph/kuyAEiNQO35gw07gF9r+/
         CqtLNZuHGdMUBkeUeGeT79GnVIgwgu+LhYzafngbrSowGyhRlEdwAZ+Uv3oC9ioKagEw
         28PEcvmsHW2OJ7I/LHdUFW+blZ1hjs+4pCHafpuKIaLJq69X0gjPK8/OCFB0ewp/7SBg
         tVydKZfmBFBhlluY/ARhAh/w4Nqmv2g3FjcA3I27PajHzx9TSu1Etz+s0UQxxnQXli3q
         jZ50yKkneaROUWU0nFyX6tcs+i/kNuIofNm3qUB9vI6tFSe4aQHhf3UNV2t6TS2YkaHJ
         ALgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773908606; x=1774513406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjUr6MGV3U2zzmMZUFw98rgTx4QpGsGZjMQDA4j0k88=;
        b=lI1ugsNu8lIqlZ6DddT021d6wg4RM4jwZyHSlH7iNoHN7p1J1U2rchfbHn6gkwJTkt
         omsY9pMJhUTu0iXSAKc1NrMyJLcuN6SJnrnGhgyfZ7Vt5w06smpvMFBkJTAR2drnZDxI
         jUNeXu4wzA/6qlVqw8WBBXErGqDA0LS9mccK9RekRVu6WDD/dgIFM+QnQLpme+gBeBR+
         BhI+SHVogFUcdTc9gyMEj1Pzsbisc/4f21hS7um7ZjpbXVB1IC+ayV2VctEUgyiJ/GeG
         Zx1IvpB3gLMnt/a5VX//AQ77l2u4AeJgC5r7IlTjGzcd216lK8ofFC/fjEVdPR6wCSDF
         57qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYMK5OK6DTL/TDFxYZERAqdh7VhJHjG8Oi4jz9QMW4M63/p6AodqMPLvGzwgM13WtpyL5zYN6bl7IjAXDL9+fhGPDOz0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPdobnNPZ0IENCvgQzDt3CwWvR/0Heki6WhWaww9Dxzot5J2B
	4teEDXGiDqLKT39dFGh1HByNgRUku+j9CkMNiazD4VaRIARPNzu9LUkox1ussNdHSCjUteMPr06
	mvsS8hxFeeAlwX+uAFenhJ0FvBp4x+v0=
X-Gm-Gg: ATEYQzx6UJOBRTmTjZzFLkUrIyNBrIPFUwOrcmYdQdSgtuoB/nJZhESYReqkLL2Sj6j
	OVUR+welnHOVMZMABOBMLKiJty5MHt8DYCKhYCppL+acLjJKB3cnmZTgFr/5cIKRiSGuUT++EFP
	Et4TrzNeTy/903MvngTfVDUoueHak/qknsEbJd4vGC0Rgf04wTlwFLrTINW2Cv/0CEqHQAmgl20
	wHUdEP7kbYMKTUs7YDf7pwflyF/evD1MLPUNrEi9xCLpGYKGqAXu4tmsgYhOaQCPk+mrQiMEcfY
	LhB9
X-Received: by 2002:a17:907:e11c:b0:b97:73ae:e2e with SMTP id
 a640c23a62f3a-b980f9e248amr87553266b.18.1773908605574; Thu, 19 Mar 2026
 01:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210172159.535137-1-mpellizzer.dev@gmail.com> <779f2d5b-a5af-4137-a1ee-78dc9fed58e1@canonical.com>
In-Reply-To: <779f2d5b-a5af-4137-a1ee-78dc9fed58e1@canonical.com>
From: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Date: Thu, 19 Mar 2026 09:23:14 +0100
X-Gm-Features: AaiRm504G9ed9x5jw35d17aQJhgfrKxgvqcsFzi0qAVz3Org6Ozme7GafH5FEhk
Message-ID: <CALUEkOc7n60MdBpA_hF5Uvhwxs+ABjn=fWrzUg1s95p8wAgWWg@mail.gmail.com>
Subject: Re: [apparmor][PATCH] apparmor: fix incorrect success return value in unpack_tag_headers()
To: John Johansen <john.johansen@canonical.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 6:53=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 2/10/26 09:21, Massimiliano Pellizzer wrote:
> > unpack_tag_headers() returns `true` (1) on success instead of 0.
> > Since it's caller unpack_tags() checks the return value with
> > `if (error)`, a non-zero success value is incorrectly treated as
> > a failure, causing tag header unpacking to always even if the data
> > is well-formed.
> >
> > Change the success return in unpack_tag_headers() from `true` to 0.
> >
> > Fixes: 3d28e2397af7 ("apparmor: add support loading per permission tagg=
ing")
> > Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
>
> sorry, my reply to this seems to have failed. This was pulled in for the
> 7.0 PR
>
> Acked-by: John Johansen <john.johansen@canonical.com>
>
>
> > ---
> >   security/apparmor/policy_unpack.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/poli=
cy_unpack.c
> > index dc908e1f5a88..221208788025 100644
> > --- a/security/apparmor/policy_unpack.c
> > +++ b/security/apparmor/policy_unpack.c
> > @@ -825,7 +825,7 @@ static int unpack_tag_headers(struct aa_ext *e, str=
uct aa_tags_struct *tags)
> >       tags->hdrs.size =3D size;
> >       tags->hdrs.table =3D hdrs;
> >       AA_DEBUG(DEBUG_UNPACK, "headers %ld size %d", (long) hdrs, size);
> > -     return true;
> > +     return 0;
> >
> >   fail:
> >       kfree_sensitive(hdrs);
>

Hello JJ,
I don't see this patch being part of v7.0-rc4:
$ git --no-pager log --grep "apparmor: fix incorrect success return
value in unpack"

I don't see the change applied to the apparmor-next branch either
(https://gitlab.com/apparmor/apparmor-kernel/-/blob/apparmor-next/security/=
apparmor/policy_unpack.c).

---
Massimiliano Pellizzer
