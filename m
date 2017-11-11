From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sat, 11 Nov 2017 18:04:16 -0500
Subject: [RFC PATCH v1] fw_lockdown: new micro LSM module to prevent
	loading unsigned firmware
In-Reply-To: <20171110223930.GT22894@wotan.suse.de>
References: <1510347775.3549.2.camel@linux.vnet.ibm.com>
	<20171110223930.GT22894@wotan.suse.de>
Message-ID: <1510441456.3404.3.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-11-10 at 23:39 +0100, Luis R. Rodriguez wrote:
> On Fri, Nov 10, 2017 at 04:02:55PM -0500, Mimi Zohar wrote:
> > If the kernel is locked down and IMA-appraisal is not enabled, prevent
> > loading of unsigned firmware.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> > 
> > Changelog v1:
> > - Lots of minor changes Kconfig, Makefile, fw_lsm.c for such a small patch
> 
> <-- snip -->
> 
> > diff --git a/security/fw_lockdown/fw_lsm.c b/security/fw_lockdown/fw_lsm.c
> > new file mode 100644
> > index 000000000000..cce03a5c5280
> > --- /dev/null
> > +++ b/security/fw_lockdown/fw_lsm.c
> > @@ -0,0 +1,51 @@
> > +/*
> > + * fw_lockdown security module
> > + *
> > + * Copyright (C) 2017 IBM Corporation
> > + *
> > + * Authors:
> > + * Mimi Zohar <zohar@linux.vnet.ibm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#define pr_fmt(fmt) "fw_lockdown: " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/ima.h>
> > +#include <linux/lsm_hooks.h>
> > +
> > +/**
> > + * fw_lockdown_read_file - prevent loading of unsigned firmware
> > + * @file: pointer to firmware
> > + * @read_id: caller identifier
> > + *
> > + * Prevent loading of unsigned firmware in lockdown mode.
> > + */
> > +static int fw_lockdown_read_file(struct file *file, enum kernel_read_file_id id)
> > +{
> > +	if (id == READING_FIRMWARE) {
> > +		if (!is_ima_appraise_enabled() &&
> > +		    !kernel_is_locked_down("Loading of unsigned firmware"))
> > +			return -EACCES;
> 
> I don't have kernel_is_locked_down() but I found it here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=keys-lockdown&id=0ff5adf1e81135c4ed914d0a8b70124caed04142
> 

> 1) I don't see it taking any arguments

David reposted the patches?https://lkml.org/lkml/2017/11/9/659?with
the change. ?The latest version of the patches are in his?efi-lock-
down branch.

> 2) Don't we want:
> 
> 	if (!is_ima_appraise_enabled() && kernel_is_locked_down())
> 		return -EACCES;
> 
> If, only if IMA appraisal is enabled would we enable kernel lockdown.

Yes, the kernel_is_locked_down() test needs to be inverted.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
