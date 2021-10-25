Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C10AC433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 07:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF1260F22
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 07:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhJYH6O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhJYH6N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Oct 2021 03:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HaP6doBxD9Jv1Cm2ztaSXVICaEyRQuexJoV+q8tgM3o=;
        b=b0X386vcyCj/Pulpo9GEa5A8W0QeI1mDUlLbOcJFeA8YlP1U6waQDmKTYV5bB2bR7yI724
        wHBZHE1+7n0ETyrZZ3dCYqw0m/Q20K70M9btI8GYI7Qb7VHqctO76dIS6WZQ4hUUxiet8r
        b1/xcDNjZ5iPBPmpGNxadzc7NppFLuM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-dUVWJELaMQmYIe--R2yj0Q-1; Mon, 25 Oct 2021 03:55:47 -0400
X-MC-Unique: dUVWJELaMQmYIe--R2yj0Q-1
Received: by mail-yb1-f197.google.com with SMTP id i128-20020a252286000000b005beea522aa8so16144113ybi.17
        for <linux-security-module@vger.kernel.org>; Mon, 25 Oct 2021 00:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaP6doBxD9Jv1Cm2ztaSXVICaEyRQuexJoV+q8tgM3o=;
        b=M8HqSLG4+cq6CqFU+0/eU2mxDBkD9NXhdmbvZ2sy7U0wxA9AZLdcfl+9ewcyCT46qJ
         jMfLEuWRNX7oIs20vrdwCeDFHpFZAk6iy7/C1Ydq7qtynyGF2E5EwWEpgWYHBhWSid3Z
         ns9LqT7z1Ssl/uq2j2mDP52/p8CGCtPogfG2rlrQ9zRdpGvsvRndpkFyNVyal/KJW1zo
         qew4QW2fDSCTIVbXgRcdiaUiB6tZdhgmGZbXQmPF8AP006T23ON9zM17mL7l/tz/hK7D
         Rcg8UXXDVcXJcfAJi6CEBtqWznZQLDqYI5+H94XpYrXVFskC0MhXr2cyFNXun01nWj+E
         7U6Q==
X-Gm-Message-State: AOAM530uyhB6JFJce5+s4yj3P4LT5KHwPLDYINvEIqZB4gZCQa3zfsT2
        CbASZtFZTHvAY5eNaY0HpXOADn7LduhPSzicsPtwBsEM343l3u88nKV3CaBZ+fkGvPdRb6gMU8V
        xYwLUsm09L+dwy1z6wKW+fAxDX2n8S2D3FxW2dbOfiNgALyH5q+7U
X-Received: by 2002:a25:3b16:: with SMTP id i22mr16104532yba.467.1635148547335;
        Mon, 25 Oct 2021 00:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQw0oj27SWyE9xLBVuhd8Wl9gLIz3ENrF6wNdaHq8P1pN33qBVs/7UZHdeiuqKxnM8N6EFqfHGvFU6FiORm38=
X-Received: by 2002:a25:3b16:: with SMTP id i22mr16104517yba.467.1635148547139;
 Mon, 25 Oct 2021 00:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211021153846.745289-1-omosnace@redhat.com> <YXGNZTJPxL9Q/GHt@t14s.localdomain>
 <CADvbK_eHsAjih9bAiH3d2cwkaizuYnn6gL85V6LdpWUrenMAxg@mail.gmail.com>
In-Reply-To: <CADvbK_eHsAjih9bAiH3d2cwkaizuYnn6gL85V6LdpWUrenMAxg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Oct 2021 09:55:36 +0200
Message-ID: <CAFqZXNuPwbwTD4KqQfc1+RtLswR3a=j4aFMYPf7rnxkkZMLvMA@mail.gmail.com>
Subject: Re: [PATCH] sctp: initialize endpoint LSM labels also on the client side
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 22, 2021 at 8:33 AM Xin Long <lucien.xin@gmail.com> wrote:
> On Thu, Oct 21, 2021 at 11:55 PM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > On Thu, Oct 21, 2021 at 05:38:46PM +0200, Ondrej Mosnacek wrote:
> > > The secid* fields in struct sctp_endpoint are used to initialize the
> > > labels of a peeloff socket created from the given association. Currently
> > > they are initialized properly when a new association is created on the
> > > server side (upon receiving an INIT packet), but not on the client side.
> >
> > +Cc Xin
> Thanks Marcelo,
>
> security_sctp_assoc_request() is not supposed to call on the client side,
> as we can see on TCP. The client side's labels should be set to the
> connection by selinux_inet_conn_request(). But we can't do it based
> on the current hooks.
>
> The root problem is that the current hooks incorrectly treat sctp_endpoint
> in SCTP as request_sock in TCP, while it should've been sctp_association.
> We need a bigger change on the current security sctp code.
>
> I will post the patch series in hand, please take a look.

Thanks, your patches indeed seem to do the right thing and they also
do pass selinux-testsuite with the added client peeloff tests (as also
confirmed by Richard already). I have just a few minor comments, which
I'll send as replies to the individual patches.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

