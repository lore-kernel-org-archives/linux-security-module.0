Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4934C433E0
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 07:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77BBC64E74
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 07:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCEHpf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:45:35 -0500
Received: from forward100p.mail.yandex.net ([77.88.28.100]:34753 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhCEHpe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Mar 2021 02:45:34 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2021 02:45:34 EST
Received: from sas1-37a29cf4dc11.qloud-c.yandex.net (sas1-37a29cf4dc11.qloud-c.yandex.net [IPv6:2a02:6b8:c08:121b:0:640:37a2:9cf4])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 09B165983583;
        Fri,  5 Mar 2021 10:40:11 +0300 (MSK)
Received: from sas1-f4dc5f2fc86f.qloud-c.yandex.net (sas1-f4dc5f2fc86f.qloud-c.yandex.net [2a02:6b8:c08:cb28:0:640:f4dc:5f2f])
        by sas1-37a29cf4dc11.qloud-c.yandex.net (mxback/Yandex) with ESMTP id WCS4dmNJYc-eAImYA3a;
        Fri, 05 Mar 2021 10:40:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1614930010;
        bh=F40z9fg3r3bjUL8G6ySYe1cCEL2G+6TpDgeyj84aA3A=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=krCr/L6l7zhMn26EIeSS5lQMTbvOHQUmTmx11109PoiqpaoGlQw8IqSi7LcoZRzkX
         AaeqGwdVUrKVaGOFbusmhYXeggQONrR6tYyADbDWd23x6I8z4pIXMw/ad74Bs+lyzW
         TnVnnxrK5rHq0d/DliFXD7oc9h/euWQEl/0DdVNo=
Authentication-Results: sas1-37a29cf4dc11.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-f4dc5f2fc86f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id z1cB9zW8zF-eAnqLRjp;
        Fri, 05 Mar 2021 10:40:10 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Message-ID: <45f43d86cfd472bd26ac864f94f5de3486ae6b45.camel@yandex.ru>
Subject: Re: [PATCH] CIPSO: Fix unaligned memory access in
 cipso_v4_gentag_hdr
From:   Seergey Nazarov <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 05 Mar 2021 10:40:10 +0300
In-Reply-To: <CAHC9VhSRKwiDB0Ekffs3DWWC6hzZy=2Nazzfg_UdE9vhffbv=g@mail.gmail.com>
References: <a93d1b4c1d027d037ec341eabfc8e7920e589a49.camel@yandex.ru>
         <CAFqZXNsgVFCa-DnG5G_Ceu+oHsFszt-TQP27Wur_RJg8bG-wMQ@mail.gmail.com>
         <CAHC9VhSRKwiDB0Ekffs3DWWC6hzZy=2Nazzfg_UdE9vhffbv=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

В Чт, 04/03/2021 в 16:45 -0500, Paul Moore пишет:
> On Thu, Mar 4, 2021 at 4:17 PM Ondrej Mosnacek <omosnace@redhat.com>
> wrote:
> > On Thu, Mar 4, 2021 at 10:09 PM Seergey Nazarov <
> > s-nazarov@yandex.ru> wrote:
> > > We need to use put_unaligned when writing 32-bit DOI value
> > > in cipso_v4_gentag_hdr to avoid unaligned memory access.
> > > 
> > > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> > > ---
> > >  net/ipv4/cipso_ipv4.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> > > index 471d33a..28dfe40 100644
> > > --- a/net/ipv4/cipso_ipv4.c
> > > +++ b/net/ipv4/cipso_ipv4.c
> > > @@ -1162,7 +1162,7 @@ static void cipso_v4_gentag_hdr(const
> > > struct
> > > cipso_v4_doi *doi_def,
> > >  {
> > >         buf[0] = IPOPT_CIPSO;
> > >         buf[1] = CIPSO_V4_HDR_LEN + len;
> > > -       *(__be32 *)&buf[2] = htonl(doi_def->doi);
> > > +       put_unaligned_be32(doi_def->doi, (__be32 *)&buf[2]);
> > 
> > I think you can now also drop the cast, since put_unaligned_be32()
> > expects a void *.
> 
> Yes, it shouldn't be necessary.
> 
> You should also send this to netdev as NetLabel code lives under net/
> and goes to Linus via the netdev tree.
> 
> Also, looking at the code, there are a few similar spots you should
> probably fix while you are revising this patch:
> 
> * the short/__be16 assignment in cipso_v4_map_cat_enum_hton()
> * the short/__be16 assignments in cipso_v4_map_cat_rng_hton()
> * the long/__be32 assignment incalipso_genopt()
> 
Yes, I looked it.
In cipso_v4_map_cat_enum_hton, cipso_v4_map_cat_rng_hton access
address aligned by 2, so it's okay.
In cipso_v4_gentag_loc, cipso_v4_parsetag_loc access address is
CIPSO_V4_HDR_LEN(6) + 2, so it's okay too.
In calipso_genopt access address is 4n + 2 + 2, it's okay too.


