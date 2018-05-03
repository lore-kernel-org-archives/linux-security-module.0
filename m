From: igor.stoppa@gmail.com (Igor Stoppa)
Date: Fri, 4 May 2018 01:52:29 +0400
Subject: Correct way to access the physmap? - Was: Re: [PATCH 7/9] Pmalloc
	Rare Write: modify selected pools
In-Reply-To: <20180424115050.GD26636@bombadil.infradead.org>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
	<20180423125458.5338-8-igor.stoppa@huawei.com>
	<20180424115050.GD26636@bombadil.infradead.org>
Message-ID: <035f2bba-ebb1-06a0-fb88-3d40f7e484a7@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 24/04/18 15:50, Matthew Wilcox wrote:
> On Mon, Apr 23, 2018 at 04:54:56PM +0400, Igor Stoppa wrote:
>> While the vanilla version of pmalloc provides support for permanently
>> transitioning between writable and read-only of a memory pool, this
>> patch seeks to support a separate class of data, which would still
>> benefit from write protection, most of the time, but it still needs to
>> be modifiable. Maybe very seldom, but still cannot be permanently marked
>> as read-only.
> 
> This seems like a horrible idea that basically makes this feature useless.
> I would say the right way to do this is to have:
> 
> struct modifiable_data {
> 	struct immutable_data *d;
> 	...
> };
> 
> Then allocate a new pool, change d and destroy the old pool.

At the end of the summit, we agreed that I would go through the physmap.

But I'm not sure of what is the correct way to access it :-/

Starting from a vmalloc address, say:

int *i = vmalloc(sizeof(int));

I can get its linear counterpart:

int *j = page_to_virt(vmalloc_to_page(i));

and the physical address:

int *k = virt_to_phys(j);

But how do I get to the physmap?

I did not find much about it, apart from papers that talk about specific 
hardcoded addresses, but I would expect that if there is any hardcoded 
constant, by now, it's hidden behind some macro.

What I have verified, so far, at least on qemu x86_64, is that 
protecting "i" will also make "j" unwritable.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
