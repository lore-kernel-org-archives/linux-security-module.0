Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1313350A05
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867687; cv=pass; b=bc/9Aju0hTXkGEPw0X3py0kZDBdbD0SefjS0YK7hHy5E/rNcjYrDtf7iJ6X2FhkxeZAWwi0qxkxsXiCTge3jNaDL7f/w17i6jvwM4xnIMIR7V/V37gpow1qM5A3PdF66ne3Zb/Tq1hciI8eftWQMQssQyrgtdiF1QKfmC6ESHyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867687; c=relaxed/simple;
	bh=58SYG8u0pc/53nUlC52jnU/rC2SgxqQAeHb7MZSbjZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ip6oXQttL/HEoU2k3ogoXUJHHt5jevajir/sbWWBamMQQxvW2inWQAnrMxtoGrh1NPpMzPJ5jyxtq8/oquJ/8RN3b8uI92TVpjtSP2Z8goUlHnoMPrNusBatiPMJxiAgfl2EE6ETA+3rP6V2d3QbkFk84u1PqVgq9R2klNRWDd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Oye3jcMX; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Oye3jcMX"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2279090a12.1
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 18:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789867685; cv=none;
        d=google.com; s=arc-20260327;
        b=YX64ds8jus+8o7kePG1CB7+4d1Zf/VTeza47eM0e993OX/l4KSuMRbbxge5kh3z6QL
         JoSfeLownE9lmhLSPzsaQ/NkJtQBQJaK7d5XV5zcbGzkU9utE2CY+hHfuT9O7FnB3Qh4
         AER/SP3NecfsazZ+QfithjwWJHkPteRyMHK79favoPuyx1OkgawPi2Fc+yE5HnllfcMr
         T6pSK1WSNKHu4DxvbdduYDaaDI1b0NdA4yYK9NKXoQa9X9ZzoNhdOJ7m8D7vyoJuHBSA
         0SbIfawFAvJfioYEsKdKXB8PYMiczeHUY/wwtrJENY9JYy4/oCZ64zOgzkCSfp3f5ZgD
         Hxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=REeNKeU2w+4sUIJzVcJdRnI84oWXH0Weq6lkeZd2jWQ=;
        fh=sZ2Kq74X75tC/oMXRvNonX9hsuakcYObCm8o/7lPItM=;
        b=PVy4kPzHJMBuQtl7NK/bjvBF+QhAao5HRYUjz91m9UIM7D6j2duiXNESBjvxOkiF1r
         pzB9VhMkNGW+Nj05LQma08IN8yTzkDHenfFcDO+mS8q/5dD+1GxsxH+j81ss3YmvK+sX
         mb7SHFP3hWNA43KcwHyMyjPFbMRrdSD5PHu3DFuyzCgXyG8a67QU6x7YjeK2eCnPyePj
         K8KeJpbfHMxBuYfev/kinktA7fkptsHL9BCKc3ZKXqHyANnfv9WXohy6dFGCtvKYG+oc
         YhcQPxyk8+BL7tRqovTSLSh85Ii4Rk45zHMj1uxe3Sery6kqxSi4+bdRhQZbxIEN51ZL
         tn0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789867685; x=1790472485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=REeNKeU2w+4sUIJzVcJdRnI84oWXH0Weq6lkeZd2jWQ=;
        b=Oye3jcMXOo+JxGG8lg0tyo01cPzFsTzFwSPst9BvLEqGSGa10jiZlNKw79qgxxXa2k
         FI9TdJpfbNUX38lw6WTLltiufg7psbg6ZhkN9+GE+846FFKTSoEId/ybZ2apmxSgMMPy
         LE0W8gEqHSzp0XDoi1x8HsmzbmaaCelra3DFxYhN3neBAb+PEMRuYjgD8zCe057sWJ1B
         Y4GAduW19STxRo5cwliyVd/iDZJejl7gDPX4fsWHXqAF6ldjFQaRevoZCJVuHUz1+k31
         EDUaRNJrocKF7nWOUz6G6BjlQpgPUhvK3h5mSgDAnFPhNCY0opQYbm3BwV19mw19547R
         rO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789867685; x=1790472485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REeNKeU2w+4sUIJzVcJdRnI84oWXH0Weq6lkeZd2jWQ=;
        b=LN6CDHq10BGI6j01URvbV1Z590cKUfDp5QnjLSye7fYK6eLcnh3nrEmKEA8CSBYpWR
         bCPWXKbOtBIWWlQTb3tD8Ovnu3fOjBwe7yWGhqeTDDJquOJfQV5s7abH0iFPdKh1kedW
         uF71Cy7+WHdDiGQEOG5H6gmUUQzuYE4qdbdxLmVgplbvvXq/pgoLNIZgIyknxjJNdezn
         zfUbFQ4C+ujFyQOoYA5U62uZ2xkFgVSwaR739plRvNU2lNh87c5LU6wkgYPdFpvF2UYg
         0xK4Z/oHER+BER3+0XDkEzGQ7+9ADKtgdFAYno4+ZNV1BwZFsAablPUuUX/Fz2A0SvlL
         pxhA==
