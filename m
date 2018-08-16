From: jannh@google.com (Jann Horn)
Date: Thu, 16 Aug 2018 16:22:08 +0200
Subject: [PATCH RFC 5/5] SELinux: Support SELinux determination of
	side-channel vulnerability
In-Reply-To: <20180815235355.14908-6-casey.schaufler@intel.com>
References: <20180815235355.14908-1-casey.schaufler@intel.com>
	<20180815235355.14908-6-casey.schaufler@intel.com>
Message-ID: <CAG48ez0OAFqzak1=OEF5V8cZR_-dYUiXnUVp=mgnikexjQkELA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Aug 16, 2018 at 11:52 AM Casey Schaufler
<casey.schaufler@intel.com> wrote:
>
> SELinux considers tasks to be side-channel safe if they
> have PROCESS_SHARE access.
>
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>  security/selinux/hooks.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a8bf324130f5..7fbd7d7ac1cb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4219,6 +4219,14 @@ static void selinux_task_to_inode(struct task_struct *p,
>         spin_unlock(&isec->lock);
>  }
>
> +static int selinux_task_safe_sidechannel(struct task_struct *p)
> +{
> +       struct av_decision avd;
> +
> +       return avc_has_perm_noaudit(&selinux_state, current_sid(), task_sid(p),
> +                                   SECCLASS_PROCESS, PROCESS__SHARE, 0, &avd);
> +}

current_sid() -> current_security() -> current_cred_xxx() ->
current_cred() accesses current->cred, the subjective credentials
associated with the current syscall context, affected by
override_creds(). You probably want to look at objective credentials
here, since what you're interested in is not the security context of
the current syscall, but the security context of the userspace code
running in the current address space.

task_sid() does the right thing and looks at the objective creds.
