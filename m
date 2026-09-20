Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E06242D62
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867332; cv=pass; b=eXDCTJ0lmpYuMw3gWNVzA3TmnILOXk3TdbvqdsJeHyZFjhgw7mHKjc4MXg0Hd3llGjmv0u3GPVtuengTQY34Cp+mYXColWMAWw5Q008IshZnnAZiP2Micq4gR0jWaEUq+em2KzsgHjfcJ16gXGdn4P9673jPT02tC6mEEIEWxe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867332; c=relaxed/simple;
	bh=2VEm69UeAdHkIwbBU0Ergf1rGXkHAkJuOFSQAiSO0p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vfnqf6meF4KJVnOw+G5Sc+JMWztiTPq+PKl+T7A63lqCBV89K/90S4HdnkghrCxBOu/dSa6/8wGBpSUusGFg7VAPGv0u8GfCjGZ3f/Ai1Hz6ZrW6rKysId3/56ch6/AS9bfXVXeRap3jhvv8UcjnJoGjZgwez32xMIwuLQnRuQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L6O+ve67; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L6O+ve67"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50db3so1075575a12.1
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 18:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789867330; cv=none;
        d=google.com; s=arc-20260327;
        b=dv6hcpSo/IwGOMksoqPEIwBYp8oz2lMhH4AHFqxX+/GKeBIY2pBq+PR8Is57tBxRd2
         zf+UJGwe1Z2J1n0XvJCSmamwlqDNX2woyiFx1lz5MK8TFRTP8tbi+63CHvJfxhJXWpVR
         gDnEJ1xQfbNgaMYIIQeoqMfDllDdNFo9rl/II8Kxo06bQ7LPhvTUdDo8q+kwfVA3Em+p
         y0bAHFyiheqka483GfC1mf0YsdNZju9uMv+mlwrut/nk+TMHUerj5H5a19kDv/q6Rn6E
         T59ED24nj0K2F2q+pN21uBVawNqXqtSVuAK8P1P1JoJXJ01+v+nnsiUkT44g5sXzj6+X
         Rurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXdKuOcPQjh4tFULSVStg5yQtDl5Sivh8Z/3KuFYKs0=;
        fh=xitIjIrl4yzPKALHb2IxhSgFfA75ZfDGxOVaA98X0o8=;
        b=HpeHWwNishJplwUJpTM1Mi01s9QCiBjrDAlP6ml7JxtnbHJ1PSqdIeCTjwinywQ/QM
         ztTWnGvAUIwLSqr8uk0f1Q4du9q/cA+6a4tfiqWUHB7w9aSxuq4nSDhINFd0SjT3fmmG
         ZSRQ9zE5pO7lLGGOuIgvv1HUaBdvIOesLQLMkuCNeRDRoDyx0b29fFAeHGH69uGNqX+/
         nhZUlyJqkn6WVgmVA6p/B2jahrSUCkqYX2wNhbtUtJ/YPr10zYvYJVQ+oMBPl92CgUWF
         XoNmrOGHWBzHKM7p2XNEY0GDwviShAv/YIyTILefTzTf68vz8gEUYhULh/zlRF08N57s
         b3rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789867330; x=1790472130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zXdKuOcPQjh4tFULSVStg5yQtDl5Sivh8Z/3KuFYKs0=;
        b=L6O+ve675fqEPtcUxqXtqgUQOpms6zlKaUIVzibB6dwlz8UfhHs18NE2LQUD0Itsbq
         AmXaRpmqj59ev0o94mh3ukN0p/YT3QVdvoOrUJ1MdZT9J/lGPqVNQkvOsxD5rhN+A9eL
         LSsfQ6qJGaQTDNhZ2QQWWEBDV889TT7n/YsnabMngyUxuZlKl/P1C3y/n3UyrpfAOlcN
         MOBAOUOJScs7eRYBD8xg0ICP/+2B7tz/TIyD6q5N1RhFcabKg9Gkct3n4hjEokIhjm3X
         69PzVQcrIsgtUubhk1bGHZETjXsz2Or2LbKOUnyrb7IK1ddnqQG3J9tdZG88507MKWLH
         P/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789867330; x=1790472130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zXdKuOcPQjh4tFULSVStg5yQtDl5Sivh8Z/3KuFYKs0=;
        b=pAV81EO7ETbIOJeotRL3igtD08zD/Te+VYkD6Vh6oKpH0hsRab52t/bPYy2ffPWvZ9
         BnjzSC4J+K9Ubpon6acqf8vMrMCA/1dDvTzly4/5HmBpfKZVNk0e+m8O0q87VlKqoGph
         MREws+P9pkkgv97Hk2ow8oEjib2PGoX/IzjkX3kPNbefuS8ydwIxLPM/7Czz+IpnwBeM
         TLsP0439YhE/5QoTCCDCjxMWhgr1tYrWf7NNCc30mCO7vJJD0bXv9MSHIuws+xRgq1Fq
         qEVLaVh1orcBHgShBXC4gJA1lu9ncgG+J+KWh1jQG+wuPgRREurv4nqw6O8V84wiC1/j
         E2ew==
