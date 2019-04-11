Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E066DC10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 17:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF98F20818
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 17:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZ9wgp47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDKRHO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:07:14 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40062 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKRHN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 13:07:13 -0400
Received: by mail-vk1-f194.google.com with SMTP id l17so1537510vke.7
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbcJ3mmCOAVKf4I0SG7Bw7/SmKO1DKpNw86RlNMfNJg=;
        b=oZ9wgp47WacWgWVPILd180QXmBlpI7VT2L9ZsJepWnhslekvHyUFmNBqvIw3Ji1idU
         VRxCUXxa2Qj7pYMOHc6hi+hkbiJY0NtSfhiTCzlCkvj3RqgK9eVBa/WEPqRsDbhs5r2a
         taivyVnQmAdHCPbqehX3usNhFGmP0CgqnAfng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbcJ3mmCOAVKf4I0SG7Bw7/SmKO1DKpNw86RlNMfNJg=;
        b=ZOHtTt670a2vpGR3XxE74neehDqeHIeu9TL4E6y9/2C/gco5/Audd95AtUqJSDIi6+
         IbNxpIcMkU36slLXOBpMVcIAJAZLGvpXvadVnEXj/1xAha9rPliRJ1YzP+yeiBJJgjcE
         F2rbMLaoj4DKKd9P8itLAagyZl6QO8KUz725Cy3hI1SSgtZgmWWlUOxld44P54YySxnZ
         2cyxOfg+9dMMoKgc8m1jHtJcdXYIkd2ptSzbHK3TFbam3nP5StHp/NxTi+XqPtfpGfk/
         OyRDfwmTq3ZgMkC5LZ2Atiwsl7+DMkz6IW5YYXdVkxjqchBb/TflCUTWevWL0o+jXG7H
         Q6gg==
X-Gm-Message-State: APjAAAUtghqJ4YqnEB1prpnT23oVHKxum+/AAgp8ctgwf7czHiDmHNLf
        J6PIZkc+Tv6qFwWs5vEDRC5o3v3paOs=
X-Google-Smtp-Source: APXvYqzHsK0lyrGqGqD21GDlRthQO9uqvncHW+9rnBgzoCQxGvpzha4JFlDmGVQ1aIztLSKOKLCjaw==
X-Received: by 2002:a1f:cd2:: with SMTP id 201mr28090868vkm.11.1555002432055;
        Thu, 11 Apr 2019 10:07:12 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id p135sm11100437vkd.8.2019.04.11.10.07.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:07:11 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id n4so3926714vsm.3
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 10:07:11 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr27463532vsc.115.1555001955557;
 Thu, 11 Apr 2019 09:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190410161612.18545-1-keescook@chromium.org> <20190410161612.18545-2-keescook@chromium.org>
 <CAK7LNASLdZKNNM-Gft5bfVxKOG=4Ak-LBMnjb2E-QR4q_5GmEQ@mail.gmail.com>
In-Reply-To: <CAK7LNASLdZKNNM-Gft5bfVxKOG=4Ak-LBMnjb2E-QR4q_5GmEQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 09:59:04 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+S1He+2sR+cvjV=2xAcCHQoRv942+OAEDprMmB=TF4Bw@mail.gmail.com>
Message-ID: <CAGXu5j+S1He+2sR+cvjV=2xAcCHQoRv942+OAEDprMmB=TF4Bw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Kconfig: Create "kernel hardening" config area
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 11, 2019 at 1:51 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Thu, Apr 11, 2019 at 1:16 AM Kees Cook <keescook@chromium.org> wrote:
> > diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> > index 74271dba4f94..01874ef0f883 100644
> > --- a/scripts/gcc-plugins/Kconfig
> > +++ b/scripts/gcc-plugins/Kconfig
> > @@ -13,10 +13,11 @@ config HAVE_GCC_PLUGINS
> >           An arch should select this symbol if it supports building with
> >           GCC plugins.
> >
> > -menuconfig GCC_PLUGINS
> > -       bool "GCC plugins"
> > +config GCC_PLUGINS
> > +       bool
>
>
> This will flatten the plugin config options.
>
> If you want to keep the current menu structure, you can do:
>
> menu "GCC plugins"
> ...
> endmenu

Ah, excellent point. I'll fix this.

> Another side-effect is Kbuild will descend into scripts/gcc-plugins/
> even when no plugin is selected.
> It is not a big build speed regression, though.

I suspect the plugins Kconfig may disppear eventually with the options
spread around other Kconfigs (since now the plugin capability is known
at config time).

> > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > new file mode 100644
> > index 000000000000..8223a8ab1a12
> > --- /dev/null
> > +++ b/security/Kconfig.hardening
> > @@ -0,0 +1,94 @@
> > +menu "Kernel hardening options"
> > +
> > +config GCC_PLUGIN_STRUCTLEAK
> > +       bool
> > +       depends on GCC_PLUGIN_STRUCTLEAK_USER || GCC_PLUGIN_STRUCTLEAK_BYREF || GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
>
>
> I think this 'depends on' is unnecessary.

Okay, I'll drop it.

>
>
> > +menu "Memory initialization"
> > +
> > +choice
> > +       prompt "Initialize kernel stack variables at function entry"
> > +       depends on CC_HAS_AUTO_VAR_INIT || GCC_PLUGINS
>
> Nit:
> CC_HAS_AUTO_VAR_INIT does not exist at this point.
> I will be added by 3/3.

Oops, yes, I split this chunk in the wrong place. I will fix it.

Thanks!

-- 
Kees Cook
