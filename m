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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE46C433DB
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 07:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF786501F
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 07:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCEHeL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEHeL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Mar 2021 02:34:11 -0500
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Mar 2021 23:34:10 PST
Received: from forward101o.mail.yandex.net (forward101o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C9C061574
        for <linux-security-module@vger.kernel.org>; Thu,  4 Mar 2021 23:34:10 -0800 (PST)
Received: from iva3-4f441b146a71.qloud-c.yandex.net (iva3-4f441b146a71.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:498c:0:640:4f44:1b14])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id A2A763C00EB4;
        Fri,  5 Mar 2021 10:28:25 +0300 (MSK)
Received: from iva3-dd2bb2ff2b5f.qloud-c.yandex.net (iva3-dd2bb2ff2b5f.qloud-c.yandex.net [2a02:6b8:c0c:7611:0:640:dd2b:b2ff])
        by iva3-4f441b146a71.qloud-c.yandex.net (mxback/Yandex) with ESMTP id JkMMx2pkGG-SPHmeK0L;
        Fri, 05 Mar 2021 10:28:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1614929305;
        bh=z5RL5noQan1fR77g1RUaCIgT5l2XyPAKz5yr3g6lCeE=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=vC2e9Tkd6Xrkev+hGGxPpGP9A8A5DUQhS2ZWSol1jygmgHPltjS5FkUl+pfU7s933
         M6oHwzFNxv31wi4yFyoQ8MEDD5mtYCrWr0mfN44QsyayK2xTCKF34tKPJ6/kTwnFsa
         V2ukjWY3SMr3uwDzb3Uw1+4+jbgZVkbslhKfuhYc=
Authentication-Results: iva3-4f441b146a71.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva3-dd2bb2ff2b5f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id pRMPLL1ZZG-SOnaGgbC;
        Fri, 05 Mar 2021 10:28:24 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Message-ID: <50bc54bc65f78b7379a9a1114b52985a9098a3fb.camel@yandex.ru>
Subject: Re: [PATCH] CIPSO: Fix unaligned memory access in
 cipso_v4_gentag_hdr
From:   Seergey Nazarov <s-nazarov@yandex.ru>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Date:   Fri, 05 Mar 2021 10:28:25 +0300
In-Reply-To: <CAFqZXNsgVFCa-DnG5G_Ceu+oHsFszt-TQP27Wur_RJg8bG-wMQ@mail.gmail.com>
References: <a93d1b4c1d027d037ec341eabfc8e7920e589a49.camel@yandex.ru>
         <CAFqZXNsgVFCa-DnG5G_Ceu+oHsFszt-TQP27Wur_RJg8bG-wMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

В Чт, 04/03/2021 в 22:17 +0100, Ondrej Mosnacek пишет:
> On Thu, Mar 4, 2021 at 10:09 PM Seergey Nazarov <s-nazarov@yandex.ru>
> wrote:
> > We need to use put_unaligned when writing 32-bit DOI value
> > in cipso_v4_gentag_hdr to avoid unaligned memory access.
> > 
> > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> > ---
> >  net/ipv4/cipso_ipv4.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> > index 471d33a..28dfe40 100644
> > --- a/net/ipv4/cipso_ipv4.c
> > +++ b/net/ipv4/cipso_ipv4.c
> > @@ -1162,7 +1162,7 @@ static void cipso_v4_gentag_hdr(const struct
> > cipso_v4_doi *doi_def,
> >  {
> >         buf[0] = IPOPT_CIPSO;
> >         buf[1] = CIPSO_V4_HDR_LEN + len;
> > -       *(__be32 *)&buf[2] = htonl(doi_def->doi);
> > +       put_unaligned_be32(doi_def->doi, (__be32 *)&buf[2]);
> 
> I think you can now also drop the cast, since put_unaligned_be32()
> expects a void *.
> 
> >  }
> > 
> >  /**
> > --
> > 1.8.3.1
> > 
> > 
> 
> 
You are right, thanks!

