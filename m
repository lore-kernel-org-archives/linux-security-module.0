Return-Path: <SRS0=f9XP=75=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C89C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6BA208FE
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 12:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrm2oqhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgFPMFx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPMFw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 08:05:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCD3C08C5C2
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 05:05:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so2639539wmj.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ov3hkENeaY3t0fiQ/hSwKv231EuvY8HIl/TMX2XAFJc=;
        b=hrm2oqhERxJ2pIZj6mPbOXuPz8MWkHIyr7nPF9F5TTTvPpRjEB/bU1+umrwL5hDUKD
         /oBgyEshM3XtO6Oe1gVllt/EculFu0fZtP6n8/A6LKp1qdQouffltTDJohD+zjqZv4co
         Av2qqTFF9YNnrdbqneCtIxFPyv7x4lVBruPrsSJizUYjp4YB32kFys1dRRKwjG6c7pwZ
         8H1qijwlPHF+JtWN4GvYgGKAMmOVDJ3DzhN2ro/V5ryq6Dk02oYV2QSNsBozH4UCcNYj
         sMU8b1Wn3AxK25xzw3ZsLei9uxGi1goLKUGgOqGtMJ3+jkFjjaMUvmbbPYOaPvxkh68g
         9z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ov3hkENeaY3t0fiQ/hSwKv231EuvY8HIl/TMX2XAFJc=;
        b=OnI4O68jGjKPdo2EjxOx+qrObVxf08Vf8iYI5HkQZXBUXuOZ5S52fIdAWOXDeQsR/x
         EU4U74vSgSdySER/oMf3g22x3R1Pc9FDraeMuGd7gHYyGwO9Pgx4GJ1U7CHdnXac7Ph4
         D5ikWlHeZJTNX29Wtz5U751IKuleIS15hGA75macY5632BpVUWGwzKTExm5WcMEZUKNk
         gELUj27EA4lpgV8rMbhr6R1rsZ9OFhN5+Tg28C6nimLhC4YILe63+BZXGGHNmgmPYHjn
         QXRUfbUC6LQmsg6mzvBaV5TYQkUiKYw1JeZJKBRcyy6EP3coL7bjPQfBhfWBJMmfuTD6
         iInA==
X-Gm-Message-State: AOAM532/zHeFS3bMz886fhgQDt5f+hetXr9jkivtsR8ifFbafkCvjcIh
        pVgQCwuIlX33meQn/2KJLsbpskhn8YG2sKmZfHHUQIUv
X-Google-Smtp-Source: ABdhPJxRsLNjXMbf2UUETZShWAdzuAq4Xj2Rtv9Uc4cmGf7rzWcsx8DY23jUyQJnacegr5ubzMEV0J4q2wXs1c5ig4Y=
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr3023341wmi.165.1592309148902;
 Tue, 16 Jun 2020 05:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200616083435.223038-1-glider@google.com> <20200616100309.GA2614426@kroah.com>
 <CANP3RGckq6_kMLzS-Yp5ottH4fm9Z3BQo3dbY1fMiQKiRMPbPw@mail.gmail.com>
In-Reply-To: <CANP3RGckq6_kMLzS-Yp5ottH4fm9Z3BQo3dbY1fMiQKiRMPbPw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 16 Jun 2020 14:05:37 +0200
Message-ID: <CAG_fn=XnPZzQXPJLMzSXZNbs8AzZWwPG67RhMAnr=cZO2Af_ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] security: allow using Clang's zero
 initialization for stack variables
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel hackers <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 16, 2020 at 12:19 PM Maciej =C5=BBenczykowski <maze@google.com>=
 wrote:
>
> > Nit, your From: line of your email does not match your signed-off-by:
> > line :(

That's hard to notice while being on the sending end, thanks for
pointing that out!
I'll look into this.

> This is *probably* a matter of configuring git:
> git config --global user.name "Alexander Potapenko"
> git config --global user.email "glider@google.com"
> git config --global sendemail.from "Alexander Potapenko <glider@google.co=
m>"

I do have all these options set, although I don't have them quoted,
not sure if it's necessary.
Moreover, when I do `git send-email --dry-run` the From: line looks correct=
.
