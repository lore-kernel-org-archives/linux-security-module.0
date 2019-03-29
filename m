Return-Path: <SRS0=lFQA=SA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B5C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 18:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A222206B7
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 18:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2I23v4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfC2SBX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:01:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38177 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2SBX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Mar 2019 14:01:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so2750905ljg.5
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2019 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=u6sttfKQ2Hom9s0WLCTUKDmAN0HgPWFIaoa6yHh3VqU=;
        b=a2I23v4ZNxULI0jM8k9cbE8kYyAW77JBZjAkRf0nH8cyqeW41Rb+dHFp+iTo4kkq2/
         vbsTyOMuU8T++TryGox+NJXApWzUDurOTPViFPlsetGaDQKhBdjxvmS+HCacBI96JPf1
         66PHoIZaL9QaYqv4p1X1whx+z6OZ/T/lYEbv7I7G0JKCcLCZ1h8DUsC6AgxC8TC1amvb
         ljgqAhWvqg0ZdFruba0J1QFGdZpf70HuJe43rNRV3w3av76zvBiKTRO+IbWp2e+A8AXa
         MyXEgVi4bbampuxEb7WWNH9DD3rFnmf7s0gxb6Se/DT36wGY7mx1E6U8o1xNJ31qBEoi
         a4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=u6sttfKQ2Hom9s0WLCTUKDmAN0HgPWFIaoa6yHh3VqU=;
        b=uR+sYDynOHIIedPdCfowYSjrrDPdqGbE2mfcbjvHgJM2U3Vhtcx4fYqrqJrxIv7KOM
         O+zG3uTBgNuJBpxIEEXziB/mU36bz0ZaKrZQST1IhaWK0ZKvMv08ZlmZwJXriJLYE2td
         CqLC81bonQ7Zu0je79SGniWqyrVvp/p7A6YxsGuWdh9WMLhIoMoOUre+Wf+LWccXTmLd
         Wie9lj2T1FksLnk78uIhXJA83eUW54jOBNG/YxpwRi+rw9uN71SjXQCrYgbPdXhkjbwV
         wzLT40Cwttpc9UdZOf/7I6r7mFVQn5/oWwPWZPmd+c+PrfawuaF9rv/PRBKJe7/LAJr2
         lwnw==
X-Gm-Message-State: APjAAAUwQA96rKTHQkh5+a9oZxmcYG+NzDZ0FE2Dt8gNr6fqaTfO/N5J
        H2azt6IU46xACBHo4bHeUbZkOL7LTBso60aUs1NUDSdR
X-Google-Smtp-Source: APXvYqyaewS8B0DPfV/k+oG/GhNmVl17tf/3QdQiV9DP6qM9xftcrYf0PNcLO7UAP8al1FagrgHubaRRtzTEBIZ7HHY=
X-Received: by 2002:a2e:1311:: with SMTP id 17mr6197035ljt.75.1553882481504;
 Fri, 29 Mar 2019 11:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_wR2t_jLYx3=-uivpDHnGpozdhBzZOBcz3KJ=Mi-PikBw@mail.gmail.com>
In-Reply-To: <CABatt_wR2t_jLYx3=-uivpDHnGpozdhBzZOBcz3KJ=Mi-PikBw@mail.gmail.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Fri, 29 Mar 2019 18:01:10 +0000
Message-ID: <CABatt_yJxncPXVy09j757Ff_caodTUM4S4nf399MOatQ1LdPtA@mail.gmail.com>
Subject: Re: LoadPin old-api-denied
To:     LSM <linux-security-module@vger.kernel.org>, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 29, 2019 at 5:26 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
>
> Hi,
>
> I'm seeing the following message when trying to load some backported
> kernel modules:
> Mar 29 16:24:09 mach-cw-rnet-ppm-1840 kernel: LoadPin: kernel-module
> old-api-denied obj=<unknown> pid=340 cmdline="modprobe compat"
>
> I have other kernel modules that were built out of tree and these load
> fine, the only difference I can see is that they are loaded via
> /etc/modules-load.d
>
> I've read through the loadpin docs and it states that it will only
> allow modules that are from the main root filesystem and that
> filesystem is read-only.  I've checked and both of these are true for
> the failing module.  I've read through the source code and there's a
> comment above the code path that loadpin is taking where the file
> pointer is NULL.
> /* This handles the older init_module API that has a NULL file. */
> if (!file) {
>
> I'm not 100% sure what this means, but could it be that
> modprobe/insmod are using this older init_module API? if so how can I
> get around this, I need to manually insert these modules at an
> appropriate time during boot?
>
> Any help greatly appreciated,
>
> Martin.

After sending this I then found this post:
https://lwn.net/Articles/519010/

So I think I need to write some C code to use finit_module so I will try this.