X-Forwarded-Encrypted: i=1; AKwUvByw54tNwFm7lW9RydtNbeirU/cArZ8nBunhPYVhcuyDRTM82M35CAOff3e5b0Orn5GPIZXo7UIUJl/rgZc6O43lUu/zU+Y=@vger.kernel.org
X-Gm-Message-State: AFuF++ncEGWHpMRz0Qs+sEtSvvaJt6A7yZHaGcreRDjze7Ptsgmx+cFA
	s5aQRq92t1r6OiHkcgMOFS4uXyom8p0l2Q09N/OAaHSY9TaNDVVF/H5ZPlr1pH+FyfNAZG221I5
	LwUvPv0IPB9d9oajS/n34VsHImruYprtr3CD9ew4w
X-Gm-Gg: AYBFou05O/MWA4wgl/uLFHX8BPOcIHlsBZudT7mLrzhnQNAO/jLyqkSe1nCQiOyDTK/
	RgAswyPn39W9x1DMi0YdIwJag1n+O8lspHQ94vpx49AHtPTOR9HSBgxzGcbjDYZB8lPGg2pWNkS
	z7wrc0yoGUDpZCDGs1AhDxXIV5YPsNYC/3Agly368ud/QTWzeioGGW73Hp90H+cn1FGue1UHFtB
	a1g2CPftJjOfMbLOkRBd1UJ7+pD4cfCzc0BlJX3xSGY9ldzSwBAw3X5Sz3Ey7TpI3V2TbreLhR7
	I6KhDlxhyOlDys+bOlvw1pcu84i3eAhT4yjm5uPs0eRuxWCQ0Rlx4/RN2HNhH4e7W2CI4/cAN7U
	yR2EAAvOvyB0=
X-Received: by 2002:a05:6a20:144d:b0:3dd:a008:dc39 with SMTP id
 adf61e73a8af0-3dda008e131mr6498106637.39.1789867330527; Sat, 19 Sep 2026
 18:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919223438.3883567-1-benquike@gmail.com>
In-Reply-To: <20260919223438.3883567-1-benquike@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Sep 2026 21:21:58 -0400
X-Gm-Features: AcwNN1XYIQ_wBn8i5ggt4CeI5Ch8V6l0HMTPG10aIvqe5hBWEiugJPjmk6GI8NQ
Message-ID: <CAHC9VhS7sZQaPaRswKQ1ETrReEPB2f5buNAMGSXqZ1iBKTs+bg@mail.gmail.com>
Subject: Re: [PATCH] netlabel: calipso, x509: clean up ADDRSELECT on DOI
 removal and check AKID len
To: Hui Peng <benquike@gmail.com>
Cc: dhowells@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 6:34=E2=80=AFPM Hui Peng <benquike@gmail.com> wrote=
:
>
> Fix two issues in netlabel CALIPSO and X.509 key parsing:
>
> 1. In netlbl_calipso_remove_cb() (net/netlabel/netlabel_calipso.c), also
>    inspect NETLBL_NLTYPE_ADDRSELECT entries so IPv6 address-selected
>    mappings referencing a removed CALIPSO DOI are removed.
> 2. In crypto/asymmetric_keys/x509_public_key.c, guard against zero-
>    length signature/AKID fields before key matching.
>
> Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink p=
rotocol.")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Thank you for your patch, but as NetLabel and the kernel key code are
in two very different subsystems, please split this into two patches
so they can be properly reviewed and potentially merged.

> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric=
_keys/x509_public_key.c
> index 25cf8ac7f257..5c9165a83f91 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -53,9 +53,11 @@ int x509_get_sig_params(struct x509_certificate *cert)
>
>         if (sig->algo_takes_data) {
>                 /* The signature algorithm does whatever passes for hashi=
ng. */
> -               sig->m =3D (u8 *)cert->tbs;
> +               sig->m =3D kmemdup(cert->tbs, cert->tbs_size, GFP_KERNEL)=
;
> +               if (!sig->m)
> +                       return -ENOMEM;
>                 sig->m_size =3D cert->tbs_size;
> -               sig->m_free =3D false;
> +               sig->m_free =3D true;
>                 goto out;
>         }
>
> diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_cali=
pso.c
> index e1efd888b4a2..3756193b1c49 100644
> --- a/net/netlabel/netlabel_calipso.c
> +++ b/net/netlabel/netlabel_calipso.c
> @@ -283,10 +283,21 @@ static int netlbl_calipso_listall(struct sk_buff *s=
kb,
>  static int netlbl_calipso_remove_cb(struct netlbl_dom_map *entry, void *=
arg)
>  {
>         struct netlbl_domhsh_walk_arg *cb_arg =3D arg;
> +       struct netlbl_af6list *iter6;
> +       struct netlbl_domaddr6_map *map6;
>
>         if (entry->def.type =3D=3D NETLBL_NLTYPE_CALIPSO &&
>             entry->def.calipso->doi =3D=3D cb_arg->doi)
>                 return netlbl_domhsh_remove_entry(entry, cb_arg->audit_in=
fo);
> +       else if (entry->def.type =3D=3D NETLBL_NLTYPE_ADDRSELECT) {
> +               netlbl_af6list_foreach_rcu(iter6, &entry->def.addrsel->li=
st6) {
> +                       map6 =3D netlbl_domhsh_addr6_entry(iter6);
> +                       if (map6->def.type =3D=3D NETLBL_NLTYPE_CALIPSO &=
&
> +                           map6->def.calipso->doi =3D=3D cb_arg->doi)
> +                               return netlbl_domhsh_remove_entry(entry,
> +                                                                 cb_arg-=
>audit_info);
> +               }
> +       }
>
>         return 0;
>  }



--=20
paul-moore.com
