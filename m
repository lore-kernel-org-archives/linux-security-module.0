Return-Path: <SRS0=gDDV=6W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517FC38A2A
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508FF2173E
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 15:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgEHPpy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 May 2020 11:45:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:62555 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgEHPpy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 May 2020 11:45:54 -0400
IronPort-SDR: +yd/cQ4CtZ7SsM3ZCY+iu3EDEnr2cL1l+EeenYgwat+T4izcUC5cNHBKXm9rvzOqZWCLO+pD90
 giXRzZeVzjlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 08:45:53 -0700
IronPort-SDR: kML9TWEw7QXFXDMKy14JPIY8Gk7mkGgTQgp+h9sR24hccB5Fq44lwLMHP5E/u0FvVNWCez+pxd
 ErBoROaXN98A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="285506118"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2020 08:45:53 -0700
Date:   Fri, 8 May 2020 08:45:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 10/11] fs: remove __vfs_read
Message-ID: <20200508154552.GB1431382@iweiny-DESK2.sc.intel.com>
References: <20200508092222.2097-1-hch@lst.de>
 <20200508092222.2097-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508092222.2097-11-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 08, 2020 at 11:22:21AM +0200, Christoph Hellwig wrote:
> Fold it into the two callers.

In 5.7-rc4, it looks like __vfs_read() is called from
security/integrity/iint.c

Was that removed somewhere prior to this patch?

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/read_write.c    | 43 +++++++++++++++++++++----------------------
>  include/linux/fs.h |  1 -
>  2 files changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0ffbed5fd8136..f0009b506014c 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -419,17 +419,6 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
>  	return ret;
>  }
>  
> -ssize_t __vfs_read(struct file *file, char __user *buf, size_t count,
> -		   loff_t *pos)
> -{
> -	if (file->f_op->read)
> -		return file->f_op->read(file, buf, count, pos);
> -	else if (file->f_op->read_iter)
> -		return new_sync_read(file, buf, count, pos);
> -	else
> -		return -EINVAL;
> -}
> -
>  ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
>  {
>  	mm_segment_t old_fs = get_fs();
> @@ -441,7 +430,12 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
>  	if (count > MAX_RW_COUNT)
>  		count =  MAX_RW_COUNT;
>  	set_fs(KERNEL_DS);
> -	ret = __vfs_read(file, (void __user *)buf, count, pos);
> +	if (file->f_op->read)
> +		ret = file->f_op->read(file, (void __user *)buf, count, pos);
> +	else if (file->f_op->read_iter)
> +		ret = new_sync_read(file, (void __user *)buf, count, pos);
> +	else
> +		ret = -EINVAL;
>  	set_fs(old_fs);
>  	if (ret > 0) {
>  		fsnotify_access(file);
> @@ -474,17 +468,22 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
>  		return -EFAULT;
>  
>  	ret = rw_verify_area(READ, file, pos, count);
> -	if (!ret) {
> -		if (count > MAX_RW_COUNT)
> -			count =  MAX_RW_COUNT;
> -		ret = __vfs_read(file, buf, count, pos);
> -		if (ret > 0) {
> -			fsnotify_access(file);
> -			add_rchar(current, ret);
> -		}
> -		inc_syscr(current);
> -	}
> +	if (ret)
> +		return ret;
> +	if (count > MAX_RW_COUNT)
> +		count =  MAX_RW_COUNT;

Couldn't this clean up still happen while keeping __vfs_read()?

Ira

> +	if (file->f_op->read)
> +		ret = file->f_op->read(file, buf, count, pos);
> +	else if (file->f_op->read_iter)
> +		ret = new_sync_read(file, buf, count, pos);
> +	else
> +		ret = -EINVAL;
> +	if (ret > 0) {
> +		fsnotify_access(file);
> +		add_rchar(current, ret);
> +	}
> +	inc_syscr(current);
>  	return ret;
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6441aaa25f8f2..4c10a07a36178 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1905,7 +1905,6 @@ ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
>  			      struct iovec *fast_pointer,
>  			      struct iovec **ret_pointer);
>  
> -extern ssize_t __vfs_read(struct file *, char __user *, size_t, loff_t *);
>  extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
>  extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
>  extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
> -- 
> 2.26.2
> 
