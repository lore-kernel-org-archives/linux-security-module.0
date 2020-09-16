Return-Path: <SRS0=TMVc=CZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C76C35257
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 20:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5411A221E3
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Sep 2020 20:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sm6cIcfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgIPUYg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgIPR1y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Sep 2020 13:27:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF7C0A8888
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 05:41:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so6736489wrm.9
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2020 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3G5QEGbkKNJ30+kU6LXaoDvAPXSs+sgtSj04KcPMQDA=;
        b=Sm6cIcfQdXNR/nF1M6QBVB85DcM267KkHeDIh+C55CN2GI/VpjGh5/9vYV+w6/PO8p
         hM4qeeJULScCVDGUTv6S+LM86m4JI962GHTZSRSTfmXtntkwvK3VcOLh37+ttAfjB1oX
         RuTgcNg2yzaOnoCOLFRNWtA09LNIyiaL1rWuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3G5QEGbkKNJ30+kU6LXaoDvAPXSs+sgtSj04KcPMQDA=;
        b=d4aq8JG6F6u3vEClKiHGXnzYWiEsD/x8uu0CDE3AN0w9qTDG4PyvrJ0027uJ4cV954
         W2lqW9y2hai+K73ki46r673qFXL9jJ5a0oJop/1VxeadqdGWp9TLpCfv/MXfL76HQga6
         4mn9K9YaAPwax+sVSczN68orXtzlupwEzYZAgpz2vtWhisa3p1hES75Wv5AW0+GpUcZg
         xPze/Ujjmk5QBtncKYZ0R407gEfjjtN72YXGSWvjpUmRIkAkO6+jYrkIMELy5RWYBzqX
         jVeqJ0EZayvdCBKmVN3Gl7vcBxpXIGeiXnZ1gK3bxSgyeoTiXZbTM+/+cCzAl9B7NUru
         IA1g==
X-Gm-Message-State: AOAM531GoYN1fHZ2Qr4040eX751U1VET9/8YElsGWdGu81V3FeJ45Hd4
        EdM9X2euAoIOEBGiLGrLJFK7Fg==
X-Google-Smtp-Source: ABdhPJxq1vh9EO0rpXrBaT8rs4odd+BzkhQ3bZnhitc/G/USx0mz2PsAuVGR9PiugesL21jUx6GiFA==
X-Received: by 2002:adf:fec7:: with SMTP id q7mr26627057wrs.293.1600260095569;
        Wed, 16 Sep 2020 05:41:35 -0700 (PDT)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id v17sm32719109wrr.60.2020.09.16.05.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:41:34 -0700 (PDT)
Message-ID: <5ab256148e8ad5f9882e888dac809bc72cd3fe66.camel@chromium.org>
Subject: Re: [PATCH] ima: Fix NULL pointer dereference in ima_file_hash
From:   Florent Revest <revest@chromium.org>
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Jann Horn <jannh@google.com>
Date:   Wed, 16 Sep 2020 14:41:33 +0200
In-Reply-To: <20200916120548.364892-1-kpsingh@chromium.org>
References: <20200916120548.364892-1-kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Reviewed-by: Florent Revest <revest@chromium.org>

On Wed, 2020-09-16 at 12:05 +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> ima_file_hash can be called when there is no iint->ima_hash available
> even though the inode exists in the integrity cache.
> 
> An example where this can happen (suggested by Jann Horn):
> 
> Process A does:
> 
> 	while(1) {
> 		unlink("/tmp/imafoo");
> 		fd = open("/tmp/imafoo", O_RDWR|O_CREAT|O_TRUNC, 0700);
> 		if (fd == -1) {
> 			perror("open");
> 			continue;
> 		}
> 		write(fd, "A", 1);
> 		close(fd);
> 	}
> 
> and Process B does:
> 
> 	while (1) {
> 		int fd = open("/tmp/imafoo", O_RDONLY);
> 		if (fd == -1)
> 			continue;
>     		char *mapping = mmap(NULL, 0x1000, PROT_READ|PROT_EXEC,
> 			 	     MAP_PRIVATE, fd, 0);
> 		if (mapping != MAP_FAILED)
> 			munmap(mapping, 0x1000);
> 		close(fd);
>   	}
> 
> Due to the race to get the iint->mutex between ima_file_hash and
> process_measurement iint->ima_hash could still be NULL.
> 
> Fixes: 6beea7afcc72 ("ima: add the ability to query the cached hash
> of a given file")
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  security/integrity/ima/ima_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index 8a91711ca79b..4c86cd4eece0 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -531,6 +531,16 @@ int ima_file_hash(struct file *file, char *buf,
> size_t buf_size)
>  		return -EOPNOTSUPP;
>  
>  	mutex_lock(&iint->mutex);
> +
> +	/*
> +	 * ima_file_hash can be called when ima_collect_measurement has
> still
> +	 * not been called, we might not always have a hash.
> +	 */
> +	if (!iint->ima_hash) {
> +		mutex_unlock(&iint->mutex);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (buf) {
>  		size_t copied_size;
>  

