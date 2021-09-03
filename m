Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C8C433F5
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 03:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACFE61056
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 03:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhICDob (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Sep 2021 23:44:31 -0400
Received: from mail.hallyn.com ([178.63.66.53]:50096 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230074AbhICDoa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Sep 2021 23:44:30 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 1D60E7E8; Thu,  2 Sep 2021 22:43:29 -0500 (CDT)
Date:   Thu, 2 Sep 2021 22:43:29 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apparmor: remove unused argument of aa_umount()
Message-ID: <20210903034328.GA1636@mail.hallyn.com>
References: <20210831000912.GA4588@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831000912.GA4588@raspberrypi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 31, 2021 at 01:09:12AM +0100, Austin Kim wrote:
> The 'flags' argument in aa_umount() is not used,
> so it had better remove unused argument.

Seems fine, thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>


> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
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
> -- 
> 2.20.1
