Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8029EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jun 2023 21:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFSVsJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jun 2023 17:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFSVsI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 17:48:08 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F308F
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 14:48:05 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9b1f43bd0so41336531cf.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687211285; x=1689803285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/a28Txpe/xFs8OvL2UdzPa0B/lrYB+pe8A6lGyR9n4=;
        b=TnZqaiebwtv85kvXU8LPXr9Lq0kIs8D666fZOLzE3PdnavwHA2nl7Nr2ZEycZj18rx
         B8zajBi68rQcoStusHu7uobaROlnt20ZGJ90mJWEW2Aa04bCRmNE9BGBSgwDjUjAqR2X
         pNmwY5LMR/WCovjvvhcVNtZLrCfb9qevRM6mfgEDSOmiVcI7MHD7PqWqQ2NyN/sY8Sme
         HT26rb8XvbdXo3Uj+zoB2EHI6y7JJ9sZnFEbvMk3MgQJOCjwHr48Gug+tX7KyURynK5l
         vSSxrV4Ugb8rEsjJwH/CCmdI3vB6goj0kr2YPT2yfg5GBTyCEr5m3W5aCRACEGaJvjaU
         Mu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687211285; x=1689803285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/a28Txpe/xFs8OvL2UdzPa0B/lrYB+pe8A6lGyR9n4=;
        b=Ij20gl1qSM3Prf8nQKdX2rDXZYuDHCZAfTSJTQXdIE46LAOQ2CH6vng0vpnY0/+vvL
         VAiOOnMGBuX3A3UkQbHj1lBJiSo2aGhzjJmcZKn9bkGt7AE8nqIRxjOAz+bwvvbZ+/Co
         u8osS/GhVIPwka90wiaYii7ijNmxjjP3ws5ruAOtGTGg6n1hYsidKELpVXu8fXAq5DNE
         WPwljyiYbZN5p0MSaJ30nZbDQA+l/XG5urcP/3BKhceAJvCthoiqIkvCylRJuvB/oI/k
         R0UyX2DjnRSgYDre5E43Vu2blVLUMNeXV8d1RMsPp6j5CzE+jUZzZmFvzJZPqAsxwlhp
         W55Q==
X-Gm-Message-State: AC+VfDz8FeszRx2krNOSs64n16aEgSLQ9y0SVyi3Qf0NLv3VKNHUGTlN
        K6GMEDZrA60FN1UCfCD8j55QAVaCa7ILuLUQwFjC
X-Google-Smtp-Source: ACHHUZ5WUVtPyLbh1y+BwzvrAZDSSn9X8cX4a4Ec+I0knJvwMXFOqtcF3hUpiZd+SxA9vRfFHQ2b+1dKBuq7XaPQt3Q=
X-Received: by 2002:a05:622a:34b:b0:3f6:b823:f2af with SMTP id
 r11-20020a05622a034b00b003f6b823f2afmr2394470qtw.1.1687211284960; Mon, 19 Jun
 2023 14:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230619123535.324632-1-ben.dooks@codethink.co.uk> <20230619175710.GA200481@mail.hallyn.com>
In-Reply-To: <20230619175710.GA200481@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Jun 2023 17:47:54 -0400
Message-ID: <CAHC9VhRz0Y_D1Q=8xPKVJemYf=KUziC9s1TUJ86F+Lw+OrXdVg@mail.gmail.com>
Subject: Re: [PATCH] capabilities: fix sparse warning about __user access
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 19, 2023 at 1:57=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Mon, Jun 19, 2023 at 01:35:35PM +0100, Ben Dooks wrote:
> > The two syscalls for capget and capset are producing sparse warnings
> > as sparse is thinking that the "struct __user_cap_data_struct" is marke=
d
> > user, which seems to be down to the declaration and typedef at the same
> > time.
> >
> > Fix the following warnings by splutting the struct declaration and then
> > the user typedef into two:
>
> I'm not a fan of making code changes to work around scanners'
> shortcomings, mainly because eventually I assume the scanners
> will learn to deal with it.
>
> However, I don't like the all-in-one typedef+struct definition
> either, so let's go with it :)
>
> Paul, do you mind picking this up?

Sure, no problem.  Since we are at -rc7, I'm assuming this can wait
until after the merge window?

--=20
paul-moore.com
