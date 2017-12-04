From: eduval@amazon.com (Eduardo Valentin)
Date: Mon, 4 Dec 2017 11:21:23 -0800
Subject: [PATCH] treewide: remove duplicate includes
In-Reply-To: <1512337779-16842-1-git-send-email-pravin.shedge4linux@gmail.com>
References: <1512337779-16842-1-git-send-email-pravin.shedge4linux@gmail.com>
Message-ID: <20171204192123.GA1463@u40b0340c692b58f6553c.ant.amazon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello,

On Mon, Dec 04, 2017 at 03:19:39AM +0530, Pravin Shedge wrote:
<cut>

> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index d04ec3b..e09f035 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -30,7 +30,6 @@
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/string.h>
> -#include <linux/thermal.h>
>  
>  #include "thermal_core.h"
>  

No issues with this but,

Please send a separate patch to linux-pm at vger.kernel.org and copy edubezva at gmail.com

thanks,

-- 
All the best,
Eduardo Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
