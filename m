From: james.l.morris@oracle.com (James Morris)
Date: Fri, 20 Oct 2017 16:15:00 +1100 (AEDT)
Subject: [PATCH GHAK16 V5 00/10] capabilities: do not audit log BPRM_FCAPS
	on set*id
In-Reply-To: <20171019130809.2farwdz3uav6vlp3@madcap2.tricolour.ca>
References: <cover.1507769413.git.rgb@redhat.com>
	<20171019130809.2farwdz3uav6vlp3@madcap2.tricolour.ca>
Message-ID: <alpine.LFD.2.20.1710201614310.20085@t440>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017, Richard Guy Briggs wrote:

> On 2017-10-11 20:57, Richard Guy Briggs wrote:
> > The audit subsystem is adding a BPRM_FCAPS record when auditing setuid
> > application execution (SYSCALL execve). This is not expected as it was
> > supposed to be limited to when the file system actually had capabilities
> > in an extended attribute.  It lists all capabilities making the event
> > really ugly to parse what is happening.  The PATH record correctly
> > records the setuid bit and owner.  Suppress the BPRM_FCAPS record on
> > set*id.
> 
> <crickets>
> 
> Serge?  James?  Can one of you two take this via your trees since Paul
> has backed down citing (reasonably) that it is mostly capabilities
> patches rather than audit?

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
