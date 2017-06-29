From: john.johansen@canonical.com (John Johansen)
Date: Thu, 29 Jun 2017 09:46:39 -0700
Subject: The secmark "one user" policy
In-Reply-To: <alpine.LRH.2.20.1706291826200.3111@namei.org>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<alpine.LRH.2.20.1706221937410.20196@namei.org>
	<3baf4aae-6268-356b-8545-30655f561192@canonical.com>
	<alpine.LRH.2.20.1706231257140.17128@namei.org>
	<77bb65a4-d07e-7e92-2f80-d157833c07e8@canonical.com>
	<alpine.LRH.2.20.1706291826200.3111@namei.org>
Message-ID: <b37e1e12-9e64-8772-c15d-0ac64756fa7d@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/29/2017 02:10 AM, James Morris wrote:
> On Thu, 22 Jun 2017, John Johansen wrote:
> 
>> I don't see why not. The container could be built expecting smack
>> labeling, selinux applies 1 or just a few labels to the whole
>> container, and accesses within the container are mediated fine grained
>> with smack.
> 
> This would require that all LSM-tagged objects and subjects be namespaced, 
> correct?  If there is some way that a mediation happens across the 
> container boundary, things could get confusing (e.g. Smack policy not 
> seeming to allow things which SELinux is in fact denying).
> 
> Note also that LSM and namespaces are not abstracted in identical ways, so 
> we would need to know what it it means for LSM policy when say networking 
> is namespaced but not mounts.  Or how to deal with shared subtrees.
> 
> Namespacing of LSM is probably the more fundamental issue to be resolved.
> 

Yes namespacing of LSMs is an open issue that needs to be solved, and
probably would be needed for the selinux, and smack case, or apparmor
system + (selinux/smack container) but would not be needed for the
(selinux/smack system) + apparmor container case. Stacking should be
sufficient today because apparmor internally supports stacking and
namespacing of it self.  ie. system apparmor + container with a
different apparmor policy

With Casey's stacking patches today we can do an selinux host with an
apparmor container by having selinux do regular enforcement and
setting the system apparmor policy to unconfined.  The container is
then setup to use an apparmor policy namespace. Permissions for the
host are determined by selinux and in the container by the
intersection of what is granted by the selinux system policy and what
is allowed by the apparmor policy in the container.

But we run into problems with networking as soon as apparmor's support
for secmark lands.

> 
>> A little more speculatively another potential example would be an LSM
>> doing a personal firewalls around individual applications. Its really
>> very similar to the snappy/flatpak sandboxing of apps but maybe
>> someone wants that with out the additional baggage of a bigger LSM.
>> Whether it would ever get in upstream is a separate question.
> 
> Landlock shows promise here, and stacking it inside one of the major MAC 
> LSMs seems to make sense.
> 

agreed Landlock is promising here


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
