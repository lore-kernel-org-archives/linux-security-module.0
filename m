From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 28 Jul 2018 17:28:35 +0300
Subject: [GIT PULL] tpmdd 4.19 updates
In-Reply-To: <20180728142130.GA13541@linux.intel.com>
References: <20180728142130.GA13541@linux.intel.com>
Message-ID: <20180728142835.GA13620@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Sorry, I pressed send before writing anything. Here is the summary:

* Migrated away from PM runtime as explicit cmdReady/goIdle trasactions
  for every command is a spec requirement. PM runtime adds only a layer of
  complexity on our case.
* tpm_tis drivers can now specify the hwrng quality.
* TPM 2.0 code uses now tpm_buf for constructing messages. I think Tomas
  Winkler has done the same for TPM 1.2. I'll start digging those
  changes from the patchwork in the near future.
* Bug fixes and clean ups.

/Jarkko

On Sat, Jul 28, 2018 at 05:21:30PM +0300, Jarkko Sakkinen wrote:
> The following changes since commit 87ea58433208d17295e200d56be5e2a4fe4ce7d6:
> 
>   security: check for kstrdup() failure in lsm_append() (2018-07-17 21:27:06 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180728
> 
> for you to fetch changes up to ec403d8ed08c8272cfeeeea154fdebcd289988c8:
> 
>   ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead (2018-07-28 17:03:11 +0300)
> 
> ----------------------------------------------------------------
> tpmdd updates for Linux 4.19
> 
> ----------------------------------------------------------------
> Jarkko Sakkinen (5):
>       tpm: migrate tpm2_shutdown() to use struct tpm_buf
>       tpm: migrate tpm2_probe() to use struct tpm_buf
>       tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
>       tpm: migrate tpm2_get_random() to use struct tpm_buf
>       tpm: replace TPM_TRANSMIT_RAW with TPM_TRANSMIT_NESTED
> 
> Linus Walleij (1):
>       tpm_tis_spi: Pass the SPI IRQ down to the driver
> 
> Louis Collard (1):
>       tpm: Allow tpm_tis drivers to set hwrng quality.
> 
> Peter Rosin (1):
>       tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
> 
> Ricardo Schwarzmeier (1):
>       tpm: Return the actual size when receiving an unsupported command
> 
> Stefan Berger (5):
>       tpm: rename tpm_chip_find_get() to tpm_find_get_ops()
>       tpm: Implement tpm_default_chip() to find a TPM chip
>       tpm: Convert tpm_find_get_ops() to use tpm_default_chip()
>       ima: Use tpm_default_chip() and call TPM functions with a tpm_chip
>       ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead
> 
> Tomas Winkler (1):
>       tpm: separate cmd_ready/go_idle from runtime_pm
> 
>  drivers/char/tpm/tpm-chip.c         |  68 +++++++---
>  drivers/char/tpm/tpm-interface.c    |  72 +++++++---
>  drivers/char/tpm/tpm.h              |  31 +++--
>  drivers/char/tpm/tpm2-cmd.c         | 258 +++++++++++++++---------------------
>  drivers/char/tpm/tpm2-space.c       |  12 +-
>  drivers/char/tpm/tpm_crb.c          | 101 ++++----------
>  drivers/char/tpm/tpm_i2c_infineon.c |   8 +-
>  drivers/char/tpm/tpm_tis_core.c     |   2 +
>  drivers/char/tpm/tpm_tis_core.h     |   1 +
>  drivers/char/tpm/tpm_tis_spi.c      |   9 +-
>  drivers/char/tpm/tpm_vtpm_proxy.c   |   2 +-
>  include/linux/tpm.h                 |   7 +
>  security/integrity/ima/ima.h        |   2 +-
>  security/integrity/ima/ima_crypto.c |   4 +-
>  security/integrity/ima/ima_init.c   |  16 +--
>  security/integrity/ima/ima_queue.c  |   4 +-
>  16 files changed, 289 insertions(+), 308 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
