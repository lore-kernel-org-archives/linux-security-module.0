Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C590C001DE
	for <linux-security-module@archiver.kernel.org>; Mon, 31 Jul 2023 13:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjGaNmR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 31 Jul 2023 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjGaNmQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 31 Jul 2023 09:42:16 -0400
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [IPv6:2001:1600:3:17::190f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6CD1711
        for <linux-security-module@vger.kernel.org>; Mon, 31 Jul 2023 06:42:12 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RDztn46nHzMpnVV;
        Mon, 31 Jul 2023 13:42:09 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RDztm5SYHzMpnPf;
        Mon, 31 Jul 2023 15:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1690810929;
        bh=GoI2dx2k4v56r0nUARSTSjKyQuTN9FJvuZrpLVbOTOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHpucaNjNHbVnHfytytWlosX1m6gBxDOCpGoS+wlcGm+yWGwWPyQAeLbyH9DiMiia
         K+5sVcfhYVVZz04lQt/5nTZGb5tAsS4bkTZ5Hu9zEfraBEGsMLZgnMgfg7L7DeixDh
         QkuG00m+JgP1g6nxr46qIRQ078BneWntDejIdl7c=
Date:   Mon, 31 Jul 2023 15:42:15 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [RFC 2/4] landlock: Add LANDLOCK_ACCESS_FS_IOCTL access right
Message-ID: <20230731.iwieNiak3Wee@digikod.net>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <20230502171755.9788-3-gnoack3000@gmail.com>
 <09c6939f-c9e4-d1ed-bef1-3b1f05f81522@digikod.net>
 <ZLFDkbyaEBe0fc6e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLFDkbyaEBe0fc6e@google.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 14, 2023 at 02:46:09PM +0200, Günther Noack wrote:
> Hi!
> 
> On Mon, Jun 19, 2023 at 04:42:07PM +0200, Mickaël Salaün wrote:
> > I'd like a new documentation paragraph explaining the limitation of
> > LANDLOCK_ACCESS_FS_IOCTL (not fine-grained; should be careful about
> > fscrypt-like features for regular files; compatibility with TTY and other
> > common IOCTLs), a way to get more guarantees (e.g. using nodev mount points
> > when possible), and a sentence explaining that future work will enable a
> > more fine-grained access control.
> 
> I tried to add this comment but realized that I don't understand it well enough -
> 
> Regarding fscrypt:
> 
>   If a process is not the fscrypt user space tool itself, in which ways do the
>   fscrypt ioctls matter for that process?

These IOCTLs may be only used by the fscrypt tool on most distros but
there are of course no guarantee any application could use it to encrypt
its own files according to various use cases.

> 
>   I dug up a list of ioctls in tools/include/uapi/linux/fscrypt.h which look
>   related, but these look like they are only needed for the set up of encrypted
>   files and directories, but not for using these files later from other
>   processes?

Correct

> 
>   Am I misunderstanding that?
> 
>   The one thing that seems to stand out with the fscrypt ioctls is that the same
>   ioctl numbers are implemented by multiple different file systems.

My point was to highlight that nodev IOCTLs might be used by user space
on regular files and directories, not only /dev files, and we should be
careful to not inadvertently deny legitimate IOCTLs.  I think
nodev-IOCTLs are legitimate for unprivileged users, taking into account
capability checks and file mode checks, which might not be the case for
IOCTLs implemented by drivers.

You can take a look ad do_vfs_ioctl() to get a hint about other
FS-related IOCTLs (i.e. FIGETBSZ, FIONREAD), and all other nodev-files
(e.g. pipe, sockets) IOCTLs that may be required to properly use them.

We should be careful to find the good balance between restricting as
much as possible but without breaking user space and bother users that
would then disable security features. ;)

> 
> Regarding nodev mount points:
> 
>   I guess this is not relevant any more if we split the IOCTL right into a
>   device-only and non-device-only flag?
> 
>   (I prefer that solution over nodev mounts as well, because that solution works
>   unprivileged from the perspective of the process that defines the Landlock
>   policy. Re-mounting with different options requires more rights and can often
>   not be influenced by small utilities.)

We're now going withouth the split, but this nodev property could in fact
be part of step 2 (or 3).  Indeed, being able to differenciate file type
would enable to enforce a nodev-like control over a file hierarchy.

> 
> Thanks,
> —Günther
> 
> -- 
> Sent using Mutt 🐕 Woof Woof
> 
