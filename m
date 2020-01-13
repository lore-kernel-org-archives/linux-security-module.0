Return-Path: <SRS0=WVaQ=3C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005D5C33CAD
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jan 2020 10:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA5C2081E
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jan 2020 10:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dmdaEKfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAMKse (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:48:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35621 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAMKsd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jan 2020 05:48:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so9080988wmb.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2020 02:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q72nxyYifHuN/2SoRmUuohcGv85roM34W+YCiMDzhOU=;
        b=dmdaEKfLffOvuwT8MuhA2MntZz1aFWQRQRH8ewU8dUHRnXYtyeD/Ic2FRFbsUl2JEo
         wRVAvMLgz56QLfUc9K9i0YKOv53V959l6eJRvB8tkUxsxv8uDfztCiT+ZIA9co3ov44f
         l0TvwnZi0XDy7U1MIpI2r7RPLoBB5FkY0zCx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q72nxyYifHuN/2SoRmUuohcGv85roM34W+YCiMDzhOU=;
        b=edQdZp/SpEKWSX14zWf4awTkHOgwciUMKcMthWi04rqhXvVUQtPyOv+5EA8sGMvcib
         EAVw7WPftCSQ2PRjGK8UvqerBDmKsGKrCLhvRcqW8z0Th3LozhsScscTU4Vc1sakfKpq
         Z46y/n+yRRLlqiR80DBNR7+5PKnkDhCfej2eFnP7LO5L3gD1JJ9Y7b4chV9njM/AxoHU
         BZaJ5WU5Hb1izCypmc4FHG/bDZ+uG3Q0+prSB/s6yywMCMxwhYHCqjhXJcebnWA4OW4e
         jnRiIoohUwDKuYZrspb+icdpmq7q8AQFF9/hmKk9gqHQ/CAKG+AoN3SQuYpCRTMbVC8y
         hAVA==
X-Gm-Message-State: APjAAAWEr6NAHnAHtCR8DAeGk/hj3t1Bw8dVADOMRyH6yCQUj/Yi0bfF
        PGgLvHkczKFmLFMpMvyBuNnGfA==
X-Google-Smtp-Source: APXvYqxNeOGAz2aOzj9D5YgGs3DM/AjYyoLeykfRXdr8x4952mDTvGKJPdy/xh9j5SZPBakRbNV3TQ==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr19266314wmj.96.1578912512152;
        Mon, 13 Jan 2020 02:48:32 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id q14sm14239337wmj.14.2020.01.13.02.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 02:48:31 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 13 Jan 2020 11:48:30 +0100
To:     Florent Revest <revest@chromium.org>
Cc:     linux-integrity@vger.kernel.org, kpsingh@chromium.org,
        mjg59@google.com, zohar@linux.ibm.com, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Subject: Re: [PATCH v2] ima: add the ability to query the hash of a given
 file.
Message-ID: <20200113104830.GA28588@google.com>
References: <20200106162524.164650-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106162524.164650-1-revest@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 06-Jan 17:25, Florent Revest wrote:
> From: Florent Revest <revest@google.com>
> 
> This allows other parts of the kernel (perhaps a stacked LSM allowing
> system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the hash
> of a given file from IMA if it's present in the iint cache.
> 
> It's true that the existence of the hash means that it's also in the
> audit logs or in /sys/kernel/security/ima/ascii_runtime_measurements,
> but it can be difficult to pull that information out for every
> subsequent exec.  This is especially true if a given host has been up
> for a long time and the file was first measured a long time ago.
> 
> This is based on Peter Moody's patch:
>  https://sourceforge.net/p/linux-ima/mailman/message/33036180/
> 
> [1] https://lkml.org/lkml/2019/9/10/393
> 
> Signed-off-by: Florent Revest <revest@google.com>

Thanks for adding this Florent!

Reviewed-by: KP Singh <kpsingh@chromium.org>

> ---
>  include/linux/ima.h               |  6 ++++
>  security/integrity/ima/ima_main.c | 46 +++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 6d904754d858..d621c65ba9a5 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -23,6 +23,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
>  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
> +extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
>  extern void ima_kexec_cmdline(const void *buf, int size);
>  
>  #ifdef CONFIG_IMA_KEXEC
> @@ -91,6 +92,11 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
>  	return;
>  }
>  
> +static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline void ima_kexec_cmdline(const void *buf, int size) {}
>  #endif /* CONFIG_IMA */
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index d7e987baf127..3799b6c6c3b8 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -445,6 +445,52 @@ int ima_file_check(struct file *file, int mask)
>  }
>  EXPORT_SYMBOL_GPL(ima_file_check);
>  
> +/**
> + * ima_file_hash - return the stored measurement if a file has been hashed.
> + * @file: pointer to the file
> + * @buf: buffer in which to store the hash
> + * @buf_size: length of the buffer
> + *
> + * On success, return the hash algorithm (as defined in the enum hash_algo).
> + * If buf is not NULL, this function also outputs the hash into buf.
> + * If the hash is larger than buf_size, then only buf_size bytes will be copied.
> + * It generally just makes sense to pass a buffer capable of holding the largest
> + * possible hash: IMA_MAX_DIGEST_SIZE
> + *
> + * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
> + * If the parameters are incorrect, return -EINVAL.
> + */
> +int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> +{
> +	struct inode *inode;
> +	struct integrity_iint_cache *iint;
> +	int hash_algo;
> +
> +	if (!file)
> +		return -EINVAL;
> +
> +	if (!ima_policy_flag)
> +		return -EOPNOTSUPP;
> +
> +	inode = file_inode(file);
> +	iint = integrity_iint_find(inode);
> +	if (!iint)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&iint->mutex);
> +	if (buf) {
> +		size_t copied_size;
> +
> +		copied_size = min_t(size_t, iint->ima_hash->length, buf_size);
> +		memcpy(buf, iint->ima_hash->digest, copied_size);
> +	}
> +	hash_algo = iint->ima_hash->algo;
> +	mutex_unlock(&iint->mutex);
> +
> +	return hash_algo;
> +}
> +EXPORT_SYMBOL_GPL(ima_file_hash);
> +
>  /**
>   * ima_post_create_tmpfile - mark newly created tmpfile as new
>   * @file : newly created tmpfile
> -- 
> 2.24.1.735.g03f4e72817-goog
> 
