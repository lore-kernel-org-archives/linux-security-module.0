Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AC7C433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 13 May 2022 14:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381099AbiEMOjd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 May 2022 10:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381268AbiEMOfF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 May 2022 10:35:05 -0400
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8019B68986
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 07:30:15 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4L09zB072PzMqsRg;
        Fri, 13 May 2022 16:30:14 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4L09z85BpGzlhRVC;
        Fri, 13 May 2022 16:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1652452214;
        bh=pIrmnI8WmkfDn4dBSjfTor/KJ6S4feWqrW6Nt+2XxVY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qq/GqznoRJBFl2cZkNnuzDRoWJ68wYmySWC3Nx0isXVmhakVws5hGVNa6Fmb+PJV4
         e/yCkBFU/8qYJnmqcNK94G66Z/aBp7O9YRBZAVgNEikD5QAZug+PfLN49Wu6hXdov+
         D9IWBWOd6rOwpLv3Jf22tVgToKZaQMjNQTMwJBjM=
Message-ID: <35fbd428-52cd-c5f8-c2d1-ff36be920a5f@digikod.net>
Date:   Fri, 13 May 2022 16:30:12 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] landlock: Explain how to support Landlock
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220513112743.156414-1-mic@digikod.net>
 <CAHC9VhQS1mNAzC2Qo2+rxUs5BERA6Y9FyzapdRQ65g5FY1Mwtw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAHC9VhQS1mNAzC2Qo2+rxUs5BERA6Y9FyzapdRQ65g5FY1Mwtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 13/05/2022 14:57, Paul Moore wrote:
> On Fri, May 13, 2022 at 7:27 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> Let's help users by documenting how to enable and check for Landlock in
>> the kernel and the running system.  The userspace-api section may not be
>> the best place for this but it still makes sense to put all the user
>> documentation at the same place.
>>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20220513112743.156414-1-mic@digikod.net
>> ---
>>
>> Changes since v1:
>> * Move the checking subsection at the beginning (suggested by Paul
>>    Moore) and merge the two configuration subsections.
>> * Use both dmesg and journalctl to handle cases where journald is not
>>    installed or when the kernel log buffer is full.
>> * Add reference to the syscall check (ABI section).
>> * Improve explanations.
>> * Update copyright date.
>> ---
>>   Documentation/userspace-api/landlock.rst | 29 +++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> Looks good to me.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 

Thanks Paul!
