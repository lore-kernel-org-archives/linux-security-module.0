Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1094339D3D9
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jun 2026 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218616; cv=pass; b=GudPShsGG9Dv5gx+2GJp0gBSEOV5Sj0cicZTPCzcLINOrzGBGC4nWwYkuyGaG9OFP+us/x6Z8DBPFZ7SbIoPmx9WTBZUY2li6OmCxrp1I1lz1OQufcQMScGy9RVZX5MEfRvu3lIjybD/TJb6/XpmZ+831q5VnoHPm1ZM4dKQ+qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218616; c=relaxed/simple;
	bh=80IYC70Oqf5mkhaHEMZbvU5upw4Wm2QTz2Iwsnv8oa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAiCKHtTjgfGE85iDWwXKgZqjCCdy/b+0mr3wehjOYk9ylnzK2le1nTh9PIZqCmgRNDVcFO8p5M4ukES6N2T+7J+SZuB2C1etYHD/pF+/0Xb6W2TnLkrIYYiSrZT9lokYkJr/udYjpWdAJ6bPXJCn2M4EyYlk6XyrTNGci7MrEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Uvf95QhK; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Uvf95QhK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf18c30bb2so3187685ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jun 2026 15:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218613; cv=none;
        d=google.com; s=arc-20240605;
        b=gu/Q/ymJyfEMNZ/VMgtBlRIJilBGHSxp4gi9liuO4xMk0Sm4ofTUJn2J6kCe4uO3Xy
         hcf0kOVjykIY+9oUVwFHb5s/Jid//VMqr0wAQny+FMZZgUOH3iOZM0oYDWLD4u3CW9qz
         MctyU7Q/mMarup13o8Tt12D9DbCtFnMMQB3l0N+0FDzUsAHF5qRTSx+b5rAaYHcvucch
         Xc6tlLi8tEJCssL0rjSZ1ZqF5bskbe05Ftcg0EapfH53+d0bttS5xi0Es6O3I7J9j1Ng
         CVNE5dUWgpwIFKdeJ1OllkIw1WJDBO5H9R13KSy89t5VDDPtZ587TwdQ935z7PWMH1od
         pOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGYX8yE3GouSmB36dE4d3FWlMSjRjKMWRg/5nxp8fB8=;
        fh=0400/Wn07BzaZZuHmIJldEQ4lIMPPOlFyhpg6dMP+Bg=;
        b=DnQ3NnEgIiMxQk9IhJm6TiMD4nsrM30YBctcHNbGkjGvsIly3kKV1XQrECMnMwfRP7
         tO0gIIcqdlxs9gzkn5ejKLTn6h4DdBUgwX09QNaFLrYUEA9WmfsUQSm290sXcCa7nWUY
         jGzXyPQ38k4tNQpGmGlJt7SHEKiQHXqWMpysO6ACjCQ4sXh47ru+EYJv0bpTDx4mDFOL
         45Z+3DlOn1wtc+OmrNfMeXf61aFZkoIlcFY19mRB8cprZseI+1IQ6b1tRt3RMX5Jolxl
         9WRlLLvCdh1Nky+nzfUKPpUAvh2c9Y6G57QvzoCIukB0o2UanPI0SbZ+coppfpXPNtVH
         YrbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781218613; x=1781823413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGYX8yE3GouSmB36dE4d3FWlMSjRjKMWRg/5nxp8fB8=;
        b=Uvf95QhKe8gsE507vXK4mzeblnXg7tk9VfD49UfRShWQGtWCXXjk054NlyEz4g4FSs
         FSAU2N7j9bswIIDgbxyjpQmtoJBjXDUeCQ+MBmN8AIqBBoqPTVbY4h+a+tBEDjaqGBhH
         lGyGIy2ugrZx+hoqee+0a9Oy6781Kscl9DECIaTEKivo9FCDgrry6rA3wO2etmUP8rEx
         J2VNKhZ8HKzijzndbQnZtS5GjKrQtCYHPtv8W0QoyuK41yE9z4QYFsJHmCohs6vgyXdc
         e9okEfh6U6Gq29IOISlSSzL33GgzIPy3PDkcnMMwTVdcNi6pLKA/S/k6Jgn4K3/xg8V1
         tPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218613; x=1781823413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGYX8yE3GouSmB36dE4d3FWlMSjRjKMWRg/5nxp8fB8=;
        b=eVezaxZuY90Z3VtT7nnCneVTiyciSmBVhv05zQ635m8XgEN7hcJuOzXFRPjrusKVLd
         FPEmXJa79lbrAULhnmB4d4r2znAojv6zDd+UApqzXw84KKQF3DMSnydBzu7ZYo1CmEhA
         YaEoJX0RcK5UqFeZ10cJPjoBzgvWU/hOeCTBcr3Bh78vFNCGp2wtgjQlPxynrlrdFcPL
         Q3joXinYKS/gFmwT2MIhVwmhJxoX47yW847FMEpeDcd2CNbMYjFqxj1KvK3A0xMlJYIx
         eJn1FPmLlfNDRNQy0f9O0ld+Xa1k/ka6St/UDyL/MsjWFAxu+IMUKgXSaqw4xUX1BZ71
         07Mw==
