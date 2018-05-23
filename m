From: corbet@lwn.net (Jonathan Corbet)
Date: Wed, 23 May 2018 07:39:17 -0600
Subject: [PATCH 6/6] Drop flex_arrays
In-Reply-To: <20180523011821.12165-6-kent.overstreet@gmail.com>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
	<20180523011821.12165-6-kent.overstreet@gmail.com>
Message-ID: <20180523073917.618db21a@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 22 May 2018 21:18:21 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> All existing users have been converted to generic radix trees
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  Documentation/core-api/flexible-arrays.rst | 130 -------
>  Documentation/flexible-arrays.txt          | 123 -------
>  include/linux/flex_array.h                 | 149 --------
>  include/linux/poison.h                     |   3 -
>  lib/Makefile                               |   2 +-
>  lib/flex_array.c                           | 398 ---------------------
>  tools/include/linux/poison.h               |   3 -
>  7 files changed, 1 insertion(+), 807 deletions(-)
>  delete mode 100644 Documentation/core-api/flexible-arrays.rst
>  delete mode 100644 Documentation/flexible-arrays.txt
>  delete mode 100644 include/linux/flex_array.h
>  delete mode 100644 lib/flex_array.c

Interesting, I didn't realize that flexible-arrays.txt was still there;
that should go regardless (and 00-INDEX adjusted accordingly).  If you zap
the RST file, though, you should also fix Documentation/core-api/index.rst
or you'll break the docs build.

Thanks,

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
