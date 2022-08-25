Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA9ECAAA2
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Aug 2022 22:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbiHYWMY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiHYWMW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Aug 2022 18:12:22 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D02275CC
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 15:12:19 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MDHJK5hD0zMqFnt;
        Fri, 26 Aug 2022 00:12:17 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MDHJJ5zsQzlh8TV;
        Fri, 26 Aug 2022 00:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661465537;
        bh=BP6SZchf288ny4ezm1q/cXHQFPT7Ywjw75McWGaDmPI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=S9gx9WYiLPcl2b1M+KfaqQXSZB/jhIxf3h8cXDp2QW0l115Zqf5eRmITP9jIzBgDg
         T63snwXOZRRtLntj5/3xkuRShPXhLHdraiceMeKgbaKK1IWxTwWmAusp/y3pBI5KVE
         NNKiXEDufhkhzCIUYaOx3jstBGKUcKWN2jBFQnts=
Message-ID: <5e3ff465-2e11-aa3c-1b39-6cf1e6246132@digikod.net>
Date:   Fri, 26 Aug 2022 00:12:16 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20220823144123.633721-1-mic@digikod.net> <YwUzfXaUFrPtnSMJ@nuc>
 <818012cf-c404-ec58-6c21-87ebee6a2522@digikod.net>
 <CAHC9VhSF7UkpVjwyn3W75UA+6h7S5+S=fs52F4ZUwMM_STH1PQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit
 LANDLOCK_ACCESS_FS_REFER
In-Reply-To: <CAHC9VhSF7UkpVjwyn3W75UA+6h7S5+S=fs52F4ZUwMM_STH1PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 25/08/2022 22:16, Paul Moore wrote:
> On Wed, Aug 24, 2022 at 5:04 AM Mickaël Salaün <mic@digikod.net> wrote:
>> On 23/08/2022 22:07, Günther Noack wrote:
>>> On Tue, Aug 23, 2022 at 04:41:23PM +0200, Mickaël Salaün wrote:
>>>> With the introduction of LANDLOCK_ACCESS_FS_REFER, we added the first
>>>> globally denied-by-default access right.  Indeed, this lifted an initial
>>>> Landlock limitation to rename and link files, which was initially always
>>>> denied when the source or the destination were different directories.
>>>>
>>>> This led to an inconsistent backward compatibility behavior which was
>>>> only taken into account if no domain layer were using the new
>>>> LANDLOCK_ACCESS_FS_REFER right.  However, in a scenario where layers are
>>>> using the first and the second Landlock ABI (i.e.
>>>> LANDLOCK_ACCESS_FS_REFER or not), the access control behaves like if all
>>>> domains were handling LANDLOCK_ACCESS_FS_REFER with their rules
>>>> implicitely allowing such right.
>>
>> "the access control behaves like if domains not handling
>> LANDLOCK_ACCESS_FS_REFER are in fact handling it and with their rules
>> implicitely allowing such right."
>>
>> Is this better?
> 
> I'm still looking at the actual code changes, but I had similar
> problems as Günther while I was reading the description.  While the
> new text above is different, I'm not sure it is significantly easier
> to understand.  I might suggest adding a short example to the commit
> description showing what happens now and what will change with this
> patch; similar to what Günther did in his reply.

OK, what about these new paragraphs replacing the second one?

This led to an inconsistent backward compatibility behavior which was
only taken into account if no domain layer were using the new
LANDLOCK_ACCESS_FS_REFER right. However, when restricting a thread with 
a new ruleset handling LANDLOCK_ACCESS_FS_REFER, all inherited parent 
ruleset/layers not explicitly handling LANDLOCK_ACCESS_FS_REFER would 
behave as if they were handling this access right and with all their 
rules allowing it. This means that renaming and linking files could 
became allowed by these parent layers, but all the other required 
accesses must also be granted: all layers must allow file removal or 
creation, and renaming and linking operations must not lead to privilege 
escalation according to the Landlock policy (see detailed explanation in 
commit b91c3e4ea756).

To say it another way, this bug may lifts the renaming and linking 
limitations of the initial Landlock version, and a same ruleset can 
restrict differently depending on previous or next enforced ruleset 
(i.e. inconsistent behavior). The LANDLOCK_ACCESS_FS_REFER right cannot 
give access to data not already allowed, but this doesn't follow the 
contract of the first Landlock ABI. This fix puts back the limitation 
for sandboxes that didn't opt-in for this additional right.

For instance, if a first ruleset allows LANDLOCK_ACCESS_FS_MAKE_REG on 
/dst and LANDLOCK_ACCESS_FS_REMOVE_FILE on /src, renaming /src/file to 
/dst/file is denied. However, without this fix, stacking a new ruleset 
which allows LANDLOCK_ACCESS_FS_REFER on / would now permit the 
sandboxed thread to rename /src/file to /dst/file .
