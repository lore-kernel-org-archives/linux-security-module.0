Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D357BC3DA6E
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Dec 2022 12:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiLOMr4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Dec 2022 07:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLOMr3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Dec 2022 07:47:29 -0500
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C325CE2B
        for <linux-security-module@vger.kernel.org>; Thu, 15 Dec 2022 04:45:41 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NXsQq496MzMqbQC;
        Thu, 15 Dec 2022 13:45:39 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NXsQp0ppyzMppKY;
        Thu, 15 Dec 2022 13:45:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1671108339;
        bh=J7bkpE8pII1jDRivbh/AaVOZodqPxGCv2q0TIcL31yI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NEZbSUcLRln7wxppYbOEfx+XVBH1Ml/wFv9KSOFXvbhwbdLdoCEInOUzGp0QfLCN8
         1l7qGYyLdaBfbYv43XxSUfecXXljiF5Iwp1qirLNIMhh7mtk0+AUDtAHravH3Szzlf
         CYk12AVCJqUxPIaNkVfqa+cHf9es99VxOYrDfbN8=
Message-ID: <c7da47ef-92de-1e3c-1f29-3e3fdecd2c25@digikod.net>
Date:   Thu, 15 Dec 2022 13:45:13 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] landlock: Explain file descriptor access rights
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20221209193813.972012-1-mic@digikod.net> <Y5bapU9dWu0sBed6@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Y5bapU9dWu0sBed6@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 12/12/2022 08:39, Günther Noack wrote:
> On Fri, Dec 09, 2022 at 08:38:13PM +0100, Mickaël Salaün wrote:
>> Starting with LANDLOCK_ACCESS_FS_TRUNCATE, it is worth explaining why we
>> choose to restrict access checks at open time.  This new "File
>> descriptor access rights" section is complementary to the existing
>> "Inode access rights" section.  Add a new guiding principle related to
>> this section.
>>
>> Cc: Günther Noack <gnoack3000@gmail.com>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20221209193813.972012-1-mic@digikod.net
>> ---
>>
>> Changes since v1:
>> https://lore.kernel.org/r/20221205112621.3530557-1-mic@digikod.net
>> * Reworded the new section based on Günther suggestions.
>> * Added a new guiding principle.
>> * Update date.
>> ---
>>   Documentation/security/landlock.rst | 33 ++++++++++++++++++++++++++---
>>   1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
>> index c0029d5d02eb..95a0e4726dc5 100644
>> --- a/Documentation/security/landlock.rst
>> +++ b/Documentation/security/landlock.rst
>> @@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
>>   ==================================
>>   
>>   :Author: Mickaël Salaün
>> -:Date: September 2022
>> +:Date: December 2022
>>   
>>   Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>>   harden a whole system, this feature should be available to any process,
>> @@ -41,12 +41,15 @@ Guiding principles for safe access controls
>>     processes.
>>   * Computation related to Landlock operations (e.g. enforcing a ruleset) shall
>>     only impact the processes requesting them.
>> +* Resources (e.g. file descriptors) directly obtained from the kernel by a
>> +  sandboxed process shall retain their scoped accesses whatever process use
> 
> Optional nit: Maybe add "at the time of resource acquisition" to stress that part?

I included this suggestion in -next: 
https://git.kernel.org/mic/c/4dd6da345ac2

Thanks!

> 
>> +  them.  Cf. `File descriptor access rights`_.
>>   
>>   Design choices
>>   ==============
>>   
>> -Filesystem access rights
>> -------------------------
>> +Inode access rights
>> +-------------------
>>   
>>   All access rights are tied to an inode and what can be accessed through it.
>>   Reading the content of a directory does not imply to be allowed to read the
>> @@ -57,6 +60,30 @@ directory, not the unlinked inode.  This is the reason why
>>   ``LANDLOCK_ACCESS_FS_REMOVE_FILE`` or ``LANDLOCK_ACCESS_FS_REFER`` are not
>>   allowed to be tied to files but only to directories.
>>   
>> +File descriptor access rights
>> +-----------------------------
>> +
>> +Access rights are checked and tied to file descriptors at open time.  The
>> +underlying principle is that equivalent sequences of operations should lead to
>> +the same results, when they are executed under the same Landlock domain.
>> +
>> +Taking the ``LANDLOCK_ACCESS_FS_TRUNCATE`` right as an example, it may be
>> +allowed to open a file for writing without being allowed to
>> +:manpage:`ftruncate` the resulting file descriptor if the related file
>> +hierarchy doesn't grant such access right.  The following sequences of
>> +operations have the same semantic and should then have the same result:
>> +
>> +* ``truncate(path);``
>> +* ``int fd = open(path, O_WRONLY); ftruncate(fd); close(fd);``
>> +
>> +Similarly to file access modes (e.g. ``O_RDWR``), Landlock access rights
>> +attached to file descriptors are retained even if they are passed between
>> +processes (e.g. through a Unix domain socket).  Such access rights will then be
>> +enforced even if the receiving process is not sandboxed by Landlock.  Indeed,
>> +this is required to keep a consistent access control over the whole system, and
>> +avoid unattended bypasses through file descriptor passing (i.e. confused deputy
>> +attack).
>> +
>>   Tests
>>   =====
>>   
>>
>> base-commit: 0b4ab8cd635e8b21e42c14b9e4810ca701babd11
>> -- 
>> 2.38.1
>>
> 
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 
> Thank you!
> 
