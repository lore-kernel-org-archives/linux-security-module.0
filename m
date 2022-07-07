Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF22C433EF
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 19:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiGGTEv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiGGTEi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 15:04:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9972A1EAE7
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 12:04:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d16so21286541wrv.10
        for <linux-security-module@vger.kernel.org>; Thu, 07 Jul 2022 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvbWOmfqFQDZxi50SzgZZmdTVRAaxdCY1RZHpPXVEMs=;
        b=sQXbPP029EsL0H2p6P1gN30yzE8ETEjjvGpFb7Z0AlZdjrDvtC8M0pOdlUuJWgjEP9
         t7yAIEuxsACYGDUS5C17SSSFkB3xod8OGr4+wyBDoVBvN3KQIwYTJplu8zNYJNAymVSJ
         olLYLU+SiI9Hv9Ji4cBrZuiH0zuCY7au3GNPzNxkKvpWEblJPJHz1lVHSnrRw6JEKXMi
         vE3YlWoJa9HcUAVloluTOXwSoTqDDZY5bofygSgfIM4C3x+rR9g+Box1vi1C51MM3GFu
         gKRCrOPGY7VjioBXNUlRGQL5XcTZo1vAanbxAYC5E05Js4Sq89XV8p/1BB+oBnRtpEAV
         nKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvbWOmfqFQDZxi50SzgZZmdTVRAaxdCY1RZHpPXVEMs=;
        b=6vXK2G/2S26yN8bBt1cMt34Zl1iXVJKC9WJkpv+qhGU9lz67vMvIZw+feltzjwYdot
         /gyuh5/pMNKDKLADxbFsd76twHzIha5UpFYizjCOUU0C3EEMTcev2SeDmbflM+TY9KE1
         eoTFMwJMPb+A9pBvgEl5UY5jzUoFQ9VGXMP4kyLUUh0pFqi2epA0rSTIGoa6DGEk0EAg
         1pIhAKA57kGuiFeWx0d505XdFn498Fm8Sx/A88pLO8n0eKjFAf60LYhn7+eTDpP7r9aJ
         UM6Itl67WEBk94+UOPeQLNsFY5Mnc7qRqUbty0YuqNyaq32MU1V0qq+vPWTL4ruze+Wj
         DSHA==
X-Gm-Message-State: AJIora/KBPEZ+0EUBXCYZwyVKtEEY++eYroGcCv5vO9PooADPiTT9fZM
        qpg3ub+gNuuYvF2bSOkwhm9YtW9CDV6PAloGHsgBbkd1uw==
X-Google-Smtp-Source: AGRyM1vrpmFLPdKWe+jpcz+rkPcEbAbBWm488b1dVLLK1KoQw/HGAQmgvK/oDBN7Ib9CVomTUhm49PYHQyxptAumNSI=
X-Received: by 2002:a5d:64ad:0:b0:21b:b412:a34b with SMTP id
 m13-20020a5d64ad000000b0021bb412a34bmr45101495wrp.161.1657220675093; Thu, 07
 Jul 2022 12:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <c513dcdb-17f9-377a-1329-2b8fee8dc28c@namei.org>
In-Reply-To: <c513dcdb-17f9-377a-1329-2b8fee8dc28c@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Jul 2022 15:04:24 -0400
Message-ID: <CAHC9VhSMHqiXrLhA_DXrstTod2Afjy6v9fPjJfygfC36D2cHuw@mail.gmail.com>
Subject: Re: Maintainer update
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 6, 2022 at 3:15 PM James Morris <jmorris@namei.org> wrote:
>
> Hi Folks,
>
> I'm now a manager and don't get as much time to focus directly on
> development work.
>
> I'd like to propose that we add Paul Moore as a maintainer of the Security
> Subsystem, and for him to take the lead on that, in addition to his
> SELinux and other maintainer work.
>
> With LSMs pushing directly to Linus, this maintainer role is now mostly
> about merging new LSMs and major LSM changes, and integrating bugfixes.
>
> Paul has been taking many LSM bugfixes through his SELinux tree for a
> while, so this would be somewhat a formalization of things there. In terms
> of new LSMs and major changes, this is and will remain a collaborative
> process with the LSM community.

Thanks James, Serge, Casey.  I promise to do my best not to screw
things up too badly ;)

I'll put together a new LSM tree under my kernel.org account and send
out a MAINTAINERS patch with the updated info.

-- 
paul-moore.com
