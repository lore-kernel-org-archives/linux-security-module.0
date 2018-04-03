From: luto@kernel.org (Andy Lutomirski)
Date: Mon, 2 Apr 2018 17:42:22 -0700
Subject: [RFC PATCH v1] fw_lockdown: new micro LSM module to prevent
	loading unsigned firmware
In-Reply-To: <1510347775.3549.2.camel@linux.vnet.ibm.com>
References: <1510347775.3549.2.camel@linux.vnet.ibm.com>
Message-ID: <21dd4b88-f6e7-f6bb-e34d-ba8ef3755622@kernel.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/10/2017 01:02 PM, Mimi Zohar wrote:
> If the kernel is locked down and IMA-appraisal is not enabled, prevent
> loading of unsigned firmware.

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

Please be honest about what this does.  This option makes your system 
useless if you don't use IMA-Appraisal and it offers a particular 
security benefit if you do you IMA-Appraisal.  How about making it 
depend on IMA-Appraisal?  Change the name to 
SECURITY_ONLY_LOAD_IMA_APPRAISED_FIRMWARE and adjust the text 
accordingly, please.

> +/**
> + * fw_lockdown_read_file - prevent loading of unsigned firmware
> + * @file: pointer to firmware
> + * @read_id: caller identifier
> + *
> + * Prevent loading of unsigned firmware in lockdown mode.

That comment gives a highly misleading impression of what this function 
does.

> + */
> +static int fw_lockdown_read_file(struct file *file, enum kernel_read_file_id id)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
