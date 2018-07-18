From: jmorris@namei.org (James Morris)
Date: Wed, 18 Jul 2018 14:28:27 +1000 (AEST)
Subject: [PATCH] security: export security_kernel_load_data function
In-Reply-To: <20180717202355.2119407-1-arnd@arndb.de>
References: <20180717202355.2119407-1-arnd@arndb.de>
Message-ID: <alpine.LRH.2.21.1807181428110.20653@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 17 Jul 2018, Arnd Bergmann wrote:

> The firmware_loader can be built as a loadable module, which now
> fails when CONFIG_SECURITY is enabled, because a call to the
> security_kernel_load_data() function got added, and this is
> not exported to modules:
> 
> ERROR: "security_kernel_load_data" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> 
> Add an EXPORT_SYMBOL_GPL() to make it available here.
> 
> Fixes: 6e852651f28e ("firmware: add call to LSM hook before firmware sysfs fallback")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
