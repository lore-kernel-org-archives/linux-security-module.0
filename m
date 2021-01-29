Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6246C433E9
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jan 2021 17:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C2264DED
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jan 2021 17:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhA2RJp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:09:45 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60344 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhA2RJe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jan 2021 12:09:34 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 10TH8gL7041384;
        Sat, 30 Jan 2021 02:08:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Sat, 30 Jan 2021 02:08:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 10TH8gCx041381
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 30 Jan 2021 02:08:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com
References: <000000000000647eff05b3f7e0d4@google.com>
 <20201113120055.11748-1-hdanton@sina.com>
 <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
 <ea4028b7-53f2-aeaf-76e7-69874efcdec5@I-love.SAKURA.ne.jp>
 <2b70d360-a293-4acb-ea6c-2badda5e8b8b@linuxfoundation.org>
 <9bdd3f10-bddb-bd87-d7ad-b4b706477006@i-love.sakura.ne.jp>
 <6b8da36f-a994-7604-77f4-52e29434605f@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5f9ec159-77d8-ffba-21d1-2810e059f998@i-love.sakura.ne.jp>
Date:   Sat, 30 Jan 2021 02:08:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6b8da36f-a994-7604-77f4-52e29434605f@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/01/30 1:05, Shuah Khan wrote:
>> Since "general protection fault in tomoyo_socket_sendmsg_permission" is caused by
>> unexpectedly resetting ud->tcp_socket to NULL without waiting for tx thread to
>> terminate, tracing the ordering of events is worth knowing. Even adding
>> schedule_timeout_uninterruptible() to before kernel_sendmsg() might help.
>>
> 
> What about the duplicate bug information that was in my email?
> Did you take a look at that?

I was not aware of the duplicate bugs. It is interesting that
"KASAN: null-ptr-deref Write in event_handler" says that vdev->ud.tcp_tx became NULL at

	if (vdev->ud.tcp_tx) {

		/* this location */

		kthread_stop_put(vdev->ud.tcp_tx);
		vdev->ud.tcp_tx = NULL;
	}

which means that somebody else is unexpectedly resetting vdev->ud.tcp_tx to NULL.

If memset() from vhci_device_init() from vhci_start() were unexpectedly called,
all of tcp_socket, tcp_rx, tcp_tx etc. becomes NULL which can explain these bugs ?
I'm inclined to report not only tcp_socket but also other fields when kernel_sendmsg()
detected that tcp_socket is NULL...
