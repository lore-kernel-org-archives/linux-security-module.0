Return-Path: <SRS0=PFxj=WK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4918C0650F
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 05:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9557D2084F
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 05:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHNFYJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Aug 2019 01:24:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbfHNFYI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Aug 2019 01:24:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2F463002096;
        Wed, 14 Aug 2019 05:24:07 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-126.pek2.redhat.com [10.72.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53BBB88B31;
        Wed, 14 Aug 2019 05:24:04 +0000 (UTC)
Date:   Wed, 14 Aug 2019 13:23:59 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Jiri Bohac <jbohac@suse.cz>, kexec@lists.infradead.org
Subject: Re: [PATCH 3/6] Avoid build warning when !CONFIG_KEXEC_SIG
Message-ID: <20190814052359.GA10664@dhcp-128-65.nay.redhat.com>
References: <20190813192126.122370-1-matthewgarrett@google.com>
 <20190813192126.122370-4-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813192126.122370-4-matthewgarrett@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 14 Aug 2019 05:24:08 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 08/13/19 at 12:21pm, Matthew Garrett wrote:
> Refactor the signature validation and lockdown integration a little in
> order to avoid an unused variable.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: kexec@lists.infradead.org
> ---
>  kernel/kexec_file.c | 72 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index be0c13076056..e878587715b9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -177,36 +177,13 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  	image->image_loader_data = NULL;
>  }
>  
> -/*
> - * In file mode list of segments is prepared by kernel. Copy relevant
> - * data from user space, do error checking, prepare segment list
> - */
> +#ifdef CONFIG_KEXEC_SIG
>  static int
> -kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> -			     const char __user *cmdline_ptr,
> -			     unsigned long cmdline_len, unsigned flags)
> +kimage_validate_signature(struct kimage *image)
>  {
>  	const char *reason;
>  	int ret;
> -	void *ldata;
> -	loff_t size;
> -
> -	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
> -				       &size, INT_MAX, READING_KEXEC_IMAGE);
> -	if (ret)
> -		return ret;
> -	image->kernel_buf_len = size;
> -
> -	/* IMA needs to pass the measurement list to the next kernel. */
> -	ima_add_kexec_buffer(image);
>  
> -	/* Call arch image probe handlers */
> -	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> -					    image->kernel_buf_len);
> -	if (ret)
> -		goto out;
> -
> -#ifdef CONFIG_KEXEC_SIG
>  	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>  					   image->kernel_buf_len);
>  	switch (ret) {
> @@ -228,7 +205,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	decide:
>  		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
>  			pr_notice("%s rejected\n", reason);
> -			goto out;
> +			break;
>  		}
>  
>  		ret = 0;
> @@ -251,9 +228,44 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		 */
>  	default:
>  		pr_notice("kernel signature verification failed (%d).\n", ret);
> -		goto out;
> +		break;
>  	}
> +
> +	return ret;
> +}
> +#endif
> +
> +/*
> + * In file mode list of segments is prepared by kernel. Copy relevant
> + * data from user space, do error checking, prepare segment list
> + */
> +static int
> +kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> +			     const char __user *cmdline_ptr,
> +			     unsigned long cmdline_len, unsigned flags)
> +{
> +	int ret;
> +	void *ldata;
> +	loff_t size;
> +
> +	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
> +				       &size, INT_MAX, READING_KEXEC_IMAGE);
> +	if (ret)
> +		return ret;
> +	image->kernel_buf_len = size;
> +
> +	/* Call arch image probe handlers */
> +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> +					    image->kernel_buf_len);
> +	if (ret)
> +		goto out;
> +
> +#ifdef CONFIG_KEXEC_SIG
> +	ret = kimage_validate_signature(image);
> +	if (ret)
> +		goto out;
>  #endif
> +
>  	/* It is possible that there no initramfs is being loaded */
>  	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>  		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
> @@ -279,8 +291,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> +
> +		ima_kexec_cmdline(image->cmdline_buf,
> +				  image->cmdline_buf_len - 1);
>  	}
>  
> +	/* IMA needs to pass the measurement list to the next kernel. */
> +	ima_add_kexec_buffer(image);
> +
>  	/* Call arch image load handlers */
>  	ldata = arch_kexec_kernel_image_load(image);
>  

I can not get the whole thread, also not sure which tree it should
apply.

I assume it is based on your series for lockdown.  But it is really hard
to review because of no context in this patch.

Also I think it should be good to split the preparation piece of kexec
and send them separately.  Since it is improve the signature
verification logic, they do not necessarily depend on the lockdown
series.

Thanks
Dave
