Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA0EC4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Dec 2022 15:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiLLPh5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Dec 2022 10:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiLLPht (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Dec 2022 10:37:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C1B9FEA
        for <linux-security-module@vger.kernel.org>; Mon, 12 Dec 2022 07:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670859415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PccKKszWkRWP5I2XDQgnn1TfMCygRci1+qIyYeNPyTU=;
        b=CCZYWE3UanN2vzPc/A1tK4I345JRzWQuUGcfmFVv6LQ3t6TzQ+985uaBwUP2b4mP4xcuxP
        CX9+xklTN8Kejx6Za/oRLBmaFwsYkar6wx15oZifMzcnmsfZWGls/A/2Uf7UZc+txPPHm1
        yCpaYC4OiXYCRaXzHfRpaNo1D0OcBs4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-377-hA58MuB4OcyhFnwxPLKu6Q-1; Mon, 12 Dec 2022 10:36:52 -0500
X-MC-Unique: hA58MuB4OcyhFnwxPLKu6Q-1
Received: by mail-yb1-f199.google.com with SMTP id i10-20020a25f20a000000b006ea4f43c0ddso13386396ybe.21
        for <linux-security-module@vger.kernel.org>; Mon, 12 Dec 2022 07:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PccKKszWkRWP5I2XDQgnn1TfMCygRci1+qIyYeNPyTU=;
        b=oN8MuATZKQGbB7+qmeuNQmiEGO0QuCO4TL8BFxgwuR6S5EQ1nx7D5PkfgBb22pIWM7
         FiPfr9MzOHoCvsz38NJ2T/v22iS3xC9daPhPRtQPblogJNxjQc0lwWP8YByNt+IfTmBY
         B6ENs33FGH/kNXW/vQPyo7cLQUO/kxQhLvLA8VikNGaQ0Bo7qFdHu3LZ8coFlxR5yfO+
         eK36ugmNyw1fMG+pSGzJjN8YG4L3dnA/ao2l5CeuEyEna6PZHoODLEjVF3hKWnDYhQ0q
         uR23Z8ZzMb2VF4HAzm54+XgBA5w8Xx6/WLAqzx80fsjmgr8Z8oAkIC4xhGXD6ZBZgcon
         ETww==
X-Gm-Message-State: ANoB5pn7TciYMq7dAF5rC3MIz/Al+L5E8BC8E7fpomRru/Z0sM6/Bjqt
        cVLQ2v0sTKOWf0B6u353QLPx3NlLjWF8z/brxOFoUFJd0t/N1xj0yG+De89yXuswP1BCSw9eWLJ
        /9i/4hOhhx9nSZsrq1Xa2B2Y42fF1BFLuhYA4
X-Received: by 2002:a05:690c:c0f:b0:3e3:b823:db3c with SMTP id cl15-20020a05690c0c0f00b003e3b823db3cmr15425531ywb.46.1670859411950;
        Mon, 12 Dec 2022 07:36:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YEE+nBMdkf+sl+1Cqvao/1eIaETZGMRa8d1Z+htlQZ3qfbcab5EPNjWmo0Y4+I0MTV0Wthg==
X-Received: by 2002:a05:690c:c0f:b0:3e3:b823:db3c with SMTP id cl15-20020a05690c0c0f00b003e3b823db3cmr15425505ywb.46.1670859411656;
        Mon, 12 Dec 2022 07:36:51 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id de36-20020a05620a372400b006e99290e83fsm5928683qkb.107.2022.12.12.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 07:36:51 -0800 (PST)
Message-ID: <75d48710be78d59e990cbb3930133a4f42c95a30.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix LSM labeling for passive msk
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc:     mptcp@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Date:   Mon, 12 Dec 2022 16:36:47 +0100
In-Reply-To: <CAHC9VhQzJAhNtpMnU7STEfq6QpaJo-xiie8HoHH2w3io3aXBHw@mail.gmail.com>
References: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
         <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com>
         <CAHC9VhQzJAhNtpMnU7STEfq6QpaJo-xiie8HoHH2w3io3aXBHw@mail.gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

On Thu, 2022-12-08 at 18:40 -0500, Paul Moore wrote:
> On Wed, Dec 7, 2022 at 9:19 PM Mat Martineau
> <mathew.j.martineau@linux.intel.com> wrote:
> > On Wed, 7 Dec 2022, Paolo Abeni wrote:
> > 
> > > MPTCP sockets created via accept() inherit their LSM label
> > > from the initial request socket, which in turn get it from the
> > > listener socket's first subflow. The latter is a kernel socket,
> > > and get the relevant labeling at creation time.
> > > 
> > > Due to all the above even the accepted MPTCP socket get a kernel
> > > label, causing unexpected behaviour and failure on later LSM tests.
> > > 
> > > Address the issue factoring out a socket creation helper that does
> > > not include the post-creation LSM checks. Use such helper to create
> > > mptcp subflow as in-kernel sockets and doing explicitly LSM validation:
> > > vs the current user for the first subflow, as a kernel socket otherwise.
> > > 
> > > Fixes: 0c14846032f2 ("mptcp: fix security context on server socket")
> > > Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > 
> > The MPTCP content looks good to me:
> > 
> > Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > 
> > I didn't see issues with the socket.c changes but I'd like to get some
> > security community feedback before upstreaming - Paul or other security
> > reviewers, what do you think?
> 
> Sorry, I was distracted by other things the past few days ...
> 
> One thing that jumps out is the potential for misuse of
> __sock_create_nosec(); I can see people accidentally using this
> function by accident in other areas of the stack and causing a new set
> of problems.
> 
> We discussed this in the other thread, but there is an issue with
> subflows being labeled based on the mptcp_subflow_create_socket()
> caller and not the main MPTCP socket.
> 
> I know there is a desire to get a small (in size) patch to fix this,
> but I think creating a new LSM hook may be the only way to solve this
> in a sane manner.  My original thought was a new LSM hook call inside
> mptcp_subflow_create_socket() right after the sock_create_kern() call.
> The only gotcha is that it would occur after
> security_socket_post_create(), but that should be easy enough to
> handle inside the LSMs.

If the preferrede solution is via a new LSM hook I have no objections
at all. I'm sorry to put another hook mainteinance on you.

How do you propose to preceed? After quickly digging into the relevant
LSM code, the only module I think I could handle in a reasonable
timeframe is selinux. Hopefully the new hook implementation should be
quite straight-forward for the relevant SME.

I guess the patch[es] should target the LSM tree, as the change in the
mptcp code should be a one-liner. On the flip side, that would likely
lead to some merge conflict, as the mptcp protocol impl. is quite a
moving target.

Cheers,

Paolo

