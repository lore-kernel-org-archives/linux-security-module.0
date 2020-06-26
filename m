Return-Path: <SRS0=ekpI=AH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DE2C433E1
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 16:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352B1206BE
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 16:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgFZQuF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:50:05 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56708 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgFZQuF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Jun 2020 12:50:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jorY9-0005GM-1G; Fri, 26 Jun 2020 10:50:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jorY2-0000c6-V9; Fri, 26 Jun 2020 10:50:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87tuyyf0ln.fsf_-_@x220.int.ebiederm.org>
        <5ce4d340-096a-f468-6719-4c34a951511e@i-love.sakura.ne.jp>
Date:   Fri, 26 Jun 2020 11:45:27 -0500
In-Reply-To: <5ce4d340-096a-f468-6719-4c34a951511e@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Sat, 27 Jun 2020 01:22:12 +0900")
Message-ID: <87d05lbwt4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jorY2-0000c6-V9;;;mid=<87d05lbwt4.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19kMmKGvmUojtO4rei5sXZ7Qr00EPT1MD0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 05/14] umh: Separate the user mode driver and the user mode helper support
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/06/26 21:55, Eric W. Biederman wrote:
>> +static void umd_cleanup(struct subprocess_info *info)
>> +{
>> +	struct umh_info *umh_info = info->data;
>> +
>> +	/* cleanup if umh_pipe_setup() was successful but exec failed */
>
> s/umh_pipe_setup/umd_setup/

Good catch.  I will fix that when I respin.

>> +	if (info->retval) {
>> +		fput(umh_info->pipe_to_umh);
>> +		fput(umh_info->pipe_from_umh);
>> +	}
>> +}
>
> After this cleanup, I expect adding some protections/isolation which kernel threads
> have (e.g. excluded from ptrace(), excluded from OOM victim selection, excluded from
> SysRq-i, won't be terminated by SIGKILL from usermode processes, won't be stopped by
> SIGSTOP from usermode processes, what else?). Doing it means giving up Alexei's
>
>   It's nice to be able to compile that blob with -g and be able to 'gdb -p' into it.
>   That works and very convenient when it comes to debugging. Compare that to debugging
>   a kernel module!
>
> but I think doing it is essential for keeping usermode blob processes as secure/robust
> as kernel threads.

Do you have an application for a user mode driver?

I think concerns like that are best addressed in the context of a
specific driver/usecase.  Just to make certain we are solving the right
problems.

My sense is that an advantage of user mode drivers can safely be buggier
than kernel drivers and the freedom to kill them when the drivers go
wrong (knowing the drivers will restart) is important.

Does this series by using the normal path through exec solve your
concerns with LSMs being able to identify these processes (both
individually and as class)?.

Eric

