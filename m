Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D9CC43334
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Jul 2022 21:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiGRVZK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Jul 2022 17:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiGRVZJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Jul 2022 17:25:09 -0400
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860F29CBB
        for <linux-security-module@vger.kernel.org>; Mon, 18 Jul 2022 14:25:07 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Lmw3N6GKFzMq4HH;
        Mon, 18 Jul 2022 23:25:04 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Lmw3N2ZpZzlrKcd;
        Mon, 18 Jul 2022 23:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1658179504;
        bh=uihiR1f4lYUSezy+w1vsLpwdQHDrAdjGFXDr/iSKEUg=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=J8SeEUPxGPIv+q6/PgK+rCdPIy0Rh9huigjRJ/GI0G5aphiZbv8mh/a/utyL3mUh3
         EWEeT/fYTMOTXm4HgFVc48dySvAU+QdkD+M0UChtIP1/bPso8CPyZQijgEw2KtaLIF
         wlqlcrtCCZX9in3lE+exEOcfofBj4KvjPbjhm2+k=
Message-ID: <b851a37a-f5f1-3ee0-edf7-582d848c915b@digikod.net>
Date:   Mon, 18 Jul 2022 23:24:48 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Guenter Roeck <groeck@google.com>, Jeff Xu <jeffxu@google.com>
Cc:     linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
References: <20220628222941.2642917-1-jeffxu@google.com>
 <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
 <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net>
 <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
 <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com>
 <CALmYWFvfDcJCUDCLhrDPdvyY6fH_2diQbbo8ejq3Xvu6E8_2rA@mail.gmail.com>
 <CABXOdTcQOrat3vGCm3nw_ufYKcrQ1gqVdvbUSEUehfhZ7gAW4g@mail.gmail.com>
 <CALmYWFu-c7HvfqB=JpX-iN8QUfEwwZpQRpwncebJ8R8urvvCUQ@mail.gmail.com>
 <CALmYWFtrMdTY9HTWzG=MctUcsKQZVExHWu7+3C58hncazH5+5w@mail.gmail.com>
 <CABXOdTcZM-RomzrCZQkzexCSS7RTFf_Mz+kCghqEK_icd9W3LQ@mail.gmail.com>
 <CALmYWFtstvRVZOYCJBwrhayGJDc-=c8avuD0wWm6LURu8EKG2g@mail.gmail.com>
 <CABXOdTdzHu6CkNvOLvFoxH13MBo=r+TCr56xJsK3oXCbuOp4NA@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
In-Reply-To: <CABXOdTdzHu6CkNvOLvFoxH13MBo=r+TCr56xJsK3oXCbuOp4NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 16/07/2022 23:45, Guenter Roeck wrote:
> On Fri, Jul 15, 2022 at 5:17 PM Jeff Xu <jeffxu@google.com> wrote:
>>
>>> Maybe the error code returned from mount gives a hint.
>>
>> It returns -1
>>
> Sorry, I meant errno, not the return value.
> 
>>>
>>> Also, how about
>>> /proc/filesystems ?
>>
>> Yes. it has what I want:
>> nodev overlay
>>
> Excellent.
> 
> Guenter
> 
>> Thanks for your help! I can use this at runtime check.
>>
>> Jeff
>>
>>
>> On Fri, Jul 15, 2022 at 3:42 PM Guenter Roeck <groeck@google.com> wrote:
>>>
>>> On Fri, Jul 15, 2022 at 2:42 PM Jeff Xu <jeffxu@google.com> wrote:
>>>>
>>>> Jeff Xu <jeffxu@google.com>
>>>>
>>>>> Jul 14, 2022, 5:35 PM (20 hours ago)
>>>>> to Guenter, Mickaël, linux-security-module, Jorge, Guenter, Kees
>>>>>> On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
>>>>>>>
>>>>>>>>>> Hmm, well, it is not related to Yama then. Could it be linked to other
>>>>>>>>>> Chromium OS non-upstream patches?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is not
>>>>>>>>> enabled in chromeOS.
>>>>>>>>> If there is a reliable way of detecting OVERLAYFS (checking mount
>>>>>>>>> overlayfs is successful ? ), this is a good candidate to add SKIP.
>>>>>>>>>
>>>>>>>
>>>>>>>> IS_ENABLED(CONFIG_OVERLAY_FS) ?
>>>>>>>
>>>>>>> Could be. Landlock selftest currently is a user space program though,
>>>>>>> IS_ENABLED will depend on the kernel header during compile time.
>>>>>>>
>>>>
>>>>
>>>>
>>>>>> Ah, sorry, I thought it was an in-kernel test. Userspace should be
>>>>>> able to determine if overlayfs is supported by checking /sys/fs/ or
>>>>>> possibly /proc/fs/.
>>>>
>>>>
>>>>> Thanks for clarifying.
>>>>
>>>>
>>>>> lsmod might be the one, such as:
>>>>> lsmod | grep overlayfs
>>>>
>>>>
>>>> I built a kernel with overlayfs on chromeos, and lsmod didn't give me
>>>> what I wanted.
>>>> /sys/fs and /proc/fs also doesn't show anything about overlayfs
>>>>
>>>> @Mickaël Salaün
>>>> Are you OK with SKIP the overlay test when mount("overlay",...) fails
>>>> in FIXTURE_SETUP() ? Mount failure can be used as an indication.

In a normal scenario, all configurations in 
tools/testing/selftests/landlock/config should be enabled, but I think 
it makes sense for some use cases like chromeOS to be able to not fail 
if overlayfs is not supported. Please patch 
FIXTURE_SETUP(layout2_overlay) to skip these tests if the related 
filesystem string is present (with or without "nodev") in 
/proc/filesystems . You can create a is_filesystem_supported(const char 
*filesystem) helper before prepare_layout() for this check, we'll need 
it for future tests.


>>>>
>>>
>>> Maybe the error code returned from mount gives a hint. Also, how about
>>> /proc/filesystems ?
>>>
>>> Guenter
