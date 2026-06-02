Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B6373C00
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780370259; cv=pass; b=D5LX3O16IzxvFB0TY+2GTuab6J6UZKcm6lSa/e8lDBgCnqUA0GWEF90/xqBk4/X7AOlsz8Mv1jaSX3Ycvr9kzKbF3kRrQNvHYmdTOWBruvOkIfDEGhjFTERN3tt/Z1YWQlKaQzXnxzOg/ZP5Owjp5BLj0fECCCvIh3jrdyJcn1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780370259; c=relaxed/simple;
	bh=NrNtds7Xu9hVrX2Bnojh/FQca01+7oLkxZWeAGFo1N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4Xh8i1K3xeCD9n+vuJT7EYmn3VDj6pYYhYwWhjiHOUDfGQZVwscHg/sOqVJNi4uvH3qYpK9/O6GvLynRxoc2IOKPZmsFZFh5bm4XI7MoGDv1HxIv8inc+lBDJaR3yTY4N9FuqD0eustN7ueaVdkv0a/UwND57fL5eKPnhhVCYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bcf3oh79; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bcf3oh79"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf1cda2b17so29354215ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 20:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780370254; cv=none;
        d=google.com; s=arc-20240605;
        b=F6gv+dBQxGMpw0WJoR7uhfCWdDWYiyP2nlgkOGpIVAw1LfnIX3duLMES8JxKv0y79v
         4O34Jk2GF+nAuJndYbECUcAhadqtKOk9A79vaa8Og0AuqUex1/9FooMJiMdRD8A4WLfU
         dPeyXoT9ManaqfaRV2pIy/55lSnWdLzjqDAVuH3MiTG8edSjNU2G3D0d32vxrJbJMS0h
         tn57rcekuz3KPZtPaP4lGj8Qk2NlNUBAkM/ah9NFmJrJ4tWJ2nhKin9prYtd0RmBLvYx
         rDY7P+kr6j3JtW0xtv40JsBUjCxYagt+AzYWAX4o+mX9sKIThhRjHwwdRQLTuBAIdz+5
         vgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRbGrDPr8/1rgB/5c9BpqqyHTaNQfsdpMIViVvNKLvo=;
        fh=zsgwLSpN4+L/IBYaabGsCCdJdwtdv2JodzWvTAWrA3w=;
        b=kA/bVP5fb3UxaL9cCcalwrJ6+S/MtBF5lr7X5Hzly9fbB+x8OEJgNvKTIwzCENOnbd
         0awQmVsPNXD3typb0u7lLzU3Aq2u2S9vRn99EOmXue6G0uG8TQw/3w72TuIxIHlCXXw8
         fcIsgjiN0ptrDNDvzFE068z1AC3E/Jzn6zpL9C99ufZ8XvpqG8iZ8D/92APWnj3RhlEE
         NnHsSMp11AYIm3zlJ3wJyAI/yDqJpQNzbZmcWEGRdVpgKhi09CQU3OEhTGUhuA55AdUO
         jr6wZYAQRIyWslGucDP3GNUea9DvEFSgCr8Ei7oHkSRQh1Wm2OEmuqcFiChFDVLvSy8E
         i2DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780370254; x=1780975054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRbGrDPr8/1rgB/5c9BpqqyHTaNQfsdpMIViVvNKLvo=;
        b=Bcf3oh79gvB1y1h6vk6ljHru9+bI24G7Wt0cxnV3x2oqt4H+GGZ4DFS9ILOrcW4dP6
         V0p3wzXsBwZszoOzXJhS+v7nMMJIGcjNFtDp9hwFrp90GciKOsTBjMWlmb6QFTBE3kpK
         ylYebVEOBN9LgI50lyAo2D5aUQv64AsXOr6jnbF3lbFZ3PmYla5HfXVUlQp0N/JGBWGT
         iKbrbYNcVvp2TZIpzqvNgzxL0S/6nPrzo+BrNRwScJtbnMJRFnnMm3J9JDtUFrpmCKpT
         UrxKsuk06jXGm9Bs9FINYcVXGGmlp/VBOseRSLqWXEJQK6kEaXUYFVN1Y2Lgs1a1da6Z
         9TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370254; x=1780975054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRbGrDPr8/1rgB/5c9BpqqyHTaNQfsdpMIViVvNKLvo=;
        b=l9QMvKEiLJ1qw42et0vARu2TyWqYkxrEo1jezPXXlgzewAdyHtSJy4IR2Ei0aD9sva
         Uf88H5mSWYM5iUsJ11slfhCUlmvLz67sVuyOPS8Jdoq7R0CfHbbCKsngvnUgcfrKUK4B
         FCfLDPwhSUemn9tGRJEwE+oUqfbZzwBS01OskZk8VFbcTdH4H+xQjTDedFsb1STNvg0F
         XTJSJd6ibK64LGqvCNdNmBO8lopLwuLBZebfjMTIRFhN1zWWS8XxISgnfIlHscjCQVuM
         wUaHFVQ3eX/Cd9ziF8w3xnAnEBc6IbywfDdQtSnZy0YZdl+N4+xGEiyMO8Ba7OJUZPbL
         Y9Fg==
X-Forwarded-Encrypted: i=1; AFNElJ/GgtGHuGixNrbn5AIgP6HHb70+H+e6b0FYDROBx8tr1cyF0EK3arMV+Jv9i79r0dRbITAJtOFaYHlohQwFcNhzvMF6DZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4R/J+B8LRcyU5QMfRtevCWZwvMHwUMpj+yErJ5MS/Q3jHTLul
	6b/9JBEC2c+qJaioUVGv8zQB+wczm6UJOPWugHu+W/PPp4ZbR9bIHwkOuFAXtaOgr4yR4u6520N
	Wg15A0iISP1vZTnLq5Wr/fB9m/5zaXtN4pDYwSnkE
