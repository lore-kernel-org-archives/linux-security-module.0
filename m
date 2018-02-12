From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Mon, 12 Feb 2018 15:41:57 +0200
Subject: [PATCH 4/6] Protectable Memory
In-Reply-To: <20180212125347.GE20737@rapoport-lnx>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
	<20180211031920.3424-5-igor.stoppa@huawei.com>
	<20180211123743.GC13931@rapoport-lnx>
	<e7ea02b4-3d43-9543-3d14-61c27e155042@huawei.com>
	<20180212114310.GD20737@rapoport-lnx>
	<20180212125347.GE20737@rapoport-lnx>
Message-ID: <68edadf0-2b23-eaeb-17de-884032f0b906@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 12/02/18 14:53, Mike Rapoport wrote:
> 'scripts/kernel-doc -v -none 

That has a quite interesting behavior.

I run it on genalloc.c while I am in the process of adding the brackets
to the function names in the kernel-doc description.

The brackets confuse the script and it fails to output the name of the
function in the log:

lib/genalloc.c:123: info: Scanning doc for get_bitmap_entry
lib/genalloc.c:139: info: Scanning doc for
lib/genalloc.c:152: info: Scanning doc for
lib/genalloc.c:164: info: Scanning doc for


The first function does not have the brackets.
The others do. So what should I do with the missing brackets?
Add them, according to the kernel docs, or leave them out?

I'd lean toward adding them.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
