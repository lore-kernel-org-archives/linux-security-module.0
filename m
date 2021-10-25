Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBE9C4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 08:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1703060EE9
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Oct 2021 08:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhJYITm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231685AbhJYITm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Oct 2021 04:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635149840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0PbCh/f6v5Mr3XWPFNcAw3uOEmvsmdFvbrT4W31P5CY=;
        b=DXrTY9QHhju19w5VW96U1RjSOAXUmW+FCoqBHB0V61GlqRPy3SWV6luGH0mfYO7q9nu5cd
        XGae/jhKdfFIkuAAXo6a11ehigzZ/LmWkV1ILpDsXzVqHYKv/q9KzJqNk8tNALpKDGvjrX
        35G2zQZHanTO2be35PdM6DlDX/FVn/k=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-cVGk4x5cMXyPT9BG3n0c7Q-1; Mon, 25 Oct 2021 04:17:18 -0400
X-MC-Unique: cVGk4x5cMXyPT9BG3n0c7Q-1
Received: by mail-yb1-f198.google.com with SMTP id h185-20020a256cc2000000b005bdce4db0easo16147777ybc.12
        for <linux-security-module@vger.kernel.org>; Mon, 25 Oct 2021 01:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PbCh/f6v5Mr3XWPFNcAw3uOEmvsmdFvbrT4W31P5CY=;
        b=CcTtXgeGRverkZfnNr57v6N5sihrpzmN77mrXdx1cTDeafYtH5hHx8mg8HZdF161UT
         mtd56bmV7p8uTdFHSL7eeR5qipgel9VfEl/BdBU3+nqQifXkzQaWXtBgyLFQ8OpdlyGs
         xhkXO+Y4JhFaiK/YMfNoPLH+GpzKi7a/e/8L4AkFOX6RZBdSOh9eccZ3Ev59RTgvbz5R
         aP95vtrMQHMnPBjb4Yhq9bR6GHIS4pWYHCtI0qVkgPj+SsSVo+T3EZJLs72jir3SBIdW
         5hgOlbayKBlfvJNpho/tRTwGXb3/qxlXvj7qwzY7tDPaLi64spx8wEigGlojnW/BsqhH
         /ayA==
X-Gm-Message-State: AOAM532kGtuk6qh8KMVXmSN47H8c4jk2I+bgCSDlR0RWZUZ1FJuYhIEk
        G/W6V3tM7A49Eq4P1Tr+0b5GpqsHbDp4gSCOOHJh7uOFpWLoCf9smHmFISjyn48beAnJh1vxRp/
        n9DrvIxizqYRUr2TQajg6DoSQRbm7dG1yffK4N1Kf89XSNOo1TfWP
X-Received: by 2002:a25:3308:: with SMTP id z8mr15949249ybz.384.1635149837725;
        Mon, 25 Oct 2021 01:17:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyV6iwnX5my7u3trMgr4p8Ip5qSrgjNdNPT0BaDlNaTLHrvB6lD00jifJC29Lyq4YyGXdT52OSopw/4yM3UVSk=
X-Received: by 2002:a25:3308:: with SMTP id z8mr15949223ybz.384.1635149837497;
 Mon, 25 Oct 2021 01:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634884487.git.lucien.xin@gmail.com> <53026dedd66beeaf18a4570437c4e6c9e760bb90.1634884487.git.lucien.xin@gmail.com>
In-Reply-To: <53026dedd66beeaf18a4570437c4e6c9e760bb90.1634884487.git.lucien.xin@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Oct 2021 10:17:06 +0200
Message-ID: <CAFqZXNs89yGcoXumNwavLRQpYutfnLY-SM2qrHbvpjJxVtiniw@mail.gmail.com>
Subject: Re: [PATCH net 4/4] security: implement sctp_assoc_established hook
 in selinux
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 22, 2021 at 8:36 AM Xin Long <lucien.xin@gmail.com> wrote:
> Different from selinux_inet_conn_established(), it also gives the
> secid to asoc->peer_secid in selinux_sctp_assoc_established(),
> as one UDP-type socket may have more than one asocs.
>
> Note that peer_secid in asoc will save the peer secid for this
> asoc connection, and peer_sid in sksec will just keep the peer
> secid for the latest connection. So the right use should be do
> peeloff for UDP-type socket if there will be multiple asocs in
> one socket, so that the peeloff socket has the right label for
> its asoc.

Hm... this sounds like something we should also try to fix (if
possible). In access control we can't trust userspace to do the right
thing - receiving from multiple peers on one SOCK_SEQPACKET socket
shouldn't cause checking against the wrong peer_sid. But that can be
addressed separately. (And maybe it's even already accounted for
somehow - I didn't yet look at the code closely.)

>
> Fixes: 72e89f50084c ("security: Add support for SCTP security hooks")
> Reported-by: Prashanth Prahlad <pprahlad@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  security/selinux/hooks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f025fc00421b..793fdcbc68bd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5525,6 +5525,21 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
>         selinux_netlbl_sctp_sk_clone(sk, newsk);
>  }
>
> +static void selinux_sctp_assoc_established(struct sctp_association *asoc,
> +                                          struct sk_buff *skb)
> +{
> +       struct sk_security_struct *sksec = asoc->base.sk->sk_security;
> +       u16 family = asoc->base.sk->sk_family;
> +
> +       /* handle mapped IPv4 packets arriving via IPv6 sockets */
> +       if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
> +               family = PF_INET;
> +
> +       selinux_skb_peerlbl_sid(skb, family, &sksec->peer_sid);

You could replace the above with
`selinux_inet_conn_established(asoc->base.sk, skb);` to reduce code
duplication.

> +       asoc->secid = sksec->sid;
> +       asoc->peer_secid = sksec->peer_sid;
> +}
> +
>  static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
>                                      struct request_sock *req)
>  {
> @@ -7290,6 +7305,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(sctp_assoc_request, selinux_sctp_assoc_request),
>         LSM_HOOK_INIT(sctp_sk_clone, selinux_sctp_sk_clone),
>         LSM_HOOK_INIT(sctp_bind_connect, selinux_sctp_bind_connect),
> +       LSM_HOOK_INIT(sctp_assoc_established, selinux_sctp_assoc_established),
>         LSM_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
>         LSM_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
>         LSM_HOOK_INIT(inet_conn_established, selinux_inet_conn_established),
> --
> 2.27.0
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

