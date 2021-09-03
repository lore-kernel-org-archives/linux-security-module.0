Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23243C433EF
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 23:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DD760F9C
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 23:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhICXbt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Sep 2021 19:31:49 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47722
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244436AbhICXbt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Sep 2021 19:31:49 -0400
Received: from [192.168.192.153] (unknown [50.45.173.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F10574019F;
        Fri,  3 Sep 2021 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630711846;
        bh=fSqoKAVb/v3yd5ZXv3SCjlXdU8zYK++3SwXEnF6fn20=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=CatxpOv1jxLe27L85oUPSAbKK+LISLMaWnFnV2z479+ux2h6VWJ34z9EbxRrEn8Dd
         gb4v0SWvCouewWv/KHH8I/GMPIMBie/6R/fd+0+mWMQmYgQgcgGHwIdRqM4wmA9ABB
         sZXA0jW3/2PbOOq5FSMrlnwydp/43/qILtmEFuDED7eaT+/4appj9G1okDJHrfbNHi
         RmP4Io2j4ZXeYgBxRjHDrjSlGrrPsT3jbV3Tz8NBYJJ7tJ0g/8IT5Afn/BrTs8MHby
         LoPei/avjhbhblLlU/Ag6vxguvzd8IfS2C9xX8SaMnQEXLpyepFKugfQNeKigCNuRb
         hbAogRnjTHCAQ==
Subject: Re: [PATCH] apparmor: remove unused argument of aa_umount()
To:     Austin Kim <austindh.kim@gmail.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210831000912.GA4588@raspberrypi>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <4b68307a-26a8-c17b-bbf6-1fb9b88e7f9e@canonical.com>
Date:   Fri, 3 Sep 2021 16:30:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831000912.GA4588@raspberrypi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/30/21 5:09 PM, Austin Kim wrote:
> The 'flags' argument in aa_umount() is not used,
> so it had better remove unused argument.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>

looks good, I'll pull this into my tree

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>  security/apparmor/include/mount.h | 2 +-
>  security/apparmor/lsm.c           | 2 +-
>  security/apparmor/mount.c         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/include/mount.h b/security/apparmor/include/mount.h
> index a710683b2496..9327456cda09 100644
> --- a/security/apparmor/include/mount.h
> +++ b/security/apparmor/include/mount.h
> @@ -42,7 +42,7 @@ int aa_new_mount(struct aa_label *label, const char *dev_name,
>  		 const struct path *path, const char *type, unsigned long flags,
>  		 void *data);
>  
> -int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags);
> +int aa_umount(struct aa_label *label, struct vfsmount *mnt);
>  
>  int aa_pivotroot(struct aa_label *label, const struct path *old_path,
>  		 const struct path *new_path);
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> Index 0834ba6a8a2e..58ba3f0605d2 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -574,7 +574,7 @@ static int apparmor_sb_umount(struct vfsmount *mnt, int flags)
>  
>  	label = __begin_current_label_crit_section();
>  	if (!unconfined(label))
> -		error = aa_umount(label, mnt, flags);
> +		error = aa_umount(label, mnt);
>  	__end_current_label_crit_section(label);
>  
>  	return error;
> diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
> index aa6fcfde3051..e33de97839ec 100644
> --- a/security/apparmor/mount.c
> +++ b/security/apparmor/mount.c
> @@ -610,7 +610,7 @@ static int profile_umount(struct aa_profile *profile, const struct path *path,
>  			   AA_MAY_UMOUNT, &perms, info, error);
>  }
>  
> -int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags)
> +int aa_umount(struct aa_label *label, struct vfsmount *mnt)
>  {
>  	struct aa_profile *profile;
>  	char *buffer = NULL;
> 

