Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71628C4361B
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Dec 2020 02:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1B122B39
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Dec 2020 02:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgLJCoO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgLJCoN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Dec 2020 21:44:13 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B4C0613CF
        for <linux-security-module@vger.kernel.org>; Wed,  9 Dec 2020 18:43:33 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cw27so3885706edb.5
        for <linux-security-module@vger.kernel.org>; Wed, 09 Dec 2020 18:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0aVBj2oVCLmagjHE9Cqxds8/lFdzYP2q+t0zPGaUgo=;
        b=2HxpDWHAkg2P2hR8w583x17naj9uMrD3SIpVb1k80iG/nMVCtND0iEmCg44KbqqvH7
         BhAOfKsc+rwS5yVv74HAA+COrX2gMt3hUtMnBoaNqx1rU5gccNjgPq1JfiE4oQMKb3O9
         ZQw9RgObzLPPcF5EZtqUQz6I3G3KhU3eiJ/VusFUH6dYFUTcD10BN9ZbqAS4e5NtliJb
         ZWpn3pxKzP5Halty0JnorNYWh9/9jzz426qf8YYwwUCvpBK6wtw3xK7H2ALNtkREQeWn
         3selvEwrQhnSRQdj/05nO8qLOirdN82izmehz50HXck6WdDWvIhPuS2pGsqFEgk8UckI
         oFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0aVBj2oVCLmagjHE9Cqxds8/lFdzYP2q+t0zPGaUgo=;
        b=Pr3Hk2+sf7mSq4qi3chDSLIaKP+CEl6padKMrDMhXqoZPFzIo0aqAchhY20pUINQRH
         eAzKdhrcql6MnEq1y0Z8/uZGSODn8GXC9sbvB+f/MDygljqHuU+R9ARlmbIdzfC2yQh6
         J964nVYVqw1LAqhBUnrdSrXIl0INlvfAFXdhJBwtvUSovdxPjQ0pBvK0GWhtEjWH32kp
         azhWIgo3QSIV54zZvDksN8Mj2ayNJBRr+gT+69gEQpKkA1OxfMtsykdGltnT2O3xAv2M
         l49wRLuF31wcBQbIQFjQkKf74JS8qfZLhn7J4Br2f9LuX9l+nA9bza75itvJB8wqOPVo
         v6vA==
X-Gm-Message-State: AOAM533k/f+36qPkw3MerK5pY32K/AtuiGrWdiobYUVSuABLQYmXhIf7
        aPuRyJPhQZLMSC3NZKhl6q/yYYDfoTH0P96DID3a
X-Google-Smtp-Source: ABdhPJyU1agaVGRzuOArAtj6MGJiTK9Y4THXqFVifU1fZsssvIdLnq+R2HS7zuTXBFK/lIy9Ik/ud9pAN0emhnWgGU4=
X-Received: by 2002:a05:6402:44b:: with SMTP id p11mr4747810edw.164.1607568212212;
 Wed, 09 Dec 2020 18:43:32 -0800 (PST)
MIME-Version: 1.0
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
 <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
 <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com> <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
 <20201203235415.GD5710@breakpoint.cc> <CAHC9VhT-rj=tJwVycS19TgJDQ766oUH6ng+Uv=wu+WDrgE0AHA@mail.gmail.com>
 <8c844984eaa92413066367af69b56194b111ad8f.camel@redhat.com>
 <CAHC9VhS9xRSbHMCgDkix0fHYeO=aA_=DVyV1Xdu8qFpggws8Kg@mail.gmail.com>
 <08b7534580e1bdb134ba0c2816977836cd446c5d.camel@redhat.com>
 <CAHC9VhQmZ_Ra8eY3O-qNo-QN9wLXBFP3VHuHvjY8vWOMSfGafA@mail.gmail.com> <8ceb498f3fd712c4122718cf445f8e3f2a642140.camel@redhat.com>
In-Reply-To: <8ceb498f3fd712c4122718cf445f8e3f2a642140.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Dec 2020 21:43:21 -0500
Message-ID: <CAHC9VhTaK3xx0hEGByD2zxfF7fadyPP1kb-WeWH_YCyq9X-sRg@mail.gmail.com>
Subject: Re: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 9, 2020 at 5:02 AM Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2020-12-08 at 18:35 -0500, Paul Moore wrote:
> > On Tue, Dec 8, 2020 at 10:35 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > Hello,
> > >
> > > I'm sorry for the latency, I'll have limited internet access till
> > > tomorrow.
> > >
> > > On Fri, 2020-12-04 at 18:22 -0500, Paul Moore wrote:
> > > > For SELinux the issue is that we need to track state in the sock
> > > > struct, via sock->sk_security, and that state needs to be initialized
> > > > and set properly.
> > >
> > > As far as I can see, for regular sockets, sk_security is allocated via:
> > >
> > > - sk_prot_alloc() -> security_sk_alloc() for client/listener sockets
> > > - sk_clone_lock() -> sock_copy() for server sockets
> > >
> > > MPTCP uses the above helpers, sk_security should be initialized
> > > properly.
> >
> > At least for SELinux, the security_socket_post_create() hook is
> > critical too as that is where the SELinux sock/socket state values are
> > actually set; see selinux_socket_post_create() for the SELinux hook.
>
> MPTCP sockets are created via the conventional sys_socket() call path
> or sk_clone_lock(). MPTCP subflows are created via sock_create_kern()
> or csk_af_ops->syn_recv_sock().
>
> Overall the above matches what plain TCP does: client sockets and
> listener sockets will hit selinux_socket_post_create(), server sockets
> will hit security_sk_clone().
>
> > > >  Similarly with TCP request_sock structs, via
> > > > request_sock->{secid,peer_secid}.  Is the MPTCP code allocating and/or
> > > > otherwise creating socks or request_socks outside of the regular TCP
> > > > code?
> > >
> > > Request sockets are easier, I guess/hope: MPTCP handles them very
> > > closely to plain TCP.
> >
> > Are there a calls to security_inet_conn_request() and
> > security_inet_csk_clone() in the MPTCP code path?  As an example look
> > at tcp_conn_request() and inet_csk_clone_lock() for IPv4.
>
> MPTCP subflows call both the above, via the relevant TCP call-path.
> MPTCP sockets calls security_inet_conn_request() for client sockets on
> connect(), but it looks like we currently lack a call
> to security_inet_csk_clone() for server MPTCP sockets, as they are
> created via direct call to sk_clone_lock().
>
> I think that could be easily handled with an MPTCP patch.
>
> > > > We would also be concerned about socket structs, but I'm
> > > > guessing that code reuses the TCP code based on what you've said.
> > >
> > > Only the main MPTCP 'struct socket' is exposed to the user space, and
> > > that is allocated via the usual __sys_socket() call-chain. I guess that
> > > should be fine. If you could provide some more context (what I should
> > > look after) I can dig more.
> >
> > Hopefully the stuff above should help, if not let me know :)
>
> yes, it helped, thanks!
>
> My understanding is that the MPTCP implementation aligns with this
> proposed patch - modulo the required changed mentioned above, which
> looks like a MPTCP bug.

Great, thanks for taking the time to go through all this with me/us.
When you're ready with an updated patch(set), be sure to send it to
both the SELinux and LSM lists so we can look it over, ACK, etc.

Thanks!

-- 
paul moore
www.paul-moore.com
