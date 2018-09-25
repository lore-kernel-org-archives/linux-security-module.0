From: ztong@vt.edu (Tong Zhang)
Date: Tue, 25 Sep 2018 13:27:11 -0400
Subject: leaking path in android binder: set_nice
Message-ID: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

When setting nice value, it is checked by LSM function security_task_setnice().
see kernel/sched/core.c:3972 SYSCALL_DEFINE1(nice, int, increment)

We discovered a leaking path in android binder which allows using binder?s interface to change 
a process?s nice value. This path is leaked from being monitored by LSM.
see drivers/android/binder.c:1107 binder_set_nice.

- Tong
