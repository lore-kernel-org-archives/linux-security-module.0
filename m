Return-Path: <SRS0=Cp5G=QU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C99C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Feb 2019 21:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604C4222A4
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Feb 2019 21:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="b9cuU1RJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbfBMVmI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:42:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39714 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbfBMVmI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Feb 2019 16:42:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id g80so3360247ljg.6
        for <linux-security-module@vger.kernel.org>; Wed, 13 Feb 2019 13:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvNtUD893tbCTBK+Aa3/Gob1b+OLwEJljGIV7sI1ZxA=;
        b=b9cuU1RJ4Q3ceD+KFgdVWXEJSTu8ZZiZJJSRnIzVwHnmlJasqbKR5hPsKnWEl4z5j3
         WgB/ezfe4WRxBTbiaAHV0BicbWlM2had8i3NtdAxA3iaRDUbPGbviv+k7OQCun6Ol1Nl
         sa0jKAATVuCD/BaTmBkSM37sPe491RlUwyiu5ng0r9JzqMwz0wXiDDxNE1hHqaFpxsKC
         0F4A/m92ZSf33AX57pR9FapyWVio9MYfEB2UBlzx1V5xsRlYZRta3pPcO0VbZyqXgepV
         O3Q0KAfZjnkbFATdV4dXm66Dpfr7nNTVtnyRwzflAIp5tR3T3RTUNYO6N7yGOKwNyiVx
         Dzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvNtUD893tbCTBK+Aa3/Gob1b+OLwEJljGIV7sI1ZxA=;
        b=Nasit4jQBabnfHKvgnH+xhI5QN7QVDR2n5qEOwhQMxlFFtjyh99PIFOs9TWmDvCExk
         nCWGmX6/ss70GVSBMk8Ury17ws1RvQZYKr+RSqNwKnQSTWaQ623VixrbaUSlX/dD75xo
         BPLSY65ajax9+LXWTc/ikbGrosW7s+BED4hAuJjFOn+17Wr5uZjpXR5igyoWbNge0KR2
         a/w4VVOECmlICmL4ZMRt0+sf4L7AtfHFlaAmAYGhNkdL/pL9m93+wA5QSsz01OIazUs3
         tYgyAI+5J3T9CVbmjgzFstEiQAXiqCeCLHFVfJdBBHh6DuDJ/Byv4f6QMGUm360P7LwU
         JPFA==
X-Gm-Message-State: AHQUAubUp0hvxtT9/1JjAsS5diM2bJ206kqvRNCUq3to+qET9tllKDQl
        YZcqYQMf8384Ex8i+l/PmZn/L6inuL3bffaRMmCU
X-Google-Smtp-Source: AHgI3IZb88DsbEbRrgih32ncxxemqezU5SHg4RsI72HcZ9qXV7btAmVGa89I3ABegk+NDYd/8vb4EhA6lKdbRLEy+eQ=
X-Received: by 2002:a2e:474a:: with SMTP id u71-v6mr146246lja.161.1550094126040;
 Wed, 13 Feb 2019 13:42:06 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
 <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
 <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
 <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
 <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net> <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
 <11471341548341163@sas2-7b909973f402.qloud-c.yandex.net> <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
 <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net> <CAHC9VhRC8BC9Ocs9FYVrwnWutWD4Dow_MjwpvowxmJd=NtVN5g@mail.gmail.com>
 <3499451548746609@myt4-929fb874f3f2.qloud-c.yandex.net> <CAHC9VhRXc=UAfNidPjYsG561_kc_j2CkD6Db=Kb=Gjyhk3ko6Q@mail.gmail.com>
 <3191601548853902@myt6-23299ba78d64.qloud-c.yandex.net> <CAHC9VhQcrnXmjcVw_ppwM-fGcwhJq9SafTnZKjgpQpxK0ie+Jw@mail.gmail.com>
 <11242361548940840@iva8-8d7a47df0521.qloud-c.yandex.net> <CAHC9VhSjtQRGBUHvx73eVg32NMm4UN4qqaOXFyB9BMSx0Bz7dQ@mail.gmail.com>
 <34948711549920080@myt1-06117f29c1ea.qloud-c.yandex.net> <CAHC9VhSDot+uNDi7ULoT7dry4FW9Jgp=NcqDh6TmA=z--kmqkA@mail.gmail.com>
 <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net>
