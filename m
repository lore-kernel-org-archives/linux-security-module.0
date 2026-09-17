Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44F4DEC1D
	for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2026 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672773; cv=pass; b=II2FK0uvELLskNudDLwRb2LL/CZaX5ImWfUxiTFyRmb0Z9JcOIeYQfKkVIRfWFW4BgEgTKTaIRV7iE3QF+8cWyYRCnNdHfi9tdZQuXfIv/XD5xminpE+NOQNLmlsYppSmiEG2TBuzhyRyPaYF6ARTxXvcuGPY3G33mBP2wf0QCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672773; c=relaxed/simple;
	bh=vg/HnBjL6ui8rIqhl2mHTCgUWM64HScF5/iWIe/ShIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=da34nfxdD97AZ54hT93O0E5/miOZAKMvhv1TPUoRuxqw0KWiYBhGPNUHqyaw71u0Ef2rIoFGicOzbFSU4Aljkq/spAXBkbr7Nw7QeSLPw2Dj7dU9yROIWHGisbHsk/9prZmqp9gIpmhoWqWP9vPj94a1JAznBpaEz92ITj3pqkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=nLybyOiJ; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="nLybyOiJ"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D8BDD3FCF2
	for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2026 19:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1789672766;
	bh=9ZQkQJ8DBmzRmP+IXbsxhfErJtZ6ER/ycldjmLcGGe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nLybyOiJ7SKhwDnpnmvhMCEFIaInDvUq8COaa8Wp+wRRI4aOKLDA+6lnwYzawaCj0
	 LkF3zgmWRAgiG5ZOkoCJav5IlSDycklo3IyplmPXxmisalPOVcreZibfdoe+fNSjgK
	 7BcebBbr5R6XlMUJ9BJa+yI8eSLSOyS91NyC8yOv+HALineqoU2m16mkWmy7t1BoQf
	 cF/fI9WEomcqcXhKjhvHUgQQ1apEfSgizZF01mc33DYOeh3uEAqKP2qwvJkaioVJ4y
	 fHBI0nfp2UYZSG1QYzrc5P0leByRPN92yIfCqLZ+pO09ecMx0Q47qdctZ0tAB8dv3Z
	 febwGU8Kmz0AOeBUyXSZF+8Vtp+SMkTlC66xBIrCcaBZYc3OvZxbpv7ARCgn8apbFb
	 4ADmgxLS1HTkh6V8OI3mMxWlmPxvtxlCTwpPpV8h+ati2+k5fqCc6Ua/DcdTHfcKbs
	 mIFa6F7S4vu4NkZG5qYnB30mMx1X+5FdXL8aVu9ZwYzr2Ke/cWow1WbEsfUpugvLgw
	 V4g7hTYvTwvxrBFqfT8eM7pGYJjKOzjNOpRN9O3AAUVbL0/9pK5Ook5QxwBGOGlmhC
	 +baUGAsZQZKxIx/TJDIezTUUfAVEuYPPQD3sPht9ZfQtLI8DcEXZEsGazpGvKex0+B
	 A/q/Hl+hZC+43aAv2s2NrNY0=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c293e9cd02fso144529366b.3
        for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2026 12:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789672766; cv=none;
        d=google.com; s=arc-20260327;
        b=ppB2xGrgx7vQd0EfLqh/0Znz3buRg8JGLAZUWN0nZy43PPJKIM4Rd/s4oFy+t0E3Jo
         gDLtttc/YWiROBa5CQR5TXMnm2R909u1xEXZWlKqvXgwfwjAuldVbh8Mxrx4uXtWhnFJ
         kOtrIOydB5Y0hTsxhUmEXRcgWyWEfjeQYp4QmcMQTbqfd8FjUkf09zX538YrTebEZAp2
         K1DSXalNOTxjqy7pSNln2IoiVPeM3RMtegthLVjwOb/QXpA2/fI61LBQQUwobaErjFji
         ymGgydq6tBRIOt+GAS5lfIdXef4+T0GQo0VcxM5QoP+mWNu/kRDvPaQ6DYsj0sRUV6lW
         +lnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=9ZQkQJ8DBmzRmP+IXbsxhfErJtZ6ER/ycldjmLcGGe8=;
        fh=88oRiehlHwDcEnKrzX82pRkgk0HIm93ysfymAlZdZ0M=;
        b=ZgnAiiJ4HRCaDbHn4DAH2g1OXjLJUuhkucnRKOYNhG+IGvyJ1OeMD2/sRf7CpKqh8I
         FIeO955kwbOrZJteY60KLeJXdzNbN0rfgJ2oOYNKkvrdWgJ1eXQJjSEw9v6y9VLw9Mh9
         CN5dbs0UQlM/Jt5SGvfT+VeazauPAeIEkuniLL0GrneK5KO78glG+Qk+Q77be9i0jG4w
         R6mj0v1LAvRw9LHfq/3aiI3E8YxIeIZvJpQcMFiP5nZ3IenOhQn4dm+9s8PdvqEFcd0P
         fUJLH9Kgd9+WDoCWp/lWRq4IGr43u8TZs0nn3jGNqIQdqDDwkO3Jyc0XrQ79va2LCBYr
         S1wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672766; x=1790277566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZQkQJ8DBmzRmP+IXbsxhfErJtZ6ER/ycldjmLcGGe8=;
        b=aQYDL4n/BvRJMsShJ6qu3zCfyki10N27WRDVKnWLnnwbyrRGnLud4zNdcyFtKVWoJ9
         pZyq0nK3MersWlYBK8FBcJ2L4vkrMWZ2fqMuSSyGGuoyerbtb/Gi5wfS02adXDjwwXtY
         viBTMekjLtGHvmzh40QGyPoVVib+9rj4ypaL/7uzcfdgZ5+VPqtop5g1r9xSUQ9rjm1M
         vyB58MsejUAqmhDfaoN4pH4YZZ/QsWMitfncwgIh7u+8VgaO3OGSdWf6nW1owvERyHB/
         JAPKw6mopkQnoSuUWgTSlAClvyaFCyfdYAe8QyD+BX9VV0LoGb7HGP8n+AauPGmIRj+c
         XUfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbhQQiOk5GZGOtky1Lf5chAikG37sbPaUb2Qi3iH3eaeGx6HVZC8upb4qGyq+mBSxRr+5WT+GF9Ex0a6a2wa91H04zqe8=@vger.kernel.org
