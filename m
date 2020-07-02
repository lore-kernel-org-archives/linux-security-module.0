Return-Path: <SRS0=SqoC=AN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA66CC433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D019F20870
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Jul 2020 16:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgGBQpP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:45:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39778 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgGBQpK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 12:45:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2Kb-0001ix-Ij; Thu, 02 Jul 2020 10:45:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2Ka-0002gd-Iu; Thu, 02 Jul 2020 10:45:01 -0600
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
Date:   Thu, 02 Jul 2020 11:40:25 -0500
In-Reply-To: <87bll17ili.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 29 Jun 2020 14:55:05 -0500")
Message-ID: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jr2Ka-0002gd-Iu;;;mid=<87y2o1swee.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+cAMX22Bki5ikqHRo2wNDRagTIDRtVz2s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v3 00/16] Make the user mode driver code a better citizen
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


This is the third round of my changeset to split the user mode driver
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
by killing "bpfilter_umh" and "running iptables -vnL" to restart
the userspace driver, also by running "while true; do iptables -L;rmmod
bpfilter; done" to verify the module load and unload work properly.

I have compiled tested each change with and without CONFIG_BPFILTER
enabled.

From v2 to v3 I have made two siginficant changes.
- I factored thread_group_exit out of pidfd_poll to allow the test
  to be used by the bpfilter code.
- I renamed umd.c and umd.h to usermode_driver.c and usermode_driver.h
  respectively.

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

v1: https://lkml.kernel.org/r/87pn9mgfc2.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87bll17ili.fsf_-_@x220.int.ebiederm.org

Eric W. Biederman (16):
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
      exit: Factor thread_group_exited out of pidfd_poll
      bpfilter: Take advantage of the facilities of struct pid
      umd: Remove exit_umh
      umd: Stop using split_argv

 fs/exec.c                        |  38 ++------
 include/linux/binfmts.h          |   1 -
 include/linux/bpfilter.h         |   7 +-
 include/linux/sched.h            |   9 --
 include/linux/sched/signal.h     |   2 +
 include/linux/umh.h              |  15 ----
 include/linux/usermode_driver.h  |  18 ++++
 kernel/Makefile                  |   1 +
 kernel/exit.c                    |  25 +++++-
 kernel/fork.c                    |   6 +-
 kernel/umh.c                     | 171 +-----------------------------------
 kernel/usermode_driver.c         | 182 +++++++++++++++++++++++++++++++++++++++
 net/bpfilter/bpfilter_kern.c     |  38 ++++----
 net/bpfilter/bpfilter_umh_blob.S |   2 +-
 net/ipv4/bpfilter/sockopt.c      |  20 +++--
 15 files changed, 275 insertions(+), 260 deletions(-)


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

