Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC9DC433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jan 2021 05:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF82D64DFF
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jan 2021 05:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhA2Ft1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Jan 2021 00:49:27 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55372 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhA2Ft0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jan 2021 00:49:26 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 10T5mhR4047405;
        Fri, 29 Jan 2021 14:48:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Fri, 29 Jan 2021 14:48:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 10T5maKc047394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Jan 2021 14:48:43 +0900 (JST)
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9bdd3f10-bddb-bd87-d7ad-b4b706477006@i-love.sakura.ne.jp>
Date:   Fri, 29 Jan 2021 14:48:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <2b70d360-a293-4acb-ea6c-2badda5e8b8b@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/01/29 4:05, Shuah Khan wrote:
> The reason I don't like adding printk's is this is a race condition
> and as a result time sensitive. Adding printks in the path will not
> help debug this issue. It will make it harder to reproduce the problem.

Not always. Adding printk() might make it easier to reproduce the problem.

> 
> I am unable to reproduce the problem using the reproducer and running multiple instances of the reproducer.

Since syzkaller cannot find a reproducer for "general protection fault in
tomoyo_socket_sendmsg_permission", and you cannot reproduce other problem
using reproducer, trying to obtain some clue via printing messages by asking
syzkaller to try debug patch can be very helpful.

Since "general protection fault in tomoyo_socket_sendmsg_permission" is caused by
unexpectedly resetting ud->tcp_socket to NULL without waiting for tx thread to
terminate, tracing the ordering of events is worth knowing. Even adding
schedule_timeout_uninterruptible() to before kernel_sendmsg() might help.

