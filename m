Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B63ACA74
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125659; cv=pass; b=N4hazSr1o8AlVV6GKElbBMCt9Ios20IxSpqcnFKJFxqtJmcuRpZ8Qe6/3j8J4jF//t5N+l+x/tC5jLQ3jPamDoy8KrcB0n47dnGgVjX2a7b+mYnPzrt/OnZUYQfcQx9RDU5r+XHJeSD9EpnQGwoSuW/smLNU11lvab/pRebeHnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125659; c=relaxed/simple;
	bh=73eVXxvMzyJNjHQHUZC9yuQ3YHZKXsjI8C8I0R1boWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5+wMcdKPhvKWsG+3TsVeaURCOao4DLWnpcNWBAg7P1vVNhjcmuQ8t3RBKYVy7GYI8GIVaEDc3INwe3hbMR9QzvTViXbLi98UolKZkSHGsGbanrbB1ynMG0029V75q0JDBa4CF0sGWlIVE2F1d6LZP6f3a82/SfkDpb4V0UB8ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+lg862M; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+lg862M"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec49f7e35eso1043096366b.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 14:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125657; cv=none;
        d=google.com; s=arc-20240605;
        b=YmQCzIa1IbDlH4EKQMt8lwFAxL5mKVrddjiBuIO0kl0EHyNabj4Yg2jdw39VFHmZ95
         sn7jsDhE/zs1C3lE5vGJMxy99aYanXzQzeDItrkmjnHPkqXYvucI8fLMd0VIz4zT8syi
         GMtGudXQzElI86mvb+9I4wRecwZa6jZlyOv57YYaedxu7fwwKNN35ZAgMdiFTpDP1/YB
         9bPDztwq74BHVRshDv4uYufN/8ucNKi+i8RhUqOfKZwDOX6Wug3SL2+Zin/gMEnl7Dva
         /A6jtM7t9o4XKJhWS2USOY0AKbreLeFYgc7S5CRN4VXDsk3aNuaDv1klYdkwBcc8rv7T
         kVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=73eVXxvMzyJNjHQHUZC9yuQ3YHZKXsjI8C8I0R1boWI=;
        fh=9FHrc8sRaJ8fTypeiMPUYGVSMOm98Iv58JJcXAMDcOw=;
        b=Khk6vHToImgMizsvVnL9pUOsaMDOLFmU60LHUd4Y57KWSWBF0YiVnmtmUOXINYCs6/
         +gd6msiI/MfySo1yxezBStPokknYiBgDZT5DNaAXYFyuWHAEVlZIk7XsTARzgCxwK+0O
         TjK8jBv6CMbj3HUkuI/A0BoWPuy4EyAkvvS8w2rRul6jBllTbtcJSA327B1wGVqfzTwK
         y7JnMyxtaxnDeWMBx53S0pfNsy7k9njt9cOwUJ+KzVgEOrg7kr8cvM1oxgUJtOtJcvuE
         m9W60wQX92sfVne9UHaM7nT8LBLsaLg30ORVel67+wbCzBg9FK12jnN+Y8a47zoBqycU
         tjcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781125657; x=1781730457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73eVXxvMzyJNjHQHUZC9yuQ3YHZKXsjI8C8I0R1boWI=;
        b=S+lg862MLGLRUnxuNN1YE2H6+AG87TCJiBkG0EKCPCOEzQ6PgRWGYFaEsQZz33fF1F
         MHG0cCbifm+kSG85kNkS27sOSZ7Er/Sq+uHbScP8rJQvYVarAnZaO0DRCqLNgqiaQSfG
         7gMdIKEcfM633FtgupZbB2I5dyraYzSNx2/J7yg5uQ1fgYAV+D3FCcLZ++mJKT3UcU88
         y4RNqFRYRFAZleZHvehZMTupSzkr0hbJLcqF4Nx17B5VKQs48L5R/sOjHyuIEaNah12t
         2hYfJi7jpvvLzTUPaycx9GSai/RB8Rn5fwU+wunZkK+NPw4JEtV8FVkjoCADNbXHIQSM
         kaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125657; x=1781730457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73eVXxvMzyJNjHQHUZC9yuQ3YHZKXsjI8C8I0R1boWI=;
        b=YFosz90axE853vaOucw4/MUSIGAxR3Dsj7kpft6y+2izMepcOjH6CFqchbt9S412KU
         pSS3jjQCxXQ2+AyMppvKpP3aCrG6yDR/t08mvG68CXCsS43Y/5hc1mo4FK0bk3VenCMS
         6eDIS8y8wf8xUoC+o4qf5Ii8TW2Jkqc2vRCitzo3oGR76p3LxFvM98bYD5Lodd2ZZNWc
         25zM8uWX6AkiWxOfbuZrxqLCBcCCwkXdPtiDZxJRVlbaOWcC/yR0kzXnPD3OlxflL7IM
         8yUlptZbD6lWtTdciaqXwRxHbp0GpsjEKlsW+zCiENswDCYoZEe5VyhdoZ9E+G7FbAZE
         FpEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PazfPmIsY0+QuiUX9ueUMMWtesoBcky7BZ9HXmRszuFnJm/qfsLK93EjH6sdZdnXMwIPtGJNL88jSviKVczwqaPTY/mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6P3gnbQh98yQfbl8NlklJnt1/pNaAZZKqu2Ysfxt318VrlJ5x
	7H3Q+Nt/P1mRFRbQpHLR4s2E7QJawGF7CxAz/93DbV7fWrWCAtBjj4EQZAmfrmvxc9XB3412Lln
	2OjBai9bpyrof3zYuBBwJgbdpTFlFFw==
