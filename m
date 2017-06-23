From: john.johansen@canonical.com (John Johansen)
Date: Thu, 22 Jun 2017 21:32:01 -0700
Subject: The secmark "one user" policy
In-Reply-To: <alpine.LRH.2.20.1706231257140.17128@namei.org>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<alpine.LRH.2.20.1706221937410.20196@namei.org>
	<3baf4aae-6268-356b-8545-30655f561192@canonical.com>
	<alpine.LRH.2.20.1706231257140.17128@namei.org>
Message-ID: <77bb65a4-d07e-7e92-2f80-d157833c07e8@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/22/2017 08:02 PM, James Morris wrote:
> On Thu, 22 Jun 2017, John Johansen wrote:
> 
>>> Trying to stack major LSMs arbitrarily and exposing that to userland is an 
>>> architectural mess, which is what these kinds of problems are really 
>>> telling us.
>>>
>>
>> The use case I keep seeing is not exposing multiple LSMs to the user
>> space. Its the container where the container wants a different LSM
>> than the system is running.
>>
>> Stacking 2 LSMs in that case and only exposing one to user space isn't
>> so unreasonable.
> 
> In this case, would they both be labeling LSMs which need to label 
> packets?
> 
> I can imagine having Smack or SELinux as the base LSM and then having 
> AppArmor in the container, but having Smack and SELinux in that 
> combination would still not make sense to me.
> 

I don't see why not. The container could be built expecting smack
labeling, selinux applies 1 or just a few labels to the whole
container, and accesses within the container are mediated fine grained
with smack.

If you are talking system containers like LXC/D this makes even more
sense, your running selinux on the host and the container is using smack
or AppArmor.

It does mean you would have to do some namespacing of some sort so that
the interface would know which LSM to multiplex to. Tasks in the container
write to smack or apparmor, system tasks get selinux.

selinux still gets to enforce a system policy even on the container as
it does today, and the other LSM applies policy as if the container is
the system (at least for system containers).

>>
>>> How can a user be expected to reason about a system which is running 
>>> multiple independent MAC security models simultaneously?  It's a terrible 
>>> idea.
>>>
>>
>> At a generic system MAC level I agree, but not all LSMs that need
>> state are MACs and in the more limited container case it isn't so
>> unreasonable.
> 
> Can you provide a concrete example of needing two independent packet 
> labeling LSMs?
> 

System containers come to mind, as mentioned above. Take an Ubuntu LXC
container and run it on fedora or RHEL. While apparmor isn't doing
packet label yet, patches for that should float up to the list soon,
and really it doesn't have to be ubuntu/apparmor the container guys
want to be a replacement for virtualization, allowing you to run
applications from different OSes on the same host.

You could take the same basic situation of an LXC container built
expecting smack and run it on fedora/RHEL with selinux enforcing for
the host. Except it isn't currently supported.

Right now LXC is limited as to what it can do with the MAC system in
the container. It can currently stack an apparmor host with an
apparmor guest each applying their own policy, but I know they would
love to be mix and match MAC systems, getting them closer to being a
replacement for virtualization. Again it could be argued that going
full virtualization is a better solution if you want different MAC
systems but people will choose (currently are choosing) to run the
container without a MAC instead of going with virtualization.

Another use case would be running snappy packages (chosen because it
is using apparmor to enforce some things, but same could be done with
flatpak if/when it starts using an LSM) on fedora. Currently you have
to either boot the system into apparmor (disabling selinux) or disable
part of the applications mediation. Again yes apparmor doesn't label
packets today but it will soon.

A little more speculatively another potential example would be an LSM
doing a personal firewalls around individual applications. Its really
very similar to the snappy/flatpak sandboxing of apps but maybe
someone wants that with out the additional baggage of a bigger LSM.
Whether it would ever get in upstream is a separate question.

I think we are just starting to scratch the surface of how stacking
will be used. Especially with all the different container/sandboxing
that is going on, and projects like flatpak and snappy pushing to be
system agnostic.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
