From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 23 Jun 2017 13:34:33 -0500
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <d288ea69-adec-f257-30cb-b1d9c57c996b@linux.vnet.ibm.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAOQ4uxj=_Riih1K+QOYasZU8vZKCSrsg393f=17mJ2O-909e=Q@mail.gmail.com>
	<20170623160026.GA18257@mail.hallyn.com>
	<aa62373e-7cd6-39dd-2e38-2b6d6dbe18a8@schaufler-ca.com>
	<20170623163030.GA18820@mail.hallyn.com>
	<1498237641.3641.15.camel@HansenPartnership.com>
	<d288ea69-adec-f257-30cb-b1d9c57c996b@linux.vnet.ibm.com>
Message-ID: <20170623183433.GB21137@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Stefan Berger (stefanb at linux.vnet.ibm.com):
> On 06/23/2017 01:07 PM, James Bottomley wrote:
> >On Fri, 2017-06-23 at 11:30 -0500, Serge E. Hallyn wrote:
> >>Quoting Casey Schaufler (casey at schaufler-ca.com):
> >>>Or maybe just security.ns.capability, taking James' comment into
> >>>account.
> >>That last one may be suitable as an option, useful for his particular
> >>(somewhat barbaric :) use case, but it's not ok for the general
> >>solution.
> >>
> >>If uid 1000 was delegated the subuids 100000-199999, it should be
> >>able to write a file capability for use by his subuids, but that file
> >>capability must not apply to other subuids.
> >I don't think it's barbaric, I think it's the common use case.  Let me
> >give a more comprehensible answer in terms of docker and IMA.  Lets
> >suppose I'm running docker locally and in a test cloud both with userns
> >enabled.
> >
> >I build an image locally, mapping my uid (1000) to root.  If I begin
> >with a standard base, each of the files has a security.ima signature.
> >  Now I add my layer, which involves updating a file, so I need to write
> >a new signature to security.ima.  Because I'm running user namespaced,
> >the update gets written at security.ima at uid=1000 when I do a docker
> >save.
> >
> >Now supposing I deploy that image to a cloud.  As a tenant, the cloud
> >gives me real uid 4531 and maps that to root.  Execution of the binary
> >fails because it tries to use the underlying signature (in
> >security.ima) as there is no xattr named security.ima at uid=4531
> 
> Yes. An answer would be to have Docker rewrite these on the fly. It
> knows what uid the container was running as and specifically looks
> for security.ima at uid=1000 or security.ima, takes the former if it
> finds, otherwise the latter or nothing.

I know many people hate this answer, but I just want to point out that
on my little laptop, while untarring a 500M images takes 9.5 seconds,
remapping all uids and gids and restoring setuid+setgid on that image
takes .01s.

It's high cpu utilization, and it's not zero time, but it's very fast,
and it's 100% safe (when done the right way, not "sudo domychown").

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
