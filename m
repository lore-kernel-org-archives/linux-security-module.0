From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Thu, 22 Feb 2018 11:01:09 +0200
Subject: [PATCH 5/6] Pmalloc: self-test
In-Reply-To: <CAGXu5j+ivd0Ys++6hqCjkipx8RFKTAmWf+KbtxEwT3SECD5C6A@mail.gmail.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
	<20180212165301.17933-6-igor.stoppa@huawei.com>
	<CAGXu5j+ZZkgLzsxcwAYgyu=A=11Fkeuj+F_8gCUAbXDmjWFdeg@mail.gmail.com>
	<bd11826b-f3c1-be03-895c-85c08a149045@huawei.com>
	<CAGXu5j+ivd0Ys++6hqCjkipx8RFKTAmWf+KbtxEwT3SECD5C6A@mail.gmail.com>
Message-ID: <cfe0dd48-2c72-cc4f-010b-a667648cad3b@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 22/02/18 00:24, Kees Cook wrote:
> On Tue, Feb 20, 2018 at 8:40 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>> sorry for being dense ... are you proposing that I do something to
>> lkdtm_rodata.c ? An example would probably help me understand.
> 
> It would likely live in lkdtm_perms.c (or maybe lkdtm_heap.c). Namely,
> use the pmalloc API and then attempt to write to a read-only variable
> in the pmalloc region (to prove that the permission adjustment
> actually happened). Likely a good example is
> lkdtm_WRITE_RO_AFTER_INIT().


ok, thanks for the explanation, I will do it

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
