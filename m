Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517DCC433FE
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Dec 2020 23:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0587F2245C
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Dec 2020 23:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgLCXbP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Dec 2020 18:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgLCXbP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Dec 2020 18:31:15 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D958C061A4F
        for <linux-security-module@vger.kernel.org>; Thu,  3 Dec 2020 15:30:34 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so5983095ejb.13
        for <linux-security-module@vger.kernel.org>; Thu, 03 Dec 2020 15:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NR9oRwj3TSbmYk5wMv1T5De4ZNaJpHA3oFz3Npuf3W8=;
        b=JGl7MF43anxbW/l5Y5J5TPVql+vw5eqSvFLKRsBFJxtMNjnVWl0U10T9ms9Ua0f+jq
         5jnTWwEeWs3i6121m4achrWK5I/ZXEi1a9ayMFxKqtkNURU3yZuEDveMiRXG4BIfgBet
         pODG+2L0rNYrieuVzcZ+u4IM9ftZ5vTwbTr9bqpsIHW2rSYB6clTgTJIlIu06Af4h5kQ
         s9D6PJAZ3LNu24H3RG0VKJfjLWTEfhhI3hsx0FKFVM8akj3k+WozhYTze4vNVEULepcf
         4SqFK5lxW7ZOO+Bt93hRzOCpWLzqJz/hse098sKSYc6bq8S0vsTT8KpjKKLqLbCq5Cuh
         hQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NR9oRwj3TSbmYk5wMv1T5De4ZNaJpHA3oFz3Npuf3W8=;
        b=GzrNaqJ7qo7Dgs7sEykgCJoYMpshSXqgxVv4Hk6m5/84AggzXHFSwpyvtiYUdupDvM
         AJ8/XfBWMKUm4B/jMNXCiZsrBsm8GF3nKmvXlE0+hK/RFCmRVy1k+KrnIlx5DsgHPy7S
         ULFRWsQHgN78FaX1RP4nLLeyg2YifZ0c2ga/l+4bjBO+w7wMzZq0JVcDSrsqR0wze5Rl
         nJiYJj9xWYos5Cm+UxQAXRdEdUbFCL+k4krJTCvxOdP+wJtJzP1mOy1o0oUn9WusMJ40
         NZ8upb/bCdz14k7qkPhpZTv8DugJjaTqdQBBJDy7rSC+64jg/9Lcj7auf5374QvHtf/P
         lo2g==
X-Gm-Message-State: AOAM532b8t32Ips6/3wgrp+D4X34yHFjkfP1HwhLCsX9DkLuxo/excuD
        o8W1EdEpq26CymO64VjbQ680XC5meag55VTKsuxR
X-Google-Smtp-Source: ABdhPJy0ChvHIjXbonGYzA/CgNMV5CaZxR9DBRCVPWSfsgRVHTU/S447rCGwrSYu5K3bIKhwX+8MyTouZ5DO/ZSkNUA=
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr4776398ejc.178.1607038233262;
 Thu, 03 Dec 2020 15:30:33 -0800 (PST)
MIME-Version: 1.0
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
 <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com> <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com>
In-Reply-To: <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Dec 2020 18:30:22 -0500
Message-ID: <CAHC9VhTVc07P_MhWm7YRF6LXdMRQOcDEKe7SB+fpJJizdKOvEg@mail.gmail.com>
Subject: Re: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with TCP
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 3, 2020 at 12:24 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
> On Wed, 2 Dec 2020, Paolo Abeni wrote:
> > On Wed, 2020-12-02 at 11:31 +0100, Paolo Abeni wrote:
> >> The MPTCP protocol uses a specific protocol value, even if
> >> it's an extension to TCP. Additionally, MPTCP sockets
> >> could 'fall-back' to TCP at run-time, depending on peer MPTCP
> >> support and available resources.
> >>
> >> As a consequence of the specific protocol number, selinux
> >> applies the raw_socket class to MPTCP sockets.
> >>
> >> Existing TCP application converted to MPTCP - or forced to
> >> use MPTCP socket with user-space hacks - will need an
> >> updated policy to run successfully.
> >>
> >> This change lets selinux attach the TCP socket class to
> >> MPTCP sockets, too, so that no policy changes are needed in
> >> the above scenario.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >>  security/selinux/hooks.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 6b1826fc3658..9a6b4bf1bc5b 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -1120,7 +1120,8 @@ static inline u16 inode_mode_to_security_class(umode_t mode)
> >>
> >>  static inline int default_protocol_stream(int protocol)
> >>  {
> >> -    return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP);
> >> +    return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP ||
> >> +            protocol == IPPROTO_MPTCP);
> >>  }
>
> This looks like a good default to me.
>
> >>
> >>  static inline int default_protocol_dgram(int protocol)
> >> @@ -1152,7 +1153,7 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
> >>                              return SECCLASS_TCP_SOCKET;
> >>                      else if (extsockclass && protocol == IPPROTO_SCTP)
> >>                              return SECCLASS_SCTP_SOCKET;
> >> -                    else
> >> +                    elseextsockclass
> >
> > Whoops, my bad! I don't know how this chunk slipped-in. I'll fix it in
> > the formal submission for inclusion, if there is agreement on this
> > change.
>
> Ok, looks fine to send after fixup.

I'm not very well versed in MPTCP, but this *seems* okay to me, minus
the else-crud chunk.  Just to confirm my understanding, while MPTCP
allows one TCP connection/stream to be subdivided and distributed
across multiple interfaces, it does not allow multiple TCP streams to
be multiplexed on a single connection, yes?

> I think there may be a small fix required to smack too, but that's an
> entirely different patch.

It would probably be a good idea to CC the LSM list just to make sure
all of the LSMs are made aware (done on this email).

-- 
paul moore
www.paul-moore.com
