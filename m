From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Thu, 15 Mar 2018 15:43:49 +0200
Subject: [RFC PATCH v19 0/8] mm: security: ro protection for dynamic data
In-Reply-To: <20180314173343.GJ29631@bombadil.infradead.org>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
	<a9bfc57f-1591-21b6-1676-b60341a2fadd@huawei.com>
	<20180314115653.GD29631@bombadil.infradead.org>
	<8623382b-cdbe-8862-8c2f-fa5bc6a1213a@huawei.com>
	<20180314130418.GG29631@bombadil.infradead.org>
	<9623b0d1-4ace-b3e7-b861-edba03b8a8cd@huawei.com>
	<20180314173343.GJ29631@bombadil.infradead.org>
Message-ID: <fc984bf4-c46a-976c-ec74-ad89dc3d150e@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 14/03/2018 19:33, Matthew Wilcox wrote:
> On Wed, Mar 14, 2018 at 06:11:22PM +0200, Igor Stoppa wrote:

[...]

>> Probably page_frag does well with relatively large allocations, while
>> genalloc seems to be better for small (few allocation units) allocations.
> 
> I don't understand why you would think that.  If you allocate 4096 1-byte
> elements, page_frag will just use up a page.  Doing the same thing with
> genalloc requires allocating two bits per byte (1kB of bitmap), plus
> other overheads.

I had misunderstood the amount of page_frag structures needed.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
