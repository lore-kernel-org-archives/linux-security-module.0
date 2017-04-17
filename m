From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 17 Apr 2017 08:50:55 +0200
Subject: [PATCH 1/4] added SECURITY_TIOCSTI_RESTRICT kernel config
In-Reply-To: <20170417060706.28674-2-matt@nmatt.com>
References: <20170417060706.28674-1-matt@nmatt.com>
	<20170417060706.28674-2-matt@nmatt.com>
Message-ID: <20170417065055.GA21022@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 17, 2017 at 02:07:03AM -0400, Matt Brown wrote:
> adding the kernel config SECURITY_TIOCSTI_RESTRICT in order to allow
> the user to restrict unprivileged command injection using TIOCSTI
> tty ioctls

"unpriviledged command injection"?  That sounds a bit "odd", don't you
think?

> 
> Signed-off-by: Matt Brown <matt@nmatt.com>
> ---
>  security/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 3ff1bf9..d757bcb 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -18,6 +18,18 @@ config SECURITY_DMESG_RESTRICT
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config SECURITY_TIOCSTI_RESTRICT
> +        bool "Restrict unprivileged use of tiocsti command injection"
> +        default n
> +        help
> +	  This enforces restrictions on unprivileged users injecting commands
> +	  into other processes in the same tty session using the TIOCSTI ioctl

Tabs and spaces?

Since tty sessions are usually separated by different users, how would
they have the same one and yet need something like this?

Also, why not put this in the tty config section?

And finally, this patch on its own doesn't do anything :(

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
