From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 01 May 2018 10:36:14 -0400
Subject: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
In-Reply-To: <20180429093558.5411-3-hdegoede@redhat.com>
References: <20180429093558.5411-1-hdegoede@redhat.com>
	<20180429093558.5411-3-hdegoede@redhat.com>
Message-ID: <1525185374.5669.49.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

[Cc'ing linux-security]

On Sun, 2018-04-29 at 11:35 +0200, Hans de Goede wrote:
[...]
> diff --git a/drivers/base/firmware_loader/fallback_efi.c b/drivers/base/firmware_loader/fallback_efi.c
> new file mode 100644
> index 000000000000..82ba82f48a79
> --- /dev/null
> +++ b/drivers/base/firmware_loader/fallback_efi.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/efi_embedded_fw.h>
> +#include <linux/property.h>
> +#include <linux/security.h>
> +#include <linux/vmalloc.h>
> +
> +#include "fallback.h"
> +#include "firmware.h"
> +
> +int fw_get_efi_embedded_fw(struct device *dev, struct fw_priv *fw_priv,
> +			   enum fw_opt *opt_flags, int ret)
> +{
> +	enum kernel_read_file_id id = READING_FIRMWARE;

Please define a new kernel_read_file_id for this (eg.
READING_FIRMWARE_EFI_EMBEDDED).

> +	size_t size, max = INT_MAX;
> +	int rc;
> +
> +	if (!dev)
> +		return ret;
> +
> +	if (!device_property_read_bool(dev, "efi-embedded-firmware"))
> +		return ret;

Instead of calling security_kernel_post_read_file(), either in
device_property_read_bool() or here call security_kernel_read_file().

The pre read call is for deciding whether to allow this call
independent of the firmware being loaded, whereas the post security
call is currently being used by IMA-appraisal for verifying a
signature. ?There might be other LSMs using the post hook as well. ?As
there is no kernel signature associated with this firmware, use the
security pre read_file hook.

thanks,

Mimi

> +
> +	*opt_flags |= FW_OPT_NO_WARN | FW_OPT_NOCACHE | FW_OPT_NOFALLBACK;
> +
> +	/* Already populated data member means we're loading into a buffer */
> +	if (fw_priv->data) {
> +		id = READING_FIRMWARE_PREALLOC_BUFFER;
> +		max = fw_priv->allocated_size;
> +	}
> +
> +	rc = efi_get_embedded_fw(fw_priv->fw_name, &fw_priv->data, &size, max);
> +	if (rc) {
> +		dev_warn(dev, "Firmware %s not in EFI\n", fw_priv->fw_name);
> +		return ret;
> +	}
> +
> +	rc = security_kernel_post_read_file(NULL, fw_priv->data, size, id);
> +	if (rc) {
> +		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
> +			vfree(fw_priv->data);
> +			fw_priv->data = NULL;
> +		}
> +		return rc;
> +	}
> +
> +	dev_dbg(dev, "using efi-embedded fw %s\n", fw_priv->fw_name);
> +	fw_priv->size = size;
> +	fw_state_done(fw_priv);
> +	return 0;
> +}

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
