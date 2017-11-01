From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Wed, 01 Nov 2017 11:22:05 -0400
Subject: [RFC v0.1][PATCH] selinuxns: extend namespace support to
	security.selinux xattrs
In-Reply-To: <alpine.LFD.2.20.1711011738110.6046@localhost>
References: <alpine.LFD.2.20.1710301859170.11614@localhost>
	<1509390973.10174.9.camel@tycho.nsa.gov>
	<alpine.LFD.2.20.1710311357320.22021@localhost>
	<1509454842.20694.1.camel@tycho.nsa.gov>
	<1509458646.20694.10.camel@tycho.nsa.gov>
	<alpine.LFD.2.20.1711011738110.6046@localhost>
Message-ID: <1509549725.24459.6.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-11-01 at 17:40 +1100, James Morris wrote:
> On Tue, 31 Oct 2017, Stephen Smalley wrote:
> 
> > This btw would be a bit cleaner if we dropped the .ns. portion of
> > the
> > name, such that we would have:
> > security.selinux # xattr name in the init namespace
> > security.selinux.vmN # xattr name in the vmN namespace
> > security.selinux.vmN.vmM # xattr name in the vmN.vmM namespace
> 
> I used 'ns' to diffetentiate against other potential extensions of
> the?
> xattr name.??If that's not a concern, then yes it will be cleaner.
> 
> Do we limit the number of nestings?

Not in the current code, but I think we will need to do so. That's
mentioned in the list of known issues in the next-to-last commit:

????* There is no way currently to restrict or bound nesting of
????namespaces; if you allow it to a domain in the init namespace,
????then that domain can in turn unshare to arbitrary depths and can
????grant the same to any domain in its own policy.??Related to this
????is the fact that there is no way to control resource usage due to
????selinux namespaces and they can be substantial (per-namespace
????policydb, sidtab, AVC, etc).
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
