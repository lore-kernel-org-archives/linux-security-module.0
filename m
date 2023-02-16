Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84701C636D7
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Feb 2023 18:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBPSnE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBPSnB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 13:43:01 -0500
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987DBDEA
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 10:42:54 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PHkMx0585zMr7G2;
        Thu, 16 Feb 2023 19:42:53 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PHkMw2K8zzMsCGj;
        Thu, 16 Feb 2023 19:42:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1676572972;
        bh=0YSq//s3EoirjdfL2LsschZJMq828sfUpeX1wKyeJmQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EYsm96dqRSg6XVo5FMxtGj3sNBZXZ6NicEOlTP4CLGnsd7GwXCW4cRfPhUnVLoVe2
         7q0lbPcUp3ZHnhfX0TnqoCb9BzulM0VR33AN05DlsFUaHVvyHkTP98rWGuUrhX/GsI
         UZUhyY9KqGpn2ErTEyD4ykRmJJJNwmYiBWQdjH8E=
Message-ID: <a66bb3f7-9d8d-f2da-9b92-be489780c67b@digikod.net>
Date:   Thu, 16 Feb 2023 19:42:51 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230213210115.5150-1-gnoack3000@gmail.com>
 <d8112efe-d270-3013-97e6-bcc7c5237c02@digikod.net> <Y+0la4VBbkV8rlkD@galopp>
 <Y+1BxwRbdY+PZXNA@galopp>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Y+1BxwRbdY+PZXNA@galopp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 15/02/2023 21:34, Günther Noack wrote:
> On Wed, Feb 15, 2023 at 07:33:15PM +0100, Günther Noack wrote:
>> Thanks for the feedback, Mickaël!
>>
>> See some proposals for rephrasings inline. I tried to avoid passive
>> voice to make it easier to follow. Please let me know what you think.
>>
>> (Any native English speakers are more than welcome to chime in as well. 8-))

Alex, could you please get a look? It is plan for this update to also go 
to the man pages.

>>
>> –-Günther
>>
>> On Tue, Feb 14, 2023 at 01:04:04PM +0100, Mickaël Salaün wrote:
>>>
>>> On 13/02/2023 22:01, Günther Noack wrote:
>>>> Clarify the "refer" documentation by splitting up a big paragraph of text.
>>>>
>>>> - Call out specifically that the denial by default applies to ABI v1 as well.
>>>> - Turn the three additional constraints for link/rename operations
>>>>     into bullet points, to give it more structure.
>>>>
>>>> Includes wording and semantics corrections by Mickaël Salaün.
>>>>
>>>> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
>>>> ---
>>>>    include/uapi/linux/landlock.h | 41 ++++++++++++++++++++++-------------
>>>>    1 file changed, 26 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
>>>> index f3223f96469..f6bccd87aa0 100644
>>>> --- a/include/uapi/linux/landlock.h
>>>> +++ b/include/uapi/linux/landlock.h
>>>> @@ -130,21 +130,32 @@ struct landlock_path_beneath_attr {
>>>>     * - %LANDLOCK_ACCESS_FS_MAKE_BLOCK: Create (or rename or link) a block device.
>>>>     * - %LANDLOCK_ACCESS_FS_MAKE_SYM: Create (or rename or link) a symbolic link.
>>>>     * - %LANDLOCK_ACCESS_FS_REFER: Link or rename a file from or to a different
>>>> - *   directory (i.e. reparent a file hierarchy).  This access right is
>>>> - *   available since the second version of the Landlock ABI.  This is also the
>>>> - *   only access right which is always considered handled by any ruleset in
>>>> - *   such a way that reparenting a file hierarchy is always denied by default.
>>>> - *   To avoid privilege escalation, it is not enough to add a rule with this
>>>> - *   access right.  When linking or renaming a file, the destination directory
>>>> - *   hierarchy must also always have the same or a superset of restrictions of
>>>> - *   the source hierarchy.  If it is not the case, or if the domain doesn't
>>>> - *   handle this access right, such actions are denied by default with errno
>>>> - *   set to ``EXDEV``.  Linking also requires a ``LANDLOCK_ACCESS_FS_MAKE_*``
>>>> - *   access right on the destination directory, and renaming also requires a
>>>> - *   ``LANDLOCK_ACCESS_FS_REMOVE_*`` access right on the source's (file or
>>>> - *   directory) parent.  Otherwise, such actions are denied with errno set to
>>>> - *   ``EACCES``.  The ``EACCES`` errno prevails over ``EXDEV`` to let user space
>>>> - *   efficiently deal with an unrecoverable error.
>>>> + *   directory (i.e. reparent a file hierarchy).
>>>> + *
>>>> + *   This access right is available since the second version of the Landlock
>>>> + *   ABI.  This is also the only access right which is always considered
>>>> + *   handled by any ruleset in such a way that reparenting a file hierarchy is
>>>
>>> This is from me, but do you think "reparenting a file hierarchy" is not
>>> confusing? What about "reparenting a file or a directory"? Not sure which
>>> one is better.
>>
>> I find that sentence confusing as well, but the "reparenting a file"
>> part is not the confusing part to me.
>>
>> Proposal for this paragraph:
>>
>>    This access right is available since the second version of the
>>    Landlock.  This is also the only access right which is implicitly
>>    handled by any ruleset, even if the right is not specified at the
>>    time of creating the ruleset.  So by default, Landlock will deny
>>    linking and reparenting files between different directories, and
>>    only grant this right when it is explicitly permitted to a directory
>>    by adding a rule.
>>
>>    When using the first Landlock ABI version, Landlock will always deny
>>    the reparenting of files between different directories.
> 
> Sorry, correction (+ABI, s/to/for/):
> 
>    This access right is available since the second version of the
>    Landlock ABI.  This is also the only access right which is
>    implicitly handled by any ruleset, even if the right is not
>    specified at the time of creating the ruleset. So, by default,
>    Landlock will deny linking and reparenting files between different
>    directories, and only grant this right when it is explicitly