X-Forwarded-Encrypted: i=1; AKwUvBzp4HYUSg6aa3DN4QMVjaLUqfaK2FBt50PFyyGAny+7r5IBDBSxjr/u4+yAI3iN9xFdaZK7oI3XA2XocA3Hf036krsagCo=@vger.kernel.org
X-Gm-Message-State: AFuF++ntb75zS4g6jM5FJnkzweWMdXXRqj/nMek0vbcHycCTgABFfjfH
	A0zX5QIIhCZReIh77y992JLrPBnWbXwqto6RynAFERC5TPnMwiW5aW9VjsZZryP3cEtWdcZErAL
	JXwyHzOdecGwAePl6YnJveHMmkxdvRQ/UPMEEBrDD
X-Gm-Gg: AYBFou1CteGnhEMu5rHghMWlCHpimQOGlyWdYyBhXqUw1aHZMi43CSvLSAADMnQ6DeS
	2HpOg+4Pvs+gkhERIrq4wgQTUwCZ5zMc/mOW96BUbaSSWExDVBbAN/+/AxJlrekxfKTPmz9B5M2
	A5sf1xjRbcLif+g/LjUzvyNqlI3qDxYbPi1QDRJxi4b+PN2s6quciQjUrvOtLXBO0PrMWY1mvK+
	u+dLc+kbGmsA+9c4xvNBgxmQPq7WK/Vsw/nM4VUGt2kGQ8j3f0mmFjDJgdSS+/OTjX3CcB/35QP
	QjsxPrfEfkGMfADfB9ekucqQzDtspEHu3HdVroUusoK6AbvEP7FzwQ8Mtq8jrZ1h0H10BNBKfM5
	PNgKpf/iCrkk=
X-Received: by 2002:a05:6a21:6b18:b0:3da:e57d:4a79 with SMTP id
 adf61e73a8af0-3dd7263a307mr14783301637.13.1789867684717; Sat, 19 Sep 2026
 18:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919210621.3029744-1-benquike@gmail.com>
In-Reply-To: <20260919210621.3029744-1-benquike@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Sep 2026 21:27:51 -0400
X-Gm-Features: AcwNN1VaFHIGGaQ5NtAlsPyN6fZLotOP8OtOjiPI2lLmpI72SuzrZttUCiuI84A
Message-ID: <CAHC9VhT426aweDqPhBWz+16b9zWGj5GsEdn3Jv9dJUnaz5wdyw@mail.gmail.com>
Subject: Re: [PATCH] ipv6: calipso: fix 8-bit hdrlen overflow and missing
 pskb_may_pull() in hop-by-hop options
