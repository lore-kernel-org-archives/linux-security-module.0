From: jmorris@namei.org (James Morris)
Date: Thu, 22 Jun 2017 19:54:47 +1000 (AEST)
Subject: The secmark "one user" policy
In-Reply-To: <2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
Message-ID: <alpine.LRH.2.20.1706221937410.20196@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 21 Jun 2017, Casey Schaufler wrote:

> Ideally there would be a separate secmark for each security
> module that wants to use the mechanism. Mechanism would be
> provided* so that user-space can identify which security
> module it is referring to when interacting with the kernel.
> My understanding is that we're unlikely to get an expanded
> secmark, so I have concentrated elsewhere.

I don't see us getting an expanded secmark, either.

> 
> A "clever" secid mapping takes the secids from all the
> security modules and gently manipulates them until they
> fit into a single u32. This might be an index into a list
> of secid sets, but if you have two modules using secids
> you can give each half of the secmark and accommodate
> many configurations, including Fedora. Again, you need
> mechanism* for user-space. This option would require changes
> to the xt_SECMARK implementation, which goes out of it's
> way to ensure all secmarks come from the same security
> module. One option is to add a SECMARK_MODE_COMPOUND, but
> that isn't any more helpful then removing the restriction.

This sounds very ugly, and each user may assume it has 32 bits of secmark.

> As for configuration options, SELinux only uses secmarks
> when user-space introduces them. If netfilter doesn't have
> any security rules that add secmarks, none are used. Smack
> can be configured to set secmarks on all packets, with the
> potential for change by user-space, but can also be set up
> without any use of secmarks. There doesn't need to be any
> significant change to xt_SECMARK if it is important to
> maintain the "one user" model. Requiring that the user-space
> use of netfilter be sane for the multiple security module
> case (e.g. don't use SELinux firewall if Smack has the
> secmark) seems somewhat reasonable.

Reasonable?  I don't think so.  

Trying to stack major LSMs arbitrarily and exposing that to userland is an 
architectural mess, which is what these kinds of problems are really 
telling us.

How can a user be expected to reason about a system which is running 
multiple independent MAC security models simultaneously?  It's a terrible 
idea.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
