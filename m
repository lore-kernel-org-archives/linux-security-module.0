From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 17 Apr 2017 08:51:29 +0200
Subject: [PATCH 2/4] add tiocsti_restrict variable
In-Reply-To: <20170417060706.28674-3-matt@nmatt.com>
References: <20170417060706.28674-1-matt@nmatt.com>
	<20170417060706.28674-3-matt@nmatt.com>
Message-ID: <20170417065129.GB21022@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 17, 2017 at 02:07:04AM -0400, Matt Brown wrote:
> adding extern variable tiocsti_restrict to allow it to be included
> in sysctl
> 
> Signed-off-by: Matt Brown <matt@nmatt.com>
> ---
>  include/linux/tty.h | 2 ++
>  1 file changed, 2 insertions(+)

I'm all for breaking up changes to be tiny logical pieces, but this is
really not needed.  Please make it "one logical feature" per patch.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
