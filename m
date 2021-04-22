Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C66C43460
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Apr 2021 11:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C292361437
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Apr 2021 11:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhDVLkl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Apr 2021 07:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235955AbhDVLkj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Apr 2021 07:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619091604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMXkQKD92XEqLOdKkZ9LkipLsjeMEu880iIF7KLHuos=;
        b=KF5+guVGfnM0osOYVhLzTNyYYrUV3BOKta0NTgERdGxe52FI7+4hSfcM7AXDQcvYlU/BsI
        HvkFZ8u+2fFQ3yzghyGlHbYgG2VQiikGDQ3Jm736EjAIMc8/C4RUh0iQT1Zz73LEFbWXao
        lmuYO6aWXbsrLO6ztMbCsloW9sJ5qaM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-Tx3WoxcZP8iXz590xVhojQ-1; Thu, 22 Apr 2021 07:39:52 -0400
X-MC-Unique: Tx3WoxcZP8iXz590xVhojQ-1
Received: by mail-yb1-f200.google.com with SMTP id p9-20020a2574090000b02904e2cb6a90e7so19725398ybc.17
        for <linux-security-module@vger.kernel.org>; Thu, 22 Apr 2021 04:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMXkQKD92XEqLOdKkZ9LkipLsjeMEu880iIF7KLHuos=;
        b=gCFCMT0CCVKDoogyUuMSJTni++DhiWAvNI+o+8q1Gpa0rj0vXFzWoWy4gHIrvqJqy8
         hhOjSIZlxf7TG2j5xtPBW9ykII0Hng4ja0VlW/xaxwmKHBsI4gGGDmEFo9Wh2pRZlAYO
         QUBw8331Q7XQr/oWv3KCBuXZURfQbqtXB/BbnceW1cP5q8SjwSX8rbPsQC9cAvYlJPIc
         mbvEx/YmjbM2BXWTR7YmymzqaSrHdoyYdlSDuttl8ncX8oN1H35noZDi7dbO7OMpAcVS
         bKOtft2+gavyWqxhUTxoB8D57lTwN47NVmJSNHSN4vqCyXsrDymXcKP2paLzReqmIeUw
         PXQg==
X-Gm-Message-State: AOAM531im56nw2APDqV7LXIboMSEwFZ4DjbSwW0aCGk5rTz7HsXBthhm
        NcNA2XoR0Blyi/5BsZUW0I3c5heuVD++LpGXx8/RwFkHXMxqjHNQNoADoJAlzCmMQvLMnVfCKuW
        YiTiW51CiNKUE4DLDMN7lmq62wOW/7sK0yFeLvEJ0HplFlvh8h7wF
X-Received: by 2002:a25:7085:: with SMTP id l127mr4068965ybc.293.1619091591518;
        Thu, 22 Apr 2021 04:39:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyhE6DS/eW1dR9xemDwBcQEmjxrQY+fv1G9l6m2UGwYtINpsqaUV9AJsTDjlsF+gV/DTMftEHXE3GlbORd3Hk=
X-Received: by 2002:a25:7085:: with SMTP id l127mr4068951ybc.293.1619091591336;
 Thu, 22 Apr 2021 04:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
In-Reply-To: <CAHC9VhTFPHO7YtTxSZNcEZwoy4R3RXVu-4RrAHRtv8BVEw-zGA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 22 Apr 2021 13:39:39 +0200
Message-ID: <CAFqZXNts94w-hMhzCjKW5sHrVw2pw2w7cMQ3+Q2suJ_XUUpUwg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] selinux,anon_inodes: Use a separate SELinux class
 for each type of anon inode
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 21, 2021 at 10:38 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > This series aims to correct a design flaw in the original anon_inode
> > SELinux support that would make it hard to write policies for anonymous
> > inodes once more types of them are supported (currently only userfaultfd
> > inodes are). A more detailed rationale is provided in the second patch.
> >
> > The first patch extends the anon_inode_getfd_secure() function to accept
> > an additional numeric identifier that represents the type of the
> > anonymous inode being created, which is passed to the LSMs via
> > security_inode_init_security_anon().
> >
> > The second patch then introduces a new SELinux policy capability that
> > allow policies to opt-in to have a separate class used for each type of
> > anon inode. That means that the "old way" will still
>
> ... will what? :)

Whoops, I thought I had gone over all the text enough times, but
apparently not :) It should have said something along the lines of:

...will still work and will be used by default.

>
> I think it would be a very good idea if you could provide some
> concrete examples of actual policy problems encountered using the
> current approach.  I haven't looked at these patches very seriously
> yet, but my initial reaction is not "oh yes, we definitely need this".

An example is provided in patch 2. It is a generalized problem that we
would eventually run into in Fedora policy (at least) with the
unconfined_domain_type attribute and so far only hypothetical future
types of anon inodes.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

