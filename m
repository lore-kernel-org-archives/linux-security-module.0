From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 16 May 2018 10:42:56 -0700
Subject: [PATCH 00/23] LSM: Full security module stacking
In-Reply-To: <alpine.LRH.2.21.1805160747300.8368@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
	<523afc0b-5bfc-8b95-05ee-450679254a47@tycho.nsa.gov>
	<5716ab22-4d3c-1935-41f1-ba848570ccab@tycho.nsa.gov>
	<eab001ca-10ff-1cfe-9436-805840628784@schaufler-ca.com>
	<5db90fec-7640-73d5-2e96-b4c996b7ae8d@tycho.nsa.gov>
	<ad30d628-ed11-2dd6-6782-3089bf733702@schaufler-ca.com>
	<alpine.LRH.2.21.1805160747300.8368@namei.org>
Message-ID: <77dbe49f-b0fc-5b58-f8c2-a87db6b00ebc@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/15/2018 2:49 PM, James Morris wrote:
> On Tue, 15 May 2018, Casey Schaufler wrote:
>
>> Both SELinux and Smack use netlbl_sock_setattr() in their socket_post_create()
>> hooks to establish the CIPSO to use if nothing else interferes. An unfortunate
>> artifact of the Smack "ambient label" implementation is that the default
>> configuration is going to delete the netlbl attribute for the floor ("_")
>> label. This will conflict with any value that SELinux sets. :( Smack clearly
>> needs to have it's use of netlabel revised, and that is work that's going on
>> in parallel with stacking. That, however, is not an infrastructure issue, it's
>> an issue with how the two modules use the facilities.
> Can this kind of problem be prevented at the API level?  i.e. ensure you 
> can't accidentally conflict with another LSM's use of the label here?

What we're seeing isn't an accidental conflict. SELinux and Smack
use netlabel differently. SELinux uses netlabel the way it and the
way CIPSO intended, to mark the MLS levels and categories on a
packet. Smack (ab)uses netlabel to put the Smack label directly on
the packet. In most cases a SELinux system won't be sending a CIPSO
header at all, because it won't be using MLS. A Smack system, on
the other hand, sends a CIPSO header unless the label is the
"ambient" label. Further, the label transitions for a process using
both SELinux and Smack will be different. Two system services may
have different SELinux contexts but the same Smack label.

The Smack code clearly needs to be revised. It does a horrible job
on single-level hosts. It works, but does not take advantage of the
netlabel facilities well. The ambient label processing is pretty
kludgey. If the Smack use of netlabel were more in line with the
SELinux model I expect there would be more cases where they work
together. But even in the best case, it's going to take some real
configuration wizardry to get a lot of agreement on packet labeling.

I'm not saying that API level changes wouldn't be welcome. I would
be happier if the networking code called security hooks like the
other subsystems do. I also understand that there are critical
performance issues that drove the existing implementation, and that
a call to security_label_packet() in the IP stack could be a hard
sell.
?


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
