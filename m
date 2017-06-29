From: jmorris@namei.org (James Morris)
Date: Thu, 29 Jun 2017 19:10:52 +1000 (AEST)
Subject: The secmark "one user" policy
In-Reply-To: <77bb65a4-d07e-7e92-2f80-d157833c07e8@canonical.com>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<alpine.LRH.2.20.1706221937410.20196@namei.org>
	<3baf4aae-6268-356b-8545-30655f561192@canonical.com>
	<alpine.LRH.2.20.1706231257140.17128@namei.org>
	<77bb65a4-d07e-7e92-2f80-d157833c07e8@canonical.com>
Message-ID: <alpine.LRH.2.20.1706291826200.3111@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 22 Jun 2017, John Johansen wrote:

> I don't see why not. The container could be built expecting smack
> labeling, selinux applies 1 or just a few labels to the whole
> container, and accesses within the container are mediated fine grained
> with smack.

This would require that all LSM-tagged objects and subjects be namespaced, 
correct?  If there is some way that a mediation happens across the 
container boundary, things could get confusing (e.g. Smack policy not 
seeming to allow things which SELinux is in fact denying).

Note also that LSM and namespaces are not abstracted in identical ways, so 
we would need to know what it it means for LSM policy when say networking 
is namespaced but not mounts.  Or how to deal with shared subtrees.

Namespacing of LSM is probably the more fundamental issue to be resolved.


> A little more speculatively another potential example would be an LSM
> doing a personal firewalls around individual applications. Its really
> very similar to the snappy/flatpak sandboxing of apps but maybe
> someone wants that with out the additional baggage of a bigger LSM.
> Whether it would ever get in upstream is a separate question.

Landlock shows promise here, and stacking it inside one of the major MAC 
LSMs seems to make sense.



-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
