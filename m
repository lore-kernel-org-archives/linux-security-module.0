From: jmorris@namei.org (James Morris)
Date: Fri, 7 Apr 2017 08:24:47 +1000 (AEST)
Subject: [PATCH RFC 00/11] LSM: Stacking for major security modules
In-Reply-To: <1491511104.4532.17.camel@tycho.nsa.gov>
References: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
	<1491503171.4532.10.camel@tycho.nsa.gov>
	<c6d9da56-fd4d-e8e5-caa5-718de74db261@schaufler-ca.com>
	<1491511104.4532.17.camel@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.20.1704070758310.27111@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 6 Apr 2017, Stephen Smalley wrote:

> Yes, but in the meantime, if you want to be able to test
> CONFIG_SECURITY_STACKING=y with modules in enforcing mode on
> distributions that enable a major security module, it seems like you
> need to provide some way of handling this compatibly.

Regardless of the config option, we can't break existing userspace. This 
is a long-standing Linux kernel development rule.

You'll need to implement new interfaces for any changes.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
