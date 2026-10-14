Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05B4FDE71
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986571; cv=pass; b=PeR5pdP3tMNvj/M4V5cyLc3JuLoxo3RbPPKA0S4qlx62QlSIBwNXSBKcKpMRihsiahQHCUXRAzcxxG+jz8d8keJ7rdsB8iG/skIjCZkrRD/3d6kMiWPuW7Ad/fjESoonPxkPchli/Vs0T0Oz44vX5PPrl0B4WMrS/CjTeBp22qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986571; c=relaxed/simple;
	bh=YEOv0lkDuDfe1/lH4QgCR9CxwKBKYUyc20EQrB/D8SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLOlZSJfXatsySjfShrngNq8rTcdfS9dMUpGXLYEz1rC+J0uJpD8WK/06Oq7XAzFgMXu/BOAiE7k/ZQCNF4pvPXCqkJQS6u7aa32IC/hQLC/FBVqBbeqxi0cOKiPOQcDeXSYZguZT5Zy2Obf+qPy1dMboP4bTrr2WZ6kZDSmw7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d+W5A5+U; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d+W5A5+U"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8874539bccbso269729b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 07:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791986565; cv=none;
        d=google.com; s=arc-20260327;
        b=oOfrOjnb+a54+/CVr8+PUC9MlPXlo/MmtSwSgv6cVzXCJHh4viLgRz+TKde77bRT+0
         t2HANXiAqglupL5zGlVVAXsPAZX+PPrLX1kZwn01G+p4VWhz+BXhFceBD1JPdmqjtG7B
         NZoHXLBK9RBloXcO6GPLu67UvuXqCIJKOMMKXwVji/eJ3k1ceU0HJSRpJLrvFyGumVxz
         nk3NTbbnXLkx9ljiW78IXR95cWwu3bcJQnZkTAfZmXuta6OtjxyfktHdSwsInb4S1CLm
         9M8TdGmxYpUYi2F4CVFhwVPc306wSLelP86EeFceD29SLmOQnAh0d5EAv9cSK3ogD2xC
         PQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UQUVLUG7DltcFgXT3o9WfFA1jOm16iz6IC0qdjR5XQk=;
        fh=wGIfM4SDsvwXTYm+1UMI8PCP4gvc4mmOjGq8ffGSMew=;
        b=Gkgzvj/UvCMCvDFJvlw1wDpHf9uhWGJtgTIQGGy11P3otH9HcOjrp3qz7n9gFtXBR2
         SQ1IQS4Fc+oRZZNNpZAoEW8NfuljP1MIJRiFInVp1dl941yEEUUHX5ZtMvU+ZF3sA1yV
         Ils6y2yB88vSygYGQz1nRIqA4YCHjW4kaXZwMWmefE4YNdbEXTeqTAqbr6gvxtnrinzg
         wuWni9ykdcyyyv7p9srAgEn52XJ9O+x3CpkPzd/VJ4+hwUjcGzbtyF8w+3HRGH7iXVnj
         NCTJc7plhyyhuW/20/ZbeZ89YbFKZwBL/WisXfn8KbDrmagTj/EAvJYbZJvULHPAV0GN
         2msw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791986565; x=1792591365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UQUVLUG7DltcFgXT3o9WfFA1jOm16iz6IC0qdjR5XQk=;
        b=d+W5A5+U6rzHJzVD1BSoja5W5eA+EBfUcI6ZP4fGavFpAPc/U8FgzsZzmMyfr5x4hI
         WBUg9Lw+WtGCHQhD2fXts4e4qqvYZxujYuo7eL/EEkSjeW6s7WRM+Cu2axh6Ma1wyGhe
         1R69b0q5N5h6uM2a8PK6rK0wlSqybicQta176TeNqZzw2oymnm1Akx24ql69Sw37t6ro
         p61M2JBuF6pXOvhQdiD1ZT7Iz8HQk43PiWi/zwZKVchO6BEYiz6zFCDIDNgDKwiOr1O/
         nszUH2Ixc7y2E9LOAIFcOJBFhT7GQY6fPnO+VafZp15xUkan3/a/Qkhfj1CTEKJZI8IU
         gVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986565; x=1792591365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQUVLUG7DltcFgXT3o9WfFA1jOm16iz6IC0qdjR5XQk=;
        b=iIhA1bBYxsm4xcAM+WBiz+8TKy9p0tMOHATgF9RififEVYuNBZgP6aeNqHwD314zlQ
         2hyIwv/8q5oUgfKuncf8ud72z/o0GAcdBE5c03kGLTPmLgJ2BFO4Zsn3tJafX/v1OB9l
         ydsckHRHETrUAdFqKZQUH+j7aJcwAEDbuDVbHscP6eF+rlH8CpUsOseN7OBW6xCN9hdk
         t3ZrA57TbmSzG8ZHIwy1PDu68bILRnkVLBFwyL0Zc3YRnzwWau+iCwyNqzNhiOnCFkpB
         eEjtqDPW+MtTbXA+EoSx14nfFBRyqvbQ1Ks2kNKgDqxvL4Y/9vtSLFAMSAeI+/ollbyO
         mncQ==
