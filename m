Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFA1C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Feb 2021 19:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1575064E74
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Feb 2021 19:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhBJTIv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:08:51 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57770 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhBJTIq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Feb 2021 14:08:46 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11AJ85iP098318;
        Thu, 11 Feb 2021 04:08:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Thu, 11 Feb 2021 04:08:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11AJ843F098315
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Feb 2021 04:08:04 +0900 (JST)
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
 <5f9ec159-77d8-ffba-21d1-2810e059f998@i-love.sakura.ne.jp>
 <a06093f1-22b3-7d72-bc6c-f99f4e0d0de9@linuxfoundation.org>
 <40617d66-1334-13a0-de9b-bd7cc1155ce5@i-love.sakura.ne.jp>
 <43d8d6bf-53f3-11e6-894d-c257f7f4bd07@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4368349b-fc0c-6da3-a502-2733f953d271@i-love.sakura.ne.jp>
Date:   Thu, 11 Feb 2021 04:07:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <43d8d6bf-53f3-11e6-894d-c257f7f4bd07@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/02/11 3:17, Shuah Khan wrote:
> I am looking to understand the syzbot configuration and a reproducer
> to be able to debug and fix the problem. How is syzbot triggering the
> vhci_hcd attach and detach sequence?

I don't know. I'm waiting for syzbot to reproduce the problem on linux-next
with https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/usbip?id=f1bdf414e7dd0cbc26460425719fc3ea479947a2 .

> 
> This helps me determine all these fix suggestions that are coming in
> are fixes or papering over a real problem.

What are these fix suggestions?

"general protection fault in tomoyo_socket_sendmsg_permission" is a NULL pointer
dereference which can happen if vhci_device_reset() and/or vhci_device_init()
(which does vdev->ud.tcp_socket = NULL;) were unexpectedly called. There is no
reproducer, and (as far as I know) no fix suggestion.

"KASAN: null-ptr-deref Write in vhci_shutdown_connection" is an ERR_PTR(-EINTR)
pointer dereference which can happen if kthread_create() was SIGKILLed. There is
a reproducer, and https://lkml.kernel.org/r/20210205135707.4574-1-penguin-kernel@I-love.SAKURA.ne.jp
is a fix suggestion.

