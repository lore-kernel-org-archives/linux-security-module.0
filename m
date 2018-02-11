From: rdunlap@infradead.org (Randy Dunlap)
Date: Sun, 11 Feb 2018 12:27:14 -0800
Subject: [PATCH 2/6] genalloc: selftest
In-Reply-To: <CAOFm3uGNVu87qYzPufu+gGbTwuhp3cjfhKuNDkcmwn3+ysKTdg@mail.gmail.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
	<20180211031920.3424-3-igor.stoppa@huawei.com>
	<CAOFm3uGNVu87qYzPufu+gGbTwuhp3cjfhKuNDkcmwn3+ysKTdg@mail.gmail.com>
Message-ID: <f95a064d-75e9-6ff3-2c11-4158a0ad1ca9@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 02/11/18 12:22, Philippe Ombredanne wrote:
> On Sun, Feb 11, 2018 at 4:19 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>> Introduce a set of macros for writing concise test cases for genalloc.
>>
>> The test cases are meant to provide regression testing, when working on
>> new functionality for genalloc.
>>
>> Primarily they are meant to confirm that the various allocation strategy
>> will continue to work as expected.
>>
>> The execution of the self testing is controlled through a Kconfig option.
>>
>> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> 
> <snip>
> 
>> --- /dev/null
>> +++ b/include/linux/genalloc-selftest.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0
> 
> nit... For a comment in .h this line should be instead its own comment
> as the first line:
>> +/* SPDX-License-Identifier: GPL-2.0 */

Why are we treating header files (.h) differently than .c files?
Either one can use the C++ "//" comment syntax.

> <snip>
> 
>> --- /dev/null
>> +++ b/lib/genalloc-selftest.c
>> @@ -0,0 +1,400 @@
>> +/* SPDX-License-Identifier: GPL-2.0
> 
> And for a comment in .c this line should use C++ style as the first line:
> 
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Please check the docs for this (I know this can feel surprising but
> this has been debated at great length on list)
> 
> Thank you!
> 


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
