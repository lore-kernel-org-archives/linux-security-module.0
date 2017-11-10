From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 10 Nov 2017 14:50:30 -0500
Subject: [RFC PATCH] fw_lockdown: new micro LSM module to prevent
	loading unsigned firmware
In-Reply-To: <20171110193507.GP22894@wotan.suse.de>
References: <1510336703.3404.17.camel@linux.vnet.ibm.com>
	<20171110193507.GP22894@wotan.suse.de>
Message-ID: <1510343430.3404.25.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-11-10 at 20:35 +0100, Luis R. Rodriguez wrote:
> On Fri, Nov 10, 2017 at 12:58:23PM -0500, Mimi Zohar wrote:
> > Hi David,
> > 
> > If you are interested in preventing the loading of unsigned firmware,
> > the patch below is straight forward. ?The patch has ONLY been tested
> > with IMA-appraisal enabled, and works as intended - allowing only
> > signed firmware to be loaded.
> 
> Very nice! This is the sort of thing that I mean by LSM'ifying fw access
> through a system policy.
> 
> We currently handle the LSM aspect for firmware through
> kernel_read_file_from_path() and so the kernel_read_file LSM hook, so why a new
> hook here?

kernel_read_file(), itself, is not an LSM hook, but calls two LSM
hooks named security_kernel_read_file(), prior to reading a file, and
security_kernel_post_read_file(), post reading a file.

In this case, we want to reject even reading the file if it isn't
signed, so we're using the security_kernel_read_file() LSM hook.

> 
> Where does this plug in?

This is a standalone, micro LSM that can be configured at build. ?For
now I left it is an optional Kconfig parameter, but at some point, you
might want to consider making it required.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
