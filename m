Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C61391
	for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811518; cv=pass; b=NcUdxoexfvpzrk3kI1JfrUY4MPzqyQl65hfdqzbFBlnqjSf7dYNHIapwn/WyNI5UEoEsd5oFlu8shec9plldKmf2fGZ4XfYoxcT6fpwKH2p8e2mtTXIbP7TSdSjIWaPmQRsd3Dk3LR24g5+3gIgSF5IRGafW3uOMBBcf2RvWyy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811518; c=relaxed/simple;
	bh=oY1lQ3P1ZilqdyP58U4Ykl0lz4M/f/VmqSSrG9PPckU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvhYWbAs+/QhPJI+JidCycKfu5fqOclHfpfX8SqjIU3NFPKsrMvQgh7fJ6hWj5XACiy88r/FsohVEctsJVKGl5LWNz8dDDJ8kW0gHkwRu5HvK/pPWLIIdubaf1No9MWzIB/lNgLSAUc/QseRLU7/QZ77ny1cE4lawCF9E0CUcaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BeSzxk08; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BeSzxk08"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b9ec9443c2so2482505ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 19:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778811516; cv=none;
        d=google.com; s=arc-20240605;
        b=Djtt3YDWup/SN9oUqtWjkEIR/FttISN/n4bhkzMtf7sRvDCqx9JQSq/MoNpRsRd8OV
         Fzo+36jP6qVYLfPg0xV9PocKlBcEQPZ4wF/gt6jXbQquBbA/uuw7OY2JZE81/DLuzJXF
         rxdNoewxnK0CnOoRlFWXnYZAFypLf1exv7oihNJr547mC6nHhukGQ+J+/3tQc/mXGdFY
         Q++8cm04xjos9Z/1q+/6YW1Ch8lFQnd/WGbQhnnisnNjT/BnebqBwVb2Dvl76eBmrxNk
         rlwXvH1eIqMTgJnjPlsRtvqbRhi4iJ0vRkk4xUng7P2M7WvVc+POxLNC3nD+yPF3pLsw
         YI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vf1lOMGWH0ruPN8io/fGwJ1GzNeUGqhpoaRyAqzopzQ=;
        fh=AVQw7h6Xs7wVgKacFffLRGzI16FeWNpqInOWi1who5w=;
        b=hpuvJc+Mn7Q0K19GXNMwu+SJeKZhQkJGFrYJj5H4FKuf86x9rrs3+9F0wUtztg9rDZ
         Dho9pxTgiRSqc1bwm0HaACaQeTLoHDwcjrKchfWt7f0ZstzvoufOCbv5bItuu7KzCIMM
         Ta3rZpPRgMTt8ChffrJScIgwiXX+ckNg2gfDKvSH02cm9GbPAfYmRVm5BbKP+SrENMr4
         8/AmZfxs94KA0rlDbTK8LYbBfM2TqlOa3f0UuP+/QoDFAU7nFcw61AgCiPezBwCvwPh4
         bV+E+256J0mbREwNKvnBYF6kGLZstDl92/IN5QwT6uRG0y0/0M/CK5lggTabonYXjZ5c
         BOQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778811516; x=1779416316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf1lOMGWH0ruPN8io/fGwJ1GzNeUGqhpoaRyAqzopzQ=;
        b=BeSzxk08I6OIcX5iAxYgjXq7o8x55BHd4YNnY0NS0217WkmNBRoPx0ue9miJrVdgZg
         y7oohCL6jEYgvtp1qavdfTfkhewOz7vvNElgtJKdvoowtPepwnY+QvKySO8U4D1wlpAR
         89Utpntaj6dQv9pu00xPx0Gg7bZ7b1l6WA1kXbEZLqbKKSZo66BJFVNXRYSJt0iSkLLu
         y+jSDP435FCT+PDEpWalNTX8dRx+5In2SIkE6s7TLhIzaWwzzWw54DpQM6FCYLLbGnNa
         CdU09jsTbgqhUa46AMsRXSwv5urvGKkivAlzaw5WqFtj+hzORnPNIIITXqMi36vCSUCj
         9WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778811516; x=1779416316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vf1lOMGWH0ruPN8io/fGwJ1GzNeUGqhpoaRyAqzopzQ=;
        b=pzftlbTUgO6zY8u4F1SgaXf14QqjpdZQlAAjewY1ElYYtUtCdfw8ZT5UjMxzvJyczq
         p1cNwcmnOdXgv1DBnt/c38YP01sB9hULeEY6jqRNrAhvAF5HP54q+jVlTUa+2oGm4IK+
         otDXm8CJKpOKCqnqyiq2KhscwDNRlWL5JfkkKTTX273aKEez21XYOxKhn8pQOQa9xUDr
         i81sN8toBa5Fvt2ThsrhnYIBB3YfSZhZISlo9kRszfcQm2dTG1SveUdN9WQ0/vkysjgf
         xaB/ueLhh2lIM/gYgu2i4FmCCEFq1EirnsCirVcZz77GDrn0yP6rWHF4TYDsFmbLB5Vh
         24qw==
