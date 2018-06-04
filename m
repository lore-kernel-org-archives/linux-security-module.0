From: mjg59@google.com (Matthew Garrett)
Date: Mon, 4 Jun 2018 10:44:52 -0700
Subject: [PATCH] integrity: silence warning when CONFIG_SECURITYFS is not
	enabled
In-Reply-To: <1528121121-3959-1-git-send-email-sudeep.holla@arm.com>
References: <1528121121-3959-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CACdnJutEmbHH1LQRFu1AJa0S1KTARLuSw1sb2D_WKMsepVEE0A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jun 4, 2018 at 7:05 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> When CONFIG_SECURITYFS is not enabled, securityfs_create_dir returns
> -ENODEV which throws the following error:
>         "Unable to create integrity sysfs dir: -19"
>
> However, if the feature is disabled, it can't be warning and hence
> we need to silence the error.

I think it'd be preferable to check whether it's ENODEV rather than
doing IS_ENABLED. We should also reset integrity_dir to NULL rather
than leaving it as an error - it gets passed into various other
functions, and while those should all also just be returning errors
it'd be unfortunate if one attempted to dereference it.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
