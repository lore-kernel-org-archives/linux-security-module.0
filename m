Return-Path: <SRS0=LBP9=AV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A438C433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jul 2020 21:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B63206F4
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jul 2020 21:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CSG6ET/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgGJVAs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgGJVAr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jul 2020 17:00:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43052C08C5DC
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2020 14:00:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j20so3058790pfe.5
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2020 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cyPZ2F8Elm/X30AvLL1oEN+KGMJ5jtRTB8rf0GQJuQU=;
        b=CSG6ET/DEoTdyvRO4iN3bYezY58ajzJ63SpVhvOqXxT0zPMKr+VjjZhxRiQvdQVTcK
         pP5iJk8t1/K01jHv8rehu+9M45OI1F12or/xjemjXMkwwEAD1idXHk5ol+2C1yDoi44t
         u1Sjhfh5SGd5lW408UKk6ZZDogLt9jqa//FtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cyPZ2F8Elm/X30AvLL1oEN+KGMJ5jtRTB8rf0GQJuQU=;
        b=jehqNSwt7dP5ync1P6PkJRy28pTHKM+xusYKXKsw6tMJD/dAXGJQqE7rXqCZuf6UBg
         tQph/pHqU9H4wXFgM0Pa2AuLZ98UxjoPppY6/gssLirpPLLlpa09FD6mh2One+Ab69q0
         JRVG0UIlpRFTMInclxOxZF4Er9Ora5aHcd6mOWWU2RRFp8ZRYFBBGW8B4RwGPPbpvePc
         yVOsLuvQJa7CLjXaUmlU1AaMpSV7RUYZRlmNoZw7ZSK76kaG26yh1JOYq8ZB76OD96cJ
         FNCM5MIGiEm95CN1Pix9C3TjIhn6vSR7ZsSToSsulFSxdx+RDytaWbQSP15g/mJbL7mA
         YSfA==
X-Gm-Message-State: AOAM533NHnYBOV/h0YgCxeZ0HCyExehS2jo/otNJfbith6QRlA3LPglW
        dDBV9srQAnYK8a25PycaC9B53TnwARyDSTVfP9syXQAPKnckaBKgeQPSkfXChevXLxuyzCPhACC
        yywHMANaraLhvL6ks5G19Rh39P055pQT6ZFIog6KrahRdpeoMZEsEV7isMzoWBEQrBD7vc6jMQy
        3RsmJpkJtPp52D51xubtxO
X-Google-Smtp-Source: ABdhPJx9N2FJKG78sh217VkA3T8P4l6LMqcB/e6Ykg2KomvFC7EXnwO8oLP7kDriJaQKbqt4vg18jQ==
X-Received: by 2002:a63:3c2:: with SMTP id 185mr61414088pgd.46.1594414845795;
        Fri, 10 Jul 2020 14:00:45 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e28sm6852810pfm.177.2020.07.10.14.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 14:00:44 -0700 (PDT)
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
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
Date:   Fri, 10 Jul 2020 14:00:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707081926.3688096-3-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Kees,

This patch fails during booting of my system - see below.

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
The assumption that *buf is always NULL when id != 
READING_FIRMWARE_PREALLOC_BUFFER doesn't appear to be correct.
I get unhandled page faults due to this change on boot.
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
> -	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
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

