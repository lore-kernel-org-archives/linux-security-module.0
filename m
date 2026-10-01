Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82705385D9D
	for <linux-security-module@vger.kernel.org>; Thu,  1 Oct 2026 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839751; cv=pass; b=j+lJGuD/QvMbLT3HryM7DkKPXapjqHGbGWqkoqsIFYQfqo148YknmUEXeLhfqKj/kzO93hEzo1Av+1mpz6bLoEqIM+ak0kfuQdVRKcFDXNkkj5rv3lFRduSD94Y42PiunnoHljagWFCGW6JN/QVamLyGSCjzkC89tRDgq7ryNw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839751; c=relaxed/simple;
	bh=bSnKMPQZl5T2KfmiCD87MTWzFVfmb9E14C3WiZ0dnb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIsh4I+wGdHnAntLUmjDz1uS+5scvB97psyUUcLpqCW3ehEOvCpC4JmZPlRRecpm6vOsDZxG8LJdxOEXPHqD6/hSL1zVuAeY0JvDMSfFsJWSZkm3MS+qV+iaxuGPbMNFwU3CUsRK9YRUD1KC8VypUYMS77RthiQ57dd7QFndLeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzPop5l7; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzPop5l7"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1460bcc512eso3776051c88.1
        for <linux-security-module@vger.kernel.org>; Thu, 01 Oct 2026 00:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790839744; cv=none;
        d=google.com; s=arc-20260327;
        b=haZKbvNYomub9U9LFUiOkRzzjGjqPijgBc72nzfLvleZdP6vzRr1qrntEXswPGv6xl
         kW1vOhWDAWO/J7GzsQiWaTUsneyvXczaFK2SqJBz+9yUzLi810Z+IO/5jghbb1OMVXJ4
         COWhz7VUGGSjWFUQX61YhDZMsBAdI7k3Q3kJzpM1UhOZgyFP1TMZh5BOyKPnSALFD695
         7fbbvRkvFGew4OmZ1ONLZOgmaJYaAyA9zp77K1bHViOM7STdykkQ2SmYpTFuINdc3oJ2
         ThbirRyJAaJGWiqk83YG0DU3CJuKCFTTjvwcaBzc5HSdCUG7NrURMJbuqO9FOU13IDZ3
         n9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MSkLrXkaOizj7D0wzYU4iL71lfarU60xcuW4v3wm00s=;
        fh=1PvHLFloDZcTFYlTVEJ4VVPXym29pkQfV0zYJPwWi40=;
        b=H28JPhM4WqkRryQK6g6ZLA/un05hBC6b8qW4atu0uAvAZrCPhXxK64lJXB1g9sik/K
         o0vZ50SpfLfcAgIOKmScquI7Ql88hnK9DkkDQ0WuzRe2DyoCOLd1H8s6j1liyaoi/S1Z
         dEJAifQn794H8Q9WIGvtqg4DBbAtmZLxldfDt6kxgeZvmkE0BHgLZlqybS7VR5ANgc/n
         /gBHnMT3ja2ra2Yp6CmsdLlPeKWan0p4q7dORRqfDLj36zGDjnXWb0SJqXLYKxgVULu/
         hG1C5V7zETLf5uCpGFfpkcRiZsBHn7Udf2KF46sgvYUV0CUM+o0JTq70tJ2n9T1yP2Tt
         xTUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790839744; x=1791444544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MSkLrXkaOizj7D0wzYU4iL71lfarU60xcuW4v3wm00s=;
        b=PzPop5l7VsTr5Kt9koLdVHNlAltfhwrjfKcEgU66JErbDQRcCSRL4PmddSXjlDjQhX
         z2x6HTkiUOhFyY071SO2dzu8n3xnTK3UiOFbw5L4/gk5SGLsUpJDU4IV4mYBXYHiI8LN
         8EUyrK2hJ2iDAQxr9hGduuCnrQbjJCBQzzWvgGDbwo47P4JMyJYDChaHwgLrw71XQ55B
         IhrFZQCFK6SXSux+cuytsuVARnxKImQxCLJk9BihcSNe40aXHdeIrtlzsDiEK+494H+V
         8mIDfny+7GrDu5E2O76j1W9fCP1ur7o3LTVPsgcZXicMxlu8a7AFdkkWbGhAh5hZvnmF
         8Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790839744; x=1791444544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MSkLrXkaOizj7D0wzYU4iL71lfarU60xcuW4v3wm00s=;
        b=ucUKdxBTZeMIf9dbUfCR/IfL3PxtAf9gj4dzHp/sg8dH/hl2P6csAowO5ySDzNQppJ
         D937YKAWRgA4xjNl2H1jb6uYxC52tMNibxTu1ucxrathBnRVlwj0O90Zc7cBIDY0a1iy
         iB5kcyTskpStTSigyfWpofJx6eldQjd0VuXakBHyEQJ0HK1ZAwv7v1fwdj9z+DY2LkOv
         KQKD0AmqYL+ZOuR1VRW2brKPppa5xNgzS0lkYNaGXUTKd70M2JzlLioTI6xuOjvAmHNo
         h9WC2wh+ec29g9jx1Idd3PjWKhgYsBc5kYwUxUcEqcmyKAdKUIUs3bhMQHMz4T1KUzk0
         Q8rw==
