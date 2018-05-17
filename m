From: paul@paul-moore.com (Paul Moore)
Date: Thu, 17 May 2018 19:00:46 -0400
Subject: [PATCH ghak81 V3 1/3] audit: use new audit_context access
	funciton for seccomp_actions_logged
In-Reply-To: <12a849e41468d761e0782c733e58db47d83b0d16.1526430313.git.rgb@redhat.com>
References: <cover.1526430313.git.rgb@redhat.com>
	<12a849e41468d761e0782c733e58db47d83b0d16.1526430313.git.rgb@redhat.com>
Message-ID: <CAHC9VhR0Y6ZO80XrRF45QD30Gi1TK49-JTSTY0wThWZ1nrGarA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 16, 2018 at 7:55 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On the rebase of the following commit on the new seccomp actions_logged
> function, one audit_context access was missed.
>
> commit cdfb6b341f0f2409aba24b84f3b4b2bba50be5c5
> ("audit: use inline function to get audit context")
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks for the follow-up.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index cbab0da..f3d3dc6 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2497,7 +2497,7 @@ void audit_seccomp_actions_logged(const char *names, const char *old_names,
>         if (!audit_enabled)
>                 return;
>
> -       ab = audit_log_start(current->audit_context, GFP_KERNEL,
> +       ab = audit_log_start(audit_context(), GFP_KERNEL,
>                              AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return;
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
