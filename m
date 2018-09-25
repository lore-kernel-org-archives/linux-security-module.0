From: gorcunov@gmail.com (Cyrill Gorcunov)
Date: Tue, 25 Sep 2018 21:39:53 +0300
Subject: Leaking path for set_task_comm
In-Reply-To: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
References: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
Message-ID: <20180925183953.GI15710@uranus>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 25, 2018 at 01:27:08PM -0400, Tong Zhang wrote:
> Kernel Version: 4.18.5
> 
> Problem Description:
> 
> When using prctl(PR_SET_NAME) to set the thread name, it is checked by security_task_prctl.
> 
> We discovered a leaking path that can also use method implemented in 
> fs/proc/base.c:1526 comm_write(), to do similar thing without asking LSM?s decision.

I don't understand how it is a problem. Could you please explain?
procfs/comm is created with S_IRUGO|S_IWUSR permissions. So
prctl and procfs are simply different interfaces.
