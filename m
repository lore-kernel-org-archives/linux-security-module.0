Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77434C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 17:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AF420850
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 17:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZPtz8aag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDIRHM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:07:12 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39948 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIRHM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 13:07:12 -0400
Received: by mail-vs1-f65.google.com with SMTP id f22so10253818vso.7
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUESsSEpUYmi0oD8nO0oiuJsjs3lEWaHFhThRA6P6/E=;
        b=ZPtz8aagQaVUvBZoPcqxbBUQVP4zejcOisGU7dVElyXjbx7b/cVSS30MBgWMINwA7O
         hjORv5QVXQVcVpYLtZunhqAd8fWlAiS5c6cQVSxErOKba+h/xrRuhSvB43Fk1wOCOqwa
         76qR+OJCDPRtk+ot8ym5j7Ffc0wcS6ZpyFu7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUESsSEpUYmi0oD8nO0oiuJsjs3lEWaHFhThRA6P6/E=;
        b=AQEKvIDAEhfRUMStpwFL0n1HLK0XUEptTnTjr653tTI4wd0NwXeZAR9drysEK5+JYN
         g3UzSS1Xy2l6eisspQ+BIXCC/pH5vxeitungLdVLcDGM1DGcCUItzjifgj5uWcpPqhcQ
         q8O02oR/Xg9IsU6JqutF2tLs34KgR2unfbZvhFhVUC/uX1jC8tyPEamL9HmLTa68k0IZ
         /bR4dsVcRcyXe0niEjs3509u+2/aAPP6lpZuaXjEqV9wPxSiharkSfu9YH0mGgPnrkGK
         n5F3D1aZaai6tBG9jCV6XXp3o3xaIVC+erANNLxKDwV1enM1ssmcjYwEmmEB/ckG1zg4
         7opw==
X-Gm-Message-State: APjAAAVDzuGZWCPMoidNd0gxk59thT9+mBOzh95zljbCojCw04b+5UxC
        ulr+0xj//bJYAW1nou7SvVnBDILXs6I=
X-Google-Smtp-Source: APXvYqwETRdpYejZGpyxEwIYuA0Wbq8LKqRHW5c6QF/9TZnYFp3PPhrdGlj96fYPVj7yClPYRfwl2w==
X-Received: by 2002:a67:f256:: with SMTP id y22mr4736943vsm.19.1554829630923;
        Tue, 09 Apr 2019 10:07:10 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 8sm646591vks.11.2019.04.09.10.07.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:07:09 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id l17so5756655uar.4
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 10:07:09 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr19851176uah.123.1554829629115;
 Tue, 09 Apr 2019 10:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190408170418.148554-1-glider@google.com> <20190408170418.148554-2-glider@google.com>
 <CAK7LNAS3+FKpgBvvxKDukD1xcHUZ1o3TsE1BjjVq5P13MrO7Fw@mail.gmail.com>
In-Reply-To: <CAK7LNAS3+FKpgBvvxKDukD1xcHUZ1o3TsE1BjjVq5P13MrO7Fw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 9 Apr 2019 10:06:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+yeKMFwziyKzKBg-5_EiE9qE28JUkoidCwkmHQOtedcg@mail.gmail.com>
Message-ID: <CAGXu5j+yeKMFwziyKzKBg-5_EiE9qE28JUkoidCwkmHQOtedcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alexander Potapenko <glider@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 9, 2019 at 1:38 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> > +config INIT_ALL_STACK
> > +       bool "Initialize all stack"
> > +       depends on INIT_ALL_MEMORY
> > +       depends on CC_HAS_AUTO_VAR_INIT || (HAVE_GCC_PLUGINS && PLUGIN_HOSTCC != "")
> > +       select GCC_PLUGINS if !CC_HAS_AUTO_VAR_INIT
> > +       select GCC_PLUGIN_STRUCTLEAK if !CC_HAS_AUTO_VAR_INIT
> > +       select GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if !CC_HAS_AUTO_VAR_INIT
> > +       default y
> > +       help
> > +         Initialize uninitialized stack data with a fixed pattern
> > +         (0x00 in GCC, 0xAA in Clang).
> > +
>
> I am not sure about the benefit of these umbrella CONFIGs
> since these make 'depends on' and 'select' complicated.
> I will leave it to Kees, though.

Yeah, I think this could use some more cleanup to get a single config
that represents that if gcc plugins are available (instead of having
it split across two configs now). Additionally I think this needs
refactoring against the current menu choices for
GCC_PLUGIN_STRUCTLEAK. Let me send a proposed patch in a few hours...

-- 
Kees Cook
