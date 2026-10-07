Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6013D6690
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409783; cv=pass; b=ohAIf4KlB3Z4yEVVgVujBbDJmbgjhRFuqoZKED5rAL2sxS57RUR7FEgPNG8/kaMoT5wKbV0QlLKxjH5f5i5sHOBzTkB9VFrmcINuX68xGI+KNLZuoeT0ZVrI4AkY0OI6793N03No+yqNgbsOCD/viFZ95quv0d/yMjtaocBRiCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409783; c=relaxed/simple;
	bh=iUfeVPFcJRl2l483RVn1FexTtf702f8k8YD91745DT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hP/bWxIb6q/a1+pWF8O/tRX2YVdcdubgIBayLPNBZpO0oouFpfYE2fRuDZ3f75LIPTLQc1iZdL68AX3CokGJ++fDN8gYsAx02VYmOuRDrPXx7PjLgbnCp08MUkAd6yhpA2p7DKxP9EVPVzpfqEL6JD0x0bjtiDtO1vAXvmo5+38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P7du2heG; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7du2heG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48af27fe287so1760403f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Oct 2026 14:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791409780; cv=none;
        d=google.com; s=arc-20260327;
        b=fDcYSm+zTC/WOSNthAMKAh3Yhy/nmxhb2JW1xdYPYiQnHq6F0Tt3G5GvNpDHepByzz
         xxMMg0qJ6QTcR44kmG+K57fIfBz/7xqKjbBtxvH5gWY6UHkjimVe5CQ+8C7/ZagRvGx4
         HIB1q8CC1zBzWSjluYA7N8sRtGLtxC/2r1itF7BQ9OmMyNuTABUoE7LwEoYMxKcNeN3P
         opoWn0BOyzKtHwYTuO8B5EBjT+iPL+x8J3ffOI3JP7Ox6SAYew1d7jb73pWEr4QeslLM
         d3d3gdkD1B3oQdJLvW6NWy2OFFhlP0SwooO/grjbjxvoVyWx6G6/lp6QAgtZyIxH1M1g
         klAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dz2+W8ZDe1ZO58k707wXjnIbgkdV89r041+gMmUvvKQ=;
        fh=QXP2AFHvd/Lz0tTsNK4kSdRxvuV7VE6OEmzMIh+Eihk=;
        b=jPiwK6XljWIoPMkDJ6qyeSKvQFMu8TM9uynr5ki+2DRCc7r4bkhfS3+4iEcfzoSPjB
         57UiUqf/ggF3+3PBh2iuLI+vaX9qt/aHLmAKIx9k1fPpHNCHQbXPWXHOTJ5BzU61IVaZ
         hplB679UE5gqnfje5TL8vZLYCGR1ZxYxSY6gAYeZvzZHvXqcKWRH4BIlO56AWu/T6RH0
         otE+XO2GWu4tLZESP1GLlgmcq4ifKp/W78H5p3rSB+zrTYK+PNeFmkmSqtJwN6DntCO6
         E9v5yBU4sa3Zy6K50Ma1YBsr6GWe/0U2eWOQxBEBN42qwO/bz3HtWkI9zbOpK94CUxPV
         XZgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791409780; x=1792014580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dz2+W8ZDe1ZO58k707wXjnIbgkdV89r041+gMmUvvKQ=;
        b=P7du2heGRRe0NdxFmkQLnmpZhVk6IdKQBDPC/Y+UQy0PXijq9nuRtFz/ETBT6HKKq+
         sSsQ+P18FwQQVyRn4D51kzd/Cf0YyU62abyqfNRchaTz5EGHGvqw7Xn4qbeiHw9JBc6P
         eMeYBjLQ08NerlnwSiDNIWCuMiFsin/+26zzaoDcpDmP4gcA1dkS7kiVN0aoWbMXMNUb
         xegC1bik2ULslvOVb1hmlw4o+2Xx6OgwROwONx9xPwkbgV9PcmMHM62uJ5y6c7qGKBNX
         Rh93fibkDk3ttVRb7iN+VKVmAxfs/lUrJ/D0Xea3XtxxYGbbAX3FC+dQcxxg9CBmBAnP
         JVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791409780; x=1792014580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dz2+W8ZDe1ZO58k707wXjnIbgkdV89r041+gMmUvvKQ=;
        b=HmLb1FBk0YWmSEbLQJqqSVIBU7Ean0zcUBGuvX4cb54KeTA2QWyTn1qeqIbg3c0x0E
         ENEFoRe7Pa5i+e8MgZYIJb9fvXahmhtY9bPB5h/kdarDmf5FkHfTUR0gH/f6Aw4EIpp1
         p9ztSyVbTN/q1ERf+ZJa0ziW/B5necjQFn1wimAvkuBn7FJWgK/B6er5OZqLVJ7racxo
         1IBZjbrDFFeD8ZxNc5LDDJPVF1iGHS2wto2vXRMycuqx0JmB2CQzXeGZ7HpvRrotgUDP
         8qxa5znq5JPhM78ZRuxn0bXjdSVAEEqOyzwUvXYhhlJdXB35HVWafTvjJtPZK0VOD5K7
         MDLA==
