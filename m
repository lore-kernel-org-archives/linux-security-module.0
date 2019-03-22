Return-Path: <SRS0=snF/=RZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F94CC43381
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 11:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072C82190A
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 11:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfCVLTd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:19:33 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34778 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVLTc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Mar 2019 07:19:32 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44Qh4x2KcPz1rgYh;
        Fri, 22 Mar 2019 12:19:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44Qh4x1Sn6z1qv23;
        Fri, 22 Mar 2019 12:19:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id umVbA7Ms1F0S; Fri, 22 Mar 2019 12:19:26 +0100 (CET)
X-Auth-Info: dbeBQ9WElD/YTcT/WgkLkyWYI40TW7Ey2hin/0gsumh36kGapbS+g6eMGSxOHgz1
Received: from igel.home (ppp-46-244-167-18.dynamic.mnet-online.de [46.244.167.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 22 Mar 2019 12:19:26 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 4266E2C12D4; Fri, 22 Mar 2019 12:19:26 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 11/43] convert do_remount_sb() to fs_context
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
        <155059379404.12449.7151387243186063769.stgit@warthog.procyon.org.uk>
X-Yow:  Well, I'm a classic ANAL RETENTIVE!!  And I'm looking for a way to
 VICARIOUSLY experience some reason to LIVE!!
Date:   Fri, 22 Mar 2019 12:19:26 +0100
In-Reply-To: <155059379404.12449.7151387243186063769.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Tue, 19 Feb 2019 16:29:54 +0000")
Message-ID: <87a7hnyx4x.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Feb 19 2019, David Howells <dhowells@redhat.com> wrote:

> Replace do_remount_sb() with a function, reconfigure_super(), that's
> fs_context aware.  The fs_context is expected to be parameterised already
> and have ->root pointing to the superblock to be reconfigured.
>
> A legacy wrapper is provided that is intended to be called from the
> fs_context ops when those appear, but for now is called directly from
> reconfigure_super().  This wrapper invokes the ->remount_fs() superblock op
> for the moment.  It is intended that the remount_fs() op will be phased
> out.
>
> The fs_context->purpose is set to FS_CONTEXT_FOR_RECONFIGURE to indicate
> that the context is being used for reconfiguration.
>
> do_umount_root() is provided to consolidate remount-to-R/O for umount and
> emergency remount by creating a context and invoking reconfiguration.
>
> do_remount(), do_umount() and do_emergency_remount_callback() are switched
> to use the new process.

That breaks booting for me.  The problem appears to be that udev fails
to create the block devices.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
