Return-Path: <SRS0=TKeG=AU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015FCC433DF
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Jul 2020 22:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF59206A1
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Jul 2020 22:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgGIWIF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:08:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52398 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgGIWIE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Jul 2020 18:08:04 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jtehw-0007ZY-UM; Thu, 09 Jul 2020 16:07:56 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jtehv-0002HP-De; Thu, 09 Jul 2020 16:07:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
        <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
Date:   Thu, 09 Jul 2020 17:05:09 -0500
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 02 Jul 2020 11:40:25 -0500")
Message-ID: <87r1tke44q.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jtehv-0002HP-De;;;mid=<87r1tke44q.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+oAknS1uYVmiHDpfxQrqKVts0tnK/N1nA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [merged][PATCH v3 00/16] Make the user mode driver code a better citizen
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


I have merged all of this into my exec-next tree.

The code is also available on the frozen branch:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git usermode-driver-cleanup

The range-diff from the last posted version is below.

I was asked "Is there a simpler version of this code that could
be used for backports?".  The honest answer is not really.

Fundamentally do_execve_file as it existed prior to this set of changes
breaks a lot of invariants in exec.  The choices are either track down
all of the invariants it violates and fix it, or reorganize the code so
that do_execve_file is unnecessary.  Reorganizing the code was the path
I found simplest and most reliable.  I don't think anyone has tracked
down all of the constraints the code violated.

There is an issue clearly pointed out by Tetsuo Handa that in theory if
there is too long of a delay between closing the file after writing it
and flush_delayed_fput might not synchronize the file synchronously.  I
can not trigger it, and this is the same code path the initramfs relies
upon.  So I think calling flush_delayed_fput is good enough for this set
of changes.

If and when a generally accepted way to remove the theoreticaly race
it will be trivial to fix flush_delayed_fput or replace it and none
of the other logic changes.

Declaring this set of changes done now, allows the work that depends
upon this change to proceed.


Eric

--- 

1:  8fee10be3e7e !  1:  5fec25f2cb95 umh: Capture the pid in umh_pipe_setup
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87h7uygf9i.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/875zb97iix.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-1-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/umh.h ##
 2:  2d97bc5269dd !  2:  b044fa2ae50d umh: Move setting PF_UMH into umh_pipe_setup
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87bll6gf8t.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87zh8l63xs.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-2-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## kernel/umh.c ##
 3:  974e2b827aca !  3:  3a171042aeab umh: Rename the user mode driver helpers for clarity
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/875zbegf82.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87tuyt63x3.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-3-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## kernel/umh.c ##
 4:  6c8f72f8eb49 !  4:  21d598280675 umh: Remove call_usermodehelper_setup_file.
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87zh8qf0mp.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87o8p163u1.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-4-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/umh.h ##
 5:  cbf6c2b5a04a !  5:  884c5e683b67 umh: Separate the user mode driver and the user mode helper support
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87tuyyf0ln.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87imf963s6.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-5-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/bpfilter.h ##
 6:  b68617fd4ee3 !  6:  74be2d3b80af umd: For clarity rename umh_info umd_info
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87o8p6f0kw.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/878sg563po.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-6-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/bpfilter.h ##
 7:  6881acff5f6a !  7:  1199c6c3da51 umd: Rename umd_info.cmdline umd_info.driver_name
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87imfef0k3.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87366d63os.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-7-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/usermode_driver.h ##
 8:  cd210622ff6f !  8:  e2dc9bf3f527 umd: Transform fork_usermode_blob into fork_usermode_driver
    @@ Commit message
         [1] https://lore.kernel.org/linux-fsdevel/2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp/
         v1: https://lkml.kernel.org/r/87d05mf0j9.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87wo3p4p35.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-8-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/usermode_driver.h ##
 9:  74d65aaf2cab !  9:  55e6074e3fa6 umh: Stop calling do_execve_file
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/877dvuf0i7.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87r1tx4p2a.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-9-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/umh.h ##
10:  58a9854274a1 ! 10:  25cf336de51b exec: Remove do_execve_file
    @@ Commit message
         [1] https://lore.kernel.org/linux-fsdevel/2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp/
         v1: https://lkml.kernel.org/r/871rm2f0hi.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87lfk54p0m.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-10-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## fs/exec.c ##
11:  c45ae16a18c9 ! 11:  0fe3c63148ef bpfilter: Move bpfilter_umh back into init data
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87sgeidlvq.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87ftad4ozc.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-11-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## net/bpfilter/bpfilter_umh_blob.S ##
12:  43b41b9d52a0 ! 12:  1c340ead18ee umd: Track user space drivers with struct pid
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87mu4qdlv2.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/a70l4oy8.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-12-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/usermode_driver.h ##
13:  653476c24a30 ! 13:  38fd525a4c61 exit: Factor thread_group_exited out of pidfd_poll
    @@ Metadata
      ## Commit message ##
         exit: Factor thread_group_exited out of pidfd_poll
     
    -    Create an independent helper thread_group_exited report return true
    +    Create an independent helper thread_group_exited which returns true
         when all threads have passed exit_notify in do_exit.  AKA all of the
         threads are at least zombies and might be dead or completely gone.
     
    -    Create this helper by taking the logic out of pidfd_poll where
    -    it is already tested, and adding a missing READ_ONCE on
    -    the read of task->exit_state.
    +    Create this helper by taking the logic out of pidfd_poll where it is
    +    already tested, and adding a READ_ONCE on the read of
    +    task->exit_state.
     
         I will be changing the user mode driver code to use this same logic
         to know when a user mode driver needs to be restarted.
    @@ Commit message
         Place the new helper thread_group_exited in kernel/exit.c and
         EXPORT it so it can be used by modules.
     
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-13-ebiederm@xmission.com
    +    Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/sched/signal.h ##
    @@ kernel/exit.c: COMPAT_SYSCALL_DEFINE5(waitid,
     + * thread_group_exited - check that a thread group has exited
     + * @pid: tgid of thread group to be checked.
     + *
    -+ * Test if thread group is has exited (all threads are zombies, dead
    -+ * or completely gone).
    ++ * Test if the thread group represented by tgid has exited (all
    ++ * threads are zombies, dead or completely gone).
     + *
     + * Return: true if the thread group has exited. false otherwise.
     + */
14:  7ad037d12723 ! 14:  e80eb1dc868b bpfilter: Take advantage of the facilities of struct pid
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87h7uydlu9.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/874kqt4owu.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-14-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/bpfilter.h ##
15:  e50cf5e57a62 ! 15:  8c2f52663973 umd: Remove exit_umh
    @@ Commit message
     
         v1: https://lkml.kernel.org/r/87bll6dlte.fsf_-_@x220.int.ebiederm.org
         v2: https://lkml.kernel.org/r/87y2o53abg.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-15-ebiederm@xmission.com
         Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/sched.h ##
16:  32e057d8aa4a ! 16:  33c326014fe6 umd: Stop using split_argv
    @@ Commit message
         call_usermodehelper_setup.
     
         v1: https://lkml.kernel.org/r/87sged3a9n.fsf_-_@x220.int.ebiederm.org
    +    Link: https://lkml.kernel.org/r/20200702164140.4468-16-ebiederm@xmission.com
    +    Acked-by: Alexei Starovoitov <ast@kernel.org>
    +    Tested-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## kernel/usermode_driver.c ##