X-Forwarded-Encrypted: i=1; AKwUvBxO2LIhVFZD6G63jl9DejZq27N4ZxQGkPT85Mcg1fnybhyoctNdYbOX/S0t8geUtIk5Ko8pp+oY/SYobpyGyJW6vhyroxE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIi3MFu3taMKacZZ5flHaWdrrVKes3H5Y98qfKQtmQbniazZyF0
	crh9O7bwrTSUYgABGAVONHP2Wb2+bxEM6nzB0bJfhgXsm8t8P0i/1MY8FcgJX1IFx661lzFsdBF
	7OvcsTD8qEEUVBTod9Nn9ydyHwuIscff2STkssxPB
X-Gm-Gg: AYBFou0ITnecRaEaH2KmDfPnzPbdMoiIdsw/LzIUj/ZPq9Lz2JmcHftREzGTqAgZzaH
	9t7sDWNRCXnGstp+AUya8RKkSNb3adQ0ppCC2jRAmaFZRx8bGnS3cLTAiXUErcx6C1Td8lGoet6
	jCS4ePhuL7sCoa33yZemUjhkUdtJDumYPLPrUgAyMs/J8NmzYnGWzSO4mkJXE7Giks8iFaxacdp
	tBTvpGJHFFtzdSGqq/qbBXiGWRxeXyNZMjaWh/vi+6xpbzC9IcGaUC0ftlfk7qLC4I7it/uJtlN
	f6HjgPNJAlJTNZoaQUsjZNR2K4mE3G7Ik7jO9SqKWDgSpBKRdutqpIm4g9FxPq2TegQb4cw/7p6
	iHiCUkKOd3h54XtG/pWnAGouTT66WRtjZqARxzeqGZMu5kovFFIQ0UBtW67dcx/l1X21y1w6b+R
	iJ1w==
X-Received: by 2002:a5d:64c4:0:b0:48b:f92:1f75 with SMTP id
 ffacd0b85a97d-48c7289726emr6747670f8f.48.1791409779287; Wed, 07 Oct 2026
 14:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
In-Reply-To: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 7 Oct 2026 14:49:28 -0700
X-Gm-Features: AclHuK-XtGI88zcQiAtV3bin7-xktDfZZWB8sWf-q8RSqTy-N84xG7PdKD2ogLk
Message-ID: <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Bill Wendling <morbo@google.com>, 
	Tingmao Wang <m@maowtm.org>, Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 9:28=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm.co=
m> wrote:
>
> With Clang 20 and CONFIG_FORTIFY_SOURCE, stacking Landlock domains can
> trigger a fortify panic in the handled_masks copy in inherit_ruleset():
>
>   __fortify_panic
>   landlock_merge_ruleset
>   __arm64_sys_landlock_restrict_self
>
> Clang miscalculates the location of the __counted_by counter in the

Thanks for the patch.

Would you consider this a bug in clang, or an error in how the
__counted_by attribute is applied?

If the former, then a bug report against upstream llvm-project/ and a
link to that bug report would be appreciated.  Then Bill can take a
look.

