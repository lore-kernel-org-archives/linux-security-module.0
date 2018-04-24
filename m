From: igor.stoppa@gmail.com (Igor Stoppa)
Date: Tue, 24 Apr 2018 16:33:50 +0400
Subject: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
In-Reply-To: <20180424115050.GD26636@bombadil.infradead.org>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
	<20180423125458.5338-8-igor.stoppa@huawei.com>
	<20180424115050.GD26636@bombadil.infradead.org>
Message-ID: <98799559-121f-3d9d-343f-b22d30f21b6d@gmail.com>
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

I'm not sure I understand.

The pool, in the patchset, is a collection of related vm_areas.
What I would like to do is to modify some of the memory that has already 
been handed out as reference, in a way that the reference is not 
altered, nor it requires extensive rewites of  all, in place of he usual 
assignment.

Are you saying that my idea is fundamentally broken?
If yes, how to break it? :-)

If not, I need more coffee, pherhaps we can have a cup together later? :-)

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
