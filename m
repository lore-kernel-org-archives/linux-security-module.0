Return-Path: <SRS0=/Sjk=AO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38269C433DF
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Jul 2020 22:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185AF21D92
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Jul 2020 22:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGCWag (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:30:36 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45110 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgGCWaf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Jul 2020 18:30:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jrUCR-000708-Gl; Fri, 03 Jul 2020 16:30:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jrUCQ-0005eV-HO; Fri, 03 Jul 2020 16:30:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
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
        <87pn9euks9.fsf@x220.int.ebiederm.org>
        <757f37f8-5641-91d2-be80-a96ebc74cacb@i-love.sakura.ne.jp>
        <87h7upucqi.fsf@x220.int.ebiederm.org>
        <d0266a24-dfab-83d0-e178-aa67c9f5ebc0@i-love.sakura.ne.jp>
Date:   Fri, 03 Jul 2020 17:25:49 -0500
In-Reply-To: <d0266a24-dfab-83d0-e178-aa67c9f5ebc0@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Fri, 3 Jul 2020 22:19:17 +0900")
Message-ID: <87lfk0nslu.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jrUCQ-0005eV-HO;;;mid=<87lfk0nslu.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19gJkekNuulipNZ4g9GUrgrQKnIVKDpx4I=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/07/02 22:08, Eric W. Biederman wrote:
>>> By the way, commit 4a9d4b024a3102fc ("switch fput to task_work_add") says
>>> that use of flush_delayed_fput() has to be careful. Al, is it safe to call
>>> flush_delayed_fput() from blob_to_mnt() from umd_load_blob() (which might be
>>> called from both kernel thread and from process context (e.g. init_module()
>>> syscall by /sbin/insmod )) ?
>> 
>> And __fput_sync needs to be even more careful.
>> umd_load_blob is called in these changes without any locks held.
>
> But where is the guarantee that a thread which called flush_delayed_fput() waits for
> the completion of processing _all_ "struct file" linked into delayed_fput_list ?
> If some other thread or delayed_fput_work (scheduled by fput_many()) called
> flush_delayed_fput() between blob_to_mnt()'s fput(file) and flush_delayed_fput()
> sequence? blob_to_mnt()'s flush_delayed_fput() can miss the "struct file" which
> needs to be processed before execve(), can't it?

As a module the guarantee is we call task_work_run.
Built into the kernel the guarantee as best I can trace it is that
kthreadd hasn't started, and as such nothing that is scheduled has run
yet.

> Also, I don't know how convoluted the dependency of all "struct file" linked into
> delayed_fput_list might be, for there can be "struct file" which will not be a
> simple close of tmpfs file created by blob_to_mnt()'s file_open_root() request.
>
> On the other hand, although __fput_sync() cannot be called from !PF_KTHREAD threads,
> there is a guarantee that __fput_sync() waits for the completion of "struct file"
> which needs to be flushed before execve(), isn't there?

There is really not a good helper or helpers, and this code suggests we
have something better.  Right now I have used the existing helpers to
the best of my ability.  If you or someone else wants to write a better
version of flushing so that exec can happen be my guest.

As far as I can tell what I have is good enough.

>> We fundamentally AKA in any correct version of this code need to flush
>> the file descriptor before we call exec or exec can not open it a
>> read-only denying all writes from any other opens.
>> 
>> The use case of flush_delayed_fput is exactly the same as that used
>> when loading the initramfs.
>
> When loading the initramfs, the number of threads is quite few (which
> means that the possibility of hitting the race window and convoluted
> dependency is small).

But the reality is the code run very early, before the initramfs is
initialized in practice.

> But like EXPORT_SYMBOL_GPL(umd_load_blob) indicates, blob_to_mnt()'s
> flush_delayed_fput() might be called after many number of threads already
> started running.

At which point the code probably won't be runnig from a kernel thread
but instead will be running in a thread where task_work_run is relevant.

At worst it is a very small race, where someone else in another thread
starts flushing the file.  Which means the file could still be
completely close before exec.   Even that is not necessarily fatal,
as the usermode driver code has a respawn capability.

Code that is used enough that it hits that race sounds like a very
good problem to have from the perspective of the usermode driver code.

> Do we really need to mount upon umd_load_blob() and unmount upon umd_unload_blob() ?
> LSM modules might prefer only one instance of filesystem for umd
> blobs.

It is simple. People are free to change it, but a single filesystem
seems like a very good place to start with this functionality.

> For pathname based LSMs, since that filesystem is not visible from mount tree, only
> info->driver_name can be used for distinction. Therefore, one instance of filesystem
> with files created with file_open_root(O_CREAT | O_WRONLY | O_EXCL)
> might be preferable.

I took a quick look and the creation and removal of files with the
in-kernel helpers is not particularly easy.  Certainly it is more work
and thus a higher likelyhood of bugs than what I have done.

A directory per driver does sound tempting.  Just more work that I am
willing to do.

> For inode based LSMs, reusing one instance of filesystem created upon early boot might
> be convenient for labeling.
>
> Also, we might want a dedicated filesystem (say, "umdfs") instead of regular tmpfs in
> order to implement protections without labeling files. Then, we might also be able to
> implement minimal protections without LSMs.

All valid points.  Nothing sets this design in stone.
Nothing says this is the endpoint of the evolution of this code.

The entire point of this patchset for me is that I remove the
unnecessary special cases from exec and do_exit, so I don't have to deal
with the usermode driver code anymore.

Eric
