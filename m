Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62783C43387
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 22:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297EA20866
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 22:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ok3x/Ct3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbfAOWdO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:33:14 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43793 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbfAOWdO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jan 2019 17:33:14 -0500
Received: by mail-ua1-f65.google.com with SMTP id z11so1523964uaa.10
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 14:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvoVFWhot6bOui1ElZkb5mlAiMJct8FAymFNcuYXnew=;
        b=Ok3x/Ct3GtPxGgZLnGNTtzn44GvaQlbx94bXyO4z9KZJ2mHhaFR33Gx/SFf2rf+q5A
         y2nfwD7xsqQOrKTA3Wozwo0s8bvkc20dDLrucqvoE3v5E9V903yp29W69gIKZiJ4ljDY
         iM+4/tPCPH/tb3QspUh+ob0nB9h8l6WTbWxbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvoVFWhot6bOui1ElZkb5mlAiMJct8FAymFNcuYXnew=;
        b=aqCF6XCYOe5wNNjYD2yE2+LkURo98sF5l4S0D4lOuZ4V5sc6aMh2qsAWq/NvxYIG+L
         SvD6jHbbai5p0gcNgctInbTIeeOxOa4q26Ia6FbfAMVDKCJIUyncWjTBOxJ8XS5VSHEb
         S06tRudp1svB0f/ZS1UNL9u5sWuj1VL0AeSQujfytcDkLJplvXdsaGqYACspqAe3DWxW
         PZqgo6rJqhlNvdHGTfjONIRxLVu7hcIxv6cEJXpucmpdU32B6tQCkWSXyJjMZV/+CIpx
         8I5F+1I8qFOng6WAk5aI5yzKPCGM/TaCp65ovG6Ivsq3cZVz90dtuhOrZ6fp4a4x9bTt
         Wz9Q==
X-Gm-Message-State: AJcUukcaZMguEZyE/xshdVHa8Qwa7OrHaNlLk0PPmswrKwlikzxEcDi5
        wqJoUtHgpKSVJ5GDPVANVNYrwSyq2DI=
X-Google-Smtp-Source: ALg8bN4DvDVLLOgXaA/kiUlUa0TPqTxWzt5TGIO77+WLPPZOyxrKvThDBAcrBlZ8foXCyK0CewM1VA==
X-Received: by 2002:a9f:2e0b:: with SMTP id t11mr2507273uaj.79.1547591592599;
        Tue, 15 Jan 2019 14:33:12 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id x20sm7603979uan.12.2019.01.15.14.33.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 14:33:09 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id o130so979572vke.10
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 14:33:09 -0800 (PST)
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr2334501vkh.92.1547591588744;
 Tue, 15 Jan 2019 14:33:08 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jJUb3V24Yqx4m=3u_-7qv2P0qKJqreusTmpw8BkAJWL0A@mail.gmail.com>
 <20190115215020.234860-1-mortonm@chromium.org>
In-Reply-To: <20190115215020.234860-1-mortonm@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 15 Jan 2019 14:32:56 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
Message-ID: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] LSM: add SafeSetID module that gates setid calls
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 15, 2019 at 1:50 PM <mortonm@chromium.org> wrote:
> diff --git a/security/Kconfig b/security/Kconfig
> index 78dc12b7eeb3..9efc7a5e3280 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -236,6 +236,7 @@ source "security/tomoyo/Kconfig"
>  source "security/apparmor/Kconfig"
>  source "security/loadpin/Kconfig"
>  source "security/yama/Kconfig"
> +source "security/safesetid/Kconfig"
>
>  source "security/integrity/Kconfig"
>

In security-next, I'd expect "safesetid" to get added to "config LSM",
something like:

 config LSM
         string "Ordered list of enabled LSMs"
-        default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
+         default
"yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
       help
           A comma-separated list of LSMs, in initialization order.


> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> new file mode 100644
> index 000000000000..c38cab263362
> --- /dev/null
> +++ b/security/safesetid/lsm.c
> [...]
> +static struct security_hook_list safesetid_security_hooks[] = {
> +       LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
> +       LSM_HOOK_INIT(capable, safesetid_security_capable)
> +};
> +
> +static int __init safesetid_security_init(void)
> +{
> +       security_add_hooks(safesetid_security_hooks,
> +                          ARRAY_SIZE(safesetid_security_hooks), "safesetid");
> +
> +       return 0;
> +}

I think you need to add an "did I get initialized?" variable for the
securityfs init to check (see security/apparmor/apparmorfs.c).

> diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
> new file mode 100644
> index 000000000000..bf78af9bf314
> --- /dev/null
> +++ b/security/safesetid/lsm.h
> [...]
> +static int __init safesetid_init_securityfs(void)
> +{
> +       int i;
> +       int ret;

And the init check would go here to skip tree creation if safesetid
isn't running.

> +
> +       safesetid_policy_dir = securityfs_create_dir("safesetid", NULL);
> +       if (!safesetid_policy_dir) {
> +               ret = PTR_ERR(safesetid_policy_dir);
> +               goto error;
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(safesetid_files); ++i) {
> +               struct safesetid_file_entry *entry =
> +                       &safesetid_files[i];
> +               entry->dentry = securityfs_create_file(
> +                       entry->name, 0200, safesetid_policy_dir,
> +                       entry, &safesetid_file_fops);
> +               if (IS_ERR(entry->dentry)) {
> +                       ret = PTR_ERR(entry->dentry);
> +                       goto error;
> +               }
> +       }
> +
> +       return 0;
> +
> +error:
> +       safesetid_shutdown_securityfs();
> +       return ret;
> +}
> +fs_initcall(safesetid_init_securityfs);

After that, feel free to include:

Acked-by: Kees Cook <keescook@chromium.org>

Thanks for the updates!

-- 
Kees Cook
