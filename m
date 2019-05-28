Return-Path: <SRS0=jOYs=T4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF448C04AB6
	for <linux-security-module@archiver.kernel.org>; Tue, 28 May 2019 23:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C2320B1F
	for <linux-security-module@archiver.kernel.org>; Tue, 28 May 2019 23:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ot3EWkd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfE1XYE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 May 2019 19:24:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40889 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfE1XYD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 May 2019 19:24:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id u11so159250otq.7
        for <linux-security-module@vger.kernel.org>; Tue, 28 May 2019 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGPN9OjlN0u2vkYT7lUEXn5/y2a9ZsC+Dfozs38xwo0=;
        b=Ot3EWkd25DfNtyqQZi2lKoCMywsWj1GEkyVsamx8IhpKmMYoQlNVtFXDsN5kzZ6ztV
         G0G4l+Yn9BT/91zveLip+MqoiQ9WY7KdLEeUnxKqsGaf/8a6P6TCdXsDzggmJbd8BC7j
         j7g/1ER+6QZ5ydhZ3Bf+DMekuCVU7XQ2krnuSQI+4HCJgoVYtDwKLQjR3UkiqRBl2ZBC
         Hbgfr4g8WcFCgwSmqfiyN+oPogiE52ZKR9MwXWkiESYTJsOEtnnzFKKAjkloisXxqBPE
         +CTyleolaoiiIlj62zgtnI49WL88oeZM7ei1tnil/DaLguKbl4ERfII14rmEY0DmU5Lo
         55/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGPN9OjlN0u2vkYT7lUEXn5/y2a9ZsC+Dfozs38xwo0=;
        b=crcHkPM4F7qI94DyshEjkuFiKQeX4ewQPCRbi9INa9hbqf87/F4/TlibkTuQjI0NYB
         PZ6qD8Ylm9JPmuqKKNBZUFrrFeiSIzNwqlcoWhQXE0cG78oGCemtgWiALlIDrslFXCab
         2cLUehJ2HMcDxRaHb8hfRnQuAcneZgOVU0dzROrvICBdwPBF/ZQ/bKXWTKgFuMXn6AXl
         0B4q/frAzhHzSMJ2bXDV1Mzb3QDyQZ+HHyuJXNMB3YoiZwRmiM5J5LY25o47Krdvx/8q
         TcC0LDFSYC5ERsb+A/h2aEhnlbtHjduIWTpRFAfLdX4DkmrX8Jb/NsOFfEVC24Iy1yw7
         i+RA==
X-Gm-Message-State: APjAAAXj5tmTv95COnWaFdwAkHuFZM1qWgdZJYg0fqsM3wHhSDyXDDUL
        B5NGJ6V76XqUStnwu8smBIJHkPC15xOIDCOCdd+2bw==
X-Google-Smtp-Source: APXvYqzRVCXeGxin0Tw+MDHx9N4J9nIhwON+HiBvCivgZkw6Vu0lhpKmb1+NRC/UKwUe3iqj0TpzPBIsvDgNEbU7wmE=
X-Received: by 2002:a9d:7f8b:: with SMTP id t11mr5793otp.110.1559085842981;
 Tue, 28 May 2019 16:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <10418.1559084686@warthog.procyon.org.uk>
In-Reply-To: <10418.1559084686@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 01:23:36 +0200
Message-ID: <CAG48ez2SAKbPeChAf06GMazMPPThFM+OR00abRZafAP7v+ptKw@mail.gmail.com>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 29, 2019 at 1:04 AM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
> > It might make sense to redesign this stuff so that watches don't hold
> > references on the object being watched.
>
> I explicitly made it hold a reference so that if you place a watch on an
> automounted mount it stops it from expiring.
>
> Further, if I create a watch on something, *should* it be unmountable, just as
> if I had a file open there or had chdir'd into there?

I don't really know. I guess it depends on how it's being used? If
someone decides to e.g. make a file browser that installs watches for
a bunch of mountpoints for some fancy sidebar showing the device
mounts on the system, or something like that, that probably shouldn't
inhibit unmounting... I don't know if that's a realistic use case.
