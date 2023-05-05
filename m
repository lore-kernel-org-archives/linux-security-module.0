Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B71C77B7C
	for <linux-security-module@archiver.kernel.org>; Fri,  5 May 2023 14:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjEEORa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 May 2023 10:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjEEOR3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 May 2023 10:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FF74696
        for <linux-security-module@vger.kernel.org>; Fri,  5 May 2023 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683296205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQtfdULdSvD0JHxZLBgiy4HejSjwOhquH5OGzliVEtg=;
        b=DQpiX5lTyrLZ6UM0mEtj8zfra1rHi4fk+VUgZ1TGrI+r9vEpZybRw2uE0IeWtvMhhxyWKh
        3omvVgj8YQADNcqhWI4M9zkEiECbLQ6BAo7c7vmtW4798pzGi/QBE2o4KQNKf5agrUw2Ql
        n6nlfN3CvB8ez4p0tAFDD8GJAkWQC48=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-IzVc-M7hMpK81NPptKUKQw-1; Fri, 05 May 2023 10:16:41 -0400
X-MC-Unique: IzVc-M7hMpK81NPptKUKQw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-64378a8b332so970252b3a.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 May 2023 07:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683296200; x=1685888200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQtfdULdSvD0JHxZLBgiy4HejSjwOhquH5OGzliVEtg=;
        b=VRibtD0ArFh30W5WmoCEA5M/iUX2cymYaofQfaRSpf+BE3yViCaytgOODiQbiGMpbS
         9z/p1pEhAi3TWwLG4PrZ6TfFXlJ5rR68YBGDUJTNaDplMRDmNAGIicTjLHtj6ZRI8chB
         WLPTDuvNnaevKATg2OPg6/HaHdrn00e5JVSUir448Z1RPc4imFboShfo3LMQ52udLncx
         gXetN57Tf66PFK0FRKcIMQpfM79Su5iNxVK0y39Ktya3VHcqYGUPnj+McRPrLpzY9zS9
         TNoWxdAJ5hjw+OBpl0uCeC7wQjCEmVG3t8QxfFh6fY0NqS7Zm6/h1V6SGnrhlot37hVp
         9JPw==
X-Gm-Message-State: AC+VfDxH0HlbvD7PxWqJIQWQYED+hWeM0f/jatBBqRdRsWX5aRKS82s5
        3CPXwYXJv/nephKf39U5av/VRuFlU8wa8OPA9wzWaqJoPoXi8EeUX0WPhHwDBxym5jUMiqfhXvi
        IJCHyUdhDSXpp5iwSpAYYG0/IsY+XqTqO0sWcq/IN2CGqjf9Tpxt5
X-Received: by 2002:a05:6a00:1747:b0:63c:e253:a692 with SMTP id j7-20020a056a00174700b0063ce253a692mr2409782pfc.15.1683296200113;
        Fri, 05 May 2023 07:16:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mtxXj7DMVyAnEBbSIbKGOxmXfWEDkrJMvTzQz3xakLYGwlu3RNE//5PvMJFJvDrwgPGQHOJBcCZUFZi6smSg=
X-Received: by 2002:a05:6a00:1747:b0:63c:e253:a692 with SMTP id
 j7-20020a056a00174700b0063ce253a692mr2409748pfc.15.1683296199774; Fri, 05 May
 2023 07:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-0-e7a3c8c15676@tessares.net>
 <CAFqZXNt16B5A2o6fZeN5b1coNCW2m6kp7JToJFDorvPajhFyxA@mail.gmail.com> <11201df515ec41db88ad915fd1e425e62c4f81e5.camel@redhat.com>
