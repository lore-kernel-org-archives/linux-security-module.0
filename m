From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 14 Mar 2018 05:25:12 -0700
Subject: [PATCH 6/8] Pmalloc selftest
In-Reply-To: <20180313214554.28521-7-igor.stoppa@huawei.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
	<20180313214554.28521-7-igor.stoppa@huawei.com>
Message-ID: <20180314122512.GF29631@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 13, 2018 at 11:45:52PM +0200, Igor Stoppa wrote:
> Add basic self-test functionality for pmalloc.

Here're some additional tests for your test-suite:

	for (i = 1; i; i *= 2)
		pzalloc(pool, i - 1, GFP_KERNEL);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
