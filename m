From: rob@landley.net (Rob Landley)
Date: Thu, 25 Jan 2018 20:40:25 -0600
Subject: [PATCH v2 11/15] gen_init_cpio: add newcx format
In-Reply-To: <1516850875-25066-12-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-12-git-send-email-takondra@cisco.com>
Message-ID: <b3451193-0666-d929-01f3-29d3872bd5d4@landley.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 01/24/2018 09:27 PM, Taras Kondratiuk wrote:
> diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> index 7a2a6d85345d..78a47a5bdcb1 100644
> --- a/usr/gen_init_cpio.c
> +++ b/usr/gen_init_cpio.c
> @@ -10,6 +10,7 @@
>  #include <errno.h>
>  #include <ctype.h>
>  #include <limits.h>
> +#include <assert.h>

You're adding an assert? Really?

>  	fputs(s, stdout);
> -	offset += 110;
> +	assert((offset & 3) == 0);
> +	offset += cpio_hdr_size;

Why?

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
