Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9F2C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jan 2021 21:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE9F64E00
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jan 2021 21:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhA2VSx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Jan 2021 16:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhA2VSw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jan 2021 16:18:52 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD954C061573
        for <linux-security-module@vger.kernel.org>; Fri, 29 Jan 2021 13:18:12 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id i30so9993004ota.6
        for <linux-security-module@vger.kernel.org>; Fri, 29 Jan 2021 13:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x+eTXfkl3kwRn2zHA52W//U5DmNK7Dju2RwV9ojfzrs=;
        b=O3GeKbhgGGB6uJFo9RBCEIsuOvEwL0UQk/Tu6m5naoL4sdAxfnRgy48+kMB2T2TRz9
         jOX33QBJBM/+JQcz7xTxMrttBvUpPfuoCLGSsKTikKIKz99YYDw4j8mxPP5wT41tP3Ky
         FCCR+O2eGqErJwGujJ+ft37AMMKVSxoDF8UBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+eTXfkl3kwRn2zHA52W//U5DmNK7Dju2RwV9ojfzrs=;
        b=BuQ3pB8qrGHvTkqMprCPgVG0reLGyRGx6d+yzcQvsoLnE83tS+cd37Dn9gbLUpLFEa
         VdD+X2q4mzHwCORcSPRbmGJ4/MbxvdSUseIZbrEceDdNSgZGtkaZ6Cn3SrhPVewiHw5O
         ITUPJidu0nmCFHjnIbBhzevtbzAM1rBoOQKrWPvvwzAFF9GJa6nn3k5W9mxm6xBmyeTD
         zGgwXIMkb1mOsBTOV1tbTzt1l+JxCZ9S7NDU4aUBcnIcxkFhd/RGujMCIVIXtDKZc4lF
         2lUCRWNZ04NUmobHI/Sk/Uglz0H+1Lv8YxzGD9nOmgULuLN5WWf6JUFRQiQIMeCv/2+Y
         pmxQ==
X-Gm-Message-State: AOAM531yVMJf92A58tlHSe1FC4cauEr5ryyA1iCV4psyKTLxKQ6YVYDl
        iZWr+7RkK7k7zm2Lo76khcp9Zw==
X-Google-Smtp-Source: ABdhPJylVogvgm3PROgXjQqr4Z2rjfGXlE4xhglAyirm227yjrxssh0yib3GTDpkvvBT74WLO4v6tA==
X-Received: by 2002:a9d:3d66:: with SMTP id a93mr4091552otc.287.1611955092324;
        Fri, 29 Jan 2021 13:18:12 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z8sm2609891oon.10.2021.01.29.13.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 13:18:11 -0800 (PST)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a06093f1-22b3-7d72-bc6c-f99f4e0d0de9@linuxfoundation.org>
Date:   Fri, 29 Jan 2021 14:18:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5f9ec159-77d8-ffba-21d1-2810e059f998@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/29/21 10:08 AM, Tetsuo Handa wrote:
> On 2021/01/30 1:05, Shuah Khan wrote:
>>> Since "general protection fault in tomoyo_socket_sendmsg_permission" is caused by
>>> unexpectedly resetting ud->tcp_socket to NULL without waiting for tx thread to
>>> terminate, tracing the ordering of events is worth knowing. Even adding
>>> schedule_timeout_uninterruptible() to before kernel_sendmsg() might help.
>>>
>>
>> What about the duplicate bug information that was in my email?
>> Did you take a look at that?
> 
> I was not aware of the duplicate bugs. It is interesting that
> "KASAN: null-ptr-deref Write in event_handler" says that vdev->ud.tcp_tx became NULL at
> 
> 	if (vdev->ud.tcp_tx) {
> 
> 		/* this location */
> 
> 		kthread_stop_put(vdev->ud.tcp_tx);
> 		vdev->ud.tcp_tx = NULL;
> 	}
> 
> which means that somebody else is unexpectedly resetting vdev->ud.tcp_tx to NULL.
> 
> If memset() from vhci_device_init() from vhci_start() were unexpectedly called,
> all of tcp_socket, tcp_rx, tcp_tx etc. becomes NULL which can explain these bugs ?
> I'm inclined to report not only tcp_socket but also other fields when kernel_sendmsg()
> detected that tcp_socket is NULL...
> 

In this console log:

06:57:50 executing program 1:
socketpair$tipc(0x1e, 0x2, 0x0, &(0x7f00000000c0)={<r0=>0xffffffffffffffff})
sendmsg$BATADV_CMD_GET_TRANSTABLE_LOCAL(r0, 
&(0x7f00000002c0)={&(0x7f00000001c0), 0xc, &(0x7f0000000280)={0x0, 
0xd001010000000000}}, 0x0)

[ 1151.090883][T23361] vhci_hcd vhci_hcd.0: pdev(4) rhport(0) sockfd(4)
[ 1151.097445][T23361] vhci_hcd vhci_hcd.0: devid(0) speed(1) 
speed_str(low-speed)
06:57:50 executing program 0:
r0 = syz_open_dev$binderN(&(0x7f0000000680)='/dev/binder#\x00', 0x0, 0x0)
ioctl$BINDER_WRITE_READ(r0, 0xc0306201, &(0x7f0000000cc0)={0x88, 0x0, 
&(0x7f0000000b80)=[@transaction={0x40406300, {0x2, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}, @transaction={0x40406300, {0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}}], 0x0, 0x0, 0x0})

[ 1151.164402][T23363] vhci_hcd: connection closed
[ 1151.167346][  T240] vhci_hcd: stop threads


[ 1151.178329][T26761] usb 17-1: new low-speed USB device number 2 using 
vhci_hcd


SK: Looking at the console log, it looks like while connection is being
     torn down,


[ 1151.181245][  T240] vhci_hcd: release socket


Can you share your your test code for this program:
"executing program 1"

Also your setup? Do you run usbip_host and vhci_hcd both?

thanks,
-- Shuah


