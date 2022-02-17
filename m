Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1FBC4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Feb 2022 13:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbiBQNdO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:33:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbiBQNdO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Feb 2022 08:33:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 363D21F3F3D
        for <linux-security-module@vger.kernel.org>; Thu, 17 Feb 2022 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645104778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+uKxN/uQ3UdKZRYgJ9V9aHz1upM2XpQ82bT5M0IFbI=;
        b=gGnqVU2yYB6qu+9Y1ne+Lwo9n10yDlILg0hZMNwN3iLa49JU2KpR+WKE9alE8SLoyIP1fi
        DnuACwKZeFyl03C+oyFV5lkYiIVBJt/kswjMrM2JBhgxZEMTygoOeqpA/uQOi8EwRbDQoP
        8/ZrwMLdm1Nytfh/0ctYcboXRKq41lQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-7rq1cdsiNzOL6mkegbRe3w-1; Thu, 17 Feb 2022 08:32:57 -0500
X-MC-Unique: 7rq1cdsiNzOL6mkegbRe3w-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-2d6914a097cso11434577b3.10
        for <linux-security-module@vger.kernel.org>; Thu, 17 Feb 2022 05:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+uKxN/uQ3UdKZRYgJ9V9aHz1upM2XpQ82bT5M0IFbI=;
        b=18aAlu30aHRxDbsp+SApKUB0k58oyceSzWdVh8p1KJ9CyyFWadL6RUlGPqizACx79E
         SWELc6E0oNPOixjxW7dXK0TIXlZ8Rs0SdIYqpHYbUEE8cbNwQBaMrdjrvWHOy0hT6keS
         k3ChA9sXLLePJS2uwa5bYfWauPwPGGK7i+jdxz90/UFFXBnFRGeHwMKNG77mhrcPtPso
         IZ3KGz0kblMTujknC58HB99pVHrjNeFAwBoMw4pYTslgAPhYxdxRCm9BpBHwzlKIa6W3
         NxfEjF5UtWTEu/gsd+7lB+1iEnYZkSrhHa4xzkXStfuMitiXwmkQNORu5R59uvo5ZFwa
         WFRA==
X-Gm-Message-State: AOAM5336YfQ6ATfUHAtq9cUHL369wagemMBuTdRmING+uaw+aS6LiwlN
        sI8I0s+WNylnTXgeSi/Yll0laqNn8jwKDDajE12P4HWb/fC/B4iPAQ8KWgh+FNFZ+ibB+8pfTb5
        u3aqy7lHemrBCH1vSwf9wczSsmVZiacKn4I65SxeJz673iVvBTj79
X-Received: by 2002:a81:52cd:0:b0:2d6:93e0:f1b2 with SMTP id g196-20020a8152cd000000b002d693e0f1b2mr2533105ywb.245.1645104776598;
        Thu, 17 Feb 2022 05:32:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFefMUXhH6RLwk9ZmWiTLxleS0FIicYntXWMfUeWl3fFq0Bq5LTKQkneJWoctpaIWmiEqJxFMmMbodYIp8NzE=
X-Received: by 2002:a81:52cd:0:b0:2d6:93e0:f1b2 with SMTP id
 g196-20020a8152cd000000b002d693e0f1b2mr2533075ywb.245.1645104776330; Thu, 17
 Feb 2022 05:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20220212175922.665442-1-omosnace@redhat.com> <20220212175922.665442-3-omosnace@redhat.com>
 <CAHC9VhT90617FoqQJBCrDQ8gceVVA6a1h74h6T4ZOwNk6RVB3g@mail.gmail.com>
In-Reply-To: <CAHC9VhT90617FoqQJBCrDQ8gceVVA6a1h74h6T4ZOwNk6RVB3g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 17 Feb 2022 14:32:44 +0100
Message-ID: <CAFqZXNtRgYbZnL25aiDDXzq2ukujiipgJ32CfhfvROAQDHVgLA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] security: implement sctp_assoc_established
 hook in selinux
To:     Paul Moore <paul@paul-moore.com>
Cc:     network dev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Prashanth Prahlad <pprahlad@redhat.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 14, 2022 at 11:14 PM Paul Moore <paul@paul-moore.com> wrote:
> On Sat, Feb 12, 2022 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Do this by extracting the peer labeling per-association logic from
> > selinux_sctp_assoc_request() into a new helper
> > selinux_sctp_process_new_assoc() and use this helper in both
> > selinux_sctp_assoc_request() and selinux_sctp_assoc_established(). This
> > ensures that the peer labeling behavior as documented in
> > Documentation/security/SCTP.rst is applied both on the client and server
> > side:
> > """
> > An SCTP socket will only have one peer label assigned to it. This will be
> > assigned during the establishment of the first association. Any further
> > associations on this socket will have their packet peer label compared to
> > the sockets peer label, and only if they are different will the
> > ``association`` permission be validated. This is validated by checking the
> > socket peer sid against the received packets peer sid to determine whether
> > the association should be allowed or denied.
> > """
> >
> > At the same time, it also ensures that the peer label of the association
> > is set to the correct value, such that if it is peeled off into a new
> > socket, the socket's peer label  will then be set to the association's
> > peer label, same as it already works on the server side.
> >
> > While selinux_inet_conn_established() (which we are replacing by
> > selinux_sctp_assoc_established() for SCTP) only deals with assigning a
> > peer label to the connection (socket), in case of SCTP we need to also
> > copy the (local) socket label to the association, so that
> > selinux_sctp_sk_clone() can then pick it up for the new socket in case
> > of SCTP peeloff.
> >
> > Careful readers will notice that the selinux_sctp_process_new_assoc()
> > helper also includes the "IPv4 packet received over an IPv6 socket"
> > check, even though it hadn't been in selinux_sctp_assoc_request()
> > before. While such check is not necessary in
> > selinux_inet_conn_request() (because struct request_sock's family field
> > is already set according to the skb's family), here it is needed, as we
> > don't have request_sock and we take the initial family from the socket.
> > In selinux_sctp_assoc_established() it is similarly needed as well (and
> > also selinux_inet_conn_established() already has it).
> >
> > Fixes: 72e89f50084c ("security: Add support for SCTP security hooks")
> > Reported-by: Prashanth Prahlad <pprahlad@redhat.com>
> > Based-on-patch-by: Xin Long <lucien.xin@gmail.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/hooks.c | 90 +++++++++++++++++++++++++++++-----------
> >  1 file changed, 66 insertions(+), 24 deletions(-)
>
> This patch, and patch 1/2, look good to me; I'm assuming this resolves
> all of the known SELinux/SCTP problems identified before the new year?

No, not really. There is still the inconsistency that peeloff sockets
go through the socket_[post_]create hooks and then the label computed
is overwritten by the sctp_sk_clone hook. But it's a different issue
unrelated to this one. I'm still in the process of cooking up the
patches and figuring out the consequences (other LSMs would be
affected by the change, too, so it is tricky...).

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

