Return-Path: <SRS0=Ku0V=RA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF22C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 22:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEA22146F
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Feb 2019 22:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oawIxEkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfBYWHs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:07:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46194 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfBYWHr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Feb 2019 17:07:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id v16so8862377ljg.13
        for <linux-security-module@vger.kernel.org>; Mon, 25 Feb 2019 14:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FU3X/Rok6C0v7HQd5jbPiLYoFIfUSpC7EylCdYoMoYI=;
        b=oawIxEkLimYpTszJoNpNlWCTa/omu+ptAig0gKlfJEW/Ar1y1I8k52ETixjGFwu4S8
         azDKfYjsQS5svqD1vXSiM/xP352D83LkfNDVJKkIE+laFbK4B2rTpD7kt916JRsY6THl
         FYKPT/s3l+MoBM/ZY/qsruggZH9M2i/xtWjhwvYJAKiPqBdO2bby3PB+09X3+C9Z3Q+K
         MGMi+XyS0bfxjtFt8ZMNzbDXWm0UeHQZ9254+prYx4uyYD9D5D/0dXqMnxlIDSWInJow
         wR+gO/kEjYM5aRDPsNecf2g04iq0SbYmD0tS1yXP4jbpBR+TYJYM2nh3SNNeoSYo/lIE
         ZFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FU3X/Rok6C0v7HQd5jbPiLYoFIfUSpC7EylCdYoMoYI=;
        b=DCXbhVgVYbyyjj6cILBQWMPLvMeQGmTVGRJMZRSXAm98vl+SDoSu+nqDHsGeBxAUkh
         BnF608EPwJ03Cj0krE0EZFy1nvdLqsm8frX+psU6HrG1jWBTdk5CUEL2DLP2YV8EEIfG
         o5wRC8+eCnD7N/qS3sw0Lv1e9krKIBSGxq3kAM8w8joT7JJAFoBW9WFEf4xTBHjfbLE0
         LQBR045vZs02GBrSgyjZ6rJJYNCgwnNAEUKYQfaLNf7W7mofkuCSser8NNM+Sl56kITz
         ZBB8Y74F+hOBSbcrxezusaGeEkIDEXxgMdAMOkStiUv8ZFOkQMdE/AQREMYoljPYt3vy
         ZDnA==
X-Gm-Message-State: AHQUAubqQxbuPPTUi0PAT5CFwPmFDkiqnAr5JMiAOvXyMDvW5a/aBmXT
        2XcQ1v48jbADoxS1YS2yWEi0/VcXY0rQJDqP2hYQ
X-Google-Smtp-Source: AHgI3Ib7+Ffj6vS2Dcx5ggZ0ORRq7h6zQS82EweLzzBXT+AjYDfcoYpImZ4D/93I715NNy4ovrgwlPiAvRdpVWGyOgE=
X-Received: by 2002:a2e:968c:: with SMTP id q12mr11253295lji.95.1551132465722;
 Mon, 25 Feb 2019 14:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20190218.172544.1436352995315454863.davem@davemloft.net>
 <8873761550853329@myt6-67cd1de25d8a.qloud-c.yandex.net> <33533951550857169@myt3-2475c4d2af83.qloud-c.yandex.net>
 <20190224.173328.1032826011262803545.davem@davemloft.net> <52295911551111855@myt5-f1576e7b5bad.qloud-c.yandex.net>
In-Reply-To: <52295911551111855@myt5-f1576e7b5bad.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Feb 2019 17:07:34 -0500
Message-ID: <CAHC9VhTbECKmT3W81xQGgK+JeN+dKqT=OtzKYDgE+nRhDbLjNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] NETWORKING: avoid use IPCB in cipso_v4_error
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

On Mon, Feb 25, 2019 at 11:24 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
>
> Add __icmp_send function having ip_options struct parameter
>
> Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> ---
>  include/net/icmp.h    |    9 ++++++++-
>  net/ipv4/icmp.c       |    7 ++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

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
> ---
>


-- 
paul moore
www.paul-moore.com
