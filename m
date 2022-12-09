Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4F8C04FDE
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Dec 2022 17:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLIRD5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Dec 2022 12:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiLIRDL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 12:03:11 -0500
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4615510F5
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 09:02:36 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NTHQ16TPNzMrMx7;
        Fri,  9 Dec 2022 18:02:33 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NTHPz666szMppKS;
        Fri,  9 Dec 2022 18:02:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1670605353;
        bh=ER/O16Wvvmh5jXZOOsJ2vrMr2wxFrTtNVAuRf3h5MeI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wvS/y5OTqtIOTp3zIO2oDvhyqZp8Nk2/XnJf8C/4l224jQgY1eC326gYO1vKQwoSG
         0RNPxkYLzENF5fmxTNk3DcQ5PPIdPlar9bCcv18CpxPCCO2qhvLTv83ddIMK7KNDmE
         RU9uIcUb/dbPpWaS7ZMbBSRP/RLKcHnObUdQpsVc=
Message-ID: <02de3b43-da36-5bc7-f393-a026d9c6ea0a@digikod.net>
Date:   Fri, 9 Dec 2022 18:02:31 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1] landlock: Explain file descriptor access rights
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20221205112621.3530557-1-mic@digikod.net> <Y5DSFwHoYZwYEn0T@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Y5DSFwHoYZwYEn0T@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks Günther, I'll send a v2.

On 07/12/2022 18:49, Günther Noack wrote:
> Hi!
> 
> Thanks for sending this patch! I have overlooked to update this in the
> original patch set.
> 
> On Mon, Dec 05, 2022 at 12:26:21PM +0100, Mickaël Salaün wrote:
>> Starting with LANDLOCK_ACCESS_FS_TRUNCATE, it is worth explaining why we
>> choose to restrict access checks at open time.  This new "File
>> descriptor access rights" section is complementary to the existing
>> "Inode access rights" section.
>>
>> Cc: Günther Noack <gnoack3000@gmail.com>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20221205112621.3530557-1-mic@digikod.net
>> ---
>>   Documentation/security/landlock.rst | 25 ++++++++++++++++++++++---
>>   1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
>> index c0029d5d02eb..bd0af6031ebb 100644
>> --- a/Documentation/security/landlock.rst
>> +++ b/Documentation/security/landlock.rst
>> @@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
>>   ==================================
>>   
>>   :Author: Mickaël Salaün
>> -:Date: September 2022
>> +:Date: November 2022
>>   
>>   Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>>   harden a whole system, this feature should be available to any process,
>> @@ -45,8 +45,8 @@ Guiding principles for safe access controls
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
>> @@ -57,6 +57,25 @@ directory, not the unlinked inode.  This is the reason why
>>   ``LANDLOCK_ACCESS_FS_REMOVE_FILE`` or ``LANDLOCK_ACCESS_FS_REFER`` are not
>>   allowed to be tied to files but only to directories.
>>   
>> +File descriptor access rights
>> +-----------------------------
>> +
>> +Access rights are checked and tied to file descriptors at open time.  As a
>> +consequence, it may be allowed to create a file without being allowed to
>> +truncate it if the file hierarchy doesn't grant such access right.  The
>> +rationale is that this approach is simple and consistent with all access
>> +rights, however file requests are based on path or based on file descriptor
>> +(obtained with the same path, by a thread restricted with the same Landlock
>> +domain).  For instance, updating an application from using :manpage:`mknod` and
>> +:manpage:`truncate` to initialize a file (i.e. path-based), to using
>> +:manpage:`open` and :manpage:`ftruncate` to initialize the same file (i.e. file
>> +descriptor-based) should work the same way with the same Landlock restrictions.
> 
> Nit: The paragraph seems a bit long and is mixing more general
> considerations with examples. Maybe they could be split into separate
> paragraphs?
> 
> Regarding the "As a consequence..." example: I would word it as "...it
> may be allowed to open a file for writing without being allowed to
> ftruncate the resulting file descriptor...".
> 
> The example you are giving with creating files is also accurate, but
> it is potentially confusing, because creat() and open(..., O_TRUNC)
> are also implicitly truncating files when opening the file.
> 
> Regarding "The rationale is that this approach is simple and
> consistent...": The word "simple" is often a sign that we could be
> more concrete, and there is also a risk that a reader might not
> perceive it as simple ;)  How about this:
> 
> ```
> 
> The rationale is that equivalent sequences of operations should lead
> to the same results, when they are executed under the same Landlock
> domain.
> 
> For example, for the LANDLOCK_ACCESS_FS_TRUNCATE right, the following
> sequences of operations are roughly equivalent and should have the
> same result:
> 
> * truncate(path)
> * fd = open(path, O_WRONLY); ftruncate(fd); close(fd)
> 
> ```
> 
> (I think it's a bit more readable with bullet points, and the
> truncate/ftruncate example might be a bit more familiar than the
> somewhat unusual mknod?)
> 
>> +
>> +Processes not sandboxed by Landlock may still be restricted for operations on
>> +file descriptors coming from a sandboxed process.  Indeed, this is required to
>> +keep a consistent access control over the whole system, and avoid unattended
>> +bypasses through file descriptor passing (i.e. confused deputy attack).
> 
> "May still be restricted" is leaving the reader a bit in the dark
> about the exact circumstances where this might happen? I think we
> could be more bold and give a guarantee here, like:
> 
> ```
> 
> Access rights attached to file descriptors are retained even if the
> file descriptor is passed between Unix processes (e.g. through a Unix
> Domain Socket). The access rights will be enforced even if the
> receiving process is not sandboxed by Landlock.
> 
> ```
> 
> --Günther
> 
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