and will only grant…?

>    permitted for a directory by adding a rule.
>   
>    When using the first Landlock ABI version, Landlock will always deny
>    the reparenting of files between different directories.

Looks good to me!

>>
>>>
>>> I'm not sure either if we should use "deny" or "forbidden". Is there a
>>> difference? According to https://www.wikidiff.com/deny/forbid it seems that
>>> "deny" would be more appropriate because Landlock rules add exceptions to a
>>> forbidden set of actions… However, "deny" needs to be followed by "access"
>>> for the same use, which makes your wording correct. Just a thought.
>>>
>>>
>>>> + *   always denied by default.  If left unspecified during the creation of a
>>>> + *   ruleset, linking and renaming files between different directories will be
>>>> + *   forbidden, which is also the case when using the first Landlock ABI.
>>>> + *
>>>> + *   In addition to permitting this access right, the following constraints
>>>> + *   must hold for the access rights on the source and destination directory:
>>
>> Proposal for this paragraph:
>>
>>    In addition to the source and destination directories having the
>>    %LANDLOCK_ACCESS_FS_REFER access right, the attempted link or rename
>>    operation must meet the following constraints:
>>
>>>> + *
>>>> + *   * The destination directory may not grant any access rights which are
>>>> + *     forbidden for the source file. Otherwise, the operation results in an
>>>
>>> The files/directories don't grant accesses but the sandbox/domain do grant
>>> some accesses for a set of file hierarchies.
>>>
>>> What about "Any forbidden actions on the source file must also be forbidden
>>> on the destination file."
>>> Or "Any denied accesses on the source file…"
>>
>> Both valid points. How about the following phrasing which is
>> formulated a bit closer to the actual goal (not creating a loophole
>> through which you can gain more access rights for a file):
>>
>>    * The reparented file may not attain more access rights in the

s/may not/cannot/ ?
s/attain/gain/ ?

>>      destination directory than it previously had in the source
>>      directory.  If this is attempted, the operation results in an
>>      ``EXDEV`` error.

Better too!

This is becoming a bit difficult to follow, you can send a new patch 
with Alex in Cc. :)

>>
>>> This seems a bit weird according to the previous "must hold for the access
>>> rights on the source and destination directory" though.
>>
>> +1, I reformulated that too above.
>>
>>>
>>>
>>>> + *     ``EXDEV`` error.
>>>> + *
>>>> + *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for
>>>> + *     the respective file type is required in the destination directory.
>>>
>>> s/is required in the destination/must be granted for the destination/ ?
>>
>> Done.
>>
>>>
>>>
>>>> + *     Otherwise, the operation results in an ``EACCES`` error.
>>>> + *
>>>> + *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
>>>> + *     respective file type is required in the source directory.  Otherwise,
>>>
>>> Same "must be granted for"
>>
>> Done.
>>
>>>
>>>
>>>> + *     the operation results in an ``EACCES`` error.
>>>> + *
>>>> + *   If multiple requirements are not met, the ``EACCES`` error code takes
>>>> + *   precedence over ``EXDEV``.
>>>>     *
>>>>     * .. warning::
>>>>     *
>>>>
>>>> base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
