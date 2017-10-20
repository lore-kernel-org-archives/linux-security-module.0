From: rgb@redhat.com (Richard Guy Briggs)
Date: Thu, 19 Oct 2017 22:34:37 -0400
Subject: [PATCH GHAK16 V5 00/10] capabilities: do not audit log
	BPRM_FCAPS on set*id
In-Reply-To: <alpine.LFD.2.20.1710201229350.11454@t440.gateway.2wire.net>
References: <cover.1507769413.git.rgb@redhat.com>
	<20171019130809.2farwdz3uav6vlp3@madcap2.tricolour.ca>
	<alpine.LFD.2.20.1710201229350.11454@t440.gateway.2wire.net>
Message-ID: <20171020023437.eani5puqd3a67lme@madcap2.tricolour.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2017-10-20 01:29, James Morris wrote:
> On Thu, 19 Oct 2017, Richard Guy Briggs wrote:
> 
> > On 2017-10-11 20:57, Richard Guy Briggs wrote:
> > > The audit subsystem is adding a BPRM_FCAPS record when auditing setuid
> > > application execution (SYSCALL execve). This is not expected as it was
> > > supposed to be limited to when the file system actually had capabilities
> > > in an extended attribute.  It lists all capabilities making the event
> > > really ugly to parse what is happening.  The PATH record correctly
> > > records the setuid bit and owner.  Suppress the BPRM_FCAPS record on
> > > set*id.
> > 
> > <crickets>
> > 
> > Serge?  James?  Can one of you two take this via your trees since Paul
> > has backed down citing (reasonably) that it is mostly capabilities
> > patches rather than audit?
> 
> Sure, I will take it.

Thanks Jaume!

> > > See: https://github.com/linux-audit/audit-kernel/issues/16
> > > 
> > > The first to eighth patches just massage the logic to make it easier to
> > > understand.  Some of them could be squashed together.
> > > 
> > > The patch that resolves this issue is the ninth.  
> > > 
> > > It would be possible to address the original issue with a change of
> > > 	"!uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid)"
> > > to
> > > 	"!(uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid))"
> > > but it took me long enough to understand this logic that I don't think
> > > I'd be doing any favours by leaving it this difficult to understand.
> > > 
> > > The final patch attempts to address all the conditions that need logging
> > > based on mailing list conversations, recoginizing there is probably some
> > > duplication in the logic.
> > > 
> > > Passes: (ltp 20170516)
> > > 	./runltp -f syscalls -s cap
> > > 	./runltp -f securebits
> > > 	./runltp -f cap_bounds
> > > 	./runltp -f filecaps
> > > 	make TARGETS=capabilities kselftest (when run locally, fails over nfs)
> > > 
> > > Since this is mostly capabilities related rather than audit, could this go
> > > through the capabilites (Serge) or security (James) trees please?  Thanks!
> > > 
> > > v5
> > >   rebase on linux-security/next 4.14-rc2
> > >   added comment block header to handle_privileged_root()
> > >   moved comment in handle_privileged_root()
> > >   moved root_privileged() check back into handle_privileged_root()
> > > 
> > > v4
> > >   rebase on kees' 4.13 commoncap changes
> > >   minor local func renames
> > > 
> > > v3
> > >   refactor into several sub-functions
> > >   convert most macros to inline funcs
> > > 
> > > v2
> > >   use macros to clarify intent of calculations
> > >   fix original logic error
> > >   address additional audit logging conditions
> > > 
> > > Richard Guy Briggs (10):
> > >   capabilities: factor out cap_bprm_set_creds privileged root
> > >   capabilities: intuitive names for cap gain status
> > >   capabilities: rename has_cap to has_fcap
> > >   capabilities: use root_priveleged inline to clarify logic
> > >   capabilities: use intuitive names for id changes
> > >   capabilities: move audit log decision to function
> > >   capabilities: remove a layer of conditional logic
> > >   capabilities: invert logic for clarity
> > >   capabilities: fix logic for effective root or real root
> > >   capabilities: audit log other surprising conditions
> > > 
> > >  security/commoncap.c | 193 ++++++++++++++++++++++++++++++++++-----------------
> > >  1 file changed, 128 insertions(+), 65 deletions(-)
> > > 
> > > -- 
> > > 1.8.3.1
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> > > the body of a message to majordomo at vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > - RGB
> > 
> > --
> > Richard Guy Briggs <rgb@redhat.com>
> > Sr. S/W Engineer, Kernel Security, Base Operating Systems
> > Remote, Ottawa, Red Hat Canada
> > IRC: rgb, SunRaycer
> > Voice: +1.647.777.2635, Internal: (81) 32635
> > 
> 
> -- 
> James Morris
> <james.l.morris@oracle.com>
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
