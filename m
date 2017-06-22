From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 22 Jun 2017 18:32:45 -0500
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <1498174161.7636.4.camel@HansenPartnership.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1498174161.7636.4.camel@HansenPartnership.com>
Message-ID: <20170622233245.GB2894@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting James Bottomley (James.Bottomley at HansenPartnership.com):
> On Thu, 2017-06-22 at 14:59 -0400, Stefan Berger wrote:
> > This series of patches primary goal is to enable file capabilities
> > in user namespaces without affecting the file capabilities that are
> > effective on the host. This is to prevent that any unprivileged user
> > on the host maps his own uid to root in a private namespace, writes
> > the xattr, and executes the file with privilege on the host.
> > 
> > We achieve this goal by writing extended attributes with a different
> > name when a user namespace is used. If for example the root user
> > in a user namespace writes the security.capability xattr, the name
> > of the xattr that is actually written is encoded as
> > security.capability at uid=1000 for root mapped to uid 1000 on the host.
> > When listing the xattrs on the host, the existing security.capability
> > as well as the security.capability at uid=1000 will be shown. Inside the
> > namespace only 'security.capability', with the value of
> > security.capability at uid=1000, is visible.
> 
> I'm a bit bothered by the @uid=1000 suffix.  What if I want to use this
> capability but am dynamically mapping the namespaces (i.e. I know I
> want unprivileged root, but I'm going to dynamically select the range
> to map based on what's currently available on the orchestration
> system).  If we stick with the @uid=X suffix, then dynamic mapping
> won't work because X is potentially different each time and there'll be

Note that if you just set a 'security.capability' xattr, it will apply
to all namespaces.

Does that address your concern?

> a name mismatch in my xattrs.  Why not just make the suffix @uid, which
> means if root is mapped to any unprivileged uid then we pick this up
> otherwise we go with the unsuffixed property?
> 
> As far as I can see there's no real advantage to discriminating userns
> specific xattrs based on where root is mapped to, unless there's a use
> case I'm missing?
> 
> James
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