To: Hui Peng <benquike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 5:06=E2=80=AFPM Hui Peng <benquike@gmail.com> wrote=
:
>
> Two bugs exist in the CALIPSO hop-by-hop option handling in
> net/ipv6/calipso.c:
>
> 1. When inserting a CALIPSO option into an existing Hop-by-Hop extension
>    header in calipso_opt_insert() or calipso_skbuff_setattr(), the
>    resulting header length `buf_len` (or `ipv6_optlen(hop) + len_delta`)
>    can exceed the maximum size representable by the 8-bit `hdrlen` field
>    (256 * 8 =3D 2048 bytes). When `buf_len > 2048`, `new->hdrlen =3D buf_=
len
>    / 8 - 1` (or `hop->hdrlen =3D ...`) truncates modulo 256, causing
>    `ipv6_optlen()` to under-report the allocated header size and
>    mismatch `opt->opt_nflen` or `skb->len`.
> 2. In calipso_skbuff_setattr(), when `ip6_hdr->nexthdr =3D=3D NEXTHDR_HOP=
`,
>    `hop` is dereferenced at `(struct ipv6_opt_hdr *)(ip6_hdr + 1)` and
>    scanned by `calipso_opt_find(hop, &start, &end)` without ensuring
>    that the Hop-by-Hop header resides in the linear data area of `skb`
>    via `pskb_may_pull()`, risking an out-of-bounds read past `skb->tail`
>    on non-linear skbs.
>
> Reject Hop-by-Hop headers that would exceed `8 * 256` bytes with
> `-ENOSPC`, and ensure `pskb_may_pull()` linearizes `hop` before
> inspecting it in calipso_skbuff_setattr().
>
> Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the =
secattr.")
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
>
> ---
>  net/ipv6/calipso.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Similar to my comment on your other patch, since you are fixing two
potential issues in this patch, please break this up into two patches
and resubmit.

Thank you.

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index c6a34334e657..b8b7451a16ed 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -944,6 +944,10 @@ calipso_opt_insert(struct ipv6_opt_hdr *hop,
>                 memcpy((char *)new + buf_len, (char *)hop + end, hop_len =
- end);
>                 buf_len +=3D hop_len - end;
>         }
> +       if (buf_len > 8 * 256) {
> +               kfree(new);
> +               return ERR_PTR(-ENOSPC);
> +       }
>         new->nexthdr =3D 0;
>         new->hdrlen =3D buf_len / 8 - 1;
>
> @@ -1323,6 +1327,13 @@ static int calipso_skbuff_setattr(struct sk_buff *=
skb,
>
>         ip6_hdr =3D ipv6_hdr(skb);
>         if (ip6_hdr->nexthdr =3D=3D NEXTHDR_HOP) {
> +               if (!pskb_may_pull(skb, sizeof(*ip6_hdr) + sizeof(*hop)))
> +                       return -EINVAL;
> +               ip6_hdr =3D ipv6_hdr(skb);
> +               hop =3D (struct ipv6_opt_hdr *)(ip6_hdr + 1);
> +               if (!pskb_may_pull(skb, sizeof(*ip6_hdr) + ipv6_optlen(ho=
p)))
> +                       return -EINVAL;
> +               ip6_hdr =3D ipv6_hdr(skb);
>                 hop =3D (struct ipv6_opt_hdr *)(ip6_hdr + 1);
>                 ret_val =3D calipso_opt_find(hop, &start, &end);
>                 if (ret_val && ret_val !=3D -ENOENT)
> @@ -1341,6 +1352,8 @@ static int calipso_skbuff_setattr(struct sk_buff *s=
kb,
>         /* At this point new_end aligns to 4n, so (new_end & 4) pads to 8=
n */
>         pad =3D ((new_end & 4) + (end & 7)) & 7;
>         len_delta =3D new_end - (int)end + pad;
> +       if (start && (int)ipv6_optlen(hop) + len_delta > 8 * 256)
> +               return -ENOSPC;
>         ret_val =3D skb_cow(skb,
>                           skb_headroom(skb) + (len_delta > 0 ? len_delta =
: 0));
>         if (ret_val < 0)
> --
> 2.55.0.1082.g2b9226bbc0-goog
>


--=20
paul-moore.com
