Return-Path: <SRS0=Z4XS=RB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD5C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Feb 2019 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104FC20851
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Feb 2019 15:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfBZPoV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:44:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfBZPoV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Feb 2019 10:44:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 250BE30A9DC3;
        Tue, 26 Feb 2019 15:44:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A89E560BF5;
        Tue, 26 Feb 2019 15:44:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e967b416-dcef-2ce4-8775-2eb67da7d045@gmail.com>
References: <e967b416-dcef-2ce4-8775-2eb67da7d045@gmail.com> <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk> <155059371731.12449.5751025556744658291.stgit@warthog.procyon.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 04/43] separate copying and locking mount tree on cross-userns copies
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Tue, 26 Feb 2019 15:44:18 +0000
Message-ID: <27060.1551195858@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 26 Feb 2019 15:44:21 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> I can see that this covers copy_mnt_ns().  It should also cover what will
> happen in future, if you pass an OPEN_TREE_CLONE fd to a process with a
> different mnt_ns and mnt_ns->user_ns, and that process mounts the fd using
> move_mount().  However, I can't work out how this covers mount propagation
> across namespaces.
> 
> The comment "Notice when we are propagating across user namespaces" is moved
> to attach_recursive_mnt().  I can't find any call to attach_recursive_mount()
> inside the mount propagation code.  Am I overlooking something?

You've spelt the function name two different ways?

Further, attach_recursive_mnt() calls propagation, not the other way round.

David (& Al)
