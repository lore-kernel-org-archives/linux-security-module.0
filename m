From: ztong@vt.edu (TongZhang)
Date: Tue, 25 Sep 2018 20:44:39 -0400
Subject: Leaking path for set_task_comm
In-Reply-To: <20180925183953.GI15710@uranus>
References: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
	<20180925183953.GI15710@uranus>
Message-ID: <0CD63E6E-7512-4DD6-8858-4408416DC730@vt.edu>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Yes, this is exactly what I am saying.
A process can change its own name using prctl or /proc/self/comm.
prctl is protected by security_task_prctl, whereas /proc/self/comm is not protected by this LSM hook.

A system admin may expect to use security_task_prctl to block all attempt to change process name, however, it can still change name using /proc/self/comm.

> On Sep 25, 2018, at 2:39 PM, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> 
> On Tue, Sep 25, 2018 at 01:27:08PM -0400, Tong Zhang wrote:
>> Kernel Version: 4.18.5
>> 
>> Problem Description:
>> 
>> When using prctl(PR_SET_NAME) to set the thread name, it is checked by security_task_prctl.
>> 
>> We discovered a leaking path that can also use method implemented in 
>> fs/proc/base.c:1526 comm_write(), to do similar thing without asking LSM?s decision.
> 
> I don't understand how it is a problem. Could you please explain?
> procfs/comm is created with S_IRUGO|S_IWUSR permissions. So
> prctl and procfs are simply different interfaces.
