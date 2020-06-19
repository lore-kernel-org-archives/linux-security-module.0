Return-Path: <SRS0=nDQO=AA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE1C433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jun 2020 12:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685D1207E8
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jun 2020 12:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJzpqNQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbgFSMtu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:49:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40288 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732007AbgFSMtq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Jun 2020 08:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592570984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/g/+YnCzud6gIE/myiatywuh+bgiNOQQZfOvz+r2RZM=;
        b=DJzpqNQL3Ct78b71K3She8S6lrhS3usL8RrHve8/Fe6OvbZlg6mL0+tQcu46JUkXre2a7j
        wCJeM5i67zqeqXPsz5Xb5HA/z0ezPbvt16HNIJ2y+2qfvWOaQ++M8/Hn63ImspXHOc9tbP
        HV9MlLeH/yVCwJNU1bYE/DUE4N0GBAs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-IFzCDjhBM-CZ2NpYBWoBmg-1; Fri, 19 Jun 2020 08:49:42 -0400
X-MC-Unique: IFzCDjhBM-CZ2NpYBWoBmg-1
Received: by mail-lf1-f70.google.com with SMTP id l1so3414443lfj.3
        for <linux-security-module@vger.kernel.org>; Fri, 19 Jun 2020 05:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/g/+YnCzud6gIE/myiatywuh+bgiNOQQZfOvz+r2RZM=;
        b=msmD0huUmt5387SKOI0FwOMpq2DfBt/4CV0eo4Par2nxBP/YPcnxM92IwHBWxLrJHN
         0OlIrKqEiRVx1GqASlyPOkoKAq2Yf+IhCMkeSyx5urdz7UITSqTEPmIV7HAx/+flngB2
         CE1OojPopcNbwCzlN2vK3t+e7JRmdwLg2HWSBdt20wkzXE/irrfuovCuWcqrrw9EMYdq
         kxzOFmzz1jFnNMl5tvrG7/V3AQoxXsH7/NzQQeplgpcCauxGghhueWoRpMSw3HhsfhUn
         6hxpukTb8xQkhVN3hIZQkdcihCdvqpBYY8AQ8M8uqkVpn2D3uXAJVtXbhpnMv907+Sy2
         1E0Q==
X-Gm-Message-State: AOAM53158mGdXddmfhpARR9FSm8S+4Z7yPTLb2vzuGG79FrKT3TFsDRV
        J7Zoj6+GGIQ9JG2tLMtgGXVj4n74tiSZJ5T4mzLDtIaZ6CFX4gxSm0Bc7W2FRunogG8T7ziAaEQ
        VBOead82lXUXcx8/cTexS0IyPcUmY+AVfmX1wosxCe++3qiHYT3uJ
X-Received: by 2002:ac2:5604:: with SMTP id v4mr1946243lfd.124.1592570981105;
        Fri, 19 Jun 2020 05:49:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXiPt6NoxSwMoZyeQFCP8RfJAk3JTg7gTtWYjd2TAO4zxGdEHaGSVd0jZZyRVkg26M9VYhdLJvCgnHGSnzbYY=
X-Received: by 2002:ac2:5604:: with SMTP id v4mr1946227lfd.124.1592570980848;
 Fri, 19 Jun 2020 05:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200520125616.193765-1-kpsingh@chromium.org>
In-Reply-To: <20200520125616.193765-1-kpsingh@chromium.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 19 Jun 2020 14:49:29 +0200
Message-ID: <CAFqZXNsu8Vs86SKpdnej_=xnQqg=Hh132JqNe1Ybt-bHJB4NeQ@mail.gmail.com>
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
To:     KP Singh <kpsingh@chromium.org>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 20, 2020 at 2:56 PM KP Singh <kpsingh@chromium.org> wrote:
> From: KP Singh <kpsingh@google.com>
>
> secid_to_secctx is not stackable, and since the BPF LSM registers this
> hook by default, the call_int_hook logic is not suitable which
> "bails-on-fail" and casues issues when other LSMs register this hook and
> eventually breaks Audit.
>
> In order to fix this, directly iterate over the security hooks instead
> of using call_int_hook as suggested in:
>
> https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
>
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
[...]

Sorry for being late to the party, but doesn't this (and the
associated default return value patch) just paper over a bigger
problem? What if I have only the BPF LSM enabled and I attach a BPF
program to this hook that just returns 0? Doesn't that allow anything
privileged enough to do this to force the kernel to try and send
memory from uninitialized pointers to userspace and/or copy such
memory around and/or free uninitialized pointers?

Why on earth does the BPF LSM directly expose *all* of the hooks, even
those that are not being used for any security decisions (and are
"useful" in this context only for borking the kernel...)? Feel free to
prove me wrong, but this lazy approach of "let's just take all the
hooks as they are and stick BPF programs to them" doesn't seem like a
good choice... IMHO you should either limit the set of hooks that can
be attached to only those that aren't used to return back values via
pointers, or (if you really really need to do some state
updates/logging in those hooks) use wrapper functions that will call
the BPF progs via a simplified interface so that they cannot cause
unsafe behavior.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