X-Forwarded-Encrypted: i=1; AKwUvByHfRL41LZVoXnptYZKkXlc+aRBmyPfTbFeWRGaCsUQ0++n4ilIxEEu1Tg9UWuTTFUwDePdReU282bf0giKswQXJoiSUCE=@vger.kernel.org
X-Gm-Message-State: AFuF++kmwMXDtcFM/rIjiwj5VgkgfX79REJrfHGFATL6+1XegNqtmaYT
	MhBcaXadZyhTJTgrFVj7k9/Z6FJInM2kkgvlFQOiUD/s6xs3gEiow9+7PD/i3yjXfAYZEIwRos9
	Md2g0tiKDolqZJF97em0DxYqFvnP4swA=
X-Gm-Gg: AYBFou1WlOInhs0J8Ja3LROCKXLIsdbCkkqtu+1lyij3b4hK9R39S01g9YF+fuFGbvm
	nLS0U1RkH/9Iia/jjax/OB1IklXkL0KwTD19wjsSSL/KOt0RgXSnmpHqNd4zsdXeHuABnlwuBbd
	/4bPFiBTUUA7E2cldVfxbLgv9ZcJ3jwaBLfYxi/TuKAVeOhFgYuNCWVEsqql8R7JNuctBJgf/hg
	5TQ7Dt1qjIbq2qAzTqmoBvM5EXXvPJvm+Tf1spf+1VZZ1pb3ddpePsRucSlHcsMz3RGhhAZV3DO
	lQvZnZiW5sejxBiECIIONw9YMX5Nr/3JzToFD9KMLlxPzl6v0VNftiJV4dlaOek7AEDnTl79Tro
	NE34ZtxjF+ew=
X-Received: by 2002:a05:7022:ed02:b0:143:2701:9198 with SMTP id
 a92af1059eb24-14d33491b4amr3415031c88.36.1790839744378; Thu, 01 Oct 2026
 00:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930140400.2955466-1-4ncienth@gmail.com>
In-Reply-To: <20260930140400.2955466-1-4ncienth@gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Thu, 1 Oct 2026 09:28:52 +0200
X-Gm-Features: AclHuK8NL8zF-fuO6CKIa2qv-pSt6H66vE25JFzy2CmX4sYI7l1OWuYhQRHBVmQ
Message-ID: <CAAUqJDtoYAb30bEOhoRNGTR4KLP2fWJpmXqu7o096GHFJZKi-g@mail.gmail.com>
Subject: Re: [PATCH net] cipso: adjust cached option offsets when removing CIPSO
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Sept 2026 at 16:04, Daehyeon Ko <4ncienth@gmail.com> wrote:
>
> cipso_v4_skbuff_delattr() shifts every IPv4 option after CIPSO left by
> cipso_len, but leaves the cached srr, rr, ts and router_alert offsets at
> their old locations.
>
> With a valid eight-byte CIPSO option followed by a seven-byte RR option,
> RR moves from offset 28 to 20 while opt->rr remains 28.  The stale offset
> then points into packet payload, letting the sender control both the
> length and bytes copied by __ip_options_echo().  Setting the length to
> 255 produced this condensed KASAN result:
>
>   BUG: KASAN: stack-out-of-bounds in __ip_options_echo
>   Write of size 255
>   Call Trace:
>    __ip_options_echo
>    run_cipso_stale_offset [net_candidate_probe]
>
> The destination holds 40 bytes of option data.  In an existing
> uninstrumented x86-64 v7.2 build, __icmp_send() places that buffer
> immediately before its stack canary, and the 255-byte copy also crosses
> the saved return address.  A canary mismatch unconditionally panics;
> no canary disclosure or control-flow exploit was demonstrated.
>
> Mirror cipso_v4_delopt() and subtract cipso_len from each cached offset
> that follows CIPSO.  cipso_len is the logical distance moved by the first
> memmove(); hdr_len_delta includes padding, while the later header move an=
d
> network-header reset relocate the bytes and their base together.
>
> The adjusted input leaves rr at 20 with length 7 and completes without a
> sanitizer report.  Natural remote reachability requires a configured
> SELinux/NetLabel gateway and a later option consumer; the retained test
> invokes the real mutation and echo consumer directly because the availabl=
e
> rootfs has no SELinux policy or netlabelctl.
>
> Fixes: 89aa3619d141 ("cipso: make cipso_v4_skbuff_delattr() fully remove =
the CIPSO options")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  net/ipv4/cipso_ipv4.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index a05aa075de1a5..135b57c2c4f9e 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2272,6 +2272,14 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
>         new_hdr_len_actual =3D hdr_len_actual - cipso_len;
>         new_hdr_len =3D (new_hdr_len_actual + 3) & ~3;
>         hdr_len_delta =3D (iph->ihl << 2) - new_hdr_len;
> +       if (opt->srr > opt->cipso)
> +               opt->srr -=3D cipso_len;
> +       if (opt->rr > opt->cipso)
> +               opt->rr -=3D cipso_len;
> +       if (opt->ts > opt->cipso)
> +               opt->ts -=3D cipso_len;
> +       if (opt->router_alert > opt->cipso)
> +               opt->router_alert -=3D cipso_len;

Minor nit: IMHO, it would be better to move the added bits to the
block by the end of the function where the other opt->... metadata is
updated.

One way or the other:
Reviewed-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

Thank you for the fix!

>
>         /* 1. shift any options after CIPSO to the left */
>         memmove(cipso_ptr, cipso_ptr + cipso_len,
>
> base-commit: 99b43ede9e355ba35244cc9470bf1819774ce39d
> --
> 2.55.0
>
