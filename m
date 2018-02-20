From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Tue, 20 Feb 2018 18:40:04 +0200
Subject: [PATCH 5/6] Pmalloc: self-test
In-Reply-To: <CAGXu5j+ZZkgLzsxcwAYgyu=A=11Fkeuj+F_8gCUAbXDmjWFdeg@mail.gmail.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
	<20180212165301.17933-6-igor.stoppa@huawei.com>
	<CAGXu5j+ZZkgLzsxcwAYgyu=A=11Fkeuj+F_8gCUAbXDmjWFdeg@mail.gmail.com>
Message-ID: <bd11826b-f3c1-be03-895c-85c08a149045@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On 13/02/18 01:43, Kees Cook wrote:
> On Mon, Feb 12, 2018 at 8:53 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>> +obj-$(CONFIG_PROTECTABLE_MEMORY_SELFTEST) += pmalloc-selftest.o
> 
> Nit: self-test modules are traditionally named "test_$thing.o"
> (outside of the tools/ directory).

ok

[...]

> I wonder if lkdtm should grow a test too, to validate the RO-ness of
> the allocations at the right time in API usage?

sorry for being dense ... are you proposing that I do something to
lkdtm_rodata.c ? An example would probably help me understand.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
