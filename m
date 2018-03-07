From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Wed, 7 Mar 2018 12:51:46 +0200
Subject: [PATCH 1/7] genalloc: track beginning of allocations
In-Reply-To: <6d27845d-a8f3-607b-1b6b-8464de65162c@huawei.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
	<20180228200620.30026-2-igor.stoppa@huawei.com>
	<20180306141047.GB13722@bombadil.infradead.org>
	<6d27845d-a8f3-607b-1b6b-8464de65162c@huawei.com>
Message-ID: <a667773c-59fa-33d1-9621-16e702c1859f@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 06/03/18 18:05, Igor Stoppa wrote:
> On 06/03/2018 16:10, Matthew Wilcox wrote:

[...]

>> This seems unnecessarily complicated.
> 
> TBH it seemed to me a natural extension of the existing encoding :-)

BTW, to provide some background, this is where it begun:

http://www.openwall.com/lists/kernel-hardening/2017/08/18/4

Probably that comment about "keeping existing behavior and managing two
bitmaps locklessly" is what made me think of growing the 1-bit-per-unit
into a 1-word-per-unit.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
