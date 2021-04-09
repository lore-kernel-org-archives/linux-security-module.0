Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCCC43462
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD3D6113A
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Apr 2021 17:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhDIRoE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233896AbhDIRoE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Apr 2021 13:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617990230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMoHusWRU3EEFKJLrdPdn6fw7g5fEbxgGHTh4Vd8ET0=;
        b=I6kxOgE8Ko+rYXsYf5aOZ7yh2T5kfKHh+IXlNkAZyPIKYwTjG9yquk3uGTUdfsXzGGpp2X
        gTyaw/WmfmFGgyyT77p3hrz0lagpAeikNJohCRgFV1hx6t2pJ/FU/8gp5mi0BDdxJs6x9n
        T10oX9flDjYP9xwCNbrt3P3Dcky/fS0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-nbd-XsP5O8mIqv-8tT1JWQ-1; Fri, 09 Apr 2021 13:43:46 -0400
X-MC-Unique: nbd-XsP5O8mIqv-8tT1JWQ-1
Received: by mail-yb1-f199.google.com with SMTP id w7so6093379ybq.4
        for <linux-security-module@vger.kernel.org>; Fri, 09 Apr 2021 10:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMoHusWRU3EEFKJLrdPdn6fw7g5fEbxgGHTh4Vd8ET0=;
        b=tbeAWJjyecyN3KAqgjRq6XlRTElyY8kcTmz56I76V0TuWe1jRwQp6DP3P1b4fSpjI/
         3nuahZ0TfaxnPkMMnMHj247eaBlTaGatI6vBWPjP834fd4ebkPxNxClvxy3V+U6wG72m
         iNgZMsmPmPvKru+NcUf9e1VoQHFM0hc7XUKT/FgbT/ZRWHmntzOyvtEfrg3OrZPdOmiz
         3AnGrpAMFAJA2aO+SoopbClJsAveE4YlRUZ2kkhOEms7NlCVTQ2A8VkWEwtul5EEwMGD
         vYoJPWxD6c6sAucQcbPSb97wL9qU8uRX80Bi93tKyAqc1LLiV8KjuiV1k/vFK+gzoCFD
         HoxA==
X-Gm-Message-State: AOAM533sMTN/6VoESLxHPmUOjedgVfzXBmmV6Usm4ASH4B3PJMfnOF3V
        Re7sK5QWilnmG297W1qnROq2kr7fXd1q/4p1J1Alwmimk1OQDo9qy6xCpdvUGJno8X+mY5TtTuL
        KC758WAUgton+2aE5fzoPMfNRsoKOxNCh1MVWCZkOTsnUdH41dyf5
X-Received: by 2002:a25:c750:: with SMTP id w77mr18988184ybe.340.1617990226072;
        Fri, 09 Apr 2021 10:43:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyePgBUXoxlCId5qbcbVtMHPFy79XeNQKfpB+vnhzetF47rq1MWoBwqoXUkxzWZFDH1Z8C7fd36q8TbvUNnQx4=
X-Received: by 2002:a25:c750:: with SMTP id w77mr18988165ybe.340.1617990225907;
 Fri, 09 Apr 2021 10:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210409111254.271800-1-omosnace@redhat.com> <53c532c8-fecf-ff13-ac82-7755f11a087d@schaufler-ca.com>
In-Reply-To: <53c532c8-fecf-ff13-ac82-7755f11a087d@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 9 Apr 2021 19:43:33 +0200
Message-ID: <CAFqZXNtcMsTMDtT3pvRNp31UPGUgDzz6DPSC+uw=1LRvLrVspw@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs/security/NFS/btrfs: clean up and fix LSM option handling
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 9, 2021 at 7:00 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 4/9/2021 4:12 AM, Ondrej Mosnacek wrote:
> > This series attempts to clean up part of the mess that has grown around
> > the LSM mount option handling across different subsystems.
> >
> > The original motivation was to fix a NFS+SELinux bug that I found while
> > trying to get the NFS part of the selinux-testsuite [1] to work, which
> > is fixed by patch 2.
> >
> > The first patch paves the way for the second one by eliminating the
> > special case workaround in selinux_set_mnt_opts(), while also
> > simplifying BTRFS's LSM mount option handling.
> >
> > I tested the patches by running the NFS part of the SELinux testsuite
> > (which is now fully passing). I also added the pending patch for
> > broken BTRFS LSM options support with fsconfig(2) [2] and ran the
> > proposed BTRFS SELinux tests for selinux-testsuite [3] (still passing
> > with all patches).
>
> The Smack testsuite can be found at:
>         https://github.com/smack-team/smack-testsuite.git
>
> It might provide another layer of confidence.

Thanks, but that doesn't seem to exercise mounting/remounting btrfs
nor nfs with security options. Anything else should be unaffected.

>
> >
> > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > [2] https://lore.kernel.org/selinux/20210401065403.GA1363493@infradead.org/T/
> > [3] https://lore.kernel.org/selinux/20201103110121.53919-2-richard_c_haines@btinternet.com/
> >     ^^ the original patch no longer applies - a rebased version is here:
> >     https://github.com/WOnder93/selinux-testsuite/commit/212e76b5bd0775c7507c1996bd172de3bcbff139.patch
> >
> > Ondrej Mosnacek (2):
> >   vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
> >   selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount
> >
> >  fs/btrfs/super.c         | 35 ++++++-----------------------------
> >  fs/nfs/fs_context.c      |  6 ++++--
> >  fs/super.c               | 10 ++++++----
> >  include/linux/fs.h       |  3 ++-
> >  security/selinux/hooks.c | 32 +++++++++++++++++---------------
> >  5 files changed, 35 insertions(+), 51 deletions(-)
> >
>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

