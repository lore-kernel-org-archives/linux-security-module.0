From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Sun, 11 Feb 2018 21:22:34 +0100
Subject: [PATCH 2/6] genalloc: selftest
In-Reply-To: <20180211031920.3424-3-igor.stoppa@huawei.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
	<20180211031920.3424-3-igor.stoppa@huawei.com>
Message-ID: <CAOFm3uGNVu87qYzPufu+gGbTwuhp3cjfhKuNDkcmwn3+ysKTdg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Feb 11, 2018 at 4:19 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> Introduce a set of macros for writing concise test cases for genalloc.
>
> The test cases are meant to provide regression testing, when working on
> new functionality for genalloc.
>
> Primarily they are meant to confirm that the various allocation strategy
> will continue to work as expected.
>
> The execution of the self testing is controlled through a Kconfig option.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

<snip>

> --- /dev/null
> +++ b/include/linux/genalloc-selftest.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0

nit... For a comment in .h this line should be instead its own comment
as the first line:
> +/* SPDX-License-Identifier: GPL-2.0 */

<snip>

> --- /dev/null
> +++ b/lib/genalloc-selftest.c
> @@ -0,0 +1,400 @@
> +/* SPDX-License-Identifier: GPL-2.0

And for a comment in .c this line should use C++ style as the first line:

> +// SPDX-License-Identifier: GPL-2.0

Please check the docs for this (I know this can feel surprising but
this has been debated at great length on list)

Thank you!
-- 
Cordially
Philippe Ombredanne
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
