Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D4C433FE
	for <linux-security-module@archiver.kernel.org>; Sat, 12 Feb 2022 21:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiBLV6z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 12 Feb 2022 16:58:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBLV6z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 12 Feb 2022 16:58:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2052606FA
        for <linux-security-module@vger.kernel.org>; Sat, 12 Feb 2022 13:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644703129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2Cw52X1+qOYmJurqYnkoU4CLJrh/MQPlo1UwPWCQTo=;
        b=TO+9Cixk23Sdl7wQ7tExEfX9AxzDe0xoXngqNsPyLEU5XBw7LIe7QT5xawej6yPIeHY8Fh
        avotCFkw0IO2isZIiB4e/yKTJYviETBDSA8T5NgrwTXowc+zBIt/lEXLztBE42ZGrQ7H4m
        XhxiQ7E9H1GQZgRmnp3DCjaHo1iQvEk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-CA-ekpvZNcmOXGxpm7IqEw-1; Sat, 12 Feb 2022 16:58:46 -0500
X-MC-Unique: CA-ekpvZNcmOXGxpm7IqEw-1
Received: by mail-yb1-f199.google.com with SMTP id a12-20020a056902056c00b0061dc0f2a94aso26225094ybt.6
        for <linux-security-module@vger.kernel.org>; Sat, 12 Feb 2022 13:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2Cw52X1+qOYmJurqYnkoU4CLJrh/MQPlo1UwPWCQTo=;
        b=0NiewYZVkXH6eeB4zlUIEj5jF9nYEQFXrgBKmjjvJacxUrj7qEIk/C2125iO+3Uk/1
         pYeNyu5kxKF3octKjiJf4QBIrBPoZjP/wntyt4VaFqPeiiHl5PjnmNaWRhIxTbXVnvMg
         +5gDmCzHBL+Cm78ONuPzl4tWQOQldjTUGHrkd0OIULkOEmaVRfj4WU5ikAkAWMTXw4Aw
         R6FNODwa9/rWbm5pkHXCGOhFeAjxqHq/rwpFjtpAL9U4vWwCR1eUwO5teL/embv7zwGh
         /3PxtCBWwX970BW+LPZ2+RJbPS/EaTvLUlE0ZHe9uA1npgeMv7Umf4lsxRwK69ao9FrW
         28UA==
X-Gm-Message-State: AOAM531cW0CgH4hx6YPadphuH97zAnMisr+vo12wOnM6+fxxdJsbpzJn
        QH26y+GdBJqALTjT3APcLnntEj6p67iyfC0q+5JsgpPxZ8j/6KFUy4gm+d7IBxeGptFXPAUejqS
        x6g3W+krd+KZyfxiw8Rh2hO9vxy/i+9y/A5Wvw9P1tD0UjHXCz1t/
X-Received: by 2002:a81:998c:: with SMTP id q134mr7867245ywg.29.1644703126225;
        Sat, 12 Feb 2022 13:58:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6xKJ8Vy5jYdaFIUhwSOxKWkmQhlN9SOfJe/I8QaKuzargWJNwN+xx//QgsOW0nGlZiW3kBq7cjVdtfMAHuco=
X-Received: by 2002:a81:998c:: with SMTP id q134mr7867239ywg.29.1644703126022;
 Sat, 12 Feb 2022 13:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20220212175922.665442-1-omosnace@redhat.com>
In-Reply-To: <20220212175922.665442-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 12 Feb 2022 22:58:34 +0100
Message-ID: <CAFqZXNtuZ8C5sSJDktTSWiPJbPxTK7ES21NJYVvFC9N4toehew@mail.gmail.com>
Subject: Re: [PATCH net v3 0/2] security: fixups for the security hooks in sctp
To:     network dev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Feb 12, 2022 at 6:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This is a third round of patches to fix the SCTP-SELinux interaction
> w.r.t. client-side peeloff. The patches are a modified version of Xin
> Long's patches posted previously, of which only a part was merged (the
> rest was merged for a while, but was later reverted):
> https://lore.kernel.org/selinux/cover.1635854268.git.lucien.xin@gmail.com/T/
>
> In gist, these patches replace the call to
> security_inet_conn_established() in SCTP with a new hook
> security_sctp_assoc_established() and implement the new hook in SELinux
> so that the client-side association labels are set correctly (which
> matters in case the association eventually gets peeled off into a
> separate socket).
>
> Note that other LSMs than SELinux don't implement the SCTP hooks nor
> inet_conn_established, so they shouldn't be affected by any of these
> changes.
>
> These patches were tested by selinux-testsuite [1] with an additional
> patch [2] and by lksctp-tools func_tests [3].
>
> Changes since v2:
> - patches 1 and 2 dropped as they are already in mainline (not reverted)
> - in patch 3, the return value of security_sctp_assoc_established() is
>   changed to int, the call is moved earlier in the function, and if the
>   hook returns an error value, the packet will now be discarded,
>   aborting the association
> - patch 4 has been changed a lot - please see the patch description for
>   details on how the hook is now implemented and why
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
> [2] https://patchwork.kernel.org/project/selinux/patch/20211021144543.740762-1-omosnace@redhat.com/

Actually, that patch no longer applies to the current master. Please
refer to this rebased version instead:
https://patchwork.kernel.org/project/selinux/patch/20220212213454.689886-1-omosnace@redhat.com/

> [3] https://github.com/sctp/lksctp-tools/tree/master/src/func_tests
>
> Ondrej Mosnacek (2):
>   security: add sctp_assoc_established hook
>   security: implement sctp_assoc_established hook in selinux
>
>  Documentation/security/SCTP.rst | 22 ++++----
>  include/linux/lsm_hook_defs.h   |  2 +
>  include/linux/lsm_hooks.h       |  5 ++
>  include/linux/security.h        |  8 +++
>  net/sctp/sm_statefuns.c         |  8 +--
>  security/security.c             |  7 +++
>  security/selinux/hooks.c        | 90 ++++++++++++++++++++++++---------
>  7 files changed, 103 insertions(+), 39 deletions(-)
>
> --
> 2.34.1
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

