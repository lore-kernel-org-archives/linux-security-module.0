From: jmorris@namei.org (James Morris)
Date: Mon, 27 Mar 2017 08:09:17 +1100 (AEDT)
Subject: [PATCH] LSM: Revive security_task_alloc() hook and per "struct
	task_struct" security blob.
In-Reply-To: <201703261049.FAI51524.OVFQtFSLHOFMOJ@I-love.SAKURA.ne.jp>
References: <1490355993-15773-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<201703261049.FAI51524.OVFQtFSLHOFMOJ@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.20.1703270809070.25743@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 26 Mar 2017, Tetsuo Handa wrote:

> James, would you teach me why this patch still cannot go to linux-next?
> If we don't merge this patch now, we will again fail to land in 4.12.

I'm still reviewing it.


> 
> > On 02/01/2017 08:02 PM, James Morris wrote:
> > > On Wed, 1 Feb 2017, John Johansen wrote:
> > >
> > >> Sorry this took so long, it looks good to me, and I have done
> > >> some builds and tests with apparmor using it. The apparmor patch
> > >> to make use of this follows as a reply.
> > >>
> > >> Acked-by: John Johansen <john.johansen@canonical.com>
> > >
> > > We're too late in the -rc cycle to take these for 4.11.  Please
> > > keep testing them and some more review/acks would also be good.
> > >
> > Certainly, I didn't expect this to land in 4.11. I would really like
> > get some feed back/review/ack from the owner of the task struct.
> 

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
