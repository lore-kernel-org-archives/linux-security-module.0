From: bfields@redhat.com (J. Bruce Fields)
Date: Tue, 4 Apr 2017 19:26:47 -0400
Subject: [PATCH] selinux: Fix SBLABEL_MNT for NFS mounts
In-Reply-To: <1490896334.2099.4.camel@tycho.nsa.gov>
References: <20170329152724.19030-1-tomeu.vizoso@collabora.com>
	<20170329213439.GC19617@parsley.fieldses.org>
	<CAAObsKDThPAQpgO7R+JT=foU1=BEor-Zy7DES2tnGe=rGe=REw@mail.gmail.com>
	<1490894827.2099.2.camel@tycho.nsa.gov>
	<20170330174147.GA11004@parsley.fieldses.org>
	<1490896334.2099.4.camel@tycho.nsa.gov>
Message-ID: <20170404232646.GB24146@parsley.fieldses.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 30, 2017 at 01:52:14PM -0400, Stephen Smalley wrote:
> On Thu, 2017-03-30 at 13:41 -0400, J. Bruce Fields wrote:
> > It is.??I also want to keep new protocol upgrades free of user
> > regressions, which the 4.1->4.2 upgrade is in most cases if we turn
> > on
> > security labeling by default.??So I was stuck choosing between two
> > regresisons, and figured 4.2 user depending on security labeling was
> > still the much rarer case.
> > 
> > So I'd like to keep security labeling off by default, but if there's
> > anything I can do to smooth the transition obviously that's good.
> 
> Yes, I understand - wish though that it could have been communicated
> better, e.g. on selinux list (unless I just missed it somehow).

No, I didn't think of it, apologies, I agree that would have been
smarter.

> > > and at the very least, it seems odd that they didn't just use
> > > "seclabel" as the kernel does in /proc/mounts to signify a
> > > filesystem
> > > that supports security labeling by userspace.
> > 
> > I see logic in sb_finish_set_opts() that sets SBLABEL_MNT in the
> > selinux_is_sblabel_mnt() case.??Doesn't that mean "seclabel" shows up
> > in
> > /proc/mounts when we nfs sets SECURITY_LSM_NATIVE_LABELS?
> > 
> > I may not understand your comment, I'm pretty unfamiliar with this
> > area.
> 
> Correct, I just meant it seems potentially confusing to users to use
> "security_label" in exports when we show it as "seclabel" in
> /proc/mounts.  I know, they are totally different namespaces (in the
> conventional sense), but consistency might have been more user-
> friendly.

Oh, got it.

We've had problems when NFS client mount and server export options are
spelled the same but have subtle differences in semantics (I'm thinking
of "async").  But maybe that wouldn't have been an issue here.

--b.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