X-Forwarded-Encrypted: i=1; AFNElJ8jvBL4OhCfeFA4vny1iZl6uyk/UEJ/MKjlr3Km+SPP5WaR+Lo2ymGNkrwr3WV9zRdpQdw347rxk4RTDraxUjBx6EDZ60M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvKwmNYHTJYlWDH8Ouxz+rR0SZHOv6WfX1Ngov2gmVf4srKBip
	Clx+V/RPcL0cEePfKuWxuxC5osLkODvYuXixOHoResFDnvAOJ6W67ienM0JFyxdStWH3t4Guv4r
	mbMayceJtuqjLSRH24el+QhncLhMOG2jpBQkDroda
X-Gm-Gg: Acq92OEDjBdJ7msWuPybcvJgApuWYO6QEgZHuFcJTcbHzZnPUFMdEQd+k/9CfeREt67
	tAQpZZnPwLFiunuIrnnYjTVv8WTvp6SZsHDmfoMjPcfdGAVJCv2PqZsr6FoE6CN2awP2JXlLGHW
	vtfoBk1+EkCUxUG83UjNcjLPoCdram5L4D1tfv0wLAqUQi5RS4VeybAFZhr/weEoojj4VJyn2K0
	I4SkML5s/++MyNSoI0GTuNIzwB/HWb0YQPZSFY/jtGpwAL8WnbVv/DzKZJ+RRtJvIfjbTKvdcZI
	T8yBYhA=
X-Received: by 2002:a17:903:1b45:b0:2b2:9a70:3f0a with SMTP id
 d9443c01a7336-2bd7e7f4367mr16519065ad.4.1778811515808; Thu, 14 May 2026
 19:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514165139.436961-4-tpluszz77@gmail.com>
In-Reply-To: <20260514165139.436961-4-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 22:18:23 -0400
X-Gm-Features: AVHnY4LQcW6Jta9CPrYmHE8qeHN2b-YfTvmsWi6kwWzlqgcNGjKECLZviQqmFKs
Message-ID: <CAHC9VhR52b2FbD-aiMFsaXwwRrUGTLSdRFzWcVAZjUm-K3qgkw@mail.gmail.com>
Subject: Re: [PATCH net 3/4] netlabel: validate CALIPSO option against skb
 tail in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 12:52=E2=80=AFPM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
> header via calipso_optptr() and hands the bare pointer to
> calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
> calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
> calipso + 10 for cat_len bytes via netlbl_bitmap_walk().
>
> ipv6_hop_calipso() validates these bytes only at parse time inside
> ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write
> reachable from an unprivileged user namespace can rewrite both bytes
> between parse and the SELinux/Smack peer-label consume path
> (selinux_sock_rcv_skb_compat -> selinux_netlbl_sock_rcv_skb ->
> netlbl_skbuff_getattr).  The self-consistency check
> (cat_len + 8 > len) inside calipso_opt_getattr() is defeated by
> mutating both bytes consistently, allowing a ~232-byte
> slab-out-of-bounds read from calipso + 10 whose set bits become MLS
> categories driving the access decision.
>
> netlbl_skbuff_getattr() has the skb; gate the consume on the option
> fitting within skb_tail_pointer().  The IPv6 option layout is
> type(1) + length(1) + length bytes of data, so requiring
> ptr + 2 + ptr[1] <=3D skb_tail covers the option and its embedded
> bitmap.
>
> Runtime confirmation (Smack peer-label policy + nft HBH mutation):
> Udp6InDatagrams increments to 1 with the mutated cat_len, showing
> selinux/smack_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
> calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
> option's true bound; with this patch the consume path short-circuits
> at the bounds check and the counter stays 0.
>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 3583fa63dd01f..4af8ab76964e0 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1399,11 +1399,20 @@ int netlbl_skbuff_getattr(const struct sk_buff *s=
kb,
>                         return 0;
>                 break;
>  #if IS_ENABLED(CONFIG_IPV6)
> -       case AF_INET6:
> +       case AF_INET6: {
> +               const unsigned char *tail =3D skb_tail_pointer(skb);
> +               u8 opt_data_len;
> +
>                 ptr =3D calipso_optptr(skb);
> -               if (ptr && calipso_getattr(ptr, secattr) =3D=3D 0)
> +               if (!ptr || ptr + 2 > tail)
> +                       break;

Is there a reason why you simply break here and drop down into the
unlabeled code?  I would think we would want to return an error here
since we had packet that was munged.

> +               opt_data_len =3D ptr[1];  /* IPv6 option data length */
> +               if (ptr + 2 + opt_data_len > tail)
> +                       break;

Same thing.

> +               if (calipso_getattr(ptr, secattr) =3D=3D 0)
>                         return 0;
>                 break;
> +       }
>  #endif /* IPv6 */
>         }
>
> --
> 2.47.3

--=20
paul-moore.com
