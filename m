From: james.l.morris@oracle.com (James Morris)
Date: Wed, 15 Nov 2017 18:48:51 +1100 (AEDT)
Subject: [RFC v0.1][PATCH] selinuxns: extend namespace support to
	security.selinux xattrs
In-Reply-To: <1510582716.30953.2.camel@tycho.nsa.gov>
References: <alpine.LFD.2.20.1710301859170.11614@localhost>
	<1509390973.10174.9.camel@tycho.nsa.gov>
	<alpine.LFD.2.20.1710311357320.22021@localhost>
	<1509454842.20694.1.camel@tycho.nsa.gov>
	<1509458646.20694.10.camel@tycho.nsa.gov>
	<alpine.LFD.2.20.1711131734230.32474@localhost>
	<1510582716.30953.2.camel@tycho.nsa.gov>
Message-ID: <alpine.LFD.2.20.1711151847390.19987@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 13 Nov 2017, Stephen Smalley wrote:

> Was also wondering if the name read for the init namespace ought to
> just be the empty string instead of the magic "init" value to make it
> consistent with the fact that there is no xattr suffix.

Makes sense.  It could also be "security.selinux", and always exactly 
match the xattr name.



-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
