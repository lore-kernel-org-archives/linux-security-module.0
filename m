Return-Path: <SRS0=bfYL=P7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB3C282C5
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 12:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A622B2183F
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Jan 2019 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdmruNmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfAWMJk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:09:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41248 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAWMJk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Jan 2019 07:09:40 -0500
Received: by mail-oi1-f194.google.com with SMTP id j21so1568248oii.8
        for <linux-security-module@vger.kernel.org>; Wed, 23 Jan 2019 04:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ozDKIbwcmYuyejXGARNO3jJ/EJ1dH91BZQgRlXa0NVc=;
        b=TdmruNmZ40rRcOmr5c75vEIE9p7sNtcssBxrB6bd1v49wN7GdrM8dCdTjsFQkdwWpn
         swJtemBXQ8ZfNyCa1SflX10bZDRPmJb8tjwU7YUSHbALC+X1sn7gMgElfhG0yulEtun3
         dI6EjQ0qoKfuvzWguCcBeFpT2cvANhqJOLW8brHwqybryRKfXMLt2jCo+c3z0h0u9cs+
         DwJAHlcaYLhJSTROVF0VfKwLWBxSkwFrqjVe5od1op4Pncf0bV9yiTfuJ+VyvjAwTZBa
         D5nZZ6vI/i6CDyC16YUTSU53EeDC1Pc5YlFAA/BNIwJPdl/R6qmYspFi9kUVWRDYLnSU
         eOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ozDKIbwcmYuyejXGARNO3jJ/EJ1dH91BZQgRlXa0NVc=;
        b=rP0hyJ7gpcfqklqKCwHiG//cyK3m3znkD5jw3sPvfjyaYahZV+iNSWwo9ToWCfA0NV
         CKSgnZ1Wv6L+hZD7hkvl+R0S/PccezCD2rNJ4P3FqwMsDVT/9yEaT+UzoDC3jKN8UCKq
         IzzQxNKPmtoxnvAcrAsbVNNOPmbRV11EPaMnjdCW/KmdmpATkMaJ4vSChC4rj5lDJ3t2
         /Rnh0xa9BLVlixG68dyz9QwaacpgT1hAJJreyVKA+WPZG74G8dINoddgxcZFcl4/Kr5l
         1LSDKxPnFBmqzx2MkuyfakWri+06CkCaDFaweK4MO8v2Ajp/QhdsNsYNuce90uevbxpQ
         wpwQ==
X-Gm-Message-State: AJcUukfdOsQiN+d/MiLchpxTxWSu2l3UdDQX2NhkhEnKCEdT2oNFbicS
        qvCfhKqTsDfktkwv7i1cT5KAD0uj53uIPQTjndcLDw==
X-Google-Smtp-Source: ALg8bN6kOaeSQwPD4LE50phMTwZkQl9VC4fJho1QUCrFhsQiioas7XmkfUH+8ap4a9ntepudRb3YAWzJRoOY/bTa4Q4=
X-Received: by 2002:aca:c43:: with SMTP id i3mr1280767oiy.157.1548245379171;
 Wed, 23 Jan 2019 04:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20190123110349.35882-1-keescook@chromium.org> <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com>
In-Reply-To: <20190123115829.GA31385@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 23 Jan 2019 13:09:13 +0100
Message-ID: <CAG48ez2vfXkr9dozJiGmze8k49VOXfs=K7M8bv0aQsDDpzrEFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] treewide: Lift switch variables out of switches
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Alexander Popov <alex.popov@linux.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-wired-lan@lists.osuosl.org,
        Network Development <netdev@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, dev@openvswitch.org,
        linux-kbuild@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 23, 2019 at 1:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
> > Variables declared in a switch statement before any case statements
> > cannot be initialized, so move all instances out of the switches.
> > After this, future always-initialized stack variables will work
> > and not throw warnings like this:
> >
> > fs/fcntl.c: In function =E2=80=98send_sigio_to_task=E2=80=99:
> > fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-=
unreachable]
> >    siginfo_t si;
> >              ^~
>
> That's a pain, so this means we can't have any new variables in { }
> scope except for at the top of a function?

AFAICS this only applies to switch statements (because they jump to a
case and don't execute stuff at the start of the block), not blocks
after if/while/... .

> That's going to be a hard thing to keep from happening over time, as
> this is valid C :(
