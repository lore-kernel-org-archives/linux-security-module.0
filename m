From: jmorris@namei.org (James Morris)
Date: Wed, 30 Aug 2017 17:28:44 +1000 (AEST)
Subject: [PATCH 06/11] LSM: general but not extreme module stacking
In-Reply-To: <d4e17ec1-c364-6b87-52e7-bfcdfba92843@schaufler-ca.com>
References: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
	<d4e17ec1-c364-6b87-52e7-bfcdfba92843@schaufler-ca.com>
Message-ID: <alpine.LRH.2.20.1708301724350.18929@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 29 Aug 2017, Casey Schaufler wrote:

> +	config SECURITY_SELINUX_STACKED
> +		bool "SELinux" if SECURITY_SELINUX=y
> +	help
> +	  Add the SELinux security module to the stack. At this
> +	  time the Smack security module is incompatible with this
> +	  module.
> +	  Please be sure your user space code is accomodating of
> +	  this security module.
> +
> +	config SECURITY_SMACK_STACKED
> +		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
> +	help
> +	  Add the Smack security module to the stack. At this
> +	  time the SELinux security module is incompatible with this
> +	  module.
> +	  Please be sure your user space code is accomodating of
> +	  this security module.
> +
> +	config SECURITY_NOTHING_STACKED
> +		bool "Use no 'extreme' security module"
> +	help
> +	  Add neither the SELinux security module nor the Smack security
> +	  module to the stack.
> +	  Please be sure your user space code does not require either of
> +	  these security modules.
> +

These help texts are likely to be confusing.  e.g. "the stack" usually 
refers to a kernel or task stack, and which "user space code" needs what 
exactly?

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
