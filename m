Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C3369D7A
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369750; cv=pass; b=HgErhTS4PYoPXd40SAXHRJBQIM1aYIyw5wFOX8ZVKodtlP7jDU10/nq09Ia5Aq4RsY1iwIdEv3yAGREE3RG9ATuaf5u/ueUxaBQhsYZifSLr62AYgT91+1ni2JA/3dXjqEiH7JEzymeOnue9xyerGXF6hQNNgJ+OxqNwn+GuOwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369750; c=relaxed/simple;
	bh=RkU/12cK7hYiqOuf8ggxFTWQjPB1bnSQT0ROuSD4Kf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6ftFY3dHpL1+LHUIHoprWLt9UmsULDCHePf3ulWNBUhRShSeCg2AzWW6k6kB8epiWIjuaXYMetCTiWe4p/XOs9fixjzes4J7uQ2JsZOYeeGbJfbMkGtRX53CqOBEbBaF36exXfCylm19qGE8SM3TLF4ZNwnSGsR3wRq9xZzftA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PC/9yDxT; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PC/9yDxT"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso1199430a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 20:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780369749; cv=none;
        d=google.com; s=arc-20240605;
        b=AR0YzWnkJgab95f+VHzy2z/JpL9hu4TWrSkgOIUcLmtPfavU1QZ46mtB44UoTdjAUz
         xuAGGzQDe7VXEvNsvT9J0Me2SH2w6DV3U1LCFTWpoobQDprik8Yy4LSac0C+csV0yk8O
         NMGF0MjYACdXKdH/nR9F3fO6Ejfx7v1Y+voKG49FEXP/FNpmHZ6lZahiC+Hiq0tarIXk
         Uz+73GD/dccYp80BNVU816tOnM5G6uVHaTXoSb3i9x2Y8osM8OjbAKA3W/1AkxptVISi
         aKRxk0RT0A8FowvBfRRGtmrCZqeckAhLXriq+vnamVUakOxgrQv31bFkZ360hydoA6mG
         vA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Bq3RePJEw0dpHZjElKcKomidBiHV5J9wG+oOvXOgVU=;
        fh=5Sx3Ob+7bioEZI44DoUeUev7NmwFQy4p1h+e3NgLHXA=;
        b=JhBIyVPE3+1mpmZva0ifQ6U1DqbAvQJsCkmzMMovBc+Sf9GBH9JGD5lOysz/rC6xEB
         HbRnVmO/Vmcxfm7Uu9/ocUz9okcGUJOHoZwAZ2BM5wgsrDJFsILzzYFkD/FzG1rz/WBJ
         3I2chsng40b82kGQgAH+4FitojE/DwavX53KQeapRCr5IapDF28FryRsli2ShFGcChVy
         zCf7oB4q+zaXj30a/yiabF7o2A8gAodDggFZId0JEC69faQyDXGR7SMv44H/wuUlf17W
         DvmA/Q91Y0RiLYwwDsd/qHvUzgc3HqZ7UY+xU5HCxF9HNir+y9JzTWSiNc/+a4TWkhVh
         hUyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780369749; x=1780974549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bq3RePJEw0dpHZjElKcKomidBiHV5J9wG+oOvXOgVU=;
        b=PC/9yDxT9uG1vJcmaE13mmksx20463uGtNe9DCC5czF6uBiEFtWu7nguJjwjerYP/v
         zDF/t8KqsepujcLulAjrFyajSaCigKXcrNkqBzsh/9XnWqlSMbVkaOr4SXchvtSlYKZj
         mf820gdjqWUVpracIkEFbbo2tHNUUWIrb1YexlPflEiC+sLU/u82WM27az3j1dT1j4Bp
         7AeXPidtPC/zl2PDKu1tYE6V1xe+t63VtkpGdlQN7/cAAH5OmGvJz2yd3dxihjzvMbYk
         7fNv9/pO/Hdbon4eVsL2OybQbX4j7j3Scl8XKqaid3CcZcglUqAGgNG8DjOY3F31uc+m
         2ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780369749; x=1780974549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Bq3RePJEw0dpHZjElKcKomidBiHV5J9wG+oOvXOgVU=;
        b=hsqbylPQpkMpYn0eh4KgMFR5UxbEdlejF1F7ieJn/iactDTg5tBdiTIBKRP9SGH6LN
         P+kg0LlxtFPjon+GbJ/QjQ6W2p/7LH6gkIgVf+Cz6EGGtTTd3LQC0TAt4P7xXMFYL19f
         EKy3SHeUWnMiLBtHJxKTlrmYN8nqc+EMm3pSfOnpEb2M0PibHonPh5Mfva+TQUPDe8+G
         feWA+bKBGRRzLgfVmyJuI+nRLwM3k5wcpAq9P9xX756XZmRgB84ZQBvYbTkc0bdVIw2T
         LNSTdQzqE2ADlfSr11oKhfLvILoxw2KO7u6DEAV1kAfTQeDMb+SwhLojqFOq6GNexjBR
         734A==
