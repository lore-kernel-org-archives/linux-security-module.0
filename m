From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Sun, 25 Mar 2018 04:32:57 +0300
Subject: [PATCH 6/8] Pmalloc selftest
In-Reply-To: <20180314122512.GF29631@bombadil.infradead.org>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
	<20180313214554.28521-7-igor.stoppa@huawei.com>
	<20180314122512.GF29631@bombadil.infradead.org>
Message-ID: <ce6e34a4-592d-624c-2353-20e50e321298@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 14/03/18 14:25, Matthew Wilcox wrote:
> On Tue, Mar 13, 2018 at 11:45:52PM +0200, Igor Stoppa wrote:
>> Add basic self-test functionality for pmalloc.
> 
> Here're some additional tests for your test-suite:
> 
> 	for (i = 1; i; i *= 2)
> 		pzalloc(pool, i - 1, GFP_KERNEL);
> 

Ok, I have almost finished the rewrite.
I still have to address this comment.

When I run the test, eventually the system runs out of memory, it keeps
getting allocation errors from vmalloc, until i finally overflows and
becomes 0.

Am I supposed to do something about it?
If pmalloc receives a request that the vmalloc backend cannot satisfy, I
would prefer that vmalloc itself produces the warning and pmalloc
returns NULL.

This doesn't look like a test case that one can leave always enabled in
a build, but maybe I'm missing the point.

--
igor

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
