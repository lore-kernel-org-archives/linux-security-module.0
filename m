Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8872931CD
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090721; cv=pass; b=Hl2QJ1h14clg8CuP5D0F+8du9U73uzYQfri9hjjtOCcPEOoVWBkqhVW0JKbYA5NGxjyfEC4p/Gr0BZsG/v/GLBVbbhpeUMm+Df2hJWiiqsmph5aH6QOmsa1UnB4ySrDdudRKk76IeoSvmy84K+9qk78gzxve6Jpbt/op3gLn9n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090721; c=relaxed/simple;
	bh=roce0OY2AFdV4vv7C8LtEaVkWRI7KxA7oxj+4gMsfkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJqQ6vr/j6IZTumAesr0tylYcQv5sE1GHL2+3R53tDR/XivUv3mRovAr9HcmcvlvZPCOLNQgl5GbZjxQQcrR+QIiBiXInl8s2dy+HgITHUUMCo+abI8FAI2EGhH0uVETUh9Qnecqud5mWi4g1B7Ny20iguEFd+z+dWy9UJ+I/yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QhfGUmg8; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QhfGUmg8"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2024309a91.2
        for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 11:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785090719; cv=none;
        d=google.com; s=arc-20260327;
        b=QYubU9uo8SutG0I+kW24G6/zhjUvkBRLF7AYnz8pHQwW1WXhm3DESyYM655gO4/4Om
         6R58lXnCOPrlPyHrcW/rfJGjv0s4qsTIZ9Bbn/mx6kUKyv6XYRn0QmUpBVC8F/EXnw2r
         FVdcXgcmQ15lC00K/7odXGR+he0zUsVTp2pzabEgacQ1MPLs6DuxTEkpzuNJj68mNEDk
         wk1F4ds4AJFiNm+S2bgXatG3jsggN4HZxDLeG3GeM+KfdOOgZce1huzf4dKNwua/E4JJ
         QhLrWcXnEo/yU/MvqP0d2suNLFxmHb0jfPwF+baKWrJopK2Ep1WPOU/oYB8m3fZtd0IR
         Ut1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=roce0OY2AFdV4vv7C8LtEaVkWRI7KxA7oxj+4gMsfkI=;
        fh=Ur9TO/OX2oKW4kZXNHfYJVWZdWLt7fpHIgSEs3kQ8Lk=;
        b=nHAIqbEqXeGRz9lvmkz9CK0EsXRChIvFZuBzDU/cSVQ6+vt6NMLnWMojsRDOvQIRnU
         wHw4QAHLD7QQUYZajvtwk/784LMrJ8s+uZe9J6QTmVDxmwAuNaFEZXjNKWjcF/LLqI5/
         jv+/sCGvOYEEgctwOumywbkI5nDuDsTqbAbWycfP16Fo6sOPE5sS6StXeoOXZg//ompn
         73LOi+orxoIiPT4u8KWq5OMsNS/B5Hq94fba2T4X2uTP+GcInEAQ2c6A+kBz7/VEaL00
         JYCv2z8/w2QNq8/vpdvp2+//2RDGIKnhXfTW+oWZILWp51c8b7AlqR+3SNSJGHWDB2iT
         3wlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785090719; x=1785695519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=roce0OY2AFdV4vv7C8LtEaVkWRI7KxA7oxj+4gMsfkI=;
        b=QhfGUmg8I3rPtrSgegmXPOrMxtuAM90LL69pxeCzyvkBgck0+1CIwlPfdQHYcbZ2n7
         NPZsjgWQ6YIJ3a66AZwCZOsQxMqeRTRXTHQK1biARWYSZNJcyWkbXmpYgAlOo/g29vVP
         mt1Yod1Yz6tz2WMced4Q0CCH50v/IAkyDmcoMdNbo0s6bBOY+9ojymv6H8OE/eZomFIW
         098l+4Alxb4NQhFezisDdjNi6PVu+bMrbm2b8IXziiln2JRPF+JwyOYNZBUmz2UP3uwi
         zs/OtRZuudl7wXU36cUtnxA92rzSkZvJZp/BDJLIxFjaU+52CHkksN3Fue8zp+XHHSVA
         0mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090719; x=1785695519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roce0OY2AFdV4vv7C8LtEaVkWRI7KxA7oxj+4gMsfkI=;
        b=YKoaDILgAtLr02Ek7gS11iKmzyuJ2U6LkQ1jwxzeOmhoA+Jpjhlv/VbPQ8PdKTGh8K
         w/Nc1w2TGvjBZlqnKJ0ypmegDMhSK3lxpQQ7Zp7QloPQ2JpHsX84Y8mCXKXtM1xbbEkt
         Yfo7aOZCR/EmCgWegEZrDEIcDeFKRGsub+zz06aCSSZaGfKE/4pKSckyhDRifJqfCOz2
         sICXhbawO20A0DMEcyU+rbfuxP1niB1M1BDjJSb003bGvfYuu+tfh+oUMXmYHR8CmHEx
         fTgrlzc5eoGA/2GpX6r92AynmXmlnlUEgjjx38Vfl0vYKLkp+TRYvHZqjC+eKv02D1vL
         hFMA==
