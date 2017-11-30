From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 30 Nov 2017 03:05:58 +0100
Subject: [PATCH v5 next 2/5] modules:capabilities: add
	cap_kernel_module_request() permission check
In-Reply-To: <1511803118-2552-3-git-send-email-tixxdz@gmail.com>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<1511803118-2552-3-git-send-email-tixxdz@gmail.com>
Message-ID: <20171130020558.GA729@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Nov 27, 2017 at 06:18:35PM +0100, Djalal Harouni wrote:
> +/* Determine whether a module auto-load operation is permitted. */
> +int may_autoload_module(char *kmod_name, int required_cap,
> +			const char *kmod_prefix);
> +

While we are reviewing a general LSM for this, it has me wondering if an LSM or
userspace feed info may every want to use other possible context we could add for
free to make a determination.

For instance since all request_module() calls are in header files, we could 
for add for free THIS_MODULE as context to may_autoload_module() as well, so
struct module. The LSM could in theory then also help ensure only specific
modules are allowed to request a module load. Perhaps userspace could say
only built-in code could request certain modules.

Just a thought.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
