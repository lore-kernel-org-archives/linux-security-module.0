From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 25 Sep 2018 19:38:10 +0200
Subject: leaking path in android binder: set_nice
In-Reply-To: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
References: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
Message-ID: <20180925173810.GB20508@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 25, 2018 at 01:27:11PM -0400, Tong Zhang wrote:
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

Can you please submit a patch for this to get the proper credit for
finding and fixing this?

thanks,

greg k-h
