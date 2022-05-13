Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6E3C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 13 May 2022 09:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379001AbiEMJVb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 May 2022 05:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379000AbiEMJV3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 May 2022 05:21:29 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4765F261
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 02:21:26 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4L036r1qHpzMpvV1;
        Fri, 13 May 2022 11:21:24 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4L036p4zRmzlhSMk;
        Fri, 13 May 2022 11:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652433684;
        bh=vhWMOJJmQ0zQqk31oOrGZ0Qc6PAMRdpYWWsg1Bnpdxk=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=aHq4+vMJNZ9VFh/mKuSogISjR+X1QWlGf5yu4ZfIk0s/1REV5y4XsE8cPRgi+y5Hx
         Cqz6Zouw8Zl07y6irvWe3HH7CzZWyBRBckngcgN91iB2IY08q68ZhcXlnDsxgf04ss
         w/fPxHqkjvGA9vIWNqxEXcMvQrCfVfWnqEA7Ng40=
Message-ID: <26d98080-1c60-21ad-ad76-2a157a0a8390@digikod.net>
Date:   Fri, 13 May 2022 11:21:21 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220512120847.124822-1-mic@digikod.net>
 <CAHC9VhRDYnKmSGiNzED5bsT+hGarFBO9M2qHR8v1SKj4zGqMeQ@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1] landlock: Explain how to support Landlock
In-Reply-To: <CAHC9VhRDYnKmSGiNzED5bsT+hGarFBO9M2qHR8v1SKj4zGqMeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 13/05/2022 00:03, Paul Moore wrote:
> On Thu, May 12, 2022 at 8:08 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> Let's help users by documenting how to enable and check for Landlock in
>> the kernel and the running system.  The userspace-api section may not be
>> the best place for this but it still makes sense to put all the user
>> documentation at the same place.
>>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20220512120847.124822-1-mic@digikod.net
>> ---
>>   Documentation/userspace-api/landlock.rst | 26 ++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
>> index 7b4fe6218132..e69dbddcc191 100644
>> --- a/Documentation/userspace-api/landlock.rst
>> +++ b/Documentation/userspace-api/landlock.rst
>> @@ -388,6 +388,32 @@ Starting with the Landlock ABI version 2, it is now possible to securely
>>   control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
>>   access right.
>>
>> +Landlock support
>> +================
>> +
>> +Kernel configuration
>> +--------------------
> 
> I would suggest changing the section name to "Kernel build
> configuration" to make it clear the instructions below need to be done
> at build time.

That would be better indeed.

[rewinding] …well, this title would go away if I merge this subsection 
with the next one.

> 
>> +Landlock can be supported since Linux 5.13 but it must be configured in the
> 
> I would suggest rephrasing the first part of this sentence slightly:
> 
> "Landlock was first introduced in Linux v5.13 but it must be ..."

OK

> 
>> +kernel with `CONFIG_SECURITY_LANDLOCK=y`, and it should be enabled at boot time
> 
> CONFIG_LSM is a Kconfig build time variable not a runtime command line
> variable, yes?

Yes. This is confusing because it sets the default value of cmdline. 
I'll rephrase this paragraph.

> 
>> +with `CONFIG_LSM=landlock,[...]`.  The `[...]` must be replaced with the list
>> +of LSMs that may be useful for the running system (see the `CONFIG_LSM` help).
>> +
>> +Running system configuration
>> +----------------------------
> 
> This is nit-picky, but I would suggest a section name of "Kernel
> command line configuration".

I was thinking about "Kernel boot configuration" but I'll try to merge 
the two configuration subsections and put the check subsection earlier.

> 
>> +If the running kernel doesn't have `landlock` in `CONFIG_LSM`, then we can
>> +still enable it by adding `lsm=landlock,[...]` to
>> +Documentation/admin-guide/kernel-parameters.rst. The `[...]` must be replaced
>> +with the list of LSMs that may be useful for the running system (see the
>> +`CONFIG_LSM` help).
>> +
>> +Running system check
>> +--------------------
>> +
>> +We can check that Landlock is enabled by looking for "landlock: Up and running"
>> +in kernel logs: `dmesg | grep landlock`
> 
> I would suggest moving the "Running system check" section up closer to
> the top of the documentation, perhaps right before the "Landlock
> rules" section.  My thinking is that it is better to mention this as
> soon as possible in the doc so that users can verify Landlock is
> present and functioning before trying any of the code examples and
> failing.  I think it is okay to leave the "how to enable Landlock"
> sections at the bottom and simply refer to them in the "system check"
> section.
> 

Good idea, thanks!