X-Forwarded-Encrypted: i=1; AFNElJ/BNW/4hkCQx9cHrN7CjB8qm/pzn1XHHaxAPH67s8e4s6gSLDJKaJC75fh3kt2G40zV6U/gsNgKXAVtNm7NrAhPW3zqPzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLfwyv27oGKr49GbLRo05d61yiCdOS3ZuOc5e5F+DJj6+O2Fuu
	jFoqiHcbbdyseh5qsDrG4ShX78M5YqHvbFdSCIXCj62U9meHr/YuqFEq0URhGsUibp8kEHay3FG
	wEvfaxiNRD7XvHwA5EFccnZswIGVTWEaVqz/8/jl1
X-Gm-Gg: Acq92OEp1avTGCrYc+WjEpYjziZiWc9kVIRWaqDTRlWg04aJaua4Vwg+W60pwzT54C7
	CqLOsgv3PWnRrPzGhuMS71qwfwrX2qcREhSlPT965SuH/8EaMOf/PLoQqMbz2Mx/Apem+GtsTAD
	tBfn1SB45tmgLYiqlwHCHlY24/RajNBPvcc3atWH3z1ayu1+DHRlH2lB2iKi+Bks3dmfxVjquPc
	8fMGp9S+VZUWvtxKA+P/OU/OTdnDk0pGoWj2cqUu0W76auszLpGU9o5pBJaSnXBAQZxmNnJSa8j
	2Hz6tI9mPC2KMSbs8FCdpDbWfTZV
X-Received: by 2002:a17:902:e5d0:b0:2c0:ccdb:e029 with SMTP id
 d9443c01a7336-2c0ccdbe566mr94480965ad.18.1780369748980; Mon, 01 Jun 2026
 20:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528015913.190970-1-zhaochenguang@kylinos.cn> <20260601193805.011c7f15@kernel.org>
In-Reply-To: <20260601193805.011c7f15@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 23:08:57 -0400
X-Gm-Features: AVHnY4KozWy30zJsbUGGCJ6Tse9WWG7WuffD_wxHtYQhSWLL5KLDic58pOgX3Q4
Message-ID: <CAHC9VhTwu5vQf+RHutS4Wwb4ApBcwMXDXEKZg1EOL16jv3jNrA@mail.gmail.com>
Subject: Re: [PATCH net v2] netlabel: validate unlabeled mask attribute length
To: Jakub Kicinski <kuba@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 10:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Thu, 28 May 2026 09:59:13 +0800 Chenguang Zhao wrote:
> > netlbl_unlabel_addrinfo_get() checked the address length
> > but allowed shorter mask attributes to pass through to
> > fixed-size address reads.
> >
> > netlbl_unlabel_addrinfo_get() only rejected a mask
> > length mismatch when the address attribute length
> > was also invalid.  A crafted Generic Netlink request
> > could therefore provide a valid IPv4/IPv6 address
> > attribute with a shorter mask attribute.
> >
> > NLA_BINARY policy lengths are maximum lengths,
> > not exact lengths, so the short mask can pass
> > policy validation.  The mask is later read as
> > a full struct in_addr or struct in6_addr.
> > Require both address and mask attributes to
> > have the exact expected size.
>
> Sorry, didn't look at this until Paul responded.
>
> NLA_BINARY does _default_ to maximum lengths.
> But you can use NLA_POLICY_EXACT_LEN() to have the policy do the right
> thing. Using the policy is preferred - less code, and policy
> introspection informs user space about the expectations.

Thanks, I didn't know NLA_POLICY_EXACT_LEN() existed, and yes, I
agree, that would be a much better way to solve this problem.

--=20
paul-moore.com
