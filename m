Return-Path: <SRS0=Ku0V=RA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03B5C10F00
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 22:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4952146F
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 22:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="avxzkuDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfBYWG7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:06:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43228 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfBYWG7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Feb 2019 17:06:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id z20so8864274ljj.10
        for <linux-security-module@vger.kernel.org>; Mon, 25 Feb 2019 14:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWuv84ouEfygpQ1rrCreGtYTgrClrHG+89waDs4Eu4k=;
        b=avxzkuDqTAeT/Iq6eclba+17ootAz9aDV+8DDdc+T/1SICmPpA/6zsnf7Xadss0ykB
         F0yfJSdwWARngPBpL04YtbplFmPSJL8c9fCN+pRcJ/suR7wfUEU4nsoaejbI81bs61Af
         SsG30+1jKLoDB/PFxDWmZW9h0D11l9hVg3cOTI3TRNlaDERNV1P5yy1dYnHqQbxqa6z7
         dmjVRIGDZvGAZczaQLBYA1DGcjXtclXeXU+sbMg2QnMMeWG0Vt2NhYRzo4pofFux470G
         j5gGqdc8BtcdWD5ccRWkFY++W4Lv8sLvcnhkRJGNzal4koRAl10fi7qMo/0RxxQ33odJ
         gOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWuv84ouEfygpQ1rrCreGtYTgrClrHG+89waDs4Eu4k=;
        b=HTaGpYU1GEuYkxU/Ad+vnMrFK5TzGmtb5V8dIGbf1BMzTqq3RSo2+zldNIzqfFaGxG
         8gFc2ENlFEnj6bgt4hdswn+ErNq+Z9l0wfxDZIpRbdEcZW36SbhKQdiJX4SokYTBsrx/
         U1TFt+JSx2UERFxf/tYIg2D6GZbyPoqDlXchxlUiCzFRK6dJHkyAE49eXk7ZcmZHLaaK
         rp6GW9d+tkN2qhPhdJ2R9MjVSk841wHtpiuVQuIRqQRqd7dTdQXYGZKwfYUBilRmlL0T
         iaNqOICtw6uKn6wz/bLdK3GAlrHck3e2bdEPKY3FJjSe58jGm/9roRaDOkOWKu4er2i5
         +cSw==
X-Gm-Message-State: AHQUAua/BuuKH+tqsO9qw+XITqZGFkFZjYdPnV94sQna4+FDUHfH4QPT
        eJvvAl6v+FBqNkybeqO/i8tne9pTk/F4vOz9BWJG
X-Google-Smtp-Source: AHgI3IZZi1wyMdm5wiE1tTXLbfNeXxfG32nmWvpk4U0sQEdautIqbDt1+WP57eTe0KxWr2z4i66mJFnjv1/Zt46b2a8=
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr11123732lji.57.1551132416142;
 Mon, 25 Feb 2019 14:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20190218.172544.1436352995315454863.davem@davemloft.net>
 <8873761550853329@myt6-67cd1de25d8a.qloud-c.yandex.net> <33533951550857169@myt3-2475c4d2af83.qloud-c.yandex.net>
 <20190224.173328.1032826011262803545.davem@davemloft.net> <3666661551112035@myt2-dc4bba9bb23c.qloud-c.yandex.net>
In-Reply-To: <3666661551112035@myt2-dc4bba9bb23c.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Feb 2019 17:06:44 -0500
Message-ID: <CAHC9VhR5oV96mR=ofDc8PaRna=Qkq4RWsdemhsy3F=T+TuTepA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] NETWORKING: avoid use IPCB in cipso_v4_error
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     David Miller <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 25, 2019 at 11:27 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
>
> Extract IP options in cipso_v4_error and use __icmp_send.
>
> Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> ---
>  include/net/ip.h      |    2 ++
>  net/ipv4/cipso_ipv4.c |   17 +++++++++++++++--
>  net/ipv4/ip_options.c |   22 +++++++++++++++++-----
>  3 files changed, 34 insertions(+), 7 deletions(-)

Thanks Sergey.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/include/net/ip.h b/include/net/ip.h
> index 8866bfc..f0e8d06 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -667,6 +667,8 @@ static inline int ip_options_echo(struct net *net, struct ip_options *dopt,
>  }
>
>  void ip_options_fragment(struct sk_buff *skb);
> +int __ip_options_compile(struct net *net, struct ip_options *opt,
> +                        struct sk_buff *skb, __be32 *info);
>  int ip_options_compile(struct net *net, struct ip_options *opt,
>                        struct sk_buff *skb);
>  int ip_options_get(struct net *net, struct ip_options_rcu **optp,
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 777fa3b..eff86a7 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1735,13 +1735,26 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
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
> +       if (__ip_options_compile(dev_net(skb->dev), opt, skb, NULL))
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
> diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
> index ed194d4..32a3504 100644
> --- a/net/ipv4/ip_options.c
> +++ b/net/ipv4/ip_options.c
> @@ -251,8 +251,9 @@ static void spec_dst_fill(__be32 *spec_dst, struct sk_buff *skb)
>   * If opt == NULL, then skb->data should point to IP header.
>   */
>
> -int ip_options_compile(struct net *net,
> -                      struct ip_options *opt, struct sk_buff *skb)
> +int __ip_options_compile(struct net *net,
> +                        struct ip_options *opt, struct sk_buff *skb,
> +                        __be32 *info)
>  {
>         __be32 spec_dst = htonl(INADDR_ANY);
>         unsigned char *pp_ptr = NULL;
> @@ -468,11 +469,22 @@ int ip_options_compile(struct net *net,
>                 return 0;
>
>  error:
> -       if (skb) {
> -               icmp_send(skb, ICMP_PARAMETERPROB, 0, htonl((pp_ptr-iph)<<24));
> -       }
> +       if (info)
> +               *info = htonl((pp_ptr-iph)<<24);
>         return -EINVAL;
>  }
> +
> +int ip_options_compile(struct net *net,
> +                      struct ip_options *opt, struct sk_buff *skb)
> +{
> +       int ret;
> +       __be32 info;
> +
> +       ret = __ip_options_compile(net, opt, skb, &info);
> +       if (ret != 0 && skb)
> +               icmp_send(skb, ICMP_PARAMETERPROB, 0, info);
> +       return ret;
> +}
>  EXPORT_SYMBOL(ip_options_compile);
>
>  /*
> ---
>


-- 
paul moore
www.paul-moore.com
