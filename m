Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A562D540E
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749600709; cv=none; b=Iv4bZs78h+hI7tbaDxHblRkNfwegJt3BdsnRj085Jm0TJfhnObvg+BAPKuihXKDQlYk4LJG2vwlYPhqUYFY0SUDE56S2QxJgVu00FxTD7nC9iFyU/L0E5bXrS94mxizy0jz5nzW2kpY+G6tI85lMr7PcrhqWAsxipy0vJROj5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749600709; c=relaxed/simple;
	bh=cj/TB8IJfgmovr79zvSzDH6q2PFAixnmiawHxTW+SVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inhJONWNgqHuPRGVaRNygQn5P85qDX4DqcU8yGDTO1ewliYDkp6spYAm5Wd00F65vaP2r3zzfnnBu7VSY2u7+t7vwCve7eyyB0XqP6Is6YKDLVVYmjbtgeycBemo4y0lRDjWlp9luS4hqjceh2P6yogPat+4qQSvuU+tKEUO/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fyT5b+sy; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fyT5b+sy"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e64b430daso58890737b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749600705; x=1750205505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTNFlvLY9XcN/1e9H3K1aEwcxHyhCPksvLP3kPUIgwo=;
        b=fyT5b+syd1WnQ4zK4NTIkZsICzfkKcgUM44nat21YxsUJqiom8uD1vr4XiifAxUV0q
         RmTfSkSPYpZlB8h6ipE6qhFvgQHinza3Q1dUx492AyfMB3Pc+3vZLIYV05AwoG85eTFu
         1IPitp9JWrUNPJHxssCm16jIFzrtNOF97GYe5SlsipK6lUEFUaSLIyN8Rj4pinDo4byH
         bK+gyDywYRTxCYL1pomCC6Cx787yJ71JVaFzaSHC2L3ojeSANErViUVjeKJhgUIWSq6i
         5xBP0c9MTn1eEKdxQd4ojeBHl6pha+IY5hfSqWQWEVMdlMVh31CpMNCMhDWnNQCIjCPL
         3Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749600705; x=1750205505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTNFlvLY9XcN/1e9H3K1aEwcxHyhCPksvLP3kPUIgwo=;
        b=tvxHCMAZ2JTEYdDPB+Ju/DQh6Hvy4UluMh+OJMNh26WPj4oCXR0F2LFUGo9m0rf0Wt
         AQzZqMbuZVKmmt86hcw463/M79bN/Obm0A46N9b8xbNjuEtCn+WvlhW9pNTqFTmlpJHr
         VNHsnYBQg4KDJHIW2F7q1Eo9aIke3KN3AdUHwgQTyaCssss4g1yC/C1mjlK98AMHUbWy
         sRDzHGYg00vGj9izcjvCvHXOb9ADJdpzsuPjGLc8PPUuq170mzu0Iizj1dV5IvUtyprr
         co3004Td5XAq07GygWw1skK8IwHyILEWcLnXHYFbiu9zQknmUmRI4EXFVReHErL/4Uxg
         0EmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTRnHA6u+0lfW1uts+M6PAHTJ1wyUlmlOCdBEDucJnyO+cJ1d96ty5m62/K7q0K127lkP4Dc610b7MKNt89Vx5tKHEZQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzirlK6AbEEXp49Lemf7B0sPT14SQSjW7VfxZxQfDN6sp74x3yp
	vgEKih5bL3RW1ZUCrMUJ+bLRM1CMIsRgsQ+6oJfvw0cnbFZdAWOQSy19q9ihPlGViYTkLaQXzVB
	vaURJX+w8/uh8Gej6qb5qdIjoZGQTcWblA+T3PEkr
X-Gm-Gg: ASbGncvgCoOiO66jDGe8W+0vBSPS4rrOVoTGDyHKzFbQI8WoMgLC9lFzQBNZyTZHc+B
	R3Xmg7E9z6CUQfpmThSiRmbDSo1X2yzBINsKyh3hvmi3y0ODW2Gjva8/erl9wLDLwd4F8KNeo9R
	sdUty/X47NeLRETNGnDlsmC7xteJ+YxeUIGCvdrgir7nZnIUut0LvhxA==
X-Google-Smtp-Source: AGHT+IHJpryBz087Hiek3F7YEEbo2hUvIsnp+TlzUinqvyS0w+4M62RLd09ZXrMTZDOs1OictzRnHh8KcD2pYg8fbK0=
X-Received: by 2002:a05:690c:688f:b0:70e:7ae4:5a3e with SMTP id
 00721157ae682-711409ea39cmr25472137b3.11.1749600705629; Tue, 10 Jun 2025
 17:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515092402.14564-1-kalevi@kolttonen.fi> <947cf99e-41c4-4c95-8f08-b35a76246593@schaufler-ca.com>
In-Reply-To: <947cf99e-41c4-4c95-8f08-b35a76246593@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Jun 2025 20:11:34 -0400
X-Gm-Features: AX0GCFvuAW_AdsLM01-r00v9OCT0wudB2v-L65-gPhX_zVNEi7iaRwCzryhDE9I
Message-ID: <CAHC9VhQ=FPvOo9L=cG_AvBpZTkOe10gXFii6YY7RVCD=rtAiQA@mail.gmail.com>
Subject: Re: [PATCH] Fix variable type to be 'bool' instead of incorrect 'int'.
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 10:24=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 5/15/2025 2:24 AM, Kalevi Kolttonen wrote:
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> This needs to be sent to the LSM list: linux-security-module@vger.kernel.=
org
>
> There is a major rework of the LSM initialization process. You may want t=
o
> base future patches on that.
>
> https://lore.kernel.org/linux-security-module/20250409185019.238841-31-pa=
ul@paul-moore.com/

Yes, in light of that patchset I'm not sure this is something we want
to bother with right now.

> > ---
> >  security/security.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index fb57e8fddd91..02336de43ba9 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -288,7 +288,7 @@ static void __init lsm_set_blob_sizes(struct lsm_bl=
ob_sizes *needed)
> >  /* Prepare LSM for initialization. */
> >  static void __init prepare_lsm(struct lsm_info *lsm)
> >  {
> > -     int enabled =3D lsm_allowed(lsm);
> > +     bool enabled =3D lsm_allowed(lsm);
> >
> >       /* Record enablement (to handle any following exclusive LSMs). */
> >       set_enabled(lsm, enabled);

--=20
paul-moore.com
