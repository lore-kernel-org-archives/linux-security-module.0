Return-Path: <SRS0=PrzU=TK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8B9C04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 10 May 2019 21:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE402184B
	for <linux-security-module@archiver.kernel.org>; Fri, 10 May 2019 21:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpeS/e5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfEJV2k (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 May 2019 17:28:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44401 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfEJV2k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 May 2019 17:28:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so6929035edm.11
        for <linux-security-module@vger.kernel.org>; Fri, 10 May 2019 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ULvb6m5Ct7N+U+Hk+TL0VPodYz5yvNtcE2Pdidu8130=;
        b=OpeS/e5yAb8uvpLXYNqA6N1MI8D7JXLjmHyNft0qks+8R/zc45m3XbQH7ZLcDfretb
         NJx/g0yV7jox/sIORLwOrxO1a9CV1jZa4gZ98sX8gwy7R8ojzc6s0LmwQEN7UABbk8mb
         Fxhe8bCtYUg4ePrk9piZU6axZgBrTRfXt2Nca9QBNovg68zQtj8GUi/rd7SCaOGE7XQG
         maBuJVPgPv8M7/MFnTidvVHklN5G7hqvUjLYWauPMuQewufDa3+DR5c2bfu6JIzKNOi0
         rmTdxIt5cPg9YEIjCngJ1xtbJ4MWbtHDYD1wkUYVwYJKhe+0vPHojo8IZxOQPW4XrFjy
         V9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ULvb6m5Ct7N+U+Hk+TL0VPodYz5yvNtcE2Pdidu8130=;
        b=HZcnBVeJIt43iKBub3M14G92diuuASZvrSCdMvAjh2zymMpvzPTa4x80bMY7n/hg6G
         a5g+7+bjvVV10BnGizjjcAqZDq8DCR1tlHY1ebDmA44Qdyq0udv05G0aihr1N4JorI45
         i1bjnCHHHHT0Ka544iRXtbUnRypgdOyR+w9BdvAol4Xag8x8RnR9Co+D/uB909EvXrC2
         11UHuzuWq1DT5rKU2BQxH4hYYR5LRfEe4f5VWvodBupdGgTpjSu9uJTxZpdhJL+Jr74p
         yYuDcpCZ1b8dzTDp/P65P6TPiufVY6+JyaVBIgGcQLY4p5QQ2DB9ZTkdXQWog2Zx+jUY
         IIuw==
X-Gm-Message-State: APjAAAUFraLTqWmws/JdF8JZ/tf/nE338YP6NhOFP1jExrGlCWwtnbvT
        nRwxU8yv+j63WChMQiq/1mtPHA==
X-Google-Smtp-Source: APXvYqwB8IbdmimHYeSIRTDySy1Eup7HC96peg+2fx8bMgd82d1e5doTbK2hNZI5/C/ZsrOzqlCN9w==
X-Received: by 2002:a50:f5d0:: with SMTP id x16mr13446339edm.287.1557523718509;
        Fri, 10 May 2019 14:28:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:1b:201:ee0a:cce3:df40:3ac5])
        by smtp.gmail.com with ESMTPSA id c6sm1742858edk.81.2019.05.10.14.28.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 14:28:37 -0700 (PDT)
Date:   Fri, 10 May 2019 23:28:31 +0200
From:   Jann Horn <jannh@google.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com
Subject: Re: [PATCH v2 1/3] fs: add ksys_lsetxattr() wrapper
Message-ID: <20190510212831.GD253532@google.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <20190509112420.15671-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509112420.15671-2-roberto.sassu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 09, 2019 at 01:24:18PM +0200, Roberto Sassu wrote:
> Similarly to commit 03450e271a16 ("fs: add ksys_fchmod() and do_fchmodat()
> helpers and ksys_chmod() wrapper; remove in-kernel calls to syscall"), this
> patch introduces the ksys_lsetxattr() helper to avoid in-kernel calls to
> the sys_lsetxattr() syscall.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
[...]
> +int ksys_lsetxattr(const char __user *pathname,
> +		   const char __user *name, const void __user *value,
> +		   size_t size, int flags)
> +{
> +	return path_setxattr(pathname, name, value, size, flags, 0);
> +}

Instead of exposing ksys_lsetxattr(), wouldn't it be cleaner to use
kern_path() and vfs_setxattr(), or something like that? Otherwise you're
adding more code that has to cast between kernel and user pointers.
