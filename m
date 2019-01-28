Return-Path: <SRS0=3eDG=QE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C16C282CF
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 19:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247852087F
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 19:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="odS2L/NE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfA1T43 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:56:29 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43968 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfA1T43 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Jan 2019 14:56:29 -0500
Received: by mail-vs1-f65.google.com with SMTP id x1so10499152vsc.10
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jan 2019 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzdC1yKdJ4HYzcwFUOoF2jkJ7fxTRTLnL861m5A7pY8=;
        b=odS2L/NEswAgeCZSIZxbOB+XnvjAhWM0+8Li83rAe2Bf02KniDlzE21puBRqYED5Jw
         HL+s32wWDG8o4Gu2MHWQal3JXFoTeOQaD2rQ7ADVweLpRqLFQ0p26I3io8EWlJQloNhC
         ky5QbrOJwIcq+BAVZO9k8jbuiMrFVgD4uO6U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzdC1yKdJ4HYzcwFUOoF2jkJ7fxTRTLnL861m5A7pY8=;
        b=U0IsuHHegELNdNLmuHUjwDKQtvLORGpizoWDR0H6G2mszLbrWJuKNj3ohnl9DaI/H6
         fr3FZrjVALN2F6ZgUIvjKHcHebY5BFmRN4VGmUkePP2qZo0FaOmMQRKebRuoBpfafIGN
         TXsMrcUp3He4Xe1Lm0WfN7Soy6gAE+sYOVkKKM/T5ZeQg1row4zHateZxRh1FDqSiodk
         Slq0QIuWWQhdGOrgOlx2RUXacbWFiGgs0dO+iCVGMW6juj+tCeyrTr2cnLIQs+De8VvV
         tXtgaYr+6LM3qLTsCWC4toqu01EkN1g2zAFhflVJMocO8WXq62pfnf/jAakfPlAf72Cg
         +y0Q==
X-Gm-Message-State: AJcUukdqSLxoVVXiF30g00L+m2qqwcu3FMDROShxR2uWtuMIa8f6MR39
        NW8Nvpke0PBJy1Ls++HSIUY64svaHzo=
X-Google-Smtp-Source: ALg8bN7FzL29mM7Qpdj7zC5u0gGfcMMSBFeXkZQFhxgZlPRKl3NTh5Nbta8P+yjAJzq76gRUWHkSGA==
X-Received: by 2002:a67:a858:: with SMTP id r85mr9143343vse.215.1548705387800;
        Mon, 28 Jan 2019 11:56:27 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id r130sm68521905vka.55.2019.01.28.11.56.26
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 11:56:26 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id p9so6057051uaa.5
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jan 2019 11:56:26 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr9886722uan.114.1548705386048;
 Mon, 28 Jan 2019 11:56:26 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
 <20190116154606.92331-1-mortonm@chromium.org> <alpine.LRH.2.21.1901260714380.27585@namei.org>
 <CAJ-EccMc3Xz0DZAm_u09VvTzWRzhrf9x0SpJKX=4FR6NYwqkpQ@mail.gmail.com> <CAJ-EccMAb-OX3R6mk4me0x6dS2bQw=yZrpKmF7JpzHDWSX5e4g@mail.gmail.com>
In-Reply-To: <CAJ-EccMAb-OX3R6mk4me0x6dS2bQw=yZrpKmF7JpzHDWSX5e4g@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 29 Jan 2019 08:56:13 +1300
X-Gmail-Original-Message-ID: <CAGXu5jKLdcadm30NwpquX1iGJRsjZY-A5grc65BC64B96RE_Eg@mail.gmail.com>
Message-ID: <CAGXu5jKLdcadm30NwpquX1iGJRsjZY-A5grc65BC64B96RE_Eg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] LSM: add SafeSetID module that gates setid calls
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 29, 2019 at 8:47 AM Micah Morton <mortonm@chromium.org> wrote:
>
> I'm getting the following crash when booting after compiling a kernel
> with this LSM enabled, so I'll have to figure out what is going on.
> All the "core" functionality of this LSM has been tested thoroughly
> (we're already using this LSM on ChromeOS), but looks like there's
> some debugging of the initialization that still needs to be done.


+DEFINE_LSM(safesetid_security_init) = {
+       .init = safesetid_security_init,
+};

I think this is from not having:

.name = "safesetid",

I missed that in the review, sorry!

-- 
Kees Cook
