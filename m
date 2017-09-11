From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Mon, 11 Sep 2017 15:20:11 +0000
Subject: [tpmdd-devel] [PATCH v2 0/4] additional TPM performance
	improvements
In-Reply-To: <20170906125643.5070-1-nayna@linux.vnet.ibm.com>
References: <20170906125643.5070-1-nayna@linux.vnet.ibm.com>
Message-ID: <3c9f751de8af4b708ec47385acb3037f@MUCSE603.infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> After further discussions with the Device Driver working group (ddwg),
> the following changes were made:
> 
> * Check for burstcount at least once to confirm the TPM is ready to accept
> the data. Similarly, query for the TPM Expect status as sanity check at
> the end.
> 
> * Make the sleep for status check during send() in the loop less than
> 5msec.
> 
> * Make the sleep in the loop while querying for burstcount less than
> 5msec.
> 
> Below is the list of patches along with the performance improvements
> seen with a TPM 1.2 with an 8 byte burstcount for 1000 extends:
> 
> Patch                                        |Improvement(time in sec)
> 
> tpm: ignore burstcount to improve tpm_tis    | ~41 - ~14
> send() performance.
> 
> tpm: define __wait_for_tpm_stat to specify   | ~14 - ~10
> variable polling sleep time
> 
> tpm: reduce tpm_msleep() time in             | ~10 - ~9
> get_burstcount()
> 
> tpm: modify tpm_msleep() function to have    | ~9 - ~8
> max range
> 
> Changelog v2:
> 
> * Add module parameter to handle ignoring of burst count during
> tpm tis send() operation.
> * Add improvements over sleep time to reduce delays.
> 
> Nayna Jain (4):
>   tpm: ignore burstcount to improve tpm_tis send() performance.
>   tpm: define __wait_for_tpm_stat to specify variable polling sleep time
>   tpm: reduce tpm_msleep() time in get_burstcount()
>   tpm: use tpm_msleep() value as max delay
> 
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++
>  drivers/char/tpm/tpm-interface.c                | 15 ++++++++--
>  drivers/char/tpm/tpm.h                          |  7 +++--
>  drivers/char/tpm/tpm_tis_core.c                 | 37 +++++++++++++++++++------
>  4 files changed, 53 insertions(+), 14 deletions(-)
> 
> --
> 2.13.3

I haven't looked at the changes in detail yet, but some initial comments:

The ignore_burst_count functionality has already received some negative feedback and probably needs more iterations, if it can be accepted at all, so you might want to split it off from the rest of the series.

Also, did you explore any alternative ways to activate that functionality besides a command line parameter? If it is off by default, then most users will never see the benefits, and if they do activate it manually, then they might hit some obscure bugs because those code paths receive only little testing. I could imagine for example activating this functionality automatically for certain safe drivers like tpm_tis_spi, where wait states cannot block us (or anyone else on the bus) indefinitely.

I ran all your patches through my tests (though without making any changes, so ignore_burst_count was off, since that is the default) and did not see any failures. My test bench does not contain performance tests (yet), so I cannot confirm your measurements. checkpatch.pl has a couple of complaints though.

Alexander
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
