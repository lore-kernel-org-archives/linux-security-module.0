From: cl@linux.com (Christopher Lameter)
Date: Mon, 5 Feb 2018 09:33:15 -0600 (CST)
Subject: [PATCH 3/6] struct page: add field for vm_struct
In-Reply-To: <a12afe9b-79cf-d5c1-3795-89fbf61c6c9d@huawei.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
	<20180130151446.24698-4-igor.stoppa@huawei.com>
	<alpine.DEB.2.20.1801311758340.21272@nuc-kabylake>
	<48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
	<alpine.DEB.2.20.1802021240370.31548@nuc-kabylake>
	<a12afe9b-79cf-d5c1-3795-89fbf61c6c9d@huawei.com>
Message-ID: <alpine.DEB.2.20.1802050931190.10647@nuc-kabylake>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 3 Feb 2018, Igor Stoppa wrote:

> - the property of the compound page will affect the property of all the
> pages in the compound, so when one is write protected, it can generate a
> lot of wasted memory, if there is too much slack (because of the order)
> With vmalloc, I can allocate any number of pages, minimizing the waste.

I thought the intend here is to create a pool where the whole pool becomes
RO?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
