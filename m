From: igor.stoppa@gmail.com (Igor Stoppa)
Date: Tue, 24 Apr 2018 16:39:11 +0400
Subject: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
In-Reply-To: <eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
	<20180423125458.5338-8-igor.stoppa@huawei.com>
	<20180424115050.GD26636@bombadil.infradead.org>
	<eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
Message-ID: <c5344284-f205-8465-0b04-f6da96e21609@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 24/04/18 16:32, lazytyped wrote:
> 
> 
> On 4/24/18 1:50 PM, Matthew Wilcox wrote:
>> struct modifiable_data {
>> 	struct immutable_data *d;
>> 	...
>> };
>>
>> Then allocate a new pool, change d and destroy the old pool.
> 
> With the above, you have just shifted the target of the arbitrary write
> from the immutable data itself to the pointer to the immutable data, so
> got no security benefit.
> 
> The goal of the patch is to reduce the window when stuff is writeable,
> so that an arbitrary write is likely to hit the time when data is read-only.

Indeed, that was my - poorly explained, I admit it - idea.

For example, that's the reason why I am remapping one page at a time in 
a loop, instead of doing the whole array, to limit exposure and increase 
randomness.

WRT the implementation, I'm sure there are bugs that need squashing.

But if I have overlooked some aspect in the overall design, I need 
guidance, because i still do not see what I am missing :-(

--
igor

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
