Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5DFFA3741
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Oct 2022 10:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJ1KdB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Oct 2022 06:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJ1Kcw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Oct 2022 06:32:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6007C187DD0
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 03:32:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r187so5687531oia.8
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zB8BAjJNdwvTu1TcMbykSWmAi2sqHFEWOgWMfTdEcWA=;
        b=X2HCkC5CyaP5zbFrnTUERJo1tEWaZ4MLjrQp0taS9/rdmg/YsFWLiyOAPew2nGhfDI
         s9sLyh3ULpYF466ZA8mqHo0zVQhVBfDHUn1zAyZE/EGtq4BGJ5GNvX9L0izYpb0IXINO
         TYhsL1LQwH4/0hELQdWp8kP22s/Pm3MYphUQbrewNoRi2MTc5zquau2aj22wy0keqW8t
         jddFSDk89D+WrTTZAgE/c9+gEyQhY3gFuABNa6gg24NRAt3dr9FHpUhOhSrMxf52rTlB
         ZyNpjfs+XCE5hZys2GS18YVW2k6XtdhGb9AH2YbUrr5jdegxD8qZJybe0zB8satz0/a5
         M9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zB8BAjJNdwvTu1TcMbykSWmAi2sqHFEWOgWMfTdEcWA=;
        b=khcrnzbSjjLBj/BIXVMuGWiWlo0CJd356UTGGR8jgZP9qdvWPqYTWJ6FrCc4ubN+xG
         4jfr6LjRlAJWz7OOUWxwgCU5LbzHyNPWbBHkPult8BCM36ua1CXexYYqQ7lxP0qtL2mM
         h3aJhBoho2DL0MuTP7ddL+I5g1cJVq0t7BoaLETJUmgQSPcnIvuEl5eqBKMkdK5gm+IQ
         JMPS1poTquo2n8BHboQzIU/g56WcmkKNLJmqh7bxBQ/bkJ1xWD8HjYjCNvb/9QpH6M4q
         3PqLGdTUKoV3I5sGATjrnNCYXs/svMUqHRS0EY2PIzTKhUePdFFXbRm63TgKuy6qL+qr
         +N5A==
X-Gm-Message-State: ACrzQf00YD0wOqBCxIJH/lQkzkpCy6VnH1fDH2pVjyiihCjkjk0giBGm
        ujNC7EHSVwJlIroVp0skDSoHfSj+Mwf7dUM5t5t9
X-Google-Smtp-Source: AMsMyM6V45ZpBGZWipqqDVudaxbgprbN3/vC+HFmh83dfK84+Th7N8dB4dGTrIsHS1LoKX99fGVcxnfTQy83ANQ81k8=
X-Received: by 2002:aca:2404:0:b0:355:53ab:16d5 with SMTP id
 n4-20020aca2404000000b0035553ab16d5mr7874980oic.51.1666953170654; Fri, 28 Oct
 2022 03:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <166543910984.474337.2779830480340611497.stgit@olly>
 <68decac7-f8f7-1569-be84-8419a0e78417@schaufler-ca.com> <CAHC9VhQr_deuGRCien23zso+gi0VHUHK8ayYK6sBxmK3DyBOjg@mail.gmail.com>
In-Reply-To: <CAHC9VhQr_deuGRCien23zso+gi0VHUHK8ayYK6sBxmK3DyBOjg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Oct 2022 06:32:39 -0400
Message-ID: <CAHC9VhQfEX_cADrLC_gV5EhndtrANvbNpTfGVzkq7uqr7XReWw@mail.gmail.com>
Subject: Re: [PATCH] lsm: make security_socket_getpeersec_stream() sockptr_t safe
To:     John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 20, 2022 at 11:10 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Oct 20, 2022 at 9:16 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 10/10/2022 2:58 PM, Paul Moore wrote:
> > > Commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
> > > sockptr_t argument") made it possible to call sk_getsockopt()
> > > with both user and kernel address space buffers through the use of
> > > the sockptr_t type.  Unfortunately at the time of conversion the
> > > security_socket_getpeersec_stream() LSM hook was written to only
> > > accept userspace buffers, and in a desire to avoid having to change
> > > the LSM hook the commit author simply passed the sockptr_t's
> > > userspace buffer pointer.  Since the only sk_getsockopt() callers
> > > at the time of conversion which used kernel sockptr_t buffers did
> > > not allow SO_PEERSEC, and hence the
> > > security_socket_getpeersec_stream() hook, this was acceptable but
> > > also very fragile as future changes presented the possibility of
> > > silently passing kernel space pointers to the LSM hook.
> > >
> > > There are several ways to protect against this, including careful
> > > code review of future commits, but since relying on code review to
> > > catch bugs is a recipe for disaster and the upstream eBPF maintainer
> > > is "strongly against defensive programming", this patch updates the
> > > LSM hook, and all of the implementations to support sockptr_t and
> > > safely handle both user and kernel space buffers.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Smack part looks ok, I haven't had the opportunity to test it.
> > Will do so as I crunch through the backlog.
> >
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>
> Thanks Casey.
>
> John, how do the AppArmor parts look?

Hey John - can you weigh in on the AppArmor bits?

> > > ---
> > >  include/linux/lsm_hook_defs.h |    2 +-
> > >  include/linux/lsm_hooks.h     |    4 ++--
> > >  include/linux/security.h      |   11 +++++++----
> > >  net/core/sock.c               |    3 ++-
> > >  security/apparmor/lsm.c       |   29 +++++++++++++----------------
> > >  security/security.c           |    6 +++---
> > >  security/selinux/hooks.c      |   13 ++++++-------
> > >  security/smack/smack_lsm.c    |   19 ++++++++++---------
> > >  8 files changed, 44 insertions(+), 43 deletions(-)

-- 
paul-moore.com
