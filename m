From: jsnitsel@redhat.com (Jerry Snitselaar)
Date: Fri, 24 Mar 2017 11:25:57 -0700
Subject: [PATCH v4] tpm_crb: request and relinquish locality 0
In-Reply-To: <20170324101032.13496-1-jarkko.sakkinen@iki.fi>
References: <20170324101032.13496-1-jarkko.sakkinen@iki.fi>
Message-ID: <87lgru7cqy.fsf@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Jarkko Sakkinen @ 2017-03-24 10:10 GMT:

> This commit adds support for requesting and relinquishing locality 0 in
> tpm_crb for the course of command transmission.
>
> In order to achieve this, two new callbacks are added to struct
> tpm_class_ops:
>
> - request_locality
> - relinquish_locality
>
> With CRB interface you first set either requestAccess or relinquish bit
> from TPM_LOC_CTRL_x register and then wait for locAssigned and
> tpmRegValidSts bits to be set in the TPM_LOC_STATE_x register.
>
> The reason why were are doing this is to make sure that the driver
> will work properly with Intel TXT that uses locality 2. There's no
> explicit guarantee that it would relinquish this locality. In more
> general sense this commit enables tpm_crb to be a well behaving
> citizen in a multi locality environment.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>

Tested on kabylake system that was hitting issues with earlier
iteration. Still don't have platform to test it dealing with
multi-locality enviroment.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
