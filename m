Return-Path: <SRS0=axxp=AS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A19C433DF
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 16:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D762075B
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Jul 2020 16:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AJ2740PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGGQmU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgGGQmU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Jul 2020 12:42:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C81CC08C5E2
        for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2020 09:42:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so961700pfn.9
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2020 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0qMTVTx2oMUOrXFIFdM7C2a26kIggeuoWNl9Jj6kWSc=;
        b=AJ2740POBQN+J8L+rLdzMt/HO2CL8AgWMqKjZQ2eFTnScvgiY+fjNZQlBfn+t7gQgg
         lIZmcE0W3wxKbTYW3Ii5MIdLfHANVUgV1WE+boVYskStkOIHbkKsJIT7ngaN7veE/i6e
         dyyulVok8SWD6RfLNEbJuks1coNC0w5XaKC0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0qMTVTx2oMUOrXFIFdM7C2a26kIggeuoWNl9Jj6kWSc=;
        b=YZdeA7UnLM+mCUYnUE5MyDqTahoK5A906nMRoGKISnWcC97H4SMQB7+lg5QM7eYkUW
         GEN006qYFvfVBC/WHg5pnbh9BYUzMQ9dJ3+ng8Hr4Tpx9cz7mdrYKhYy3ZUJhaV43EC9
         /CB2TiqhrW++TxDDh5A3fdYDhGelsq1lVIHFjy6QH8sLQ5ks4CmzSEE1fPyg5OgbwqBh
         jDKxxYdDVs/cuLbMNTtG7at81oFBZylyeGuWZe5F6JkQAUQF9aWggGM5oP5GuDxpWoFe
         C03YGwsrFXTMaaUMwN9rQ3PKmLMMBkYSzT48EZ8Tb6UctHD9LDmwJhhh056/z8XvtOsJ
         bZzw==
X-Gm-Message-State: AOAM5308AdJfEah4SKeV8zdyOGoD+SuLD8Jz5wir911O1spzF2QiAuYU
        VnE8U7CfQ+OwupNKVFXnToEH4w==
X-Google-Smtp-Source: ABdhPJwATTzEq1uBXUjxEsiTBgA4nu7xuVsLQq8eRH6/xZSkc/o2juX6PrF3O0dVY7WZ17vqBH8jMA==
X-Received: by 2002:a63:310f:: with SMTP id x15mr46316882pgx.221.1594140139368;
        Tue, 07 Jul 2020 09:42:19 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v15sm1523113pgo.15.2020.07.07.09.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 09:42:18 -0700 (PDT)
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0a5e2c2e-507c-9114-5328-5943f63d707e@broadcom.com>
Date:   Tue, 7 Jul 2020 09:42:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707081926.3688096-3-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 2020-07-07 1:19 a.m., Kees Cook wrote:
> FIRMWARE_PREALLOC_BUFFER is a "how", not a "what", and confuses the LSMs
> that are interested in filtering between types of things. The "how"
> should be an internal detail made uninteresting to the LSMs.
>
> Fixes: a098ecd2fa7d ("firmware: support loading into a pre-allocated buffer")
> Fixes: fd90bc559bfb ("ima: based on policy verify firmware signatures (pre-allocated buffer)")
> Fixes: 4f0496d8ffa3 ("ima: based on policy warn about loading firmware (pre-allocated buffer)")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/base/firmware_loader/main.c | 5 ++---
>   fs/exec.c                           | 7 ++++---
>   include/linux/fs.h                  | 2 +-
>   security/integrity/ima/ima_main.c   | 6 ++----
>   4 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index ca871b13524e..c2f57cedcd6f 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -465,14 +465,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   	int i, len;
>   	int rc = -ENOENT;
>   	char *path;
> -	enum kernel_read_file_id id = READING_FIRMWARE;
>   	size_t msize = INT_MAX;
>   	void *buffer = NULL;
>   
>   	/* Already populated data member means we're loading into a buffer */
>   	if (!decompress && fw_priv->data) {
>   		buffer = fw_priv->data;
> -		id = READING_FIRMWARE_PREALLOC_BUFFER;
>   		msize = fw_priv->allocated_size;
>   	}
>   
> @@ -496,7 +494,8 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   
>   		/* load firmware files from the mount namespace of init */
>   		rc = kernel_read_file_from_path_initns(path, &buffer,
> -						       &size, msize, id);
> +						       &size, msize,
> +						       READING_FIRMWARE);
>   		if (rc) {
>   			if (rc != -ENOENT)
>   				dev_warn(device, "loading %s failed with error %d\n",
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a70327..2bf549757ce7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -927,6 +927,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>   {
>   	loff_t i_size, pos;
>   	ssize_t bytes = 0;
> +	void *allocated = NULL;
>   	int ret;
>   
>   	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
> @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>   		goto out;
>   	}
>   
> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
> -		*buf = vmalloc(i_size);
> +	if (!*buf)
> +		*buf = allocated = vmalloc(i_size);
>   	if (!*buf) {
>   		ret = -ENOMEM;
>   		goto out;
> @@ -980,7 +981,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>   
>   out_free:
>   	if (ret < 0) {
> -		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
> +		if (allocated) {
>   			vfree(*buf);
>   			*buf = NULL;
>   		}
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3f881a892ea7..95fc775ed937 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2993,10 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
>   #endif
>   extern int do_pipe_flags(int *, int);
>   
> +/* This is a list of *what* is being read, not *how*. */
>   #define __kernel_read_file_id(id) \
>   	id(UNKNOWN, unknown)		\
>   	id(FIRMWARE, firmware)		\
With this change, I'm trying to figure out how the partial firmware read 
is going to work on top of this reachitecture.
Is it going to be ok to add READING_PARTIAL_FIRMWARE here as that is a 
"what"?
> -	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
My patch series gets rejected any time I make a change to the 
kernel_read_file* region in linux/fs.h.
The requirement is for this api to move to another header file outside 
of linux/fs.h
It seems the same should apply to your change.
Could you please add the following patch to the start of you patch 
series to move the kernel_read_file* to its own include file?
https://patchwork.kernel.org/patch/11647063/
>   	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
>   	id(MODULE, kernel-module)		\
>   	id(KEXEC_IMAGE, kexec-image)		\
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index c1583d98c5e5..f80ee4ce4669 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -611,19 +611,17 @@ void ima_post_path_mknod(struct dentry *dentry)
>   int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>   {
>   	/*
> -	 * READING_FIRMWARE_PREALLOC_BUFFER
> -	 *
>   	 * Do devices using pre-allocated memory run the risk of the
>   	 * firmware being accessible to the device prior to the completion
>   	 * of IMA's signature verification any more than when using two
> -	 * buffers?
> +	 * buffers? It may be desirable to include the buffer address
> +	 * in this API and walk all the dma_map_single() mappings to check.
>   	 */
>   	return 0;
>   }
>   
>   const int read_idmap[READING_MAX_ID] = {
>   	[READING_FIRMWARE] = FIRMWARE_CHECK,
> -	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
>   	[READING_MODULE] = MODULE_CHECK,
>   	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
>   	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,

