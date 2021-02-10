Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CDDC433E6
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Feb 2021 18:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501D664ED7
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Feb 2021 18:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhBJSTo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhBJSR7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Feb 2021 13:17:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCA4C061574
        for <linux-security-module@vger.kernel.org>; Wed, 10 Feb 2021 10:17:08 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id q4so2671367otm.9
        for <linux-security-module@vger.kernel.org>; Wed, 10 Feb 2021 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=91NW65f73U7tYhbJABgMADCsijsHeCS7/BirUy4WduQ=;
        b=OxwdccxRTP96g+fMXhEYybO558hFLAVazpm1K6QnlWYbLFxFvi3bv6qyLkhnoj04j1
         ZzVszy64t4gEWGJ2RJC2akOHvrhGq3e66vtD0XujJT0EDa/gkXbDciXtLBl0ZDgZUbKb
         qQLBUyi3YehJZfh/hnL7Opj3vBafr5wHPzFY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=91NW65f73U7tYhbJABgMADCsijsHeCS7/BirUy4WduQ=;
        b=pWBjV5kWks+YfSiXrvFpfzaS4SVR+4JkwtmeoCF/gPcii3iiLxcSfl+sD/LV9spPr2
         FijC5l0jgVXYANUVbzA5UnMLvmmbZ95yFrl2Do0+of61cgrWhrllYHH5MbqAikE5OU0o
         Pp4fCJMH4DNMtCymrQX7B7DnrJLZ9CzkrgDnM/62gtm272ZqcydytFw5d5DPnPG7klpq
         ASUT9PCn5V+fpB1dNcl8cdeTTokf7EFzb/j7Cn5lCZU82sHQpO2OB+m9DIPyCayW1yjO
         ZaZtklxI4oUczTeugGN6i3uu7Phj7YQxdIYiUjdJ1hvLg3EfinLM5sVoW5fh/o4tqXkO
         uE2w==
X-Gm-Message-State: AOAM532GLjT/Z0W+McPj0TEGHJfBiHG4TR5q+QE9pwU3CfmbmpTt6dHX
        ZE29KEetrAdn8VGGVkfv+9HYZQ==
X-Google-Smtp-Source: ABdhPJydl2EaK2PBkFer3n1me1DSriI+1gZ2TRvOI8C3NSbG2umNfS0X1EZeLC2o6jx3iipJ5MaHcQ==
X-Received: by 2002:a05:6830:131a:: with SMTP id p26mr2969403otq.134.1612981028007;
        Wed, 10 Feb 2021 10:17:08 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n7sm542873otk.48.2021.02.10.10.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 10:17:07 -0800 (PST)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <43d8d6bf-53f3-11e6-894d-c257f7f4bd07@linuxfoundation.org>
Date:   Wed, 10 Feb 2021 11:17:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <40617d66-1334-13a0-de9b-bd7cc1155ce5@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/29/21 7:25 PM, Tetsuo Handa wrote:
> On 2021/01/30 6:18, Shuah Khan wrote:
>> In this console log:
> 
> It seems "this console log" refers to https://syzkaller.appspot.com/x/log.txt?x=10453034500000 .
> 
>>
>> 06:57:50 executing program 1:
>> socketpair$tipc(0x1e, 0x2, 0x0, &(0x7f00000000c0)={<r0=>0xffffffffffffffff})
>> sendmsg$BATADV_CMD_GET_TRANSTABLE_LOCAL(r0, &(0x7f00000002c0)={&(0x7f00000001c0), 0xc, &(0x7f0000000280)={0x0, 0xd001010000000000}}, 0x0)
>>
>> [ 1151.090883][T23361] vhci_hcd vhci_hcd.0: pdev(4) rhport(0) sockfd(4)
>> [ 1151.097445][T23361] vhci_hcd vhci_hcd.0: devid(0) speed(1) speed_str(low-speed)
>> 06:57:50 executing program 0:
>> r0 = syz_open_dev$binderN(&(0x7f0000000680)='/dev/binder#\x00', 0x0, 0x0)
>> ioctl$BINDER_WRITE_READ(r0, 0xc0306201, &(0x7f0000000cc0)={0x88, 0x0, &(0x7f0000000b80)=[@transaction={0x40406300, {0x2, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}, @transaction={0x40406300, {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}], 0x0, 0x0, 0x0})
>>
>> [ 1151.164402][T23363] vhci_hcd: connection closed
>> [ 1151.167346][  T240] vhci_hcd: stop threads
>>
>>
>> [ 1151.178329][T26761] usb 17-1: new low-speed USB device number 2 using vhci_hcd
>>
>>
>> SK: Looking at the console log, it looks like while connection is being
>>      torn down,
> 
> Excuse me, but it looks like (what comes here) while connection is being torn down ?
> I'm not familiar with driver code.
> 
>>
>>
>> [ 1151.181245][  T240] vhci_hcd: release socket
>>
>>
>> Can you share your your test code for this program:
>> "executing program 1"
> 
> I don't think program 1 is relevant. I think program 4
> 
>    06:57:50 executing program 4:
>    r0 = socket$tipc(0x1e, 0x2, 0x0)
>    syz_usbip_server_init(0x1)
>    close_range(r0, 0xffffffffffffffff, 0x0)
> 
> which calls syz_usbip_server_init() as with other duplicates is relevant.
> 
>>
>> Also your setup? Do you run usbip_host and vhci_hcd both?
> 
> Who are you referring to with "you/your" ? I'm not running syzkaller in my setup
> and I don't have test code.
> 
> I'm just proposing printing more messages in order to confirm the ordering of
> events and member values in structures.
> 

I am looking to understand the syzbot configuration and a reproducer
to be able to debug and fix the problem. How is syzbot triggering the
vhci_hcd attach and detach sequence?

This helps me determine all these fix suggestions that are coming in
are fixes or papering over a real problem.

thanks,
-- Shuah
