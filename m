From: james.l.morris@oracle.com (James Morris)
Date: Wed, 1 Nov 2017 17:40:00 +1100 (AEDT)
Subject: [RFC v0.1][PATCH] selinuxns: extend namespace support to
	security.selinux xattrs
In-Reply-To: <1509458646.20694.10.camel@tycho.nsa.gov>
References: <alpine.LFD.2.20.1710301859170.11614@localhost>
	<1509390973.10174.9.camel@tycho.nsa.gov>
	<alpine.LFD.2.20.1710311357320.22021@localhost>
	<1509454842.20694.1.camel@tycho.nsa.gov>
	<1509458646.20694.10.camel@tycho.nsa.gov>
Message-ID: <alpine.LFD.2.20.1711011738110.6046@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 31 Oct 2017, Stephen Smalley wrote:

> This btw would be a bit cleaner if we dropped the .ns. portion of the
> name, such that we would have:
> security.selinux # xattr name in the init namespace
> security.selinux.vmN # xattr name in the vmN namespace
> security.selinux.vmN.vmM # xattr name in the vmN.vmM namespace

I used 'ns' to diffetentiate against other potential extensions of the 
xattr name.  If that's not a concern, then yes it will be cleaner.

Do we limit the number of nestings?


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
