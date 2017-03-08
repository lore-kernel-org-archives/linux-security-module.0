From: tixxdz@gmail.com (Djalal Harouni)
Date: Wed, 8 Mar 2017 14:44:34 +0100
Subject: [PATCH] LSM: Revive security_task_alloc() hook.
In-Reply-To: <201703071935.BHI04160.VMJSOOLFFHOFQt@I-love.SAKURA.ne.jp>
References: <c2f75c40-991a-3d8e-d4d4-131a6c2d2828@canonical.com>
	<alpine.LRH.2.20.1702021501040.20047@namei.org>
	<d8fb57e5-93c6-99d0-619f-0978e36a8ef5@canonical.com>
	<201702082221.CAG52603.LOtVSOHFFQOJMF@I-love.SAKURA.ne.jp>
	<20170214134230.72818742@d-jobol.iot.bzh>
	<201703071935.BHI04160.VMJSOOLFFHOFQt@I-love.SAKURA.ne.jp>
Message-ID: <CAEiveUftmj_RRQWQfiuG=TcqJ0cxZk+jyZ67wPCjXdvvW3V4gA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 7, 2017 at 11:35 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> James, there seems to be no more comments.
> Can we send this patch to linux-next.git via your tree?

I've been testing this hook and updated the new minimal LSM to block
module autoload to use it. Also I'm investigating if it's possible to
use Yama ptrace restrictions in containers where we don't want to
apply Yama ptrace_scope flag globally but opt-in, the flag should be
applied/dup'ed on processes/container tree without affecting the rest
of the system.

Thanks!

>
> Jose Bollo wrote:
> > On Wed, 8 Feb 2017 22:21:14 +0900
> > Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> >
> > > John Johansen wrote:
> > > > On 02/01/2017 08:02 PM, James Morris wrote:
> > > > > On Wed, 1 Feb 2017, John Johansen wrote:
> > > > >
> > > > >> Sorry this took so long, it looks good to me, and I have done
> > > > >> some builds and tests with apparmor using it. The apparmor patch
> > > > >> to make use of this follows as a reply.
> > > > >>
> > > > >> Acked-by: John Johansen <john.johansen@canonical.com>
> > > > >
> > > > > We're too late in the -rc cycle to take these for 4.11.  Please
> > > > > keep testing them and some more review/acks would also be good.
> > > > >
> > > > Certainly, I didn't expect this to land in 4.11. I would really like
> > > > get some feed back/review/ack from the owner of the task struct.
> > >
> > > What does "the owner of the task struct" mean? "struct task_struct" is
> > > an object where fields are added/removed by individual subsystem. I
> > > think there is no explicit owner to ask feed back/review/ack.
> > >
> > > We added CONFIG_SECURITY_PATH in 2.6.29 and its user in 2.6.30.
> > > I think applying this patch without users in 4.11-rc1 for trial is
> > > better.
> >
> > agreed
> >
> > > TOMOYO can test this patch in 4.11-rcX if this patch is applied now.
> > > AppArmor can test this patch in AppArmor's tree.
> > > SELinux can apply security_task_create() => security_task_alloc()
> > > change in SELinux's tree.
> > > Casey can update "LSM: Stacking for major security modules - resend"
> > > with this change included.
> > > ptags and Timgad can evaluate this patch in their trees.
> > >
> > > We can update this patch in 4.12-rc1 if it turned out that this patch
> > > is insufficient for somebody.
> >
> > agreed
> >
> > I believe that there is a general agreement on the behaviour and the
> > spirit of the patch. So why not to go ahead?
> >
> > a+j
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
tixxdz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
