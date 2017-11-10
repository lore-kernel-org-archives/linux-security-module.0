From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 10 Nov 2017 14:45:53 -0800
Subject: [RFC PATCH v1] fw_lockdown: new micro LSM module to prevent
	loading unsigned firmware
In-Reply-To: <1510347775.3549.2.camel@linux.vnet.ibm.com>
References: <1510347775.3549.2.camel@linux.vnet.ibm.com>
Message-ID: <09acbde7-4516-dc81-430f-dcea9b00f19a@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/10/2017 1:02 PM, Mimi Zohar wrote:
> If the kernel is locked down and IMA-appraisal is not enabled, prevent
> loading of unsigned firmware.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>
> Changelog v1:
> - Lots of minor changes Kconfig, Makefile, fw_lsm.c for such a small patch
>
>  security/Kconfig              |  1 +
>  security/Makefile             |  2 ++
>  security/fw_lockdown/Kconfig  |  6 +++++
>  security/fw_lockdown/Makefile |  3 +++
>  security/fw_lockdown/fw_lsm.c | 51 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 63 insertions(+)
>  create mode 100644 security/fw_lockdown/Kconfig
>  create mode 100644 security/fw_lockdown/Makefile
>  create mode 100644 security/fw_lockdown/fw_lsm.c
>
> diff --git a/security/Kconfig b/security/Kconfig
> index a4fa8b826039..6e7e5888f823 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -243,6 +243,7 @@ source security/tomoyo/Kconfig
>  source security/apparmor/Kconfig
>  source security/loadpin/Kconfig
>  source security/yama/Kconfig
> +source security/fw_lockdown/Kconfig
>  
>  source security/integrity/Kconfig
>  
> diff --git a/security/Makefile b/security/Makefile
> index 8c4a43e3d4e0..58852dee5e22 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -9,6 +9,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        += tomoyo
>  subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
>  subdir-$(CONFIG_SECURITY_YAMA)		+= yama
>  subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
> +subdir-$(CONFIG_SECURITY_FW_LOCKDOWN)	+= fw_lockdown
>  
>  # always enable default capabilities
>  obj-y					+= commoncap.o
> @@ -24,6 +25,7 @@ obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/
>  obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
>  obj-$(CONFIG_SECURITY_YAMA)		+= yama/
>  obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
> +obj-$(CONFIG_SECURITY_FW_LOCKDOWN)	+= fw_lockdown/
>  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
>  
>  # Object integrity file lists
> diff --git a/security/fw_lockdown/Kconfig b/security/fw_lockdown/Kconfig
> new file mode 100644
> index 000000000000..d6aef6ce8fee
> --- /dev/null
> +++ b/security/fw_lockdown/Kconfig
> @@ -0,0 +1,6 @@
> +config SECURITY_FW_LOCKDOWN
> +	bool "Prevent loading unsigned firmware"
> +	depends on LOCK_DOWN_KERNEL
> +	default y
> +	help
> +	  Prevent loading unsigned firmware in lockdown mode,
> diff --git a/security/fw_lockdown/Makefile b/security/fw_lockdown/Makefile
> new file mode 100644
> index 000000000000..3a16757fd35d
> --- /dev/null
> +++ b/security/fw_lockdown/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_SECURITY_FW_LOCKDOWN) += fw_lockdown.o
> +
> +fw_lockdown-y := fw_lsm.o
> diff --git a/security/fw_lockdown/fw_lsm.c b/security/fw_lockdown/fw_lsm.c
> new file mode 100644
> index 000000000000..cce03a5c5280
> --- /dev/null
> +++ b/security/fw_lockdown/fw_lsm.c
> @@ -0,0 +1,51 @@
> +/*
> + * fw_lockdown security module
> + *
> + * Copyright (C) 2017 IBM Corporation
> + *
> + * Authors:
> + * Mimi Zohar <zohar@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt) "fw_lockdown: " fmt
> +
> +#include <linux/module.h>
> +#include <linux/ima.h>
> +#include <linux/lsm_hooks.h>
> +
> +/**
> + * fw_lockdown_read_file - prevent loading of unsigned firmware
> + * @file: pointer to firmware
> + * @read_id: caller identifier
> + *
> + * Prevent loading of unsigned firmware in lockdown mode.
> + */
> +static int fw_lockdown_read_file(struct file *file, enum kernel_read_file_id id)
> +{
> +	if (id == READING_FIRMWARE) {
> +		if (!is_ima_appraise_enabled() &&
> +		    !kernel_is_locked_down("Loading of unsigned firmware"))
> +			return -EACCES;
> +	}
> +	return 0;
> +}
> +
> +static struct security_hook_list fw_lockdown_hooks[] = {
> +	LSM_HOOK_INIT(kernel_read_file, fw_lockdown_read_file)
> +};
> +
> +static int __init init_fw_lockdown(void)
> +{
> +	security_add_hooks(fw_lockdown_hooks, ARRAY_SIZE(fw_lockdown_hooks),
> +			   "fw_lockdown");

SECURITY_NAME_MAX is 10. Either pick a shorter name or increase
this value. I slightly favor an increase to 16.

> +	pr_info("initialized\n");
> +	return 0;
> +}
> +
> +late_initcall(init_fw_lockdown);
> +MODULE_LICENSE("GPL");

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
