From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Mon, 10 Jul 2017 18:15:53 +0300
Subject: [PATCH 1/3] Protectable memory support
In-Reply-To: <20170707184843.GA3113@redhat.com>
References: <20170705134628.3803-1-igor.stoppa@huawei.com>
	<20170705134628.3803-2-igor.stoppa@huawei.com>
	<20170706162742.GA2919@redhat.com>
	<1665fd00-5908-2399-577d-1972c7d1c63b@huawei.com>
	<20170707184843.GA3113@redhat.com>
Message-ID: <774d9fc1-4caf-a6c9-3693-a90b5b954645@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/07/17 21:48, Jerome Glisse wrote:

> I believe there is enough unuse field that for vmalloc pages that
> you should find one you can use. Just add some documentation in
> mm_types.h so people are aware of alternate use for the field you
> are using.


I ended up using page->private and the corresponding bit.
Because page-private is an opaque field, specifically reserved for the
allocator, I think it should not be necessary to modify mm_types.h

The reworked patch is here:
https://marc.info/?l=linux-mm&m=149969928920772&w=2

--
thanks, igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