In-Reply-To: <11201df515ec41db88ad915fd1e425e62c4f81e5.camel@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 5 May 2023 16:16:28 +0200
Message-ID: <CAFqZXNsR4cTTFbToszUhOPr5pJNET3jJMDFPXB73RD-eqRg5_Q@mail.gmail.com>
Subject: Re: [PATCH LSM v2 0/2] security: SELinux/LSM label with MPTCP and accept
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 4, 2023 at 6:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
> On Thu, 2023-05-04 at 16:14 +0200, Ondrej Mosnacek wrote:
> > On Thu, Apr 20, 2023 at 7:17=E2=80=AFPM Matthieu Baerts
> > <matthieu.baerts@tessares.net> wrote:
> > >
> > > In [1], Ondrej Mosnacek explained they discovered the (userspace-faci=
ng)
> > > sockets returned by accept(2) when using MPTCP always end up with the
> > > label representing the kernel (typically system_u:system_r:kernel_t:s=
0),
> > > while it would make more sense to inherit the context from the parent
> > > socket (the one that is passed to accept(2)). Thanks to the
> > > participation of Paul Moore in the discussions, modifications on MPTC=
P
> > > side have started and the result is available here.
> > >
> > > Paolo Abeni worked hard to refactor the initialisation of the first
> > > subflow of a listen socket. The first subflow allocation is no longer
> > > done at the initialisation of the socket but later, when the connecti=
on
> > > request is received or when requested by the userspace. This was a
> > > prerequisite to proper support of SELinux/LSM labels with MPTCP and
> > > accept. The last batch containing the commit ddb1a072f858 ("mptcp: mo=
ve
> > > first subflow allocation at mpc access time") [2] has been recently
> > > accepted and applied in netdev/net-next repo [3].
> > >
> > > This series of 2 patches is based on top of the lsm/next branch. Desp=
ite
> > > the fact they depend on commits that are in netdev/net-next repo to
> > > support the new feature, they can be applied in lsm/next without
> > > creating conflicts with net-next or causing build issues. These two
> > > patches on top of lsm/next still passes all the MPTCP-specific tests.
> > > The only thing is that the new feature only works properly with the
> > > patches that are on netdev/net-next. The tests with the new labels ha=
ve
> > > been done on top of them.
> > >
> > > Regarding the two patches, the first one introduces a new LSM hook
> > > called from MPTCP side when creating a new subflow socket. This hook
> > > allows the security module to relabel the subflow according to the ow=
ing
> > > process. The second one implements this new hook on the SELinux side.
> > >
> > > Link: https://lore.kernel.org/netdev/CAFqZXNs2LF-OoQBUiiSEyranJUXkPLc=
CfBkMkwFeM6qEwMKCTw@mail.gmail.com/ [1]
> > > Link: https://git.kernel.org/netdev/net-next/c/ddb1a072f858 [2]
> > > Link: https://lore.kernel.org/netdev/20230414-upstream-net-next-20230=
414-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net/ [3]
> > > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > > ---
> > > Changes in v2:
> > > - Address Paul's comments, see the notes on each patch
> > > - Link to v1: https://lore.kernel.org/r/20230419-upstream-lsm-next-20=
230419-mptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net
> > >
> > > ---
> > > Paolo Abeni (2):
> > >       security, lsm: Introduce security_mptcp_add_subflow()
> > >       selinux: Implement mptcp_add_subflow hook
> > >
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  6 ++++++
> > >  net/mptcp/subflow.c           |  6 ++++++
> > >  security/security.c           | 17 +++++++++++++++++
> > >  security/selinux/hooks.c      | 16 ++++++++++++++++
> > >  security/selinux/netlabel.c   |  8 ++++++--
> > >  6 files changed, 52 insertions(+), 2 deletions(-)
> > > ---
> > > base-commit: d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > > change-id: 20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx=
-eee658fafcba
> > >
> > > Best regards,
> > > --
> > > Matthieu Baerts <matthieu.baerts@tessares.net>
> > >
> >
> > I haven't yet looked closer at the code in this series, but I can at
> > least confirm that with the series (applied on top of net-next) the
> > selinux-testsuite now passes when run under mptcpize, with one caveat:
> >
> > The "client" test prog in the inet_socket subtest sets the SO_SNDTIMEO
> > socket option on the client socket, but the subtest takes
> > significantly longer to complete than when run without mptcpize. That
> > suggests to me that there is possibly some (pre-existing) issue with
> > MPTCP where the send/receive timeouts are not being passed to the
> > subflow socket(s), leading to a longer wait (I guess the default is
> > higher?)
>
> Indeed the behavior you describe is due to some mptcp bug in handling
> the SO_{SND,RCV}TIMEO socket tions, and it's really unrelated to the
> initially reported selinux issue.

Definitely unrelated, just wanted to report the bug :)

> If you could file an issue on our tracker, that would help ;)

I was about to ask where that tracker is, but then it occured to me to
check MAINTAINERS and the link is right there, so yes, will do :)


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