In-Reply-To: <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Feb 2019 16:41:54 -0500
Message-ID: <CAHC9VhQ4ooT-_iBoTiYgPV7oBV5RAgN1_HqDS2LGrGBY6erMmQ@mail.gmail.com>
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 12, 2019 at 10:10 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> Since cipso_v4_error might be called from different network stack layers, we can't safely use icmp_send there.
> icmp_send copies IP options with ip_option_echo, which uses IPCB to take access to IP header compiled data.
> But after commit 971f10ec ("tcp: better TCP_SKB_CB layout to reduce cache line misses"), IPCB can't be used
> above IP layer.
> This patch fixes the problem by creating in cipso_v4_error a local copy of compiled IP options and using it with
> introduced __icmp_send function. This looks some overloaded, but in quite rare error conditions only.
>
> The original discussion is here:
> https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/
>
> Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> ---
>  include/net/icmp.h    |    9 ++++++++-
>  net/ipv4/cipso_ipv4.c |   18 ++++++++++++++++--
>  net/ipv4/icmp.c       |    7 ++++---
>  3 files changed, 28 insertions(+), 6 deletions(-)

Hi Sergey,

Thanks for your work on finding this and putting a fix together.  As
we discussed previously, I think this looks good, but can you describe
the testing you did to verify that this works correctly?

> diff --git a/include/net/icmp.h b/include/net/icmp.h
> index 6ac3a5b..e0f709d 100644
> --- a/include/net/icmp.h
> +++ b/include/net/icmp.h
> @@ -22,6 +22,7 @@
>
>  #include <net/inet_sock.h>
>  #include <net/snmp.h>
> +#include <net/ip.h>
>
>  struct icmp_err {
>    int          errno;
> @@ -39,7 +40,13 @@ struct icmp_err {
>  struct sk_buff;
>  struct net;
>
> -void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info);
> +void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
> +                const struct ip_options *opt);
> +static inline void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
> +{
> +       __icmp_send(skb_in, type, code, info, &IPCB(skb_in)->opt);
> +}
> +
>  int icmp_rcv(struct sk_buff *skb);
>  int icmp_err(struct sk_buff *skb, u32 info);
>  int icmp_init(void);
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 777fa3b..234d12e 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1735,13 +1735,27 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
>   */
>  void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
>  {
> +       unsigned char optbuf[sizeof(struct ip_options) + 40];
> +       struct ip_options *opt = (struct ip_options *)optbuf;
> +
>         if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
>                 return;
>
> +       /*
> +        * We might be called above the IP layer,
> +        * so we can not use icmp_send and IPCB here.
> +        */
> +
> +       memset(opt, 0, sizeof(struct ip_options));
> +       opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
> +       memcpy(opt->__data, (unsigned char *)&(ip_hdr(skb)[1]), opt->optlen);
> +       if (ip_options_compile(dev_net(skb->dev), opt, NULL))
> +               return;
> +
>         if (gateway)
> -               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
> +               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
>         else
> -               icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
> +               __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
>  }
>
>  /**
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 065997f..3f24414 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -570,7 +570,8 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
>   *                     MUST reply to only the first fragment.
>   */
>
> -void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
> +void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
> +                const struct ip_options *opt)
>  {
>         struct iphdr *iph;
>         int room;
> @@ -691,7 +692,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
>                                           iph->tos;
>         mark = IP4_REPLY_MARK(net, skb_in->mark);
>
> -       if (ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in))
> +       if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in, opt))
>                 goto out_unlock;
>
>
> @@ -742,7 +743,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
>         local_bh_enable();
>  out:;
>  }
> -EXPORT_SYMBOL(icmp_send);
> +EXPORT_SYMBOL(__icmp_send);
>
>
>  static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
> --
>


-- 
paul moore
www.paul-moore.com
