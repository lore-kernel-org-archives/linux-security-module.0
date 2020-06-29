Return-Path: <SRS0=lc+5=AK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC04FC433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 19:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9206420674
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 19:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgF2T7u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:59:50 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:36346 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbgF2T7q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jun 2020 15:59:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jpzwI-0005EK-W0; Mon, 29 Jun 2020 13:59:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jpzwG-00036K-RG; Mon, 29 Jun 2020 13:59:38 -0600
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
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
Date:   Mon, 29 Jun 2020 14:55:05 -0500
In-Reply-To: <87y2oac50p.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 26 Jun 2020 08:48:06 -0500")
Message-ID: <87bll17ili.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jpzwG-00036K-RG;;;mid=<87bll17ili.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18GL48/iLqx1TNDwX4UMVn/16EONFboVyk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject:  [PATCH v2 00/15] Make the user mode driver code a better citizen
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


This is the second round of my changeset to split the user mode driver
code from the user mode helper code, and to make the code use common
facilities to get things done instead of recreating them just
for the user mode driver code.

I have split the changes into small enough pieces so they should be
easily readable and testable.

The changes lean into the preexisting interfaces in the kernel and
remove special cases for user mode driver code in favor of solutions
that don't need special cases.  This results in smaller code with fewer
bugs.

At a practical level this removes the maintenance burden of the user
mode drivers from the user mode helper code and from exec as the special
cases are removed.

Similarly the LSM interaction bugs are fixed by not having unnecessary
special cases for user mode drivers.

I have tested thes changes by booting with the code compiled in and
by killing "bpfilter_umh" and running iptables -vnL to restart
the userspace driver.

I have compiled tested each change with and without CONFIG_BPFILTER
enabled.

I made a few very small changes from v1 to v2:
- Updated the function name in a comment when the function is renamed
- Moved some more code so that the the !CONFIG_BPFILTER case continues
  to compile when I moved the code into umd.c
- A fix for the module loading case to really flush the file descriptor.
- Removed split_argv entirely from fork_usermode_driver.
  There was nothing to split so it was just confusing.

Please let me know if you see any bugs.  Once the code review is
finished I plan to place the code in a non-rebasing branch
so I can pull it into my tree and so it can also be pulled into
the bpf-next tree.

Eric W. Biederman (15):
      umh: Capture the pid in umh_pipe_setup
      umh: Move setting PF_UMH into umh_pipe_setup
      umh: Rename the user mode driver helpers for clarity
      umh: Remove call_usermodehelper_setup_file.
      umh: Separate the user mode driver and the user mode helper support
      umd: For clarity rename umh_info umd_info
      umd: Rename umd_info.cmdline umd_info.driver_name
      umd: Transform fork_usermode_blob into fork_usermode_driver
      umh: Stop calling do_execve_file
      exec: Remove do_execve_file
      bpfilter: Move bpfilter_umh back into init data
      umd: Track user space drivers with struct pid
      bpfilter: Take advantage of the facilities of struct pid
      umd: Remove exit_umh
      umd: Stop using split_argv

 fs/exec.c                        |  38 ++------
 include/linux/binfmts.h          |   1 -
 include/linux/bpfilter.h         |   7 +-
 include/linux/sched.h            |   9 --
 include/linux/umd.h              |  18 ++++
 include/linux/umh.h              |  15 ----
 kernel/Makefile                  |   1 +
 kernel/exit.c                    |   1 -
 kernel/umd.c                     | 182 +++++++++++++++++++++++++++++++++++++++
 kernel/umh.c                     | 171 +-----------------------------------
 net/bpfilter/bpfilter_kern.c     |  38 ++++----
 net/bpfilter/bpfilter_umh_blob.S |   2 +-
 net/ipv4/bpfilter/sockopt.c      |  20 +++--
 13 files changed, 248 insertions(+), 255 deletions(-)

