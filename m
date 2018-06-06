From: mjg59@google.com (Matthew Garrett)
Date: Wed, 6 Jun 2018 14:07:36 -0700
Subject: [PATCH v2] integrity: silence warning when CONFIG_SECURITYFS is
	not enabled
In-Reply-To: <1528194345-9956-1-git-send-email-sudeep.holla@arm.com>
References: <1528121121-3959-1-git-send-email-sudeep.holla@arm.com>
	<1528194345-9956-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <CACdnJuuTtnj6VAV=a_BT3H4HRmkvi3xOMAMYGMHJBubw1taFqA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 5, 2018 at 3:26 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> When CONFIG_SECURITYFS is not enabled, securityfs_create_dir returns
> -ENODEV which throws the following error:
>         "Unable to create integrity sysfs dir: -19"
>
> However, if the feature is disabled, it can't be warning and hence
> we need to silence the error. This patch checks for the error -ENODEV
> which is returned when CONFIG_SECURITYFS is disabled to stop the error
> being thrown.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
ACKed-by: Matthew Garrett <mjg59@google.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
