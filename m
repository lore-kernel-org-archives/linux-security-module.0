Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA630CDAB
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769042937; cv=pass; b=hU5V6yd+RhcoMheZtuZIZTjxWo8bohsAn16gp+XLu8MIbkeLClwHWbc042KYpd6O4j+EUEf3Dzn+2mvYX4vGFsfV1siWNOq0cdAOAkyr3wDCa9/cSFFZi8QLZ6KK/iTKiHDvpr2UD/jXVYi++1UWTy4KzYl7jSh4C1PgN9Wbszk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769042937; c=relaxed/simple;
	bh=STgDya/rrELwxBw/nR4uv/MTvvetLae1Em5BNoXv234=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/Wi3R3hnAm0goSI+uj5w+m3yFVk6PlgtmBB9IZyxkqEBV/XmsULkaty1e53cgrdZhL90MBVTdPkN6EANg4e2phZJu5E7ueaN2QuiqvNGlMphvq2vv2uo+KUYvzXdWgmM43HjuxS2UZY7iJ0XyHGRN55rBWMx24xvLh0tYn9K0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=drxRcnqe; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="drxRcnqe"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso134361a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 16:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769042935; cv=none;
        d=google.com; s=arc-20240605;
        b=GQ/+Iqm1apCFRPdlrXp5JC3hM5GYjCmXWzyHss97s6ZHEFFJPu/LZEmAS8rwdF2w6b
         8IesQ5t1eU+EdUyopYO/EzWXIGrPeG6Qkz7KcvErz6FesAE+d8fOTjVGGOjPDt0t8l+j
         ClFnlQBvuNrtv885XQUr1DIlka/aB/yRmj9M03IuuVNm5aifxZX8VPTkMuIjJ2CX0HMy
         LjHl4a/BPoqAZtaPSTDMTkJ1cPFTROHq/x0bX3m7DzIABDkMXG4xukvwM6nmxLKeoKcE
         lVpkMzxsDVE6pB6sfdsY1I6Q8ajqkd3FfNOQLIppyTMuANJRXfKd/op81zrCi9ePPCEj
         U5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b5+P2+OzW2g3dFBRbXD1e9SjxU7d32t2ium8U07J7Q0=;
        fh=FwEnRUhDmZBlQEvta35kaKQV9mRPScikRwUivRVPQuA=;
        b=W+Sp5vnUp0EQ3myia6fOdX9+5PCXrg+9TeOO0NXZQdDmL2o77wdwARfZXjgusYHSqL
         uNMplGGhWlbifTQEhxMTKYH4RAw/7Do8soYB++k9FvIs84y8EUCa/f/VVGFMYRoOm8Rl
         RzeqHQF3wX6RtsH65wS/Uupd7lkfbZTEXMsNr/gK2iMFS2wMHl0UXmhY9xQnmHaoUim0
         26BSGBf5UFI1GRdz2ikjed3cqPsuFoK/eTFo4ClDUXYGaaP1DAhBWrFcD8KkdV4C6Ypz
         WOJHQoiJsJ306jhIJN55eEcO8SOML9jxFNKwn+oIlpFnysvEEVzcQ/a/dzaqI/fWMP1I
         Sd6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769042935; x=1769647735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5+P2+OzW2g3dFBRbXD1e9SjxU7d32t2ium8U07J7Q0=;
        b=drxRcnqepRaArCettT96atkacfAjZ1RM+kkwCB8P9zmZRgPzmAhKVDd18MuCKqOaa0
         oNWY0mDF2Tk3kskIDbiuXogi+K8DpwwEy9iZRoVhGAArS6VAFqXA4W6F52vKhLVJjsMk
         U++TRMkd55LsVJtNAB2np0epiZxFBs9Vs/YiiOlK/s7R6j7L4LLQ0CHbipFSpnebmwXv
         SAvUNlecoJLiOW0Scfx28yOJpUniNPsDFP+1agf6qP4I6/oITFAppR8y+VDkqxN3QOzg
         FblmyFnM2WXGZFHIHqtg7I8/l2uWB+dkfLp0HOasF26BMKlWS9GkwWSrcupb/KfGOxUx
         Ftnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769042935; x=1769647735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b5+P2+OzW2g3dFBRbXD1e9SjxU7d32t2ium8U07J7Q0=;
        b=Fl1tyP79oLgGf6tW0n8BJ+CkLP7bHIt7UadcwrTUhSzXKDFs6GnR4TlfwP1H27Uhoo
         71aDufOyLlf1uC0rRDFoF/GVqdcCx/CwAIbO1dj9DMooPCV/UcTYYlTztn0OOWGNjTJN
         DXliRba+OjgC+dWwcrSiCchkCSE9fqVEzvo3adYGMhKoQxTiRaTQFR1A1BxA57fT+uBE
         pP9OX1ob/qgJDk5J85ovwjq2/cu0d13wzJjWGw9WB/8bjUtkECMCgpJgSx5iROrltDPN
         IDqCk1lmLk9n6EUhN/ojftyW3ve8I5bdo6MqrgDm/FLbZHAcxRytqsxGD4PQz/xM35Ca
         Cymg==
