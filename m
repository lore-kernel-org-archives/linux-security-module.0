From: ztong@vt.edu (Tong Zhang)
Date: Tue, 25 Sep 2018 13:27:08 -0400
Subject: Leaking path for set_task_comm
Message-ID: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

When using prctl(PR_SET_NAME) to set the thread name, it is checked by security_task_prctl.

We discovered a leaking path that can also use method implemented in 
fs/proc/base.c:1526 comm_write(), to do similar thing without asking LSM?s decision.

- Tong
