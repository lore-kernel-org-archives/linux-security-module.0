From: jmorris@namei.org (James Morris)
Date: Fri, 23 Jun 2017 13:02:10 +1000 (AEST)
Subject: The secmark "one user" policy
In-Reply-To: <3baf4aae-6268-356b-8545-30655f561192@canonical.com>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<alpine.LRH.2.20.1706221937410.20196@namei.org>
	<3baf4aae-6268-356b-8545-30655f561192@canonical.com>
Message-ID: <alpine.LRH.2.20.1706231257140.17128@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 22 Jun 2017, John Johansen wrote:

> > Trying to stack major LSMs arbitrarily and exposing that to userland is an 
> > architectural mess, which is what these kinds of problems are really 
> > telling us.
> > 
> 
> The use case I keep seeing is not exposing multiple LSMs to the user
> space. Its the container where the container wants a different LSM
> than the system is running.
> 
> Stacking 2 LSMs in that case and only exposing one to user space isn't
> so unreasonable.

In this case, would they both be labeling LSMs which need to label 
packets?

I can imagine having Smack or SELinux as the base LSM and then having 
AppArmor in the container, but having Smack and SELinux in that 
combination would still not make sense to me.

> 
> > How can a user be expected to reason about a system which is running 
> > multiple independent MAC security models simultaneously?  It's a terrible 
> > idea.
> > 
> 
> At a generic system MAC level I agree, but not all LSMs that need
> state are MACs and in the more limited container case it isn't so
> unreasonable.

Can you provide a concrete example of needing two independent packet 
labeling LSMs?


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