X-Gm-Gg: Acq92OFHNKJVaFGc87VRYkBwza0K7aGunivqO2s575dwtR2FHwyykv4lzsPASo/n/kG
	Mti0yEf9pcHL1YufeYWtaBsDcNxUYmno6iyAvmXWTXpXmgQGd3mmoPgBkTYUBDgvGzpGlMTM3wq
	SOHOZoyMpQerowoYIfUtGrTXs1VdhDjQIb1xmz9UCc/+g/djKmJZCzGgQmanzr/aXujXun8O94o
	Nx9fgrdzlx0ncLqh82u8Nd+yIfcNhQQIav3E9In5oGYnOQb/nqjjYVtM4o/jtpL+k8DVGMvJuV7
	+AlCvp3cGiZHpl0X6A==
X-Received: by 2002:a17:902:fc8d:b0:2bd:9b0e:b43a with SMTP id
 d9443c01a7336-2c10cc48783mr20042485ad.7.1780370253972; Mon, 01 Jun 2026
 20:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524041442.2432071-1-tpluszz77@gmail.com> <20260524041442.2432071-5-tpluszz77@gmail.com>
In-Reply-To: <20260524041442.2432071-5-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 23:17:22 -0400
X-Gm-Features: AVHnY4I4W9V-dv4I-l2LKCn8EXbQx2RA0Mt-m8Ql8JMgxlHNkMBkt_pweVb2PlI
Message-ID: <CAHC9VhQikjqG_CZfXy3vJP3Os0xNw9jjGoMdLmWiy5epU3gxcA@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] netlabel: validate CIPSO option against skb
 tail in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, fw@strlen.de, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 12:15=E2=80=AFAM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> netlbl_skbuff_getattr() locates the CIPSO option in the IPv4 IP header
> via cipso_v4_optptr() and hands the bare pointer to cipso_v4_getattr().
> The consumer re-reads cipso[1] (option length), cipso[6] (tag type),
> and then cipso_v4_parsetag_*() re-reads further bytes from the skb.
>
> __ip_options_compile() validates these bytes only at parse time.  An
> nftables LOCAL_IN payload write reachable from an unprivileged user
> namespace can rewrite them after parse and before the SELinux/Smack
> peer-label consume path (selinux_sock_rcv_skb_compat ->
> selinux_netlbl_sock_rcv_skb -> netlbl_skbuff_getattr).  This is the
> IPv4 analogue of the CALIPSO IPv6 trust-after-modification fixed in
> the previous patch: the tag parsers walk the option using attacker-
> controlled length bytes, producing slab-out-of-bounds reads whose
> contents feed into the MLS access decision.
>
> Validate the option fits within skb_tail_pointer(skb) before invoking
> cipso_v4_getattr().  The pre-tag-walk guard "ptr + 8 > tail" covers
> the CIPSO option header (type + length + DOI =3D 6 bytes) plus the
> first tag header (type + length =3D 2 bytes), which are the bytes
> cipso_v4_getattr() reads to dispatch on the tag.  When the bounds
> check fails the packet has been mutated after parse, so return
> -EINVAL rather than fall through to the unlabeled path.
>
> Runtime confirmation (Smack peer-label policy + nft LOCAL_IN
> mutation of tag_len): UdpInDatagrams increments to 1 and recvfrom
> returns the payload, showing netlbl_skbuff_getattr ->
> cipso_v4_getattr -> cipso_v4_parsetag_rbm -> netlbl_bitmap_walk runs
> end-to-end past the option's true bound; with this patch the
> consume path returns -EINVAL at the bounds check and the counter
> stays 0.
>
> Cc: stable@vger.kernel.org
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 04f81f0154e4 ("cipso: don't use IPCB() to locate the CIPSO IP opti=
on")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index d0d6220b8d59d..c2d3ea751f4e1 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1393,11 +1393,24 @@ int netlbl_skbuff_getattr(const struct sk_buff *s=
kb,
>         unsigned char *ptr;
>
>         switch (family) {
> -       case AF_INET:
> +       case AF_INET: {
> +               const unsigned char *tail =3D skb_tail_pointer(skb);
> +               u8 opt_len, tag_len;
> +
>                 ptr =3D cipso_v4_optptr(skb);
> -               if (ptr && cipso_v4_getattr(ptr, secattr) =3D=3D 0)
> +               if (!ptr)
> +                       break;
> +               /* CIPSO header (type+len+DOI =3D 6) + first tag header (=
type+len =3D 2) */
> +               if (ptr + 8 > tail)
> +                       return -EINVAL;
> +               opt_len =3D ptr[1];       /* total CIPSO option length */
> +               tag_len =3D ptr[7];       /* first tag length */
> +               if (ptr + opt_len > tail || ptr + 6 + tag_len > tail)
> +                       return -EINVAL;
> +               if (cipso_v4_getattr(ptr, secattr) =3D=3D 0)
>                         return 0;

I'd strongly prefer if you moved the tag length check into
cipso_v4_getattr().  As you've already validated the CIPSO option
length field it should be a fairly easy check, no need to test it
against the skb's tail pointer, just ensure the tag length doesn't go
past the end of the CIPSO option.

>                 break;
> +       }
>  #if IS_ENABLED(CONFIG_IPV6)
>         case AF_INET6: {
>                 const unsigned char *tail =3D skb_tail_pointer(skb);
> --
> 2.47.3

--=20
paul-moore.com
