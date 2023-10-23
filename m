Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F130C25B46
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Oct 2023 20:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjJWUmv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Oct 2023 16:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjJWUmu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Oct 2023 16:42:50 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80788D7A
        for <linux-security-module@vger.kernel.org>; Mon, 23 Oct 2023 13:42:46 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SDnFJ3yQFzMpnvw;
        Mon, 23 Oct 2023 20:42:44 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SDnFH4644zMppt6;
        Mon, 23 Oct 2023 22:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1698093764;
        bh=9ioWM+lHac+DfHBhyDZ2lGrwrqcK03XcwTtuCKefMlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTh2hXLYx+Rai0Seg3E6HM8Zq7ssEOuUMvHVlerzShUgRSqjSWhIxmgM++lLQWDLR
         bPnbTHjaMNRG+HGk+Jae2OJleCARRX6Kcj7TD8D/laPWRheip+tTiHCb9GNlnU+yXj
         LDTCeOxy1PivBlUgtZoFL5MP8orUq2CFG0wVQ+ws=
Date:   Mon, 23 Oct 2023 22:42:39 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>
Cc:     landlock@lists.linux.dev, linux-security-module@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: Sandbox escape through missing restrictions for unix socket
 abstract namespace
Message-ID: <20231023.ahphah4Wii4v@digikod.net>
References: <3MCqhJ90QpVfPgUui9PFA8mbfxk71A6UY2gIuKqWfXQ_rPkUC-NMQ-iHKZ1BnGjK6EXwHpEdDiyAUfXhxWaarFlwpQZPs-05myboXJw2pjo=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3MCqhJ90QpVfPgUui9PFA8mbfxk71A6UY2gIuKqWfXQ_rPkUC-NMQ-iHKZ1BnGjK6EXwHpEdDiyAUfXhxWaarFlwpQZPs-05myboXJw2pjo=@protonmail.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Björn,

(CCing the Landlock and LSM mailing lists.)

On Mon, Oct 23, 2023 at 07:45:16PM +0000, Björn Roy Baron wrote:
> Hi Mickaël Salaün,
> 
> Landlock doesn't have any restrictions for connecting to unix socket
> in the abstract namespace. This means that if you don't use seccomp to
> restrict access to the connect syscall or don't use a network
> namespace to isolate the abstract namespace, on systems with a gui a
> sandboxed process will be able to connect to the socket at
> @/tmp/.X11-unix/X0 to send key presses to Xorg to make the desktop
> environment run arbitrary processes outside of the sandbox. About a
> month ago I reported a sandbox escape in a sandboxing library which
> didn't have those restrictions.

Thanks for the heads up. Abstract unix sockets don't rely on the
filesystem. In fact the path used as an "abstract address" (after the
leading NULL character) is just a string from the kernel point of view.
There is then no way to properly tie it to filesystem access control
(contrary to unix socket files).

I agree that this might be confusing, but we need network restrictions
to control such socket. We are working on TCP access control [1] which
is a first step into being able to more broadly restrict network access.
We also talked about another complementary approach to more broadly
restrict socket creation [2].

[1] https://lore.kernel.org/r/20231016015030.1684504-1-konstantin.meskhidze@huawei.com
[2] https://lore.kernel.org/r/b8a2045a-e7e8-d141-7c01-bf47874c7930@digikod.net

> 
> While this is not technically a violation of the documentation, it is
> surprising that you need seccomp or a network namespace in addition to
> Landlock to actually restrict filesystem access. In other places like
> ptrace access Landlock already does the necessary restrictions to
> prevent a program outside of the sandbox from getting hijacked.

The ptrace restrictions was a minimal requirement to not let processes
trivially bypass any sandbox. There are other missing access control
such as process signaling or networking. We'll get there but it takes
time. In the meantime, seccomp is a nice complement to Landlock to fill
these gaps.

About abstract unix socket control, I think it would be nice to be able
to scope access to such sockets the same way ptrace is limited (but this
time it would be opt-in). I think the same approach would fit well for
signaling too.

> 
> I have written a write up of the security issue in the aforementioned
> sandboxing library which I want to publish on my blog. But I first
> want to give you the chance of adding a fix to Landlock if you
> consider this a bug in Landlock.

This is not a bug even if it might be surprising. We should probably
extend the documentation to explicitly list this example as a
limitation. Feel free to send a patch, or I'll add that to my todo list.

Feel free to share a link to your blog once you published your write up.

Regards,
 Mickaël

> 
> Cheers,
> Bjorn Baron
