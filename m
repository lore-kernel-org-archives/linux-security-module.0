Return-Path: <SRS0=aSrS=7A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC0C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 18 May 2020 13:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F15207E8
	for <linux-security-module@archiver.kernel.org>; Mon, 18 May 2020 13:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgERNBC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 May 2020 09:01:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44414 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNBC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 09:01:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jafO5-0005ha-50; Mon, 18 May 2020 07:00:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jafO3-0003dN-W5; Mon, 18 May 2020 07:00:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-next@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <87lfltcbc4.fsf@x220.int.ebiederm.org>
        <20200518111716.2896385-1-gladkov.alexey@gmail.com>
        <871rnh78di.fsf@x220.int.ebiederm.org>
        <20200518125648.robgr7mud7esao2o@comp-core-i7-2640m-0182e6>
Date:   Mon, 18 May 2020 07:57:16 -0500
In-Reply-To: <20200518125648.robgr7mud7esao2o@comp-core-i7-2640m-0182e6>
        (Alexey Gladkov's message of "Mon, 18 May 2020 14:56:48 +0200")
Message-ID: <87pnb15rkj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jafO3-0003dN-W5;;;mid=<87pnb15rkj.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+7voJjdUzm6K/RfqhwLgvU8mZCtMfUl1k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] proc: proc_pid_ns takes super_block as an argument
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Mon, May 18, 2020 at 07:08:57AM -0500, Eric W. Biederman wrote:
>> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
>> 
>> > The proc_pid_ns() can be used for both inode and dentry. To avoid making
>> > two identical functions, change the argument type of the proc_pid_ns().
>> >
>> > Link: https://lore.kernel.org/lkml/c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp/
>> > Reported-by: syzbot+c1af344512918c61362c@syzkaller.appspotmail.com
>> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
>> 
>> So overall this looks good.
>> 
>> However, the description leaves a little bit to be desired as it does
>> not describe why it is bad to use dentry->d_sb.  A fixes tag would be
>> nice if for no other reason than to help anyone who decides to backport
>> this.
>
> OK. I will add it.

Thank you.  It really helps to have the full description of why in
the commit comments.

>> And can you please compile test this?
>> 
>> There is a very silly typo in proc that keeps this from compiling.
>
> I compiled the kernel with this patch and ran the kernel, but accidentally
> did not check children_seq_show(). Sorry.

Yes, children_seq_show is behind a sneaky CONFIG option.

Eric
