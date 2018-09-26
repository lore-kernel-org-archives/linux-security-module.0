From: tytso@mit.edu (Theodore Y. Ts'o)
Date: Tue, 25 Sep 2018 23:16:45 -0400
Subject: Leaking path for set_task_comm
In-Reply-To: <0CD63E6E-7512-4DD6-8858-4408416DC730@vt.edu>
References: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
	<20180925183953.GI15710@uranus>
	<0CD63E6E-7512-4DD6-8858-4408416DC730@vt.edu>
Message-ID: <20180926031645.GB3321@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 25, 2018 at 08:44:39PM -0400, TongZhang wrote:
> Yes, this is exactly what I am saying.
> A process can change its own name using prctl or /proc/self/comm.
> prctl is protected by security_task_prctl, whereas /proc/self/comm is not protected by this LSM hook.
> 
> A system admin may expect to use security_task_prctl to block all attempt to change process name, however, it can still change name using /proc/self/comm.

None of the in-tree LSM's try to affect PR_SET_NAME.  Looking at
security/commoncap.c, it's clear what is of interest is to checking
things relating to security sensitive things relating to capabilities, such as:

       PR_SET_SECUREBITS
       PR_CAPBSET_*
       PR_*_SECUREBITS
       PR_*_KEEPCAPS
       PR_CAP_AMBIENT

Trying to depend on task name for anything security sensitive is at
_really_ bad idea, so it seems unlikely that a LSM would want to
protect the process name.  (And if they did, the first thing I would
ask is "Why?  What are you trying to do?  Do you realize how many
*other* ways the process name can be spoofed or otherwise controlled
by a potentially malicious user?")

					- Ted
