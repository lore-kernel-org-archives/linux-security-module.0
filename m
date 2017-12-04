From: joe@perches.com (Joe Perches)
Date: Mon, 04 Dec 2017 15:35:37 -0800
Subject: [PATCH v2] ima: log message to module appraisal error
In-Reply-To: <20171204202347.16261-1-brdeoliv@redhat.com>
References: <20171204202347.16261-1-brdeoliv@redhat.com>
Message-ID: <1512430537.6321.58.camel@perches.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-12-04 at 18:23 -0200, Bruno E. O. Meneguele wrote:
> Simple but useful message log to the user in case of module appraise is
> forced and fails due to the lack of file descriptor, that might be
> caused by kmod calls to compressed modules.
[]
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
[]
> @@ -366,8 +366,12 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  
>  	if (!file && read_id == READING_MODULE) {
>  		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> -		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("impossible to appraise a module without a file \
> +			       descriptor. sig_enforce kernel parameter might \
> +			       help\n");
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You should probably use scripts/checkpatch.pl on your proposed
patches
before sending them.

You've got a lot of tabs and spaces after every line continuation.
Please coalesce the format on a single line and avoid this defect.

			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");

cheers, Joe
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
