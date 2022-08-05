Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA31DC00140
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Aug 2022 16:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbiHEQw4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Aug 2022 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiHEQwz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Aug 2022 12:52:55 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C91C125
        for <linux-security-module@vger.kernel.org>; Fri,  5 Aug 2022 09:52:53 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Lzs8y0FKxzMq56D;
        Fri,  5 Aug 2022 18:52:50 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Lzs8x0jm7zlqwrw;
        Fri,  5 Aug 2022 18:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659718370;
        bh=cdGXypd+d4RH8r/XjdoNhbwVLkTv/TpGNRxhbwTMQ2M=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=e9gW4KIkXktf2YcBcmi4Q7CR68su5hZsXctmXXnO938FUB/xOsjxtH4dQq9LNagv5
         09eOZSaaK4tmgU8dXvgk4EV/Qxux7gDb6rfTMVN8zYi0fh6ICytRPd1xQTvsrmLZYZ
         jWfRohF+vraIS18sqqQL8R2GKJT/djN6cgt3OaeU=
Message-ID: <7290b021-c90f-76e9-7868-ed612595b411@digikod.net>
Date:   Fri, 5 Aug 2022 18:52:48 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        landlock@lists.linux.dev
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <dbb0cd04-72a8-b014-b442-a85075314464@digikod.net> <YsqihF0387fBeiVa@nuc>
 <b7ee2d01-2e33-bf9c-3b56-b649e2fde0fb@digikod.net> <YuvvXI5Y2azqiQyU@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Landlock best-effort
In-Reply-To: <YuvvXI5Y2azqiQyU@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Adding the Landlock mailing list because it might be of interest for 
some users.

Original thread to support a new "truncate" access right: 
https://lore.kernel.org/all/YuvvXI5Y2azqiQyU@nuc/


On 04/08/2022 18:10, Günther Noack wrote:
> On Fri, Jul 29, 2022 at 01:58:17PM +0200, Mickaël Salaün wrote:

[...]

>>> (On the side, as you know from the discussion on the go-landlock
>>> library, I have some suspicion that the "best effort"
>>> backwards-compatibility approach in the sample tool is not the right
>>> one for the "refer" right, but that might be better suited for a
>>> separate patch. Maybe it'll be simpler to just not support a
>>> best-effort downgrade in the sample tool.)
>>
>> Please share your though about the "refer" right.
> 
> The sample tool implements a "best effort" approach by removing the
> access rights from all bitmasks passed to the kernel -- but this means
> different things for the refer right than it does for other rights
> like truncate:
> 
> * In the case of truncate, removing the truncate right from the
>    handled rights means that truncate *will* be permitted after
>    enforcement.
> 
> * In the case of "refer", removing the refer right from the handled
>    rights means that the "refer" operations *will not* be permitted
>    after enforcement.
> 
> Consequently, the approach of downgrading these needs to be different.
> 
> If the caller *asks* for the "refer" right to be permitted for a file
> hierarchy, this cannot be done with Landlock ABI v1. Therefore, the
> "best effort" downgrade will have to fall back to "doing nothing".
> 
> I've described this previously in this document:
> https://docs.google.com/document/d/1SkFpl_Xxyl4E6G2uYIlzL0gY2PFo-Nl8ikblLvnpvlU/edit

Thanks for the document, it's a great overview!

Here are my though on the open questions (extracted from your document):

> Problem: The 🔵 always-permitted operations are a gap in Landlock’s security.
 >
> I assume the current best practice is to band-aid over these operations
> with a seccomp-filter rule, because many programs do not need
> path-based control over them in practice.
 >
> - Problem: This is cumbersome, architecture dependent, and lists of
> syscalls are a moving target.

Indeed, seccomp-bpf would be the alternative to block some syscall 
families, but there is some issues using it. This is well explained in 
your blog post: https://blog.gnoack.org/post/pledge-on-linux/


> > Naive proposal: Can we introduce flags for these operations already, and
> accept them in landlock_ruleset_attr.handled_access_fs, but
> not in landlock_path_beneath_attr.allowed_access?
 >
> - Upside: It would become trivial to blanket-deny or blanket-allow
> the use of truncate() and the other, slightly more obscure
> operations.
> - Upside: Support for file-hierarchy-based allow-listing can still be
> added in later versions.
> - Downside: It complicates the userspace libraries a bit to keep
> track of which ABI versions can deal with which allowed_access
> flags, in addition to the already existing ABI information.

I see two downsides for this proposal:

1/ That would require to know the exact future access rights names, 
which is not possible or would be too risky.

2/ If this is what you meant, using different flags in a user space 
library compared to the kernel interface would not be a good idea.

 From a kernel point of view, I don't want to just block context-less 
actions but instead I prefer to implement a way to control such actions 
according to their "objects" (e.g. file hierarchies, TCP ports, set of 
processes…).

However, for user space libraries, we could add a dedicated list of 
coarse-grained virtual access rights that will mainly cover these 
syscall families: chdir(2), truncate(2), stat(2), flock(2), chmod(2), 
chown(2), setxattr(2), utime(2), ioctl(2), fcntl(2), access(2) and 
rename/link. This list could be used to determine if the sandboxing 
should be applied or not. I'm still not sure how this could evolve though.

This may not be required though. Indeed, if the latest version of the 
kernel cannot allow some actions that are required by an application 
(e.g. create mount points), the developer of this application will just 
not use Landlock for now. When Landlock will handle this missing 
controlled actions, the developer can use the latest user space library 
that should nicely handle a best-effort approach for this action.

It doesn't answer all the questions but here is how I would handle 
compatibility issues with the Rust library: 
https://github.com/landlock-lsm/rust-landlock/pull/12/ cf. commit 
"compat: Switch from set_best_effort() to set_compatibility()".
There is three CompatLevel: BestEffort, SoftRequirement and 
HardRequirement. This enables developers to tune this library, if they 
want to, according to their use case.


> 
> Admittedly, this line of reasoning is more relevant to the proper
> Landlock libraries than it is to the sample tool. However, the sample
> tool is the place that people look at to understand the API... maybe
> there should at least be a comment about it.

Right

> 
> But as I said, this problem existed before the truncate patch already,
> so it's probably best discussed separately; I'm happy to send a
> separate patch if you agree with this line of reasoning.

Yes please, that would be nice.