v1: https://lkml.kernel.org/r/87pn9mgfc2.fsf_-_@x220.int.ebiederm.org
---
git range-diff master v1 v2

 1:  2b76f9b3158d !  1:  d8fb851fa3d8 umh: Capture the pid in umh_pipe_setup
    @@ Commit message
         code that is specific to user mode drivers from the common user path of
         user mode helpers.
     
    +    Link: https://lkml.kernel.org/r/87h7uygf9i.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/umh.h ##
 2:  d853e933ae32 !  2:  b191c5df43ec umh: Move setting PF_UMH into umh_pipe_setup
    @@ Commit message
         Setting PF_UMH unconditionally is harmless as an action will only
         happen if it is paired with an entry on umh_list.
     
    +    Link: https://lkml.kernel.org/r/87bll6gf8t.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## kernel/umh.c ##
 3:  92d2550f0d6a !  3:  74e8c0bf3076 umh: Rename the user mode driver helpers for clarity
    @@ Commit message
         don't make much sense.  Instead name them  umd_setup and umd_cleanup
         for the functional role in setting up user mode drivers.
     
    +    Link: https://lkml.kernel.org/r/875zbegf82.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## kernel/umh.c ##
    @@ kernel/umh.c: static int umh_pipe_setup(struct subprocess_info *info, struct cre
      {
      	struct umh_info *umh_info = info->data;
      
    +-	/* cleanup if umh_pipe_setup() was successful but exec failed */
    ++	/* cleanup if umh_setup() was successful but exec failed */
    + 	if (info->retval) {
    + 		fput(umh_info->pipe_to_umh);
    + 		fput(umh_info->pipe_from_umh);
     @@ kernel/umh.c: int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
      	}
      
 4:  5a9cc2c6c64f !  4:  6652f7c0a909 umh: Remove call_usermodehelper_setup_file.
    @@ Commit message
         For this to work the argv_free is moved from umh_clean_and_save_pid
         to fork_usermode_blob.
     
    +    Link: https://lkml.kernel.org/r/87zh8qf0mp.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/umh.h ##
 5:  03ed13fa8eee !  5:  2a1ccb05cf9f umh: Separate the user mode driver and the user mode helper support
    @@ Commit message
         This makes the kernel smaller for everyone who does not use a usermode
         driver.
     
    +    v2: Moved exit_umh from sched.h to umd.h and handle the case when the
    +    code is compiled out.
    +
    +    Link: https://lkml.kernel.org/r/87tuyyf0ln.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/bpfilter.h ##
    @@ include/linux/bpfilter.h
      struct sock;
      int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
     
    + ## include/linux/sched.h ##
    +@@ include/linux/sched.h: static inline void rseq_execve(struct task_struct *t)
    + 
    + #endif
    + 
    +-void __exit_umh(struct task_struct *tsk);
    +-
    +-static inline void exit_umh(struct task_struct *tsk)
    +-{
    +-	if (unlikely(tsk->flags & PF_UMH))
    +-		__exit_umh(tsk);
    +-}
    +-
    + #ifdef CONFIG_DEBUG_RSEQ
    + 
    + void rseq_syscall(struct pt_regs *regs);
    +
      ## include/linux/umd.h (new) ##
     @@
     +#ifndef __LINUX_UMD_H__
    @@ include/linux/umd.h (new)
     +
     +#include <linux/umh.h>
     +
    ++#ifdef CONFIG_BPFILTER
    ++void __exit_umh(struct task_struct *tsk);
    ++
    ++static inline void exit_umh(struct task_struct *tsk)
    ++{
    ++	if (unlikely(tsk->flags & PF_UMH))
    ++		__exit_umh(tsk);
    ++}
    ++#else
    ++static inline void exit_umh(struct task_struct *tsk)
    ++{
    ++}
    ++#endif
    ++
     +struct umh_info {
     +	const char *cmdline;
     +	struct file *pipe_to_umh;
    @@ kernel/Makefile: obj-y     = fork.o exec_domain.o panic.o \
      obj-$(CONFIG_MULTIUSER) += groups.o
      
     
    + ## kernel/exit.c ##
    +@@
    + #include <linux/random.h>
    + #include <linux/rcuwait.h>
    + #include <linux/compat.h>
    ++#include <linux/umd.h>
    + 
    + #include <linux/uaccess.h>
    + #include <asm/unistd.h>
    +
      ## kernel/umd.c (new) ##
     @@
     +// SPDX-License-Identifier: GPL-2.0-only
    @@ kernel/umd.c (new)
     +{
     +	struct umh_info *umh_info = info->data;
     +
    -+	/* cleanup if umh_pipe_setup() was successful but exec failed */
    ++	/* cleanup if umh_setup() was successful but exec failed */
     +	if (info->retval) {
     +		fput(umh_info->pipe_to_umh);
     +		fput(umh_info->pipe_from_umh);
    @@ kernel/umh.c: struct subprocess_info *call_usermodehelper_setup(const char *path
     -{
     -	struct umh_info *umh_info = info->data;
     -
    --	/* cleanup if umh_pipe_setup() was successful but exec failed */
    +-	/* cleanup if umh_setup() was successful but exec failed */
     -	if (info->retval) {
     -		fput(umh_info->pipe_to_umh);
     -		fput(umh_info->pipe_from_umh);
 6:  698bfbcb6c7f !  6:  b16081fb8d92 umd: For clarity rename umh_info umd_info
    @@ Commit message
         This structure is only used for user mode drivers so change
         the prefix from umh to umd to make that clear.
     
    +    Link: https://lkml.kernel.org/r/87o8p6f0kw.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/bpfilter.h ##
    @@ include/linux/bpfilter.h: int bpfilter_ip_set_sockopt(struct sock *sk, int optna
      	int (*sockopt)(struct sock *sk, int optname,
     
      ## include/linux/umd.h ##
    -@@
    - 
    - #include <linux/umh.h>
    +@@ include/linux/umd.h: static inline void exit_umh(struct task_struct *tsk)
    + }
    + #endif
      
     -struct umh_info {
     +struct umd_info {
    @@ kernel/umd.c: static int umd_setup(struct subprocess_info *info, struct cred *ne
     -	struct umh_info *umh_info = info->data;
     +	struct umd_info *umd_info = info->data;
      
    - 	/* cleanup if umh_pipe_setup() was successful but exec failed */
    + 	/* cleanup if umh_setup() was successful but exec failed */
      	if (info->retval) {
     -		fput(umh_info->pipe_to_umh);
     -		fput(umh_info->pipe_from_umh);
 7:  9cdcb5e7fc61 !  7:  42c13aa9c526 umd: Rename umd_info.cmdline umd_info.driver_name
    @@ Commit message
         driver_name any place where the code is looking for a name
         of the binary.
     
    +    Link: https://lkml.kernel.org/r/87imfef0k3.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/umd.h ##
    -@@
    - #include <linux/umh.h>
    +@@ include/linux/umd.h: static inline void exit_umh(struct task_struct *tsk)
    + #endif
      
      struct umd_info {
     -	const char *cmdline;
 8:  5ada2f70ae21 !  8:  385ed14a025b umd: Transform fork_usermode_blob into fork_usermode_driver
    @@ Commit message
         path based LSMs there are no new special cases.
     
         [1] https://lore.kernel.org/linux-fsdevel/2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp/
    +    Link: https://lkml.kernel.org/r/87d05mf0j9.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/umd.h ##
    @@ include/linux/umd.h
      #include <linux/umh.h>
     +#include <linux/path.h>
      
    - struct umd_info {
    - 	const char *driver_name;
    + #ifdef CONFIG_BPFILTER
    + void __exit_umh(struct task_struct *tsk);
     @@ include/linux/umd.h: struct umd_info {
      	struct file *pipe_from_umh;
      	struct list_head list;
    @@ kernel/umd.c
      #include <linux/pipe_fs_i.h>
     +#include <linux/mount.h>
     +#include <linux/fs_struct.h>
    ++#include <linux/task_work.h>
      #include <linux/umd.h>
      
      static LIST_HEAD(umh_list);
    @@ kernel/umd.c
     +		return ERR_PTR(err);
     +	}
     +
    -+	__fput_sync(file);
    ++	fput(file);
    ++
    ++	/* Flush delayed fput so exec can open the file read-only */
    ++	flush_delayed_fput();
    ++	task_work_run();
     +	return mnt;
     +}
     +
 9:  e4ff478e77c9 !  9:  eeae92e3f0da umh: Stop calling do_execve_file
    @@ Commit message
         call_usermodehelper_exec_async that would call do_execve_file instead
         of do_execve if file was set.
     
    +    Link: https://lkml.kernel.org/r/877dvuf0i7.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/umh.h ##
10:  dc0a38f6bd51 ! 10:  c7fdaf5660b8 exec: Remove do_execve_file
    @@ Commit message
     
         Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
         [1] https://lore.kernel.org/linux-fsdevel/2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp/
    +    Link: https://lkml.kernel.org/r/871rm2f0hi.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## fs/exec.c ##
11:  d0c0c2ddf53b ! 11:  43d08e6986a7 bpfilter: Move bpfilter_umh back into init data
    @@ Commit message
         the blob the blob no longer needs to live .rodata to allow for restarting.
         So move the blob back to .init.rodata.
     
    +    Link: https://lkml.kernel.org/r/87sgeidlvq.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## net/bpfilter/bpfilter_umh_blob.S ##
12:  51b703ad75dd ! 12:  729ee744af46 umd: Track user space drivers with struct pid
    @@ Commit message
         As the tgid is now refcounted verify the tgid is NULL at the start of
         fork_usermode_driver to avoid the possibility of silent pid leaks.
     
    +    Link: https://lkml.kernel.org/r/87mu4qdlv2.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/umd.h ##
13:  cdadf89503c9 ! 13:  2d85b10b965e bpfilter: Take advantage of the facilities of struct pid
    @@ Commit message
         struct pid can be tested to see if a process still exists, and that
         struct pid has a wait queue that notifies when the process dies.
     
    +    Link: https://lkml.kernel.org/r/87h7uydlu9.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/bpfilter.h ##
14:  1d621649e144 ! 14:  6e7e8ddd2b44 umd: Remove exit_umh
    @@ Commit message
         callback is what exit_umh exists to call.  So remove exit_umh and all
         of it's associated booking.
     
    +    Link: https://lkml.kernel.org/r/87bll6dlte.fsf_-_@x220.int.ebiederm.org
    +    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## include/linux/sched.h ##
    @@ include/linux/sched.h: extern struct pid *cad_pid;
      #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
      #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
      #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
    -@@ include/linux/sched.h: static inline void rseq_execve(struct task_struct *t)
    - 
    - #endif
    +
    + ## include/linux/umd.h ##
    +@@
    + #include <linux/umh.h>
    + #include <linux/path.h>
      
    +-#ifdef CONFIG_BPFILTER
     -void __exit_umh(struct task_struct *tsk);
     -
     -static inline void exit_umh(struct task_struct *tsk)
    @@ include/linux/sched.h: static inline void rseq_execve(struct task_struct *t)
     -	if (unlikely(tsk->flags & PF_UMH))
     -		__exit_umh(tsk);
     -}
    +-#else
    +-static inline void exit_umh(struct task_struct *tsk)
    +-{
    +-}
    +-#endif
     -
    - #ifdef CONFIG_DEBUG_RSEQ
    - 
    - void rseq_syscall(struct pt_regs *regs);
    -
    - ## include/linux/umd.h ##
    -@@ include/linux/umd.h: struct umd_info {
    + struct umd_info {
      	const char *driver_name;
      	struct file *pipe_to_umh;
      	struct file *pipe_from_umh;
    @@ include/linux/umd.h: struct umd_info {
      };
     
      ## kernel/exit.c ##
    +@@
    + #include <linux/random.h>
    + #include <linux/rcuwait.h>
    + #include <linux/compat.h>
    +-#include <linux/umd.h>
    + 
    + #include <linux/uaccess.h>
    + #include <asm/unistd.h>
     @@ kernel/exit.c: void __noreturn do_exit(long code)
      	exit_task_namespaces(tsk);
      	exit_task_work(tsk);
    @@ kernel/exit.c: void __noreturn do_exit(long code)
     
      ## kernel/umd.c ##
     @@
    - #include <linux/fs_struct.h>
    + #include <linux/task_work.h>
      #include <linux/umd.h>
      
     -static LIST_HEAD(umh_list);
 -:  ------------ > 15:  662deff06d76 umd: Stop using split_argv



