Return-Path: <SRS0=ipMR=6G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048AFC55185
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Apr 2020 19:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB042098B
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Apr 2020 19:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="o8msrCuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgDVTVo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgDVTVo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Apr 2020 15:21:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B213CC03C1AA
        for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2020 12:21:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t12so2428272edw.3
        for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2020 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxCJuKeYutDLDPXAPSEMJzIV43DxzgPvToiuGHFZFLc=;
        b=o8msrCuYl9yzwxwdinHp/5zJ/iluTXdc1PKyO8gPAZru5AYRPBYpTv4YM7zOXc3nZ2
         FGujQQrnudYueNgJjGfkvcAh+9/zKbk6PPZq6bKDzW6/flpD97bfMTX1npa9m0v9spXg
         chVFpy1nyofJYumkysSQudI+cOAaRtj7pqe6tohr6PYBQvlIvsVKL0tQD9PjhghVSJiH
         zN9nuJGnSUuENXK2lVmroUT265WhUirrk/aBSjMAScCtF3fleu1UAPyUaP4gx31qOlCk
         QNC6+SqqfYISxB040FO1lDWibFTqu2SxfQZQxx/Mqavaf1xszxYhNDBN3QoHxy7651nB
         FG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxCJuKeYutDLDPXAPSEMJzIV43DxzgPvToiuGHFZFLc=;
        b=TxAAHhTxD+1yVoGvo+sCvIa0X6qsE5UI4ulasfX6YGsEGaLXRkYlQqUyzyLL59hrkx
         /PNhQruWAEsr5Qr7A6MeO/8FAd8I4nLqnK/uxlV3IN8w2Ai9oy575ZAuHfIMkZYJivzZ
         9IYxJUa0alJ9lTGd247kyeLguK96wP6tJ/Y07aSKOfGH7WSXQ1WMdQGJGPwabomOFG28
         PrraAw4QFu2bL5+2vonUUlNybVw4Bh7EOBH9I3Q2i2KFoEFrKZZt6yLoXg+fLq0g9nfY
         URBCA4lLQv4pu4O+b2OJfNrPFNtyA69up6PVI2vVBDqrNVx2NM6fio//yBGs7jhzgzhi
         uGTQ==
X-Gm-Message-State: AGi0PuaFIivapPnx6uNw0f6tjfZvJ2ZjUMch7XC+xPp/9YMnOj2NcJ6h
        u2WS9O/3MggoLcV8QW0rzm3bATT8BUfcRbvkwISy
X-Google-Smtp-Source: APiQypIvh77fUhTJY8QW3thwdXTgaIIw2VU2oQABHxAtS41WIPnpdUCvR4mja7yxyHkw8pkxV5zKKFWsvAua+tkBpBM=
X-Received: by 2002:a50:d98b:: with SMTP id w11mr129015edj.196.1587583302343;
 Wed, 22 Apr 2020 12:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200422190753.2077110-1-carnil@debian.org> <20200422191301.GA2361@lorien.valinor.li>
In-Reply-To: <20200422191301.GA2361@lorien.valinor.li>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Apr 2020 15:21:31 -0400
Message-ID: <CAHC9VhSxMA3cjdjUt+wYFLnct835KedTL9JSRCgQsecqGs+wDQ@mail.gmail.com>
Subject: Re: [PATCH] netlabel: Kconfig: Update reference for NetLabel Tools project
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 22, 2020 at 3:13 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
> On Wed, Apr 22, 2020 at 09:07:53PM +0200, Salvatore Bonaccorso wrote:
> > The NetLabel Tools project has moved from http://netlabel.sf.net to a
> > GitHub. Update to directly refer to the new home for the tools.
>
> Oh, well s/GitHub/GitHub project/.
>
> >
> > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > ---
> >  net/netlabel/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Salvatore.

Acked-by: Paul Moore <paul@paul-moore.com>

> > diff --git a/net/netlabel/Kconfig b/net/netlabel/Kconfig
> > index 64280a1d3906..07b03c306f28 100644
> > --- a/net/netlabel/Kconfig
> > +++ b/net/netlabel/Kconfig
> > @@ -14,6 +14,6 @@ config NETLABEL
> >         Documentation/netlabel as well as the NetLabel SourceForge project
> >         for configuration tools and additional documentation.
> >
> > -        * http://netlabel.sf.net
> > +        * https://github.com/netlabel/netlabel_tools
> >
> >         If you are unsure, say N.
> > --
> > 2.26.2

-- 
paul moore
www.paul-moore.com
