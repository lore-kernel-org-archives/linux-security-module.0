Return-Path: <SRS0=sAtF=DP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF8DC4363A
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 14:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4AC2184D
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 14:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgnF20Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgJHOIm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729840AbgJHOIm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Oct 2020 10:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602166120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aDrREu8JgYjM5C2pUxLMhMFJeWo9WdQPk6qfGuNUF4o=;
        b=QgnF20UcW4X1Rs1gjc+XlpU4Tim/MmplUuRalieREW4mcp+TgTiAx+MT6EWNdSSHW5bvpr
        Latjdn+9HtjiGcGvUKvH3xuQlUlrfObzMaMlwEHr7zlsw3GvlgmxvSIeQihlP3xXgQn3lo
        1QPkZC5In1CEcwns1ALphXh8JG2+xLk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-hI6j1yTOMhSQleGaXiiOfQ-1; Thu, 08 Oct 2020 10:08:39 -0400
X-MC-Unique: hI6j1yTOMhSQleGaXiiOfQ-1
Received: by mail-lj1-f200.google.com with SMTP id z8so997620lji.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2020 07:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDrREu8JgYjM5C2pUxLMhMFJeWo9WdQPk6qfGuNUF4o=;
        b=REMMyjxVbK0WAAMmOO6wpP/BXhMrHGeDRqdryf5Vvmk+D1QYW4waOuhD2riLwgoHjs
         67OO/U97D/H22AfB2FCHXrnmaUARcEOjJ7Ke/mHOCfjuOH1SGoyPSOS0CKOKhxg8G08C
         kEJ/1Y2kGh5REJvBrtly7kt9CZwsNDXGM5psTIA+W29PZiUuM71f7MJr6DGphgiu6k/V
         qwVLUBG8+FeKcTlFXLHzS7O35K/+S7mPO75PIsiso6gXIhHEUD6c6zfYq7eJmYjHIxBb
         sI2C3AGrSUum+Z8RKYeK42P+eaoddPYZZLK6K8SjjKrLQtIJx7PbPSxP7B7MNLaov4mC
         Rl+w==
X-Gm-Message-State: AOAM530ZOHHki8DB7UZgNLmt5lyBMffM/StY2hEU5vEGDeroh+EtuH6G
        6+Y3/ubDJzR9ZuxVEdLmx5DVJfXLciuSUdNbtjCs3f+zywh5IGdgGgOrGUvSDN8+MMOTTIHRjiw
        B1trHLiLzvEo8bYbXBP0SpG4IL+E8fNlEp0MAfPfV/qPTfP6P6SKj
X-Received: by 2002:a2e:99cb:: with SMTP id l11mr3196227ljj.123.1602166117372;
        Thu, 08 Oct 2020 07:08:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpBfCg43tlJRvWzMwyZ7ch5LdiqRzwF0++Hr1O762WWyHks7N/C/omz6fY1vfj0TJlpVgEU1clbbcltr0lcyI=
X-Received: by 2002:a2e:99cb:: with SMTP id l11mr3196215ljj.123.1602166117102;
 Thu, 08 Oct 2020 07:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com> <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
In-Reply-To: <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 8 Oct 2020 16:08:26 +0200
Message-ID: <CAFqZXNsG+B7OdmQimwNNVYCJM_Dc3jpNUFUpraoCEaicaoi+kQ@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 8, 2020 at 3:50 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> > > Hi folks,
> > >
> > > From some linux kernel module, is it possible to query and find out
> > > whether or not selinux is currently enabled or not?
> > >
> > > Thank you.
> >
> > [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
> > that the LSM list]
> >
> > In general most parts of the kernel shouldn't need to worry about what
> > LSMs are active and/or enabled; the simply interact with the LSM(s)
> > via the interfaces defined in include/linux/security.h (there are some
> > helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
> > bit more on what you are trying to accomplish?
>
> Hi Paul,
>
> Thank you for the response. What I'm trying to accomplish is the
> following. Within a file system (NFS), typically any queries for
> security labels are triggered by the SElinux (or I guess an LSM in
> general) (thru the xattr_handler hooks). However, when the VFS is
> calling to get directory entries NFS will always get the labels
> (baring server not supporting it). However this is useless and affects
> performance (ie., this makes servers do extra work  and adds to the
> network traffic) when selinux is disabled. It would be useful if NFS
> can check if there is anything that requires those labels, if SElinux
> is enabled or disabled.

Isn't this already accomplished by the security_ismaclabel() checks
that NFS is already doing?

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