X-Gm-Message-State: AFq9FYLWeiVp/1eDxv+aTVc7RQG8xBP9HK8R7JbjMQNUxLntNVCj4149
	hSQx8A8dok0jCK7y9EVzAOz4mW82kNb45kILy1d5I2ZuuKDJb/EVraTXyUMfti8B4pzpC1W3wec
	+GtbkD954WK8pT41w0gVuFynf6xmLAaVLN9iv/kPdn/JjjaZXkRDSf388
X-Gm-Gg: AYBFou3Bp1MT8R5WM5aWNFHOtg37j4SszxIfvQzKMPjbrErHjMDFM+1wy2BMxNk6v2q
	UD5CN2W0V0yEekZjfSM01/bhGC/Mos9bVjvA4ajn//hWgKBLsi5WYvgYrlm1lNf+tf1J4XjNxld
	1T4xfJwiQJJiZPu0ejB0M3XMwA1GLpANBuVkLyTcTlHxKDtMXjwzBAvpVQeButZoouZ/fCwX/rt
	JIpH/w8IFduEH69HbimOfXkicznKyR/8Zqy5h6yAiaEKpBfaoZ7rU4vEb5vXUwpy79Tp5isg4hl
	tLYM4nl0yopZKEmt7f2eunWwegQAbqB14hMkHH8clNHk+9To/tVj0Y2Os6bHreXgwO05kZ0JRfz
	CmPwfR7+5UXQ=
X-Received: by 2002:a05:6a00:808e:b0:89d:e6e2:b2a6 with SMTP id
 d2e1a72fcca58-89de6e2b696mr1267507b3a.45.1791986565407; Wed, 14 Oct 2026
 07:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179147329205.58079.5847298721173675285@gmail.com> <sashiko-outbox-165773@kernel.org>
In-Reply-To: <sashiko-outbox-165773@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Oct 2026 10:02:32 -0400
X-Gm-Features: AclHuK8TuxrF8-DsjOzDAUY_v3JLgEdrFU4cDHorWjqtWqZ-YeQ0FatFCmw8g4g
Message-ID: <CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: update payload_len when removing the
 CALIPSO option
To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 11:32=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] ipv6: calipso_skbuff_delattr corrupts MAC header on bridged pack=
ets
> --
>
> commit 9797bee2d14350b4afedb726df3172b004b7badd
> Author: Joas Antonio dos Santos <joasantonio108@gmail.com>
>
> calipso: update payload_len when removing the CALIPSO option
>
> This commit updates calipso_skbuff_delattr() to adjust the IPv6 payload
> length after removing a CALIPSO option. The patch prevents forwarded pack=
ets
> from being dropped as truncated by subtracting the removed length, while
> leaving BIG TCP packets unchanged.
>
> > diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> > index c6a34334e657e..5a42db4f87472 100644
> > --- a/net/ipv6/calipso.c
> > +++ b/net/ipv6/calipso.c
> > @@ -1428,6 +1428,10 @@ static int calipso_skbuff_delattr(struct sk_buff=
 *skb)
> >               skb_pull(skb, delta);
> >               memmove((char *)ip6_hdr + delta, ip6_hdr, size);
> >               skb_reset_network_header(skb);
>
> [Severity: High]
> When a bridged IPv6 packet with a CALIPSO option is forwarded, br_netfilt=
er
> feeds it to the NF_INET_FORWARD hook where SELinux may call
> calipso_skbuff_delattr() in net/ipv6/calipso.c. Does shifting the IPv6 he=
ader
> forward by delta bytes here without repositioning the MAC header create a=
 gap
> that corrupts the MAC header on bridged packets?

I haven't chased down the bridging code to confirm if the problem
identified by Sashiko is true, but I do think that in the bridging
case we don't want to change the label on the packet as we might do in
the routing case (depending on the runtime config).

This would need to be tested, but I believe we could simply add a
nf_bridge_info_exists() check to selinux_ip_forward() prior to calling
into selinux_netlbl_skbuff_setsid().  We would need to add dummy
nf_bridge_info_exists() when CONFIG_BRIDGE_NETFILTER=3Dn to
netfilter_bridge.h but I can't imagine the netdev folks being opposed
to such a change; I'm sure they will let us know either way.

> Because bridged packets bypass L3 routing and do not go through
> neigh_output(), the bridge's transmission function br_dev_queue_push_xmit=
()
> unconditionally calls skb_push(skb, ETH_HLEN). Since skb->data is shifted
> by delta bytes during the pull, this incorrectly frames the transmitted M=
AC
> header starting delta bytes into the original MAC header.
>
> Could this result in the transmission of gap bytes and the loss of the
> destination MAC address, causing severe packet corruption and drops on
> L2 forwarded packets?
>
> > +             ip6_hdr =3D ipv6_hdr(skb);
> > +             /* BIG TCP packets have payload_len =3D=3D 0 */
> > +             if (ip6_hdr->payload_len)
> > +                     be16_add_cpu(&ip6_hdr->payload_len, -delta);
> >       }
> >
> >       return 0;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179147329205.5807=
9.5847298721173675285@gmail.com?part=3D1

--=20
paul-moore.com
