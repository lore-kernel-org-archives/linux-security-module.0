Return-Path: <SRS0=+399=4C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE273C3B1BE
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Feb 2020 19:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8682E22314
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Feb 2020 19:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="v0JLbJHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgBNTDX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:03:23 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37415 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgBNTDU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Feb 2020 14:03:20 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so4306021pjb.2
        for <linux-security-module@vger.kernel.org>; Fri, 14 Feb 2020 11:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X67Mr7JHgMW0MtPbY5RUDBc6idW8KEYPReWaSuRnXh4=;
        b=v0JLbJHanSqJgxnGB542gdGMsejEY6woNkilQ94b+P9gJ+YAMQgsu9ur6JPedZ9A3Y
         F2taOjVCszau/FtGTE4KIYWb00umSwqDTMoeIGGck0H4ZjPOUWqry7S8K5Fh6x28E6iF
         SmB56gTFYXn3LYMGEXqJsCBWipK43wSQa3ZDgo9lFxdMW4DVx4MCAFdqH4uMq98UCSIy
         c/9MmVX/DzPYfTZvGTwAJ5SMGNPcSMRjI7NG0ecOjiyy9p2kZXVm4ZJcMAnPZQlkGSPK
         XMzeJo/tveLYVOhGY1FueG8X0zp7bDjMGTcFGvf/espDzfHyJ5pmJJVFdkWZzoJOr9qB
         0RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X67Mr7JHgMW0MtPbY5RUDBc6idW8KEYPReWaSuRnXh4=;
        b=TGymTxulGwiUVf7iIzQXY5JMwUmJ61lzYrCTWF4cZOUZ+gHgcc+848ZwVpWOSo6W/z
         zMXsmPUenD+tVKkoWcZNGcpM9+IgOwBNKpnIzrlJKq+nlUteQf6Wai+AZkqUXKWsm3pF
         b2vJCn0CFFQ7wtzRBz4E0n/4iX3fFPAZynsRa0EtqDCQkjZsr5TksBYcEuEwooT2M/Qo
         cRdkT3QtIUMHuDhtOCbiCcWvbmS9M+mRPtgPGr8qZL9CMydfUjgD5iJdXTtsxqf0S6PQ
         R6UJx24cC+p775L/e9KwCCXLpjaIhjF7GInojTxAiN72lrHe7jra3tfZn25VwpCKKnxx
         5OGQ==
X-Gm-Message-State: APjAAAWTLFQXu3c88UqLjIeKkYn3qB5nOcaL8eDdQd+wwvTtLAqZXoxr
        GImcQjYZuanoZ/tZpw7Tizb5YA==
X-Google-Smtp-Source: APXvYqwcwuUZwJSa7Do9y4rRp+P0PvJ6ZLvjFhDsEpfTEuG614CCQQrcH1qgYMDHXD8v2yUJD9C+uQ==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr5267083pjb.10.1581706997875;
        Fri, 14 Feb 2020 11:03:17 -0800 (PST)
Received: from cisco ([2001:420:c0c8:1005::22c])
        by smtp.gmail.com with ESMTPSA id r6sm7877667pfh.91.2020.02.14.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 11:03:17 -0800 (PST)
Date:   Fri, 14 Feb 2020 12:03:14 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, smbarber@chromium.org,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v2 19/28] stat: handle fsid mappings
Message-ID: <20200214190314.GD22883@cisco>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
 <20200214183554.1133805-20-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214183554.1133805-20-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 14, 2020 at 07:35:45PM +0100, Christian Brauner wrote:
> @@ -471,8 +484,13 @@ static long cp_new_stat64(struct kstat *stat, struct stat64 __user *statbuf)
>  #endif
>  	tmp.st_mode = stat->mode;
>  	tmp.st_nlink = stat->nlink;
> -	tmp.st_uid = from_kuid_munged(current_user_ns(), stat->uid);
> -	tmp.st_gid = from_kgid_munged(current_user_ns(), stat->gid);
> +	if (stat->userns_visible) {
> +		tmp.st_uid, from_kuid_munged(current_user_ns(), stat->uid);
> +		tmp.st_gid, from_kgid_munged(current_user_ns(), stat->gid);
> +	} else {
> +		tmp.st_uid, from_kfsuid_munged(current_user_ns(), stat->uid);
> +		tmp.st_gid, from_kfsgid_munged(current_user_ns(), stat->gid);
> +	}

I suppose this should be = ?

Tycho
