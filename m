From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 15 Jun 2017 12:00:56 -0400
Subject: [PATCH v2 3/6] ima: Log the same audit cause whenever a file
	has no signature
In-Reply-To: <1496886555-10082-4-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
	<1496886555-10082-4-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <1497542456.4287.57.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-06-07 at 22:49 -0300, Thiago Jung Bauermann wrote:
> If the file doesn't have an xattr, ima_appraise_measurement sets cause to
> "missing-hash" while if there's an xattr but it's a digest instead of a
> signature it sets cause to "IMA-signature-required".
> 
> Fix it by setting cause to "IMA-signature-required" in both cases.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Thank you.??Queued to be upstreamed.

Mimi
> ---
>  security/integrity/ima/ima_appraise.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index ea36a4f134f4..809ba70fbbbf 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -217,7 +217,8 @@ int ima_appraise_measurement(enum ima_hooks func,
>  		if (rc && rc != -ENODATA)
>  			goto out;
> 
> -		cause = "missing-hash";
> +		cause = iint->flags & IMA_DIGSIG_REQUIRED ?
> +				"IMA-signature-required" : "missing-hash";
>  		status = INTEGRITY_NOLABEL;
>  		if (opened & FILE_CREATED)
>  			iint->flags |= IMA_NEW_FILE;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
