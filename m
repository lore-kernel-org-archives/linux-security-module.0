From: willy@infradead.org (Matthew Wilcox)
Date: Sun, 11 Feb 2018 13:01:57 -0800
Subject: [PATCH 2/6] genalloc: selftest
In-Reply-To: <f95a064d-75e9-6ff3-2c11-4158a0ad1ca9@infradead.org>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
	<20180211031920.3424-3-igor.stoppa@huawei.com>
	<CAOFm3uGNVu87qYzPufu+gGbTwuhp3cjfhKuNDkcmwn3+ysKTdg@mail.gmail.com>
	<f95a064d-75e9-6ff3-2c11-4158a0ad1ca9@infradead.org>
Message-ID: <20180211210157.GB4680@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Feb 11, 2018 at 12:27:14PM -0800, Randy Dunlap wrote:
> On 02/11/18 12:22, Philippe Ombredanne wrote:
> > nit... For a comment in .h this line should be instead its own comment
> > as the first line:
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Why are we treating header files (.h) differently than .c files?
> Either one can use the C++ "//" comment syntax.

This is now documented!

Documentation/process/license-rules.rst:

   If a specific tool cannot handle the standard comment style, then the
   appropriate comment mechanism which the tool accepts shall be used. This
   is the reason for having the "/\* \*/" style comment in C header
   files. There was build breakage observed with generated .lds files where
   'ld' failed to parse the C++ comment. This has been fixed by now, but
   there are still older assembler tools which cannot handle C++ style
   comments.

Personally, I find this disappointing.  I find this:

// SPDX-License-Identifier: GPL-2.0+
/*
 * XArray implementation
 * Copyright (c) 2017 Microsoft Corporation
 * Author: Matthew Wilcox <mawilcox@microsoft.com>
 */

much less visually appealling than

/*
 * XArray implementation
 * Copyright (c) 2017 Microsoft Corporation
 * Author: Matthew Wilcox <mawilcox@microsoft.com>
 * SPDX-License-Identifier: GPL-2.0+
 */

I can't see this variation making a tag extraction tool harder to write.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
