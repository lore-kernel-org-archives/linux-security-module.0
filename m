Return-Path: <SRS0=SqoC=AN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09D5C433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 13:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DCB20772
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 13:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgGBNNE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:13:04 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56368 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGBNND (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 09:13:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqz1O-0000rK-6O; Thu, 02 Jul 2020 07:12:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqz1M-0001eL-Tx; Thu, 02 Jul 2020 07:12:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
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
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
        <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
        <87eepwzqhd.fsf@x220.int.ebiederm.org>
        <1f4d8b7e-bcff-f950-7dac-76e3c4a65661@i-love.sakura.ne.jp>
Date:   Thu, 02 Jul 2020 08:08:22 -0500
In-Reply-To: <1f4d8b7e-bcff-f950-7dac-76e3c4a65661@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Tue, 30 Jun 2020 22:21:19 +0900")
Message-ID: <87pn9euks9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jqz1M-0001eL-Tx;;;mid=<87pn9euks9.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+kQ6VutM5mgPIKiibPM2Pbny1TfBYw3+s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/06/30 21:29, Eric W. Biederman wrote:
>> Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
>> release_task is called so there is a race.  As it is possible to wake
>> up and then go back to sleep before pid_has_task becomes false.
>
> What is the reason we want to wait until pid_has_task() becomes false?
>
> - wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
> + while (!wait_event_timeout(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID), 1));

So that it is safe to call bpfilter_umh_cleanup.  The previous code
performed the wait by having a callback in do_exit.

It might be possible to call bpf_umh_cleanup early but I have not done
that analysis.

To perform the test correctly what I have right now is:

bool thread_group_exited(struct pid *pid)
{
	struct task_struct *tsk;
	bool exited;

	rcu_read_lock();
	tsk = pid_task(pid, PIDTYPE_PID);
	exited = !tsk || (READ_ONCE(tsk->exit_state) && thread_group_empty(tsk));
	rcu_read_unlock();

	return exited;
}

Which is factored out of pidfd_poll.  Which means that this won't be
something that the bpfilter code has to maintain.  That seems to be a
fundamentally good facility to have regardless of bpfilter.

I will post the whole thing in a bit once I have a chance to dot my i's
and cross my t's.

> By the way, commit 4a9d4b024a3102fc ("switch fput to task_work_add") says
> that use of flush_delayed_fput() has to be careful. Al, is it safe to call
> flush_delayed_fput() from blob_to_mnt() from umd_load_blob() (which might be
> called from both kernel thread and from process context (e.g. init_module()
> syscall by /sbin/insmod )) ?

And __fput_sync needs to be even more careful.
umd_load_blob is called in these changes without any locks held.

We fundamentally AKA in any correct version of this code need to flush
the file descriptor before we call exec or exec can not open it a
read-only denying all writes from any other opens.

The use case of flush_delayed_fput is exactly the same as that used
when loading the initramfs.

Eric