X-Forwarded-Encrypted: i=1; AHgh+RqrSYf3tmd1/HZGlU8Ezi4UVIQUZGDScHGPgz5FBI50ajkNGdJbeFqXD1OWE8u76/R6i6jGzCjs5KkRJZGCeQnD0PrGckA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03zx4k0T8by1V5XxUUzbXyhq93lY5uSKTTniBnJ88g+F8P9rt
	Jk+KS/rTtycDMFaNc0h2ONhS5Y3Z6QjNZTGRqRCqPNVvsolJAOwz8erFko8KcV9k7M24PCPBr2h
	kVrC3UT0FqxmUqJtOyn48PEmZQaeen0t/9KnUjmBQccROYeOuGatQQJGU
X-Gm-Gg: AR+sD10bACpMwwmre0FjP6tQb579j/b9ClKpNKLrZ+7jl+q0p4XdqSJV1rdzQLWeG6L
	MmJNRcN781rxMCd+fZbzJAbYg48ehyJx10xAG7CWNipPtWNefcBa1PKAlgBuPN2sltkB9lD22iu
	yrcxisLF/g9ca+zRVpO5tdx1fmKkFKanGvVE/8LTJa338h7/mX+KTXfpJNSn+rZFuzC94C0YJnm
	WP0hYQQCsSH4LzbgNbwyKS8u62lPR7BpBSjlQclW9CGyruQQIVybKzYWShC3Yz3p3vc/RvP
X-Received: by 2002:a17:90b:5443:b0:384:5dbc:cba5 with SMTP id
 98e67ed59e1d1-38f2961134amr5446040a91.26.1785090719086; Sun, 26 Jul 2026
 11:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260725200958.4471-1-cel@kernel.org> <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
In-Reply-To: <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 26 Jul 2026 14:31:47 -0400
X-Gm-Features: AUfX_mz4s5ELv8nSMCfCIDeYTuebpIuEr3Rnq7Fv6nbadAxzkUffEPG3Vn49cbc
Message-ID: <CAHC9VhSh=fXCcDG88m0Qbt61aKajx=cHGQXX7DbyiQtkJRtKYQ@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Chuck Lever <cel@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Anna Schumaker <anna@kernel.org>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 11:03=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> While I don't suspect it will be very interesting, I just started
> building a test kernel with Achilles's patch that I'll run through the
> normal selinux-testsuite automated testing.

Not that I was expecting this to be a good test, but FWIW, the
selinux-testsuite (and audit-testsuite for that matter) ran clean with
Achilles's patch.

--=20
paul-moore.com
