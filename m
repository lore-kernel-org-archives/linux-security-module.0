From: sargun@sargun.me (Sargun Dhillon)
Date: Tue, 29 May 2018 17:49:53 -0700
Subject: [PATCH 1/2] security: Move LSM registration arguments to struct
	lsm_info
In-Reply-To: <adf91142-ebb0-b20f-6e18-ae6c5b9a7774@schaufler-ca.com>
References: <20180517070052.GA22158@ircssh-2.c.rugged-nimbus-611.internal>
	<alpine.LRH.2.21.1805300853590.14712@namei.org>
	<adf91142-ebb0-b20f-6e18-ae6c5b9a7774@schaufler-ca.com>
Message-ID: <CAMp4zn_b-vw8=9UAPeJUGB5gBJ2F=Uj9TZypC8uxt9VjSRrTRA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, May 29, 2018 at 4:12 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 5/29/2018 3:54 PM, James Morris wrote:
> > On Thu, 17 May 2018, Sargun Dhillon wrote:
> >
> >>  struct security_hook_list {
> >> -    struct hlist_node               list;
> >> -    struct hlist_head               *head;
> >> -    union security_list_options     hook;
> >> -    char                            *lsm;
> >> +    struct hlist_node                       list;
> >> +    struct hlist_head                       *head;
> >> +    const union security_list_options       hook;
> >> +    struct lsm_info                         *info;
> > Kees asked if this field should be const in response to your 01 May
> > posting.  Please address this.
> >
> > Also, I'd love to see more folk review & ack these patches.
>
I'll wait for reviews to come in, and respin with this one change if
the rest of the patchset gets an (N)Ack.

> Unless there is serious interest in loadable security
> module support there isn't a lot of value to be gained
> with this patch set.
No runtime memory allocation during security module loading?


> I am officially agnostic on the topic.
> I know that there has been significant resistance to the
> facility in the past. I will put more effort into review
> if [un]loadable modules have a future.

For what it's worth, my most recent use case is systemd-in-containers.
Today, systemd needs CAP_SYS_ADMIN in the userns it's running in --
and that's alright. It makes doing a bunch of stuff in the container
easier (like lifecycle management). I would like to ensure that it
doesn't get passed on the systemd's child (general purpose units), as
a matter of defense-in-depth. This would be easy enough to cook up as
a minor LSM.

Right now, I've got nothing as far as I can tell. I know we don't add
infrastructure for out-of-tree use-cases, but what do you suggest as a
way to keep up with all of the niche container security usecases like
this?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
