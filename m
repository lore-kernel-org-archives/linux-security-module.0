From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Thu, 19 Jul 2018 12:05:02 -0700
Subject: [PATCH] tpm: add support for partial reads
In-Reply-To: <1532026030.3198.2.camel@HansenPartnership.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
	<1532020750.5396.4.camel@HansenPartnership.com>
	<421c4b75-9e9d-7045-adad-797fd112898a@intel.com>
	<1532026030.3198.2.camel@HansenPartnership.com>
Message-ID: <e8c17a40-7e5e-61e9-7088-32817766b614@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/19/2018 11:47 AM, James Bottomley wrote:
> On Thu, 2018-07-19 at 10:54 -0700, Tadeusz Struk wrote:
>> On 07/19/2018 10:19 AM, James Bottomley wrote:
>>> That's just an implementation, though, what's the use case?
>>
>> Hi James,
>> The use case is described in the TCTI spec [1] in the
>> "3.2.5.2 receive" section.
> 
> Well, yes, but I think we've all agreed that the /dev/tpm and
> /dev/tpmrmX aren't TCTI interfaces, although you can layer TCTI on top
> of them, so why not simply do fragmentation on top if you need it?
> 
> The reason for not doing it in the interface is that it alters the ABI.
>  Before this patch we had a hard packet boundary: one packet per read,
> one per write and a -EFAULT if you fail to provide a correctly sized
> buffer.  Now if you provide a buffer too small but don't know about the
> fragmentation you're going to misprocess a packet (because you think
> you got a whole reply but you didn't) and then you get a -EBUSY on your
> next command which you don't know how to handle.  The only way out is
> to update the applications to handle the new behaviour, which is a no-
> no in Linux ABI terms.

Don't all the existing applications that read a response in one go
do a 4K read now? So nothing will change for them. They will work
exactly the same with this change as they do without it.
This doesn't break the ABI.

> 
> It might be possible to layer the behaviour you want compatibly into
> the current device structure (say an ioctl to switch to the fragment
> behaviour) but I've got to ask why we'd go to the complexity without a
> use case?

New IOCTL would add extra complexity, which isn't necessary.

Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