X-Forwarded-Encrypted: i=1; AFNElJ8ZE6zPKiU5zbWLDpa5J/499Xap8ZgidiI0JnLUEn+sgri7+oNlEA58x5HQMOStG7rVDSig191GrUbc700IGuXkFvw6BjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFpQ1U44ASOTwDohHuzp1H92sGdQBg8fB0yWaxk4BV5CJaIWSY
	9+DNtgKGeta4XGLkbEXgPNUmJHWUTR4RvbSl4tyglZ1UmzVMokX+8UpRHOgeZfHMHxeeL6V0WKr
	jbXTaCipFUEzX95C3PdsgriD2yHuMuokn814RzEUZwriZ8hHz/eHYeA==
X-Gm-Gg: Acq92OE4/ZWyT2iJ3Gnc86ZcGnWTZ8ZBfi96HR1GZjFFbTU1Vn6PfmRxnY3BY3RaG9t
	8XIvHd0o943NWDZCYOIJbhGuENpGGXlHhOwubN33wek7YswqrhRxSalGWLjzjxdhyVoJCNrh38+
	uszWQdITqmSJGEve5mO1A0srQwTL5Eyqt+iXO/jFgpIBOytcrlQmH/Amr10KAfqnZ0LjnGfTkIe
	No748tLEq0Gn/gvqUBR5wchD7/PCa+JqgLU65QDL27W5PjTDosBsB9Lthj0OUMtI6+IPBZgjx0+
	F5Rt+Ko=
X-Received: by 2002:a17:903:1b23:b0:2c0:b19b:ef0d with SMTP id
 d9443c01a7336-2c41255f24bmr4235855ad.19.1781218613229; Thu, 11 Jun 2026
 15:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230329.727075-1-daniel@iogearbox.net>
In-Reply-To: <20260610230329.727075-1-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jun 2026 18:56:40 -0400
X-Gm-Features: AVVi8Ce4dPShB80KHWBIUCrtea8Uet8pr9jdlDCau5GkiPWMBa1JwKrUn85Nfmg
Message-ID: <CAHC9VhTA7tOp16wGzb1QYnkJsVz1X3oNcmT6bb_9334=B2smEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Verify BPF signed loader at load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 7:03=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> The BPF signing scheme signs a light skeleton's loader program and lets
> the loader vouch for everything else: bpftool bakes the SHA256 of the
> metadata map into the loader's instructions, signs the instructions, and
> the loader compares the (frozen, exclusive) map against that hash from
> within BPF once it runs. The construction is sound as a trusted hash
> chain, but the kernel itself never attests the metadata, and that split
> has been the recurring objection from the LSM / integrity side since the
> scheme was proposed.
>
> This proposal closes both gaps by having the kernel verify the metadata
> at BPF_PROG_LOAD time, before the LSM admission hook and before the
> verifier, /without/ growing the UAPI. A signed loader binds its metadata
> map(s) through the existing fd_array/fd_array_cnt, and exclusive maps
> are already bound to the loader's digest via excl_prog_hash. When a
> signature is present, the kernel collects the exclusive maps from the
> fd_array and appends their frozen contents to the instructions before
> PKCS#7 verification, so the signature covers ...
>
>     insns || metadata_0 || metadata_1 || [...]
>
> ... in fd_array order. The in-loader hash check is dropped from the
> gen_loader entirely: generated loaders carry no verification logic
> anymore, and signing or verifying a skeleton becomes an ordinary CMS
> operation over bytes that sit verbatim in the skeleton, reproducible
> offline. A signed program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED
> with nothing in between.

I'll be honest and say I'm a bit surprised to see this patchset,
especially since KP and Alexei argued so strongly against this
signature scheme, preferring KP's scheme where the loader verified the
maps.  I'd be curious to hear the reason for the change of heart if
you can share it.  Regardless of the motivation for this change, I
obviously think this is a significant improvement over KP's signature
scheme which shipped in Linux v6.18.

I also think it is worth mentioning the similarities to work Blaise
did before the most recent Hornet version:

https://lore.kernel.org/linux-security-module/20250929213520.1821223-1-bbos=
caccy@linux.microsoft.com/

While Blaise's patchset added to the UAPI, that was done simply to
retain compatibility with KP's signature scheme; your patchset does
without any UAPI additions, but loses compatibility with existing
signed lskels.  Beyond that, the basic signature scheme between
Blaise's patchset and what you are proposing appears the same ...
which is a good thing as far as I'm concerned.

--=20
paul-moore.com
