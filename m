From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 22 Jun 2017 09:17:40 -0700
Subject: The secmark "one user" policy
In-Reply-To: <alpine.LRH.2.20.1706221937410.20196@namei.org>
References: <d256e588-fd3c-b981-6d55-6723b5615cc9@schaufler-ca.com>
	<alpine.LRH.2.20.1706211713010.1310@namei.org>
	<2fbe01aa-8f9b-37f0-f79a-e34dcd1d0705@schaufler-ca.com>
	<alpine.LRH.2.20.1706221937410.20196@namei.org>
Message-ID: <118c3a45-8587-5cb9-fcd8-5cd8ca63a779@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/22/2017 2:54 AM, James Morris wrote:
> On Wed, 21 Jun 2017, Casey Schaufler wrote:
>
>> Ideally there would be a separate secmark for each security
>> module that wants to use the mechanism. Mechanism would be
>> provided* so that user-space can identify which security
>> module it is referring to when interacting with the kernel.
>> My understanding is that we're unlikely to get an expanded
>> secmark, so I have concentrated elsewhere.
> I don't see us getting an expanded secmark, either.
>
>> A "clever" secid mapping takes the secids from all the
>> security modules and gently manipulates them until they
>> fit into a single u32. This might be an index into a list
>> of secid sets, but if you have two modules using secids
>> you can give each half of the secmark and accommodate
>> many configurations, including Fedora. Again, you need
>> mechanism* for user-space. This option would require changes
>> to the xt_SECMARK implementation, which goes out of it's
>> way to ensure all secmarks come from the same security
>> module. One option is to add a SECMARK_MODE_COMPOUND, but
>> that isn't any more helpful then removing the restriction.
> This sounds very ugly, and each user may assume it has 32 bits of secmark.

The "two in one" doesn't scale, as well as being ugly and limited.
An index scheme, where there's a table mapping N to 1 is at least
as ugly and will do horrible things to performance.

>> As for configuration options, SELinux only uses secmarks
>> when user-space introduces them. If netfilter doesn't have
>> any security rules that add secmarks, none are used. Smack
>> can be configured to set secmarks on all packets, with the
>> potential for change by user-space, but can also be set up
>> without any use of secmarks. There doesn't need to be any
>> significant change to xt_SECMARK if it is important to
>> maintain the "one user" model. Requiring that the user-space
>> use of netfilter be sane for the multiple security module
>> case (e.g. don't use SELinux firewall if Smack has the
>> secmark) seems somewhat reasonable.
> Reasonable?  I don't think so.  
>
> Trying to stack major LSMs arbitrarily and exposing that to userland is an 
> architectural mess,

I agree that it would be an administrative nightmare to produce
a viable combination of SELinux, Smack, AppArmor and/or TOMOYO.
I also agree that anyone who thinks it's a good idea to do so
should investigate further what they're trying to accomplish.

>  which is what these kinds of problems are really telling us.

James, I respect you greatly, but disagree with you completely.
The problems with secids and secmarks have nothing to do with
the complexity of administering policy. They are issues of an
architecture that doesn't scale beyond unity.

> How can a user be expected to reason about a system which is running 
> multiple independent MAC security models simultaneously?

The combination of SELinux, Smack, AppArmor and/or TOMOYO is not
the goal so much as the test case. MAC was the coolest possible
technology in 1990. We've implemented it. I don't see anyone doing
a new MAC implementation. I *do* see security modules that implement
other security models in the pipeline. Some of these need to maintain
state, which means using security blobs in the LSM architecture.
Some of these models will want to use secmarks to implement socket
based controls. If we can provide for SELinux+Smack* we can be
confident that we can support anything today's kids want to throw
at us. If we blow that off Linux won't be able to adapt to the
security needs of the future.

> It's a terrible idea.

As I keep saying, SELinux+Smack is not the point of
complete module stacking. SELinux combined with a time
based module, or Smack with Landlock and Tags is the
point. It's the future. The technical issues are the same.
That is why I persist in the effort to make the existing
modules stack together.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
