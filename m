Return-Path: <SRS0=4lEG=AM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6CC433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 10:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FCE2078A
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Jul 2020 10:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgGAKEU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:04:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53495 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKEU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Jul 2020 06:04:20 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 061A4IeF035533;
        Wed, 1 Jul 2020 19:04:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Wed, 01 Jul 2020 19:04:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 061A4H50035530
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 1 Jul 2020 19:04:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in request_key_tag
To:     Luis Chamberlain <mcgrof@kernel.org>
References: <000000000000961dea05a95c9558@google.com>
Cc:     syzbot <syzbot+46c77dc7e98c732de754@syzkaller.appspotmail.com>,
        dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <728915db-592b-997f-6970-464cc59441d7@i-love.sakura.ne.jp>
Date:   Wed, 1 Jul 2020 19:04:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000961dea05a95c9558@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I suspect commit 9e9b47d6bbe9df65 ("umh: fix processed error when UMH_WAIT_PROC is used").
Maybe the change in kernel/umh.c and/or security/keys/request_key.c made by that commit is
affecting call_usermodehelper_keys() == 0 case when complete_request_key() is called.

On 2020/07/01 16:53, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c28e58ee Add linux-next specific files for 20200629
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17925a9d100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dcd26bbca17dd1db
> dashboard link: https://syzkaller.appspot.com/bug?extid=46c77dc7e98c732de754
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+46c77dc7e98c732de754@syzkaller.appspotmail.com
