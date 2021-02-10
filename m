Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F74C433E6
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Feb 2021 19:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D86264E77
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Feb 2021 19:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhBJTaA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhBJT35 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Feb 2021 14:29:57 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE18BC061574
        for <linux-security-module@vger.kernel.org>; Wed, 10 Feb 2021 11:29:17 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n14so3161865iog.3
        for <linux-security-module@vger.kernel.org>; Wed, 10 Feb 2021 11:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cbm/p3uSmXo7+IOFg40BnR7q3+v0HK8lsxNvbUa1a10=;
        b=YgK67SIP9M/wywknnWD9GHh0zDahDDEw5OkKAqXi3OguFVl2cBw6gNCCX0Nwsg//7r
         lu3QuTJHIP+fHj95xpSnLYSetG10eBTwXmmEpVjy0kyyhN8lyzJfz6RZX8tcxD+clsqJ
         8sn0SQpUOhYkcqfjDfNFESFMDP3eA71Al6U9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cbm/p3uSmXo7+IOFg40BnR7q3+v0HK8lsxNvbUa1a10=;
        b=aTdissqTkXNm8tSGNZCXHmV7dM+fW3IyStdE4YIYkut2OmltsmftMJjk55dVkhP+lb
         ZCqQFS/ikvxkIh8dAautaYIwaomITXQTQla9vHfGvOllWqxKDHKeOn4+hZwfMq1vi2X2
         Fh6VJq0yeKrNd2xXyzEZQY2rjONu88W5n8R10qhKUgmileE0qknKacdCJkAj765MrPSP
         +gmuo+7vzY4c0L2iku2leVq8sjf2wr5K1mOy5rmabABnQ8h3ewtM43VRsMkufQls35lG
         OC4IL9sdcpXYatGKzTO/2i+9XUXbGRgpSV+0NmAGBiZmliwybqXuqRQJPPx7Hn/k+GG5
         224g==
X-Gm-Message-State: AOAM530OT69lflwPgXDQy+6eESnlXXdM4E8lVP0ExzaX2/3WS4ewgdUM
        yj+nUIdFBdBFYYkpDYGx0S9BIQ==
X-Google-Smtp-Source: ABdhPJzI61YzNhbGvZ1ueDTIhf1/HXMZAKo5LwizR1jLQhse7nDE+gTesNRpFJEEeLxveZju4fGXOg==
X-Received: by 2002:a05:6602:2e83:: with SMTP id m3mr2200098iow.160.1612985357127;
        Wed, 10 Feb 2021 11:29:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r12sm1432697ile.59.2021.02.10.11.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 11:29:16 -0800 (PST)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <000000000000647eff05b3f7e0d4@google.com>
 <20201113120055.11748-1-hdanton@sina.com>
 <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
 <ea4028b7-53f2-aeaf-76e7-69874efcdec5@I-love.SAKURA.ne.jp>
 <2b70d360-a293-4acb-ea6c-2badda5e8b8b@linuxfoundation.org>
 <9bdd3f10-bddb-bd87-d7ad-b4b706477006@i-love.sakura.ne.jp>
 <6b8da36f-a994-7604-77f4-52e29434605f@linuxfoundation.org>
 <5f9ec159-77d8-ffba-21d1-2810e059f998@i-love.sakura.ne.jp>
 <a06093f1-22b3-7d72-bc6c-f99f4e0d0de9@linuxfoundation.org>
 <40617d66-1334-13a0-de9b-bd7cc1155ce5@i-love.sakura.ne.jp>
 <43d8d6bf-53f3-11e6-894d-c257f7f4bd07@linuxfoundation.org>
 <4368349b-fc0c-6da3-a502-2733f953d271@i-love.sakura.ne.jp>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <92a4c6ae-172d-91cb-b89e-8eb857fdfb3a@linuxfoundation.org>
Date:   Wed, 10 Feb 2021 12:29:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <4368349b-fc0c-6da3-a502-2733f953d271@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/10/21 12:07 PM, Tetsuo Handa wrote:
> On 2021/02/11 3:17, Shuah Khan wrote:
>> I am looking to understand the syzbot configuration and a reproducer
>> to be able to debug and fix the problem. How is syzbot triggering the
>> vhci_hcd attach and detach sequence?
> 
> I don't know. I'm waiting for syzbot to reproduce the problem on linux-next
> with https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/usbip?id=f1bdf414e7dd0cbc26460425719fc3ea479947a2 .
> 
>>
>> This helps me determine all these fix suggestions that are coming in
>> are fixes or papering over a real problem.
> 
> What are these fix suggestions?
> 
> "general protection fault in tomoyo_socket_sendmsg_permission" is a NULL pointer
> dereference which can happen if vhci_device_reset() and/or vhci_device_init()
> (which does vdev->ud.tcp_socket = NULL;) were unexpectedly called. There is no
> reproducer, and (as far as I know) no fix suggestion.
> 
Right. I would like to get a clear understanding of how this condition
is triggered. I am not saying this isn't a problem. Understanding how
it is triggered helps find the best fix.

> "KASAN: null-ptr-deref Write in vhci_shutdown_connection" is an ERR_PTR(-EINTR)
> pointer dereference which can happen if kthread_create() was SIGKILLed. There is
> a reproducer, and https://lkml.kernel.org/r/20210205135707.4574-1-penguin-kernel@I-love.SAKURA.ne.jp
> is a fix suggestion.
> 

This is a good find. I already replied to the thread to send a complete
fix.

thanks,
-- Shuah
