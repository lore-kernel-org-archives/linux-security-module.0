Return-Path: <SRS0=H1aQ=2F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BACCC43603
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Dec 2019 18:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEF82467E
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Dec 2019 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576434931;
	bh=HUa1dFkFsJk0pW7PuD5eHfwhEdwKM+NsJBDoVmisiGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xH54WgRjJZtmvxuFjkEn2YnZHh2XTzoT8pcSi96dB7iY6SsVVCQyRarnFsvRS/hPM
	 nRxcvTiyxFgQj35akfx4BMqhUPCHWhoV3zMshcGZIMSJsrqF/Gd/okMLFE5T7xSFJW
	 FDORvnHQtBTG8oYsovFJB6LfGu1Tk4+gI0u538zA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfLOSfb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 15 Dec 2019 13:35:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34546 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfLOSfa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 15 Dec 2019 13:35:30 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so2488066qkk.1
        for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2019 10:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qVNBjfSz84iGfI3cbckY7nQLeGanVlTDy8RZUQ1PPxE=;
        b=sNC9kDZWzBdrMYWC9zJOmsDnI8OeSScRXHcJx0Dmkw2S0LGh9V/3HjJ5Ql7u7psjcU
         LFtb5D1QG/GSrYBhXlRY5Qr0cqjN9FLV5oz2muDZabH2l6GSI3/f28+qFkd/B1O7GYZI
         MdthBxixRqv3E60IJ5gotoAwfjaSexlogni90itClgVy95fjJfIwjkETkNc60DESSJrj
         aXE/C4p/gvlK9PQmYWh0MmFWcAwxaiC48+N1E+ecQXZelBh7IUmLbChEXzp2TYrlhpmw
         JpDs6WUmIUN01S/LdYVNamztxN6Sdt9Y8joT32jrhR+k8vRmC/soeuyvmwaY8NQlgOVB
         CRow==
X-Gm-Message-State: APjAAAXFLAWZa0+7P0RmvFLmklWH/ueTuAko+Y+BuVgN+RV9z51J3NtR
        GuucyUQxhud9h0jrNUQd2ru+OIYdyWpmFCfiq81xgQ==
X-Google-Smtp-Source: APXvYqx6rfFdxQzItJ2TSNMStGQmfg7d8ar5XomnO61yuZA9Fg1sSGxu9F67NiiGyORs0pq0QkzNnvYEviwhUyDB4DY=
X-Received: by 2002:a37:9ac5:: with SMTP id c188mr23330854qke.374.1576434929818;
 Sun, 15 Dec 2019 10:35:29 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkiyAkZy=oLrpJvHYU9Tq1dunNJLOJdtr508_w3vrdPWcQ@mail.gmail.com>
 <CALQRfL7i5r1d1K3fOuwyJ0BtmrsVMC8zzdd0Z7=14n3X8QNw5g@mail.gmail.com>
In-Reply-To: <CALQRfL7i5r1d1K3fOuwyJ0BtmrsVMC8zzdd0Z7=14n3X8QNw5g@mail.gmail.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Sun, 15 Dec 2019 10:35:17 -0800
Message-ID: <CALQRfL4y0CUOPMeAKy1HhUb0ehovkNY-Apn4kUSBXBFTxDnHtg@mail.gmail.com>
Subject: Re: Anomalous output from getpcaps(1) for process with all capabilities
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        ksrot@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

gmail defaults to html. Let's try that again:

On Sun, Dec 15, 2019 at 10:30 AM Andrew G. Morgan <morgan@kernel.org> wrote:
>
> This changed with this commit I think:
>
> https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=3fa808f5886d08c45866217cfe6e6e9def7de04e
>
> Prior to that, we had "=ep" mean the cap set was ~0 for all the bitmasks in e and p. When we started to clip the bounding set to only defined capabilities, it meant that the text output started to look like "=ep 33,34,35,36,37,38,39,40,41,42.....63-ep" which was quite terrible.
>
> So, this was seen as the least worst option.
>
> Cheers
>
> Andrew
>
>
> On Sun, Dec 15, 2019 at 7:43 AM Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
>>
>> Hello Andrew,
>>
>> Once upon a time (I don't remember exactly when things changed but let
>> us say 5 years ago), when one examined the capabilities of a process
>> with all capabilities, one saw something like the following nicely
>> compact output:
>>
>> $ getpcaps 1
>> Capabilities for `1': =ep
>>
>> Nowadays, one rather sees this (as also noticed by others [1]):
>>
>> $ getpcaps 1
>> Capabilities for `1': =
>> cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,
>> cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,
>> cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,
>> cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,
>> cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,
>> cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,
>> cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,
>> cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,
>> cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,
>> cap_block_suspend,cap_audit_read+ep
>>
>> The latter of course is much harder to read.
>>
>> This all the more perplexing when compared to the folowing:
>>
>> $ setcap =ep myprog
>> $ getcap myprog
>> prog =ep
>>
>> Looking more closely, there is a difference in the respective
>> capability sets. For the process show above, the effective and
>> permitted capability have precisely the 38 current capabilities
>> available. By contrast, inspecting the security.capability attribute
>> of 'myprog' show a permitted set that has all 64 bits sets. So this
>> explains why there is a difference in the output of getpcaps and
>> getcap above.
>>
>> I'm not sure where the behavior change originated. cap_to_text() has
>> seen no change between 2008 and 2017, AFAIK, but surely it is there
>> that some bit parsing logic needs to be fixed. Do you have any
>> thoughts?
>>
>> Thanks,
>>
>> Michael
>>
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1432878
>> --
>> Michael Kerrisk
>> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
>> Linux/UNIX System Programming Training: http://man7.org/training/