X-Gm-Gg: Acq92OEBIKcQcOyGRKYcwY71Cjm+HYwOhQx2hfPNHwY2fbYZGcn0gVNLv7fTxvsaikd
	bpkzq7GZguPZisIj9uj1WUODZVC71P7XzvGMCbUMCLEBGPK56Fg3OnQ7KTecaiz4ujYbhVw81QN
	vElAGUMM8RWj8KJMTP/vcWfoSg7WtHb4VqlCMPc9upX5pvXhItsZaHmJUhxxG+q69Th0T5okBFH
	gkjgZIesWN6I2tGeOV+R2ThYORW/KtwacspanYa5m8LwDKIyRafpXscKxugUC4rjk4jN1W8KIsc
	SDPJmPnLX0QLf7g5RnUDQQWA2IayfuxBEqyMbISMpUX9uyLu6OXktnUp1gmNsH82FqpkqzsTwOs
	wVtLYJhzb8BDMl0/OF+Oe13CotytI
X-Received: by 2002:a17:907:2d0d:b0:bce:a1fc:6877 with SMTP id
 a640c23a62f3a-bf37234ac00mr1411412666b.24.1781125656562; Wed, 10 Jun 2026
 14:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606142558.13809-1-med08elkadiri@gmail.com> <202606101345.D1BDA8BBE2@keescook>
In-Reply-To: <202606101345.D1BDA8BBE2@keescook>
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Date: Wed, 10 Jun 2026 22:07:24 +0100
X-Gm-Features: AVVi8CexcpNUkSZoUjoSlVmZRkJORhumHl_-Zdg3yMbOvv_FzO0i0GVcjft9kEM
Message-ID: <CAAMeuQSZdNiCaAMYOnQE3q-Y9325PAbwVsJmTmKSS9a=NG7wcQ@mail.gmail.com>
Subject: Re: [PATCH] cred: prevent slab cache merging for cred_jar
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

Thanks for the review!
Following Vlastimil and Jarkko's feedback on the key_jar patch, should
I send a v2 here as well with similar commit message modification:
removing CVE references, dropping the skbuff comparison, and framing
it as hardening?

Thanks,
Mohammed

On Wed, Jun 10, 2026 at 9:45=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, Jun 06, 2026 at 03:25:58PM +0100, Mohammed EL Kadiri wrote:
> > The cred_jar slab cache holds struct cred objects, which contain
> > process credentials: uid, gid, euid, egid, and capability sets.
> > Overwriting any of these fields is sufficient for privilege escalation.
> >
> > On a default Ubuntu 6.17.0-23-generic system, cred_jar (named "cred"
> > in sysfs) has 2 aliases, meaning 2 unrelated object types share its
> > slab pages (object_size=3D184, objs_per_slab=3D42).
> >
> > Cross-cache heap exploitation relies on slab cache merging to achieve
> > type confusion between unrelated kernel objects. CVE-2022-29582
> > demonstrates this technique: an io_uring use-after-free is leveraged
> > across cache boundaries through page-level reallocation, ultimately
> > achieving root. struct cred is a primary target in this class of
> > attacks due to the direct privilege escalation that results from
> > corrupting any of its identity or capability fields.
> >
> > Add SLAB_NO_MERGE to ensure cred_jar receives dedicated slab pages,
> > so that freed credential slots can only be reallocated as struct cred
> > objects. The memory overhead is minimal: one struct cred exists per
> > task, and with 42 objects per slab page, the cost of dedicated pages
> > is negligible. There is zero performance impact on the allocation
> > hot path.
> >
> > This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
> > and key_jar (security/keys/key.c) which use SLAB_NO_MERGE for similar
> > isolation requirements.
> >
> > Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
>
> Yes please. :)
>
> Reviewed-by: Kees Cook <kees@kernel.org>
>
> --
> Kees Cook
