Return-Path: <SRS0=bfYL=P7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191EEC282C2
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC66721855
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IquwkO95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfAWS4M (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:56:12 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46932 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAWS4I (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jan 2019 13:56:08 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so1934534vso.13
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 10:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ireb14swxzh/kGO0PaPMQde96Q1mT+0FNq7POlr1RtA=;
        b=IquwkO95q/UwwPMizwgMyjj4ev3XxDyhR/G3JHGEMCF3sSBM1iMANjExCpcvgLzlnG
         c0k6jUJJgFMV5g0qmbSVJ021AH6TGBxq+8XWJcUoxP8kLv+OEHJYUwpGc+sctoUZRDos
         hIzip/irtCZpPPkUNHJdcUGvO4CqxO0BooUhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ireb14swxzh/kGO0PaPMQde96Q1mT+0FNq7POlr1RtA=;
        b=HYP1JFX7RtwjBfb7waL1uQ4pxoE+Vx7ctXMhOXKPiM5/uFmL60T3wJjn/UXuOCG5ph
         ueC//zbcFVSvPa6+JE9vWuF8mXns3fnWljxfLHZjM2DToyebSzIDU2Wvk4MDQISbw7MF
         1D+yfXU7fh2BRBHJROHeDQNOPS0WKuJhfiJcKOtSLMxOx3saH8NbixhL7cAC0wG0/xfd
         yA5wKhkfkjloVWH0uoZK0z+07tKKX9+cgFjqP8yZukYc1E/IOY5mpqcfdAvG9II5kcxh
         QtFV0nFAzjf5lheu6C95H/2jRxSfAnzWtqUOXwbFZ7txeVnVwSzvu4l9BCQSAxP2YSj/
         s3Rg==
X-Gm-Message-State: AJcUukfroTN/XSlWGToUTjmErglH9nSuENoAq0YmWyOy4nZ8TzWo7yav
        LGsWo7xHTdaGQfrJpPGqN97v0NVhsm0=
X-Google-Smtp-Source: ALg8bN683zvHf+LU1XQ64yHfUJk0MpX/4x0Xj+e8VcQcNvIlYewJ+00zzcLOW7AI7CaiTA73KWpSxA==
X-Received: by 2002:a67:3694:: with SMTP id d20mr1485868vsi.151.1548269766811;
        Wed, 23 Jan 2019 10:56:06 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id k200sm63268333vke.9.2019.01.23.10.56.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 10:56:05 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id e16so1076258uam.12
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 10:56:05 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr1375354uac.122.1548269764744;
 Wed, 23 Jan 2019 10:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20190123110349.35882-1-keescook@chromium.org> <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com> <874l9z31c5.fsf@intel.com>
 <000001d4b32a$845e06e0$8d1a14a0$@211mainstreet.net> <87va2f1int.fsf@intel.com>
In-Reply-To: <87va2f1int.fsf@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 24 Jan 2019 07:55:51 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJUxHtFq0rBJ9FwzMcZDWnusPUauC_=MaOz7H0_PF25jQ@mail.gmail.com>
Message-ID: <CAGXu5jJUxHtFq0rBJ9FwzMcZDWnusPUauC_=MaOz7H0_PF25jQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 1/3] treewide: Lift switch variables out of switches
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Edwin Zimmerman <edwin@211mainstreet.net>,
        Greg KH <gregkh@linuxfoundation.org>, dev@openvswitch.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Network Development <netdev@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        intel-wired-lan@lists.osuosl.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 24, 2019 at 4:44 AM Jani Nikula <jani.nikula@linux.intel.com> w=
rote:
>
> On Wed, 23 Jan 2019, Edwin Zimmerman <edwin@211mainstreet.net> wrote:
> > On Wed, 23 Jan 2019, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >> On Wed, 23 Jan 2019, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
> >> >> Variables declared in a switch statement before any case statements
> >> >> cannot be initialized, so move all instances out of the switches.
> >> >> After this, future always-initialized stack variables will work
> >> >> and not throw warnings like this:
> >> >>
> >> >> fs/fcntl.c: In function =E2=80=98send_sigio_to_task=E2=80=99:
> >> >> fs/fcntl.c:738:13: warning: statement will never be executed [-Wswi=
tch-unreachable]
> >> >>    siginfo_t si;
> >> >>              ^~
> >> >
> >> > That's a pain, so this means we can't have any new variables in { }
> >> > scope except for at the top of a function?

Just in case this wasn't clear: no, it's just the switch statement
before the first "case". I cannot imagine how bad it would be if we
couldn't have block-scoped variables! Heh. :)

> >> >
> >> > That's going to be a hard thing to keep from happening over time, as
> >> > this is valid C :(
> >>
> >> Not all valid C is meant to be used! ;)
> >
> > Very true.  The other thing to keep in mind is the burden of enforcing
> > a prohibition on a valid C construct like this.  It seems to me that
> > patch reviewers and maintainers have enough to do without forcing them
> > to watch for variable declarations in switch statements.  Automating
> > this prohibition, should it be accepted, seems like a good idea to me.
>
> Considering that the treewide diffstat to fix this is:
>
>  18 files changed, 45 insertions(+), 46 deletions(-)
>
> and using the gcc plugin in question will trigger the switch-unreachable
> warning, I think we're good. There'll probably be the occasional
> declarations that pass through, and will get fixed afterwards.

Yeah, that was my thinking as well: it's a rare use, and we get a
warning when it comes up.

Thanks!

--=20
Kees Cook
