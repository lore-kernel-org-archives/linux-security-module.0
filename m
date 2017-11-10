From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 10 Nov 2017 15:13:32 -0500
Subject: [RFC PATCH] fw_lockdown: new micro LSM module to prevent
	loading unsigned firmware
In-Reply-To: <1510336703.3404.17.camel@linux.vnet.ibm.com>
References: <1510336703.3404.17.camel@linux.vnet.ibm.com>
Message-ID: <1510344812.3404.28.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-11-10 at 12:58 -0500, Mimi Zohar wrote:
> 
> +
> +static struct security_hook_list fw_lockdown_hooks[] = {
> +	LSM_HOOK_INIT(fw_lockdown_file_check, fw_lockdown_bprm_check)

Sigh, that should have be:
	LSM_HOOK_INIT(kernel_read_file, fw_lockdown_read_file)

> +};

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
