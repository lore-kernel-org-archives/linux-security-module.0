Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876ECC433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Feb 2022 13:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbiBQNmY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbiBQNmW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Feb 2022 08:42:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6D126D95E
        for <linux-security-module@vger.kernel.org>; Thu, 17 Feb 2022 05:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645105304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ReDjgTa0AKl3IhETSr6eHHzRQ7oTYlVeTlr0c09qyCU=;
        b=C51xbD7NZyBoQByKZNy0d604ZKP2izVrxoN9MAdURCE+OSoDzlRZs+E7wP+TEfnLHg/S1T
        U2BQnRI+HZnKG1fDAY7Jug/TzxHZ4pDPd+4COuWiThVTFrssox4M9MXF/GpbToqrLJVSke
        4aiWmwnBWXun9WX4uqR3YncskDj6I9E=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-Mdmd97krNMGvWPJmp07w7Q-1; Thu, 17 Feb 2022 08:41:43 -0500
X-MC-Unique: Mdmd97krNMGvWPJmp07w7Q-1
Received: by mail-yb1-f197.google.com with SMTP id s129-20020a254587000000b00621cf68a92fso10002635yba.13
        for <linux-security-module@vger.kernel.org>; Thu, 17 Feb 2022 05:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReDjgTa0AKl3IhETSr6eHHzRQ7oTYlVeTlr0c09qyCU=;
        b=5rCr0Js185ectxJuByMUPYKlJ3nC9LzQ7iJ1umcU0TkIx6PYkuUuzAkIanzgm7boBQ
         AkGh/r3mjQbZBir6y0Rw1ogivKacitLcZ7vkgflXoZl7F69sgA9IKdbWGNTpxd7wiSOo
         EsiqI6Qulw7Wk+7T5mTkcmT/UfwniqfNfni3hkLoGVZ31KaZPoyEGrQ/OPs65j4t7KFQ
         wmqOYNTTz+oLk+owcmFVe1D0b0wgcTlvMt+xB0F+P4sCIotVCy9WrG0X95iMgKNyHeHg
         6KFu/iWqIXnsZkdEJhtoDH4EE3SepJSoYGQ9Icod8c5s9LQ+ZRETH5Wv/3ISzdqpngDE
         6weg==
X-Gm-Message-State: AOAM531Qcs6kyIcq8hZ+qzW8ZK6wXetO1Xp8HIXIhBEMlUtWZhItrYMJ
        jvRK3uROSrfaWRg0rQnT8OAjG4AGOi/FWIgxPyd2NzPggbxAoXsJa0O1SmXr96Jjwpnnv9fU4JM
        kscbHmzBuJh3YWOf4Y/2LJmlmjXFcox305vKG5gXOH5Uw2LmMtKKY
X-Received: by 2002:a25:be8a:0:b0:608:67d7:22fe with SMTP id i10-20020a25be8a000000b0060867d722femr2386866ybk.336.1645105302509;
        Thu, 17 Feb 2022 05:41:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/qTEHSLL3YCSmamzaOjBp+lXc80kYPlLLNqWjTzAirdIVkDe9EOxzg4C+QusYWruYzN7ip+2HvKyuPdKRbC0=
X-Received: by 2002:a25:be8a:0:b0:608:67d7:22fe with SMTP id
 i10-20020a25be8a000000b0060867d722femr2386846ybk.336.1645105302231; Thu, 17
 Feb 2022 05:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20220212175922.665442-1-omosnace@redhat.com> <20220212175922.665442-3-omosnace@redhat.com>
 <CAHC9VhT90617FoqQJBCrDQ8gceVVA6a1h74h6T4ZOwNk6RVB3g@mail.gmail.com>
 <20220214165436.1f6a9987@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAFSqH7zC-4Ti_mzK4ZrpCVtNVCxD8h729MezG2avJLGJ2JrMTg@mail.gmail.com>
 <CADvbK_e+TUuWhBQz1NPPS2aE59tzPKXPfUogrZ526hvm6OvY9Q@mail.gmail.com> <CAHC9VhSHxk0MUR1krpmbot6iG-vqH48sRgKOnJQ0LsFTs6Jvqg@mail.gmail.com>
In-Reply-To: <CAHC9VhSHxk0MUR1krpmbot6iG-vqH48sRgKOnJQ0LsFTs6Jvqg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 17 Feb 2022 14:41:30 +0100
Message-ID: <CAFqZXNtPZkozkzpOeW31pOn1r+xcWg6MDt7p8onTMoaUZVqzEw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] security: implement sctp_assoc_established
 hook in selinux
To:     Paul Moore <paul@paul-moore.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prashanth Prahlad <pprahlad@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 15, 2022 at 9:03 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Feb 14, 2022 at 11:13 PM Xin Long <lucien.xin@gmail.com> wrote:
> > Looks okay to me.
> >
> > The difference from the old one is that: with
> > selinux_sctp_process_new_assoc() called in
> > selinux_sctp_assoc_established(), the client sksec->peer_sid is using
> > the first asoc's peer_secid, instead of the latest asoc's peer_secid.
> > And not sure if it will cause any problems when doing the extra check
> > sksec->peer_sid != asoc->peer_secid for the latest asoc and *returns
> > err*. But I don't know about selinux, I guess there must be a reason
> > from selinux side.
>
> Generally speaking we don't want to change any SELinux socket labels
> once it has been created.  While the peer_sid is a bit different,
> changing it after userspace has access to the socket could be
> problematic.  In the case where the peer_sid differs between the two
> we have a permission check which allows policy to control this
> behavior which seems like the best option at this point.

I think that maybe Xin was referring to the fact that on error return
from the hook the return code information is lost and the assoc is
just silently dropped (but I may have misunderstood). In case of a
denial (avc_has_perm() returning -EACCESS) this isn't much of a
problem, because the denial is logged in the audit log, so there is a
way to figure out why opening the association failed. In case of other
errors we could indeed do better and either log an SELINUX_ERR audit
event or at least pr_err() into the console, but there are likely
several other existing cases like this, so it would be best to do this
cleanup independently in another patch (if anyone feels up to the
task...).

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

