From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sun, 14 May 2017 17:00:34 -0700
Subject: [PATCH 06/17] doc: security: minor cleanups to build kernel-doc
In-Reply-To: <1494676313-144890-7-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
	<1494676313-144890-7-git-send-email-keescook@chromium.org>
Message-ID: <426a04b7-183c-e445-4de8-fa9766b24ad4@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/13/2017 4:51 AM, Kees Cook wrote:
> These fixes were needed to parse lsm_hooks.h kernel-doc. More work is
> needed, but this is the first step.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked_by: Casey Schaufler <casey@schaufler-ca.com>

Tell me more about the additional work that's needed. 

> ---
>  include/linux/lsm_hooks.h | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 080f34e66017..a1eeaf603d2f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -29,6 +29,8 @@
>  #include <linux/rculist.h>
>  
>  /**
> + * union security_list_options - Linux Security Module hook function list
> + *
>   * Security hooks for program execution operations.
>   *
>   * @bprm_set_creds:
> @@ -193,8 +195,8 @@
>   *	@value will be set to the allocated attribute value.
>   *	@len will be set to the length of the value.
>   *	Returns 0 if @name and @value have been successfully set,
> - *		-EOPNOTSUPP if no security attribute is needed, or
> - *		-ENOMEM on memory allocation failure.
> + *	-EOPNOTSUPP if no security attribute is needed, or
> + *	-ENOMEM on memory allocation failure.
>   * @inode_create:
>   *	Check permission to create a regular file.
>   *	@dir contains inode structure of the parent of the new file.
> @@ -510,8 +512,7 @@
>   *	process @tsk.  Note that this hook is sometimes called from interrupt.
>   *	Note that the fown_struct, @fown, is never outside the context of a
>   *	struct file, so the file structure (and associated security information)
> - *	can always be obtained:
> - *		container_of(fown, struct file, f_owner)
> + *	can always be obtained: container_of(fown, struct file, f_owner)
>   *	@tsk contains the structure of task receiving signal.
>   *	@fown contains the file owner information.
>   *	@sig is the signal that will be sent.  When 0, kernel sends SIGIO.
> @@ -521,7 +522,7 @@
>   *	to receive an open file descriptor via socket IPC.
>   *	@file contains the file structure being received.
>   *	Return 0 if permission is granted.
> - * @file_open
> + * @file_open:
>   *	Save open-time permission checking state for later use upon
>   *	file_permission, and recheck access if anything has changed
>   *	since inode_permission.
> @@ -1143,7 +1144,7 @@
>   *	@sma contains the semaphore structure.  May be NULL.
>   *	@cmd contains the operation to be performed.
>   *	Return 0 if permission is granted.
> - * @sem_semop
> + * @sem_semop:
>   *	Check permissions before performing operations on members of the
>   *	semaphore set @sma.  If the @alter flag is nonzero, the semaphore set
>   *	may be modified.
> @@ -1153,20 +1154,20 @@
>   *	@alter contains the flag indicating whether changes are to be made.
>   *	Return 0 if permission is granted.
>   *
> - * @binder_set_context_mgr
> + * @binder_set_context_mgr:
>   *	Check whether @mgr is allowed to be the binder context manager.
>   *	@mgr contains the task_struct for the task being registered.
>   *	Return 0 if permission is granted.
> - * @binder_transaction
> + * @binder_transaction:
>   *	Check whether @from is allowed to invoke a binder transaction call
>   *	to @to.
>   *	@from contains the task_struct for the sending task.
>   *	@to contains the task_struct for the receiving task.
> - * @binder_transfer_binder
> + * @binder_transfer_binder:
>   *	Check whether @from is allowed to transfer a binder reference to @to.
>   *	@from contains the task_struct for the sending task.
>   *	@to contains the task_struct for the receiving task.
> - * @binder_transfer_file
> + * @binder_transfer_file:
>   *	Check whether @from is allowed to transfer @file to @to.
>   *	@from contains the task_struct for the sending task.
>   *	@file contains the struct file being transferred.
> @@ -1214,7 +1215,7 @@
>   *	@cred contains the credentials to use.
>   *	@ns contains the user namespace we want the capability in
>   *	@cap contains the capability <include/linux/capability.h>.
> - *	@audit: Whether to write an audit message or not
> + *	@audit contains whether to write an audit message or not
>   *	Return 0 if the capability is granted for @tsk.
>   * @syslog:
>   *	Check permission before accessing the kernel message ring or changing
> @@ -1336,9 +1337,7 @@
>   *	@inode we wish to get the security context of.
>   *	@ctx is a pointer in which to place the allocated security context.
>   *	@ctxlen points to the place to put the length of @ctx.
> - * This is the main security structure.
>   */
> -
>  union security_list_options {
>  	int (*binder_set_context_mgr)(struct task_struct *mgr);
>  	int (*binder_transaction)(struct task_struct *from,

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
