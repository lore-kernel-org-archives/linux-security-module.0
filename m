From: paul@paul-moore.com (Paul Moore)
Date: Fri, 8 Sep 2017 13:11:54 -0400
Subject: [PATCH] usb,signal,security: only pass the cred, not the secid,
	to kill_pid_info_as_cred and security_task_kill
In-Reply-To: <20170908164001.21138-1-sds@tycho.nsa.gov>
References: <20170908164001.21138-1-sds@tycho.nsa.gov>
Message-ID: <CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 8, 2017 at 12:40 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit d178bc3a708f39cbfefc3fab37032d3f2511b4ec ("user namespace: usb:
>  make usb urbs user namespace aware (v2)") changed kill_pid_info_as_uid
> to kill_pid_info_as_cred, saving and passing a cred structure instead of
> uids.  Since the secid can be obtained from the cred, drop the secid fields
> from the usb_dev_state and async structures, and drop the secid argument to
> kill_pid_info_as_cred.  Replace the secid argument to security_task_kill
> with the cred.  Update SELinux, Smack, and AppArmor to use the cred, which
> avoids the need for Smack and AppArmor to use a secid at all in this hook.
> Further changes to Smack might still be required to take full advantage of
> this change, since it should now be possible to perform capability
> checking based on the supplied cred.  The changes to Smack and AppArmor
> have only been compile-tested.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  drivers/usb/core/devio.c     | 10 ++--------
>  include/linux/lsm_hooks.h    |  5 +++--
>  include/linux/sched/signal.h |  2 +-
>  include/linux/security.h     |  4 ++--
>  kernel/signal.c              |  6 +++---
>  security/apparmor/lsm.c      | 17 ++++++++++++-----
>  security/security.c          |  4 ++--
>  security/selinux/hooks.c     |  7 +++++--
>  security/smack/smack_lsm.c   | 12 +++++-------
>  9 files changed, 35 insertions(+), 32 deletions(-)

Looks fine to me from a SELinux perspective.  If Casey and John are
happy with this I can volunteer to pull it into the selinux/next tree
(once the merge window closes), otherwise if someone else wants to
merge this my ack is below.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
