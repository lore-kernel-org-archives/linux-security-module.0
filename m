Return-Path: <SRS0=snF/=RZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1642C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 13:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0082183E
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 13:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfCVNRD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbfCVLZ4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Mar 2019 07:25:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF9F4308421A;
        Fri, 22 Mar 2019 11:25:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 789F6608A5;
        Fri, 22 Mar 2019 11:25:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87a7hnyx4x.fsf@igel.home>
References: <87a7hnyx4x.fsf@igel.home> <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk> <155059379404.12449.7151387243186063769.stgit@warthog.procyon.org.uk>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 11/43] convert do_remount_sb() to fs_context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21015.1553253953.1@warthog.procyon.org.uk>
Date:   Fri, 22 Mar 2019 11:25:53 +0000
Message-ID: <21016.1553253953@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 22 Mar 2019 11:25:55 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Andreas Schwab <schwab@linux-m68k.org> wrote:

> That breaks booting for me.  The problem appears to be that udev fails
> to create the block devices.

Can you give some more information?  Is this on m68k?  Are there any messages
logged?

David
