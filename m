From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Tue, 25 Sep 2018 13:52:57 -0400
Subject: leaking path in android binder: set_nice
In-Reply-To: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
References: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
Message-ID: <d38229cb-eb38-19fa-f5d6-30e6389ade3b@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/25/2018 01:27 PM, Tong Zhang wrote:
> Kernel Version: 4.18.5
> 
> Problem Description:
> 
> When setting nice value, it is checked by LSM function security_task_setnice().
> see kernel/sched/core.c:3972 SYSCALL_DEFINE1(nice, int, increment)
> 
> We discovered a leaking path in android binder which allows using binder?s interface to change
> a process?s nice value. This path is leaked from being monitored by LSM.
> see drivers/android/binder.c:1107 binder_set_nice.

Not sure you want to invoke the LSM hook (or at least the same hook) 
when binder is performing priority inheritance.  There is a difference 
between a userspace process switching its own priority and the kernel 
binder driver performing it.  IIUC, the can_nice() check is more about 
honoring RLIMIT_NICE than anything else.
