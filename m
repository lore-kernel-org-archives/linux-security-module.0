Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE86C00140
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Aug 2022 09:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiHXJEK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Aug 2022 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiHXJEJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Aug 2022 05:04:09 -0400
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58427DF66
        for <linux-security-module@vger.kernel.org>; Wed, 24 Aug 2022 02:04:07 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MCKsK0jPjzMqDZ1;
        Wed, 24 Aug 2022 11:04:05 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MCKsJ0bbBzlh8T4;
        Wed, 24 Aug 2022 11:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661331845;
        bh=IeIPbYZT0Wsx0jRyiVIjnoSX12DwUW5Y8G9DXsS0Ugg=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=M9ANuX0hCsPzIyVfVHYGwr4X7QcyNrqZGBv3rlQDg9AA46tEU9y5Zu5DEbBmdaw1r
         bUu9m50XK9pmyqO7O0WLkLksqLdtwnBAzavt9SKCd5+6bFO3V4dQP/WTtV+jcjRsAe
         zVUJ2SsFT2rEfyFUPaafevwhbCfG2Qht1c/gkn+Y=
Message-ID: <818012cf-c404-ec58-6c21-87ebee6a2522@digikod.net>
Date:   Wed, 24 Aug 2022 11:04:03 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20220823144123.633721-1-mic@digikod.net> <YwUzfXaUFrPtnSMJ@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit
 LANDLOCK_ACCESS_FS_REFER
In-Reply-To: <YwUzfXaUFrPtnSMJ@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 23/08/2022 22:07, Günther Noack wrote:
> On Tue, Aug 23, 2022 at 04:41:23PM +0200, Mickaël Salaün wrote:
>> With the introduction of LANDLOCK_ACCESS_FS_REFER, we added the first
>> globally denied-by-default access right.  Indeed, this lifted an initial
>> Landlock limitation to rename and link files, which was initially always
>> denied when the source or the destination were different directories.
>>
>> This led to an inconsistent backward compatibility behavior which was
>> only taken into account if no domain layer were using the new
>> LANDLOCK_ACCESS_FS_REFER right.  However, in a scenario where layers are
>> using the first and the second Landlock ABI (i.e.
>> LANDLOCK_ACCESS_FS_REFER or not), the access control behaves like if all
>> domains were handling LANDLOCK_ACCESS_FS_REFER with their rules
>> implicitely allowing such right.

"the access control behaves like if domains not handling 
LANDLOCK_ACCESS_FS_REFER are in fact handling it and with their rules 
implicitely allowing such right."

Is this better?


>>  Indeed, the not-handled access rights
>> were allowed, which should not be the case for LANDLOCK_ACCESS_FS_REFER.
>> It should be noted that this bug only allowed safe renames or links, but
>> no privilege escalation because the LANDLOCK_ACCESS_FS_REFER properties
>> were still enforced (e.g. only allowed to move a file according to all
>> other access rights, and if it doesn't give more Landlock accesses).
> 
> I had trouble understanding this paragraph - but I tried it out and I believe
> I understand what you mean; let me try to paraphrase to see whether we are on
> the same page:
> 
> This is a bug where chaining an additional ruleset on top of another one can
> increase the number of possible operations, rather than just reduce it.
> 
> Steps to reproduce:
>   - Enforce ruleset 1 *without* handled_access_fs containing "refer"
>   - Enforce ruleset 2 with handled_access_fs containing "refer"
> 
> Expected behaviour:
>   - refer-operations (rename, link...) should not be permitted because
>     ruleset 1 uses ABI v1 and refer-operations are always forbidden there.
> 
> Observed behaviour:
>   - refer-operations (rename, link...) work as if LANDLOCK_ACCESS_FS_REFER had
>     been handled in both rulesets and all rules within

"All rules within the ruleset/layer not (theoritically) handling refer 
operations". Layers handling refer-operations behave as expected and are 
not affected by this bug.

> 
> Do I understand this correctly?

Yes, except for the rules correctly handling refer operations.


> 
> 
> I believe I can reproduce it with the Go sandboxing tool (go install
> github.com/landlock-lsm/go-landlock/cmd/landlock-restrict@latest) like this:
> 
> Starting with these directory contents:
> 
>    $ find .
>    .
>    ./dst
>    ./src
>    ./src/hello
> 
> Then it is not possible to use refer (linking) with an ABIv1 ruleset (expected):
> 
>    $ $HOME/go/bin/landlock-restrict -1 -ro / -rw . -- \
>      /bin/ln src/hello dst/hello
>    /bin/ln: failed to create hard link 'dst/hello' => 'src/hello': Invalid cross-device link
> 
> But when chaining that ruleset with a ABIv2 ruleset, it suddenly does become
> possible to do "refer" operations:
> 
>    $ $HOME/go/bin/landlock-restrict -1 -ro / -rw . -- \
>      $HOME/go/bin/landlock-restrict -2 -ro / -rw +refer . -- \
>      /bin/ln src/hello dst/hello
>    $ find .
>    .
>    ./dst
>    ./dst/hello
>    ./src
>    ./src/hello

This is correct. In this case, the first landlock-restrict command 
behaves as the second command when the second is executed (i.e. a new 
refer-aware layer is added).


> 
> I need to still understand the underlying code better to reason about it,
> but this is the issue that this patch is fixing, right?
> 
> —Günther
> 
>> This change adds an ACCESS_INITIALLY_DENIED list of denied-by-default
>> rights, which (only) contains LANDLOCK_ACCESS_FS_REFER.  All domains are
>> treated as if they are also handling this list, but without modifying
>> their fs_access_masks field, which enables correct domain audit.
>>
>> A side effect is that the errno code returned by rename(2) or link(2)
>> *may* be changed from EXDEV to EACCES according to the enforced
>> restrictions.  Indeed, we now have the mechanic to identify if an access
>> is denied because of a required right (e.g. LANDLOCK_ACCESS_FS_MAKE_REG,
>> LANDLOCK_ACCESS_FS_REMOVE_FILE) or if it is denied because of missing
>> LANDLOCK_ACCESS_FS_REFER rights.  This may result in different errno
>> codes than for the initial Landlock version, but this approach is better
>> for rename/link compatibility reasons, and it wasn't possible before
>> (hence no backport to ABI v1).  The layout1.rename_file test reflects
>> this change.
>>
>> Add the layout1.refer_denied_by_default* tests to check that the
>> behavior of a ruleset not handling LANDLOCK_ACCESS_FS_REFER (ABI v1) is
>> unchanged even if another layer handles LANDLOCK_ACCESS_FS_REFER (i.e.
>> ABI v1 precedence).  Make sure rule's absolute access rights are correct
>> by testing with and without a matching path.
>>
>> Extend layout1.inval tests to check that a denied-by-default access
>> right is not necessarily part of a domain's handled access rights.
>>
>> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
>> Cc: Günther Noack <gnoack3000@gmail.com>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20220823144123.633721-1-mic@digikod.net