Or if this was a known issue specific to clang 20, then we should have
a link to the fix (or consider bumping counted_by support to the
compiler version that is bug free).

> anonymous structure nested inside the domain's union.  In an arm64 build,
> __builtin_dynamic_object_size(domain->handled_masks, 1) reads offset 40
> (the first handled_masks entry) instead of offset 36 (num_layers).
> Because the destination domain is zero-initialized and its masks have not
> yet been populated, FORTIFY sees a zero-sized destination and rejects the
> copy of the parent's layers.
>
> Move num_layers and handled_masks to the top level of landlock_domain so
> that Clang uses the correct counter.
>
> Assisted-by: LLM
> Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> Move the domain layer counter and flexible array out of the anonymous
> union to work around Clang 20 reading the wrong counter for __counted_by.
> This fixes the FORTIFY panic when copying the parent domain's layer stack=
.
>
> Based on next-20260930. Validated arm64 Landlock object builds with
> Clang 20 and GCC 14, with CONFIG_FORTIFY_SOURCE enabled, and checked the
> counter load in Clang-generated code. Not boot-tested.
> ---
>  security/landlock/domain.h | 48 +++++++++++++++++++---------------------=
------
>  1 file changed, 20 insertions(+), 28 deletions(-)
>
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index caa3d19d2c43..5e65ab004f62 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -216,37 +216,29 @@ struct landlock_domain {
>                 /**
>                  * @work_free: Enables to free a domain within a lockless
>                  * section.  This is only used by landlock_put_domain_def=
erred()
> -                * when @usage reaches zero.  The fields @usage, @num_lay=
ers and
> -                * @handled_masks are then unused.
> +                * when @usage reaches zero.  The field @usage is then un=
used.
>                  */
>                 struct work_struct work_free;
> -               struct {
> -                       /**
> -                        * @usage: Number of credentials referencing this
> -                        * domain.
> -                        */
> -                       refcount_t usage;
> -                       /**
> -                        * @num_layers: Number of layers that are used in=
 this
> -                        * domain.  This enables to check that all the la=
yers
> -                        * allow an access request.
> -                        */
> -                       u32 num_layers;
> -                       /**
> -                        * @handled_masks: Contains the subset of filesys=
tem and
> -                        * network actions that are restricted by a domai=
n.  A
> -                        * domain saves all layers of merged rulesets in =
a stack
> -                        * (FAM), starting from the first layer to the la=
st one.
> -                        * These layers are used when merging rulesets, f=
or user
> -                        * space backward compatibility (i.e. future-proo=
f), and
> -                        * to properly handle merged rulesets without
> -                        * overlapping access rights.  These layers are s=
et once
> -                        * and never changed for the lifetime of the doma=
in.
> -                        */
> -                       struct access_masks
> -                               handled_masks[] __counted_by(num_layers);
> -               };
> +               /**
> +                * @usage: Number of credentials referencing this domain.
> +                */
> +               refcount_t usage;
>         };
> +       /**
> +        * @num_layers: Number of layers that are used in this domain.  T=
his
> +        * enables to check that all the layers allow an access request.
> +        */
> +       u32 num_layers;
> +       /**
> +        * @handled_masks: Contains the subset of filesystem and network =
actions
> +        * that are restricted by a domain.  A domain saves all layers of=
 merged
> +        * rulesets in a stack (FAM), starting from the first layer to th=
e last
> +        * one.  These layers are used when merging rulesets, for user sp=
ace
> +        * backward compatibility (i.e. future-proof), and to properly ha=
ndle
> +        * merged rulesets without overlapping access rights.  These laye=
rs are
> +        * set once and never changed for the lifetime of the domain.
> +        */
> +       struct access_masks handled_masks[] __counted_by(num_layers);
>  };
>
>  static inline access_mask_t
>
> ---
> base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
> change-id: 20261007-b4-landlock-fix-domain-fortify-panic-510367f8cfe3
>
> Best regards,
> --
> Abel Vesa <abel.vesa@oss.qualcomm.com>
>


--=20
Thanks,
~Nick Desaulniers
