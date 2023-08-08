Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C5C001B0
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Aug 2023 18:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjHHSyB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjHHSxj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Aug 2023 14:53:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833946349E;
        Tue,  8 Aug 2023 10:08:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so90882431fa.2;
        Tue, 08 Aug 2023 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691514508; x=1692119308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w+N5RxJ6j6TsIuXun+/KHtX8AkDeBPMRbGieTCGtLH0=;
        b=UehQQQ1vXkVzZS4c2tTeWknevaOpsUVU/94XcQALmgDqehT/nQ6bN0pkXXbhP9E8wU
         LRzirxRk13f1NSgxNY2xdwwrXqY+lL1Rfe/20336u+IyeZWwERwvS4kcw4gKms7Ow5Ep
         x/FU0ZABxo0IoYqhJWggpjFuX32Wn1qPCvj15TIjsMttrOoN+H7xtcj3U1n5wQEJ4fpi
         ulUgPsXD3icKTuksK3lUwlfFQ9zzYyBr9ORjYtnEzU0zo+1D2rlcCRj475F7MiPKS6Ch
         ACuNYei0Q6IWC2qIVmOWFxqFuuBh+wWkWtARJm9JDqiLC1tYdIklOhJh/zWEHYZe72vM
         K2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514508; x=1692119308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+N5RxJ6j6TsIuXun+/KHtX8AkDeBPMRbGieTCGtLH0=;
        b=ZnTou9jnVlcWpUl8QXLeRAnVil17/Amubw45L6wMtsM4QoxAiKf9bx2gXG5ItFjBt2
         ZvJutrk7qqfvJEVKQ+KZlpctltjlnXO4WWCPEiU3yxJqdrhiay+d7ZVoEkv4mAdFLAwf
         3m2yO1a/rVA14JTtLbDR8HsW21qW7I/p3XS6y7DwPl3Y8X7IqUrRxfymysSvXsgizAsZ
         xR3J6hueR6bzOubhej2z6Pz6HwKO56OL/7dukPDRYUDUhJopDTQc10+DEydYBP3Epcrz
         YL5+N/ONF6O42BD8m5WFdMLSlOanSMdE2DzJh9WaDU/JFAsixAxwblB/UNENNEZutB5m
         m99g==
X-Gm-Message-State: AOJu0YzkU4Rv70OFvB+DfgbAoGfggiq40yg677UZ6yiLOjl7SeMO+qCh
        GVzVELvhZv3oZ0va4P+0gaL/FxGxL7i5LA==
X-Google-Smtp-Source: AGHT+IEnw4US5yDsOeUor3Z8UQFq3Runobu5MxyYy8pAwDuZK8bCHEEwqGaSwHqDLwP2Hpwr5dwWHg==
X-Received: by 2002:a1c:7211:0:b0:3fe:19cf:93ca with SMTP id n17-20020a1c7211000000b003fe19cf93camr8603683wmc.8.1691473291792;
        Mon, 07 Aug 2023 22:41:31 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003fa98908014sm16983211wmq.8.2023.08.07.22.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 22:41:31 -0700 (PDT)
Date:   Tue, 8 Aug 2023 10:41:29 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        ztarkhani@microsoft.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lsm: add comment block for
 security_sk_classify_flow() LSM hook
Message-ID: <ZNHVieyzjc320RXu@gmail.com>
References: <ZNCZ4KL7TRDE9vIC@gmail.com>
 <CAHC9VhSULN1B_EjVPA5st+NhDjiUbymOwt81C4gZ9Tn4_wWpuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSULN1B_EjVPA5st+NhDjiUbymOwt81C4gZ9Tn4_wWpuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 07, 2023 at 07:14:45PM -0400, Paul Moore wrote:
> On Mon, Aug 7, 2023 at 3:14 AM Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> >
> > security_sk_classify_flow() LSM hook has no comment block. Add a comment
> > block with a brief description of LSM hook and its function parameters.
> >
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> > Changed in v2:
> >  - Add parenthesis with security_sk_calssify_flow to refer to it as a
> >    function in commit message and commit log.
> >  - Remove an extra space in the comment block.
> >
> > security/security.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> Hi Khadija,
> 
> Thanks, but I already merged your original patch :)
> 
> https://lore.kernel.org/linux-security-module/abe91475c7f9e3483405c6096006b2a9.paul@paul-moore.com/

Hey Paul,

Great. Thank you. :)

Regards,
Khadija

> 
> > diff --git a/security/security.c b/security/security.c
> > index d5ff7ff45b77..b76fb27a1dc6 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -4396,6 +4396,13 @@ void security_sk_clone(const struct sock *sk, struct sock *newsk)
> >  }
> >  EXPORT_SYMBOL(security_sk_clone);
> >
> > +/**
> > + * security_sk_classify_flow() - Set a flow's secid based on socket
> > + * @sk: original socket
> > + * @flic: target flow
> > + *
> > + * Set the target flow's secid to socket's secid.
> > + */
> >  void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
> >  {
> >         call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
> > --
> > 2.34.1
> 
> -- 
> paul-moore.com