X-Forwarded-Encrypted: i=1; AJvYcCX4T+6H3v5NBeOF52bojzCWRZPjPQ/qlsGkm8/sZjCkSx7qytVCUtPvlI9jho+nXHfMs2P4+Ynp7uFau1pfVNfN3+2Fzfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7CSdgqORbXqedsXAWpcCzaxhbju7rJ9Z2YsXMcNisfwmN5YV
	U//hjbjB8M7SA6tmmRV/Y/7p8cSjYjwzUsucp4WiUPe7q/1/dMVORmkiYlinH/PQjRQ4ysPWA3f
	C/KIcAJJQ70H71cKtY+fYek/Y+l4W/0+sQPc7NONK
X-Gm-Gg: AZuq6aIq6R9G+Vvc3uL9Jikji4IBMofO/2JcT/IKrP15vxH+C7RTV++cD/tAjiRA/NF
	91kCdyRgxE7XkKeF79mFYKaz4Cfgg4bHtFReFXffwbUYyeQGpmX/6cB5V8ixw42JUDvgo7LzheW
	Wo5rqFPkZP74v3umlpvCrcX23zG1A3gtIKDLtxXmDGaYN4BWxNQgf9Y5JkzW2FQWmQiyDJPJtjc
	2+cGZrnELgIteImmsw2/EDzdY+xTXTOEpJh0FAovmw15PsGKXp+5saYO26NDmS2qT0P5tA=
X-Received: by 2002:a17:90b:4f4a:b0:353:2e1:95f6 with SMTP id
 98e67ed59e1d1-35302e19f6emr3140023a91.32.1769042934569; Wed, 21 Jan 2026
 16:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhR4d7WXOVR7Y9ee2+=-t2nThzOo-ySMB+5x_87LfBJbZw@mail.gmail.com>
 <20260120155738.982771-1-whrosenb@asu.edu>
In-Reply-To: <20260120155738.982771-1-whrosenb@asu.edu>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Jan 2026 19:48:43 -0500
X-Gm-Features: AZwV_Qi1HCix4xsckn9CD1qWcc2lwKyi1WtdhvcHnLqnNUUcK8FpFKmTthwIsB4
Message-ID: <CAHC9VhRbZoApQE07giMxd5j3ri99uMuN8SQF7d6AgOZEkxuQJg@mail.gmail.com>
Subject: Re: [PATCH] cipso: harden use of skb_cow() in cipso_v4_skbuff_setattr()
To: Will Rosenberg <whrosenb@asu.edu>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 10:57=E2=80=AFAM Will Rosenberg <whrosenb@asu.edu> =
wrote:
>
> If skb_cow() is passed a headroom <=3D -NET_SKB_PAD, it will trigger a
> BUG. As a result, use cases should avoid calling with a headroom that
> is negative to prevent triggering this issue.
>
> This is the same code pattern fixed in Commit 58fc7342b529 ("ipv6:
> BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()").
>
> In cipso_v4_skbuff_setattr(), len_delta can become negative, leading to
> a negative headroom passed to skb_cow(). However, the BUG is not
> triggerable because the condition headroom <=3D -NET_SKB_PAD cannot be
> satisfied due to limits on the IPv4 options header size.
>
> Avoid potential problems in the future by only using skb_cow() to grow
> the skb headroom.
>
> Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
> ---
>
> Notes:
>     Given that IPv4 option length should not change,
>     this may not be a worthwhile patch.
>
>     Apologies in advance if this ends up being a waste
>     of time.
>
>  net/ipv4/cipso_ipv4.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I think it's a reasonable thing to do in an effort to avoid future
problems.  Thanks Will.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 709021197e1c..32b951ebc0c2 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2196,7 +2196,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
>         /* if we don't ensure enough headroom we could panic on the skb_p=
ush()
>          * call below so make sure we have enough, we are also "mangling"=
 the
>          * packet so we should probably do a copy-on-write call anyway */
> -       ret_val =3D skb_cow(skb, skb_headroom(skb) + len_delta);
> +       ret_val =3D skb_cow(skb,
> +                         skb_headroom(skb) + (len_delta > 0 ? len_delta =
: 0));
>         if (ret_val < 0)
>                 return ret_val;
>
>
> base-commit: 58bae918d73e3b6cd57d1e39fcf7c75c7dd1a8fe
> --
> 2.34.1

--=20
paul-moore.com
