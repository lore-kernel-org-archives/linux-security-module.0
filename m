From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Sun, 11 Feb 2018 04:01:25 +0200
Subject: [PATCH 2/6] genalloc: selftest
In-Reply-To: <201802080423.jTtuTsUK%fengguang.wu@intel.com>
References: <20180204164732.28241-3-igor.stoppa@huawei.com>
	<201802080423.jTtuTsUK%fengguang.wu@intel.com>
Message-ID: <78f8d652-220f-05e9-ed69-39108517531c@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 07/02/18 22:25, kbuild test robot wrote:

[...]

>>> lib/genalloc-selftest.c:17:10: fatal error: asm/set_memory.h: No such file or directory
>     #include <asm/set_memory.h>

This header is unnecessary and will be removed.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