X-Gm-Message-State: AFuF++moi638Ll6YtsmX3cIbVq3tCrIieHBxVE1i3BwIWIciADhsU+re
	dk0CfvZNboeXbQCBV6CaNcxEdlqewWGJ64gVezEHbjhd855U6wG1MNB3h1+WjK9jwe01PR8B3Od
	Y7swvWj5kIG0Q8xfyZfFjmevkDJeNhlKfv6Qj2vVjKrUlOTfHmjXqq3uAdCnxbuDdIOOuNqLLu9
	y0ogYuQE4GUVpY/J05vTtK0jLIHXGwziQZDXkJX+NA/xdmp9BQnj3t4PUElkn6enQch3yc
X-Gm-Gg: AYBFou26+s6NVuBurEIXM7YFKjYIRKEOu5cR3vRFymM5B7yrt4VJBugL+fE2GNYQVHJ
	ZV7/1DtKb9CbDCMlBGTtrNugbFC2JsBVamJGMZvgUz+c11+Q7EqeYcT5/XhB6RtPqLj5mUhg2d+
	yuqItqMoGTWfsq5HMf81YvlyIXcNmkaHyaVncIEDt2aD72sAwXxQr76VpsEcg+Q3kynmVqpck4/
	nzAvBV6JdwMGpmCIU3+TA2GN9L/LT90OqMgBy7I1Ho=
X-Received: by 2002:a17:907:d07:b0:c26:1691:b374 with SMTP id a640c23a62f3a-c2a15827d9fmr13365466b.45.1789672766392;
        Thu, 17 Sep 2026 12:19:26 -0700 (PDT)
X-Received: by 2002:a17:907:d07:b0:c26:1691:b374 with SMTP id
 a640c23a62f3a-c2a15827d9fmr13363866b.45.1789672766071; Thu, 17 Sep 2026
 12:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917164136.2162858-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917164136.2162858-1-vulab@iscas.ac.cn>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Thu, 17 Sep 2026 12:19:12 -0700
X-Gm-Features: AcwNN1Wzvx_67694p1o28AQ7birKEsyjcvTFnAQ2BuPeUqdnKMT1U0VxjCdP-Ys
Message-ID: <CAKCV-6uui82r4U3+ab=2ZFQvGQYnxfhYMHJNzLim-HEw6pRp7A@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Fix label reference leak in aa_unix_file_perm()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: apparmor@lists.ubuntu.com, jmorris@namei.org, john.johansen@canonical.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:59=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> The inner block in aa_unix_file_perm() re-declares plabel, shadowing the
> outer variable that is released at the out label. The reference taken by
> aa_get_label_rcu() is thus lost when the block exits, and aa_put_label()
> at out is a no-op on the still NULL outer plabel, leaking one label per
> permission check on a non-filesystem unix socket.
>
> Drop the shadowing declaration so the outer plabel is used and released.
>
> Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correct=
ly updated.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  security/apparmor/af_unix.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
> index fdb4a9f212c3..ecb40cfe7e14 100644
> --- a/security/apparmor/af_unix.c
> +++ b/security/apparmor/af_unix.c
> @@ -758,7 +758,6 @@ int aa_unix_file_perm(const struct cred *subj_cred, s=
truct aa_label *label,
>                            unix_fs_perm(op, request, subj_cred, label,
>                                         is_unix_fs(peer_sk) ? &peer_path =
: NULL));
>         } else if (!is_sk_fs) {
> -               struct aa_label *plabel;
>                 struct aa_sk_ctx *pctx =3D aa_sock(peer_sk);
>
>                 rcu_read_lock();
> --
> 2.34.1
>
>

NACK: this exact patch has been proposed before, and unfortunately
exposes an additional latent bug around plabel handling that results
in a use-after-free if the shadowed declaration is removed without
additional fixes.

I can try to dig out the relevant exchange from the AppArmor mailing
list later, if you'd be interested.

Ryan
