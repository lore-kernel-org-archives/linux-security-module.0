From: sargun@sargun.me (Sargun Dhillon)
Date: Fri, 8 Dec 2017 04:24:01 +0000
Subject: [RFC v2 1/3] security: Add safe, dynamic (runtime-loadable) hook
	support
In-Reply-To: <cover.1512704909.git.sargun@netflix.com>
References: <cover.1512704909.git.sargun@netflix.com>
Message-ID: <5c089f6eb3bcec36e6021db7dcfcd4409be99111.1512704909.git.sargun@netflix.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch adds dynamic security hooks. These hooks are designed to allow
for safe runtime loading. There are a few hooks that have custom
conventions and are excluded from this list.

The primary purpose of this patchset is to facilitate the development of
out-of-tree minor LSMs. The recent developments around stacking LSMs
have results in a great many number of people being interested in
use-case specific minor LSMs, and this opens the door to automatically
generated custom LSMs.

These hooks are only run after all built-in, and major LSMs are run.
The LSMs enabled by this feature must be minor LSMs, but they can poke
at the security blobs, as they should be initialized by the time their
callback happens.

There should be little runtime performance overhead for this feature,
as it's protected behind static_keys, which are disabled by default,
and are only enabled per-hook at runtime, when a module is loaded.

It also uses an enum, as opposed to a set of list_heads for loading,
and unloading hooks. These are a new set of hooks that aren't protected
(currently) by the read-only memory allocator, but the patch is written
in the manner where the memory around the hooks could eventual be
written in a sealable manner.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hooks.h | 250 ++++++++++++++++++++++++++++++++++++++++++
 security/Kconfig          |   9 ++
 security/Makefile         |   1 +
 security/dynamic.c        | 269 ++++++++++++++++++++++++++++++++++++++++++++++
 security/dynamic.h        |  18 ++++
 security/security.c       | 135 +++++++++++++++++++++--
 6 files changed, 675 insertions(+), 7 deletions(-)
 create mode 100644 security/dynamic.c
 create mode 100644 security/dynamic.h

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7161d8e7ee79..9c44300fc1f8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
+#include <linux/module.h>
 
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -1983,6 +1984,255 @@ extern char *lsm_names;
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+enum dynamic_security_hook_type {
+	DYNAMIC_SECURITY_HOOK_binder_set_context_mgr,
+	DYNAMIC_SECURITY_HOOK_binder_transaction,
+	DYNAMIC_SECURITY_HOOK_binder_transfer_binder,
+	DYNAMIC_SECURITY_HOOK_binder_transfer_file,
+	DYNAMIC_SECURITY_HOOK_ptrace_access_check,
+	DYNAMIC_SECURITY_HOOK_ptrace_traceme,
+	DYNAMIC_SECURITY_HOOK_capget,
+	DYNAMIC_SECURITY_HOOK_capset,
+	DYNAMIC_SECURITY_HOOK_capable,
+	DYNAMIC_SECURITY_HOOK_quotactl,
+	DYNAMIC_SECURITY_HOOK_quota_on,
+	DYNAMIC_SECURITY_HOOK_syslog,
+	DYNAMIC_SECURITY_HOOK_settime,
+	DYNAMIC_SECURITY_HOOK_vm_enough_memory,
+	DYNAMIC_SECURITY_HOOK_bprm_set_creds,
+	DYNAMIC_SECURITY_HOOK_bprm_check_security,
+	DYNAMIC_SECURITY_HOOK_bprm_committing_creds,
+	DYNAMIC_SECURITY_HOOK_bprm_committed_creds,
+	DYNAMIC_SECURITY_HOOK_sb_alloc_security,
+	DYNAMIC_SECURITY_HOOK_sb_free_security,
+	DYNAMIC_SECURITY_HOOK_sb_copy_data,
+	DYNAMIC_SECURITY_HOOK_sb_remount,
+	DYNAMIC_SECURITY_HOOK_sb_kern_mount,
+	DYNAMIC_SECURITY_HOOK_sb_show_options,
+	DYNAMIC_SECURITY_HOOK_sb_statfs,
+	DYNAMIC_SECURITY_HOOK_sb_mount,
+	DYNAMIC_SECURITY_HOOK_sb_umount,
+	DYNAMIC_SECURITY_HOOK_sb_pivotroot,
+	DYNAMIC_SECURITY_HOOK_sb_set_mnt_opts,
+	DYNAMIC_SECURITY_HOOK_sb_clone_mnt_opts,
+	DYNAMIC_SECURITY_HOOK_sb_parse_opts_str,
+	DYNAMIC_SECURITY_HOOK_dentry_init_security,
+	DYNAMIC_SECURITY_HOOK_dentry_create_files_as,
+#ifdef CONFIG_SECURITY_PATH
+	DYNAMIC_SECURITY_HOOK_path_unlink,
+	DYNAMIC_SECURITY_HOOK_path_mkdir,
+	DYNAMIC_SECURITY_HOOK_path_rmdir,
+	DYNAMIC_SECURITY_HOOK_path_mknod,
+	DYNAMIC_SECURITY_HOOK_path_truncate,
+	DYNAMIC_SECURITY_HOOK_path_symlink,
+	DYNAMIC_SECURITY_HOOK_path_link,
+	DYNAMIC_SECURITY_HOOK_path_rename,
+	DYNAMIC_SECURITY_HOOK_path_chmod,
+	DYNAMIC_SECURITY_HOOK_path_chown,
+	DYNAMIC_SECURITY_HOOK_path_chroot,
+#endif
+	DYNAMIC_SECURITY_HOOK_inode_alloc_security,
+	DYNAMIC_SECURITY_HOOK_inode_free_security,
+	DYNAMIC_SECURITY_HOOK_inode_init_security,
+	DYNAMIC_SECURITY_HOOK_inode_create,
+	DYNAMIC_SECURITY_HOOK_inode_link,
+	DYNAMIC_SECURITY_HOOK_inode_unlink,
+	DYNAMIC_SECURITY_HOOK_inode_symlink,
+	DYNAMIC_SECURITY_HOOK_inode_mkdir,
+	DYNAMIC_SECURITY_HOOK_inode_rmdir,
+	DYNAMIC_SECURITY_HOOK_inode_mknod,
+	DYNAMIC_SECURITY_HOOK_inode_rename,
+	DYNAMIC_SECURITY_HOOK_inode_readlink,
+	DYNAMIC_SECURITY_HOOK_inode_follow_link,
+	DYNAMIC_SECURITY_HOOK_inode_permission,
+	DYNAMIC_SECURITY_HOOK_inode_setattr,
+	DYNAMIC_SECURITY_HOOK_inode_getattr,
+	DYNAMIC_SECURITY_HOOK_inode_setxattr,
+	DYNAMIC_SECURITY_HOOK_inode_post_setxattr,
+	DYNAMIC_SECURITY_HOOK_inode_getxattr,
+	DYNAMIC_SECURITY_HOOK_inode_listxattr,
+	DYNAMIC_SECURITY_HOOK_inode_removexattr,
+	DYNAMIC_SECURITY_HOOK_inode_need_killpriv,
+	DYNAMIC_SECURITY_HOOK_inode_killpriv,
+	DYNAMIC_SECURITY_HOOK_inode_listsecurity,
+	DYNAMIC_SECURITY_HOOK_inode_getsecid,
+	DYNAMIC_SECURITY_HOOK_inode_copy_up,
+	DYNAMIC_SECURITY_HOOK_inode_copy_up_xattr,
+	DYNAMIC_SECURITY_HOOK_file_permission,
+	DYNAMIC_SECURITY_HOOK_file_alloc_security,
+	DYNAMIC_SECURITY_HOOK_file_free_security,
+	DYNAMIC_SECURITY_HOOK_file_ioctl,
+	DYNAMIC_SECURITY_HOOK_mmap_addr,
+	DYNAMIC_SECURITY_HOOK_mmap_file,
+	DYNAMIC_SECURITY_HOOK_file_mprotect,
+	DYNAMIC_SECURITY_HOOK_file_lock,
+	DYNAMIC_SECURITY_HOOK_file_fcntl,
+	DYNAMIC_SECURITY_HOOK_file_set_fowner,
+	DYNAMIC_SECURITY_HOOK_file_send_sigiotask,
+	DYNAMIC_SECURITY_HOOK_file_receive,
+	DYNAMIC_SECURITY_HOOK_file_open,
+	DYNAMIC_SECURITY_HOOK_task_alloc,
+	DYNAMIC_SECURITY_HOOK_task_free,
+	DYNAMIC_SECURITY_HOOK_cred_alloc_blank,
+	DYNAMIC_SECURITY_HOOK_cred_free,
+	DYNAMIC_SECURITY_HOOK_cred_prepare,
+	DYNAMIC_SECURITY_HOOK_cred_transfer,
+	DYNAMIC_SECURITY_HOOK_kernel_act_as,
+	DYNAMIC_SECURITY_HOOK_kernel_create_files_as,
+	DYNAMIC_SECURITY_HOOK_kernel_read_file,
+	DYNAMIC_SECURITY_HOOK_kernel_post_read_file,
+	DYNAMIC_SECURITY_HOOK_kernel_module_request,
+	DYNAMIC_SECURITY_HOOK_task_fix_setuid,
+	DYNAMIC_SECURITY_HOOK_task_setpgid,
+	DYNAMIC_SECURITY_HOOK_task_getpgid,
+	DYNAMIC_SECURITY_HOOK_task_getsid,
+	DYNAMIC_SECURITY_HOOK_task_getsecid,
+	DYNAMIC_SECURITY_HOOK_task_setnice,
+	DYNAMIC_SECURITY_HOOK_task_setioprio,
+	DYNAMIC_SECURITY_HOOK_task_getioprio,
+	DYNAMIC_SECURITY_HOOK_task_prlimit,
+	DYNAMIC_SECURITY_HOOK_task_setrlimit,
+	DYNAMIC_SECURITY_HOOK_task_setscheduler,
+	DYNAMIC_SECURITY_HOOK_task_getscheduler,
+	DYNAMIC_SECURITY_HOOK_task_movememory,
+	DYNAMIC_SECURITY_HOOK_task_kill,
+	DYNAMIC_SECURITY_HOOK_task_prctl,
+	DYNAMIC_SECURITY_HOOK_task_to_inode,
+	DYNAMIC_SECURITY_HOOK_ipc_permission,
+	DYNAMIC_SECURITY_HOOK_ipc_getsecid,
+	DYNAMIC_SECURITY_HOOK_msg_msg_alloc_security,
+	DYNAMIC_SECURITY_HOOK_msg_msg_free_security,
+	DYNAMIC_SECURITY_HOOK_msg_queue_alloc_security,
+	DYNAMIC_SECURITY_HOOK_msg_queue_free_security,
+	DYNAMIC_SECURITY_HOOK_msg_queue_associate,
+	DYNAMIC_SECURITY_HOOK_msg_queue_msgctl,
+	DYNAMIC_SECURITY_HOOK_msg_queue_msgsnd,
+	DYNAMIC_SECURITY_HOOK_msg_queue_msgrcv,
+	DYNAMIC_SECURITY_HOOK_shm_alloc_security,
+	DYNAMIC_SECURITY_HOOK_shm_free_security,
+	DYNAMIC_SECURITY_HOOK_shm_associate,
+	DYNAMIC_SECURITY_HOOK_shm_shmctl,
+	DYNAMIC_SECURITY_HOOK_shm_shmat,
+	DYNAMIC_SECURITY_HOOK_sem_alloc_security,
+	DYNAMIC_SECURITY_HOOK_sem_free_security,
+	DYNAMIC_SECURITY_HOOK_sem_associate,
+	DYNAMIC_SECURITY_HOOK_sem_semctl,
+	DYNAMIC_SECURITY_HOOK_sem_semop,
+	DYNAMIC_SECURITY_HOOK_netlink_send,
+	DYNAMIC_SECURITY_HOOK_d_instantiate,
+	DYNAMIC_SECURITY_HOOK_getprocattr,
+	DYNAMIC_SECURITY_HOOK_setprocattr,
+	DYNAMIC_SECURITY_HOOK_ismaclabel,
+	DYNAMIC_SECURITY_HOOK_secid_to_secctx,
+	DYNAMIC_SECURITY_HOOK_secctx_to_secid,
+	DYNAMIC_SECURITY_HOOK_release_secctx,
+	DYNAMIC_SECURITY_HOOK_inode_invalidate_secctx,
+	DYNAMIC_SECURITY_HOOK_inode_notifysecctx,
+	DYNAMIC_SECURITY_HOOK_inode_setsecctx,
+	DYNAMIC_SECURITY_HOOK_inode_getsecctx,
+#ifdef CONFIG_SECURITY_NETWORK
+	DYNAMIC_SECURITY_HOOK_unix_stream_connect,
+	DYNAMIC_SECURITY_HOOK_unix_may_send,
+	DYNAMIC_SECURITY_HOOK_socket_create,
+	DYNAMIC_SECURITY_HOOK_socket_post_create,
+	DYNAMIC_SECURITY_HOOK_socket_bind,
+	DYNAMIC_SECURITY_HOOK_socket_connect,
+	DYNAMIC_SECURITY_HOOK_socket_listen,
+	DYNAMIC_SECURITY_HOOK_socket_accept,
+	DYNAMIC_SECURITY_HOOK_socket_sendmsg,
+	DYNAMIC_SECURITY_HOOK_socket_recvmsg,
+	DYNAMIC_SECURITY_HOOK_socket_getsockname,
+	DYNAMIC_SECURITY_HOOK_socket_getpeername,
+	DYNAMIC_SECURITY_HOOK_socket_getsockopt,
+	DYNAMIC_SECURITY_HOOK_socket_setsockopt,
+	DYNAMIC_SECURITY_HOOK_socket_shutdown,
+	DYNAMIC_SECURITY_HOOK_socket_sock_rcv_skb,
+	DYNAMIC_SECURITY_HOOK_socket_getpeersec_stream,
+	DYNAMIC_SECURITY_HOOK_socket_getpeersec_dgram,
+	DYNAMIC_SECURITY_HOOK_sk_alloc_security,
+	DYNAMIC_SECURITY_HOOK_sk_free_security,
+	DYNAMIC_SECURITY_HOOK_sk_clone_security,
+	DYNAMIC_SECURITY_HOOK_sk_getsecid,
+	DYNAMIC_SECURITY_HOOK_sock_graft,
+	DYNAMIC_SECURITY_HOOK_inet_conn_request,
+	DYNAMIC_SECURITY_HOOK_inet_csk_clone,
+	DYNAMIC_SECURITY_HOOK_inet_conn_established,
+	DYNAMIC_SECURITY_HOOK_secmark_relabel_packet,
+	DYNAMIC_SECURITY_HOOK_secmark_refcount_inc,
+	DYNAMIC_SECURITY_HOOK_secmark_refcount_dec,
+	DYNAMIC_SECURITY_HOOK_req_classify_flow,
+	DYNAMIC_SECURITY_HOOK_tun_dev_alloc_security,
+	DYNAMIC_SECURITY_HOOK_tun_dev_free_security,
+	DYNAMIC_SECURITY_HOOK_tun_dev_create,
+	DYNAMIC_SECURITY_HOOK_tun_dev_attach_queue,
+	DYNAMIC_SECURITY_HOOK_tun_dev_attach,
+	DYNAMIC_SECURITY_HOOK_tun_dev_open,
+#endif	/* CONFIG_SECURITY_NETWORK */
+#ifdef CONFIG_SECURITY_INFINIBAND
+	DYNAMIC_SECURITY_HOOK_ib_pkey_access,
+	DYNAMIC_SECURITY_HOOK_ib_endport_manage_subnet,
+	DYNAMIC_SECURITY_HOOK_ib_alloc_security,
+	DYNAMIC_SECURITY_HOOK_ib_free_security,
+#endif	/* CONFIG_SECURITY_INFINIBAND */
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	DYNAMIC_SECURITY_HOOK_xfrm_policy_alloc_security,
+	DYNAMIC_SECURITY_HOOK_xfrm_policy_clone_security,
+	DYNAMIC_SECURITY_HOOK_xfrm_policy_free_security,
+	DYNAMIC_SECURITY_HOOK_xfrm_policy_delete_security,
+	DYNAMIC_SECURITY_HOOK_xfrm_state_alloc,
+	DYNAMIC_SECURITY_HOOK_xfrm_state_alloc_acquire,
+	DYNAMIC_SECURITY_HOOK_xfrm_state_free_security,
+	DYNAMIC_SECURITY_HOOK_xfrm_state_delete_security,
+	DYNAMIC_SECURITY_HOOK_xfrm_policy_lookup,
+	DYNAMIC_SECURITY_HOOK_xfrm_decode_session,
+#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
+#ifdef CONFIG_KEYS
+	DYNAMIC_SECURITY_HOOK_key_alloc,
+	DYNAMIC_SECURITY_HOOK_key_free,
+	DYNAMIC_SECURITY_HOOK_key_permission,
+	DYNAMIC_SECURITY_HOOK_key_getsecurity,
+#endif	/* CONFIG_KEYS */
+#ifdef CONFIG_AUDIT
+	DYNAMIC_SECURITY_HOOK_audit_rule_init,
+	DYNAMIC_SECURITY_HOOK_audit_rule_known,
+	DYNAMIC_SECURITY_HOOK_audit_rule_match,
+	DYNAMIC_SECURITY_HOOK_audit_rule_free,
+#endif /* CONFIG_AUDIT */
+#ifdef CONFIG_BPF_SYSCALL
+	DYNAMIC_SECURITY_HOOK_bpf,
+	DYNAMIC_SECURITY_HOOK_bpf_map,
+	DYNAMIC_SECURITY_HOOK_bpf_prog,
+	DYNAMIC_SECURITY_HOOK_bpf_map_alloc_security,
+	DYNAMIC_SECURITY_HOOK_bpf_map_free_security,
+	DYNAMIC_SECURITY_HOOK_bpf_prog_alloc_security,
+	DYNAMIC_SECURITY_HOOK_bpf_prog_free_security,
+#endif /* CONFIG_BPF_SYSCALL */
+	__MAX_DYNAMIC_SECURITY_HOOK,
+};
+
+struct dynamic_security_hook {
+	struct list_head		list;
+	union security_list_options	hook;
+	enum dynamic_security_hook_type type;
+	const char			*lsm;
+	struct module			*owner;
+};
+
+#define DYNAMIC_SECURITY_HOOK(NAME, LSM_NAME, TYPE, CALLBACK)	\
+static struct dynamic_security_hook NAME = {			\
+	.type		= DYNAMIC_SECURITY_HOOK_##TYPE,		\
+	.lsm		= LSM_NAME,				\
+	.hook.TYPE	= CALLBACK,				\
+	.owner		= THIS_MODULE,				\
+}
+
+
+
+extern int security_add_dynamic_hook(struct dynamic_security_hook *hook);
+extern void security_remove_dynamic_hook(struct dynamic_security_hook *hook);
+#endif
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
  * Assuring the safety of deleting a security module is up to
diff --git a/security/Kconfig b/security/Kconfig
index e8e449444e65..77841bdb5bc5 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -85,6 +85,15 @@ config SECURITY_PATH
 	  implement pathname based access controls.
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_DYNAMIC_HOOKS
+	bool "Runtime loadable (minor) LSMs via LKMs"
+	depends on SECURITY && SRCU
+	help
+	  This enables LSMs which live in LKMs, and supports loading, and
+	  unloading them safely at runtime. These LSMs must be minor LSMs.
+	  They cannot circumvent the built-in LSMs.
+	  If you are unsure how to answer this question, answer N.
+
 config INTEL_TXT
 	bool "Enable Intel(R) Trusted Execution Technology (Intel(R) TXT)"
 	depends on HAVE_INTEL_TXT
diff --git a/security/Makefile b/security/Makefile
index 4d2d3782ddef..59e695a7e4b6 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MMU)			+= min_addr.o
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
+obj-$(CONFIG_SECURITY_DYNAMIC_HOOKS)	+= dynamic.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
 obj-$(CONFIG_AUDIT)			+= lsm_audit.o
diff --git a/security/dynamic.c b/security/dynamic.c
new file mode 100644
index 000000000000..cc2f5d232e9a
--- /dev/null
+++ b/security/dynamic.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/lsm_hooks.h>
+#include <linux/srcu.h>
+#include <linux/list.h>
+#include <linux/jump_label.h>
+#include <linux/module.h>
+
+#include "dynamic.h"
+
+static DEFINE_MUTEX(dynamic_hook_lock);
+DEFINE_STATIC_KEY_ARRAY_FALSE(dynamic_hooks_keys, __MAX_DYNAMIC_SECURITY_HOOK);
+
+#define DYNAMIC_HOOK(FUNC) \
+[DYNAMIC_SECURITY_HOOK_##FUNC] = {					\
+	.name		= #FUNC,					\
+}
+
+
+struct dynamic_hook dynamic_hooks[__MAX_DYNAMIC_SECURITY_HOOK] = {
+	DYNAMIC_HOOK(binder_set_context_mgr),
+	DYNAMIC_HOOK(binder_transaction),
+	DYNAMIC_HOOK(binder_transfer_binder),
+	DYNAMIC_HOOK(binder_transfer_file),
+	DYNAMIC_HOOK(ptrace_access_check),
+	DYNAMIC_HOOK(ptrace_traceme),
+	DYNAMIC_HOOK(capget),
+	DYNAMIC_HOOK(capset),
+	DYNAMIC_HOOK(capable),
+	DYNAMIC_HOOK(quotactl),
+	DYNAMIC_HOOK(quota_on),
+	DYNAMIC_HOOK(syslog),
+	DYNAMIC_HOOK(settime),
+	DYNAMIC_HOOK(vm_enough_memory),
+	DYNAMIC_HOOK(bprm_set_creds),
+	DYNAMIC_HOOK(bprm_check_security),
+	DYNAMIC_HOOK(bprm_committing_creds),
+	DYNAMIC_HOOK(bprm_committed_creds),
+	DYNAMIC_HOOK(sb_alloc_security),
+	DYNAMIC_HOOK(sb_free_security),
+	DYNAMIC_HOOK(sb_copy_data),
+	DYNAMIC_HOOK(sb_remount),
+	DYNAMIC_HOOK(sb_kern_mount),
+	DYNAMIC_HOOK(sb_show_options),
+	DYNAMIC_HOOK(sb_statfs),
+	DYNAMIC_HOOK(sb_mount),
+	DYNAMIC_HOOK(sb_umount),
+	DYNAMIC_HOOK(sb_pivotroot),
+	DYNAMIC_HOOK(sb_set_mnt_opts),
+	DYNAMIC_HOOK(sb_clone_mnt_opts),
+	DYNAMIC_HOOK(sb_parse_opts_str),
+	DYNAMIC_HOOK(dentry_init_security),
+	DYNAMIC_HOOK(dentry_create_files_as),
+#ifdef CONFIG_SECURITY_PATH
+	DYNAMIC_HOOK(path_unlink),
+	DYNAMIC_HOOK(path_mkdir),
+	DYNAMIC_HOOK(path_rmdir),
+	DYNAMIC_HOOK(path_mknod),
+	DYNAMIC_HOOK(path_truncate),
+	DYNAMIC_HOOK(path_symlink),
+	DYNAMIC_HOOK(path_link),
+	DYNAMIC_HOOK(path_rename),
+	DYNAMIC_HOOK(path_chmod),
+	DYNAMIC_HOOK(path_chown),
+	DYNAMIC_HOOK(path_chroot),
+#endif
+	DYNAMIC_HOOK(inode_alloc_security),
+	DYNAMIC_HOOK(inode_free_security),
+	DYNAMIC_HOOK(inode_init_security),
+	DYNAMIC_HOOK(inode_create),
+	DYNAMIC_HOOK(inode_link),
+	DYNAMIC_HOOK(inode_unlink),
+	DYNAMIC_HOOK(inode_symlink),
+	DYNAMIC_HOOK(inode_mkdir),
+	DYNAMIC_HOOK(inode_rmdir),
+	DYNAMIC_HOOK(inode_mknod),
+	DYNAMIC_HOOK(inode_rename),
+	DYNAMIC_HOOK(inode_readlink),
+	DYNAMIC_HOOK(inode_follow_link),
+	DYNAMIC_HOOK(inode_permission),
+	DYNAMIC_HOOK(inode_setattr),
+	DYNAMIC_HOOK(inode_getattr),
+	DYNAMIC_HOOK(inode_setxattr),
+	DYNAMIC_HOOK(inode_post_setxattr),
+	DYNAMIC_HOOK(inode_getxattr),
+	DYNAMIC_HOOK(inode_listxattr),
+	DYNAMIC_HOOK(inode_removexattr),
+	DYNAMIC_HOOK(inode_need_killpriv),
+	DYNAMIC_HOOK(inode_killpriv),
+	DYNAMIC_HOOK(inode_listsecurity),
+	DYNAMIC_HOOK(inode_getsecid),
+	DYNAMIC_HOOK(inode_copy_up),
+	DYNAMIC_HOOK(inode_copy_up_xattr),
+	DYNAMIC_HOOK(file_permission),
+	DYNAMIC_HOOK(file_alloc_security),
+	DYNAMIC_HOOK(file_free_security),
+	DYNAMIC_HOOK(file_ioctl),
+	DYNAMIC_HOOK(mmap_addr),
+	DYNAMIC_HOOK(mmap_file),
+	DYNAMIC_HOOK(file_mprotect),
+	DYNAMIC_HOOK(file_lock),
+	DYNAMIC_HOOK(file_fcntl),
+	DYNAMIC_HOOK(file_set_fowner),
+	DYNAMIC_HOOK(file_send_sigiotask),
+	DYNAMIC_HOOK(file_receive),
+	DYNAMIC_HOOK(file_open),
+	DYNAMIC_HOOK(task_alloc),
+	DYNAMIC_HOOK(task_free),
+	DYNAMIC_HOOK(cred_alloc_blank),
+	DYNAMIC_HOOK(cred_free),
+	DYNAMIC_HOOK(cred_prepare),
+	DYNAMIC_HOOK(cred_transfer),
+	DYNAMIC_HOOK(kernel_act_as),
+	DYNAMIC_HOOK(kernel_create_files_as),
+	DYNAMIC_HOOK(kernel_read_file),
+	DYNAMIC_HOOK(kernel_post_read_file),
+	DYNAMIC_HOOK(kernel_module_request),
+	DYNAMIC_HOOK(task_fix_setuid),
+	DYNAMIC_HOOK(task_setpgid),
+	DYNAMIC_HOOK(task_getpgid),
+	DYNAMIC_HOOK(task_getsid),
+	DYNAMIC_HOOK(task_getsecid),
+	DYNAMIC_HOOK(task_setnice),
+	DYNAMIC_HOOK(task_setioprio),
+	DYNAMIC_HOOK(task_getioprio),
+	DYNAMIC_HOOK(task_prlimit),
+	DYNAMIC_HOOK(task_setrlimit),
+	DYNAMIC_HOOK(task_setscheduler),
+	DYNAMIC_HOOK(task_getscheduler),
+	DYNAMIC_HOOK(task_movememory),
+	DYNAMIC_HOOK(task_kill),
+	DYNAMIC_HOOK(task_prctl),
+	DYNAMIC_HOOK(task_to_inode),
+	DYNAMIC_HOOK(ipc_permission),
+	DYNAMIC_HOOK(ipc_getsecid),
+	DYNAMIC_HOOK(msg_msg_alloc_security),
+	DYNAMIC_HOOK(msg_msg_free_security),
+	DYNAMIC_HOOK(msg_queue_alloc_security),
+	DYNAMIC_HOOK(msg_queue_free_security),
+	DYNAMIC_HOOK(msg_queue_associate),
+	DYNAMIC_HOOK(msg_queue_msgctl),
+	DYNAMIC_HOOK(msg_queue_msgsnd),
+	DYNAMIC_HOOK(msg_queue_msgrcv),
+	DYNAMIC_HOOK(shm_alloc_security),
+	DYNAMIC_HOOK(shm_free_security),
+	DYNAMIC_HOOK(shm_associate),
+	DYNAMIC_HOOK(shm_shmctl),
+	DYNAMIC_HOOK(shm_shmat),
+	DYNAMIC_HOOK(sem_alloc_security),
+	DYNAMIC_HOOK(sem_free_security),
+	DYNAMIC_HOOK(sem_associate),
+	DYNAMIC_HOOK(sem_semctl),
+	DYNAMIC_HOOK(sem_semop),
+	DYNAMIC_HOOK(netlink_send),
+	DYNAMIC_HOOK(d_instantiate),
+	DYNAMIC_HOOK(getprocattr),
+	DYNAMIC_HOOK(setprocattr),
+	DYNAMIC_HOOK(ismaclabel),
+	DYNAMIC_HOOK(secid_to_secctx),
+	DYNAMIC_HOOK(secctx_to_secid),
+	DYNAMIC_HOOK(release_secctx),
+	DYNAMIC_HOOK(inode_invalidate_secctx),
+	DYNAMIC_HOOK(inode_notifysecctx),
+	DYNAMIC_HOOK(inode_setsecctx),
+	DYNAMIC_HOOK(inode_getsecctx),
+#ifdef CONFIG_SECURITY_NETWORK
+	DYNAMIC_HOOK(unix_stream_connect),
+	DYNAMIC_HOOK(unix_may_send),
+	DYNAMIC_HOOK(socket_create),
+	DYNAMIC_HOOK(socket_post_create),
+	DYNAMIC_HOOK(socket_bind),
+	DYNAMIC_HOOK(socket_connect),
+	DYNAMIC_HOOK(socket_listen),
+	DYNAMIC_HOOK(socket_accept),
+	DYNAMIC_HOOK(socket_sendmsg),
+	DYNAMIC_HOOK(socket_recvmsg),
+	DYNAMIC_HOOK(socket_getsockname),
+	DYNAMIC_HOOK(socket_getpeername),
+	DYNAMIC_HOOK(socket_getsockopt),
+	DYNAMIC_HOOK(socket_setsockopt),
+	DYNAMIC_HOOK(socket_shutdown),
+	DYNAMIC_HOOK(socket_sock_rcv_skb),
+	DYNAMIC_HOOK(socket_getpeersec_stream),
+	DYNAMIC_HOOK(socket_getpeersec_dgram),
+	DYNAMIC_HOOK(sk_alloc_security),
+	DYNAMIC_HOOK(sk_free_security),
+	DYNAMIC_HOOK(sk_clone_security),
+	DYNAMIC_HOOK(sk_getsecid),
+	DYNAMIC_HOOK(sock_graft),
+	DYNAMIC_HOOK(inet_conn_request),
+	DYNAMIC_HOOK(inet_csk_clone),
+	DYNAMIC_HOOK(inet_conn_established),
+	DYNAMIC_HOOK(secmark_relabel_packet),
+	DYNAMIC_HOOK(secmark_refcount_inc),
+	DYNAMIC_HOOK(secmark_refcount_dec),
+	DYNAMIC_HOOK(req_classify_flow),
+	DYNAMIC_HOOK(tun_dev_alloc_security),
+	DYNAMIC_HOOK(tun_dev_free_security),
+	DYNAMIC_HOOK(tun_dev_create),
+	DYNAMIC_HOOK(tun_dev_attach_queue),
+	DYNAMIC_HOOK(tun_dev_attach),
+	DYNAMIC_HOOK(tun_dev_open),
+#endif	/* CONFIG_SECURITY_NETWORK */
+#ifdef CONFIG_SECURITY_INFINIBAND
+	DYNAMIC_HOOK(ib_pkey_access),
+	DYNAMIC_HOOK(ib_endport_manage_subnet),
+	DYNAMIC_HOOK(ib_alloc_security),
+	DYNAMIC_HOOK(ib_free_security),
+#endif	/* CONFIG_SECURITY_INFINIBAND */
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	DYNAMIC_HOOK(xfrm_policy_alloc_security),
+	DYNAMIC_HOOK(xfrm_policy_clone_security),
+	DYNAMIC_HOOK(xfrm_policy_free_security),
+	DYNAMIC_HOOK(xfrm_policy_delete_security),
+	DYNAMIC_HOOK(xfrm_state_alloc),
+	DYNAMIC_HOOK(xfrm_state_alloc_acquire),
+	DYNAMIC_HOOK(xfrm_state_free_security),
+	DYNAMIC_HOOK(xfrm_state_delete_security),
+	DYNAMIC_HOOK(xfrm_policy_lookup),
+	DYNAMIC_HOOK(xfrm_decode_session),
+#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
+#ifdef CONFIG_KEYS
+	DYNAMIC_HOOK(key_alloc),
+	DYNAMIC_HOOK(key_free),
+	DYNAMIC_HOOK(key_permission),
+	DYNAMIC_HOOK(key_getsecurity),
+#endif	/* CONFIG_KEYS */
+#ifdef CONFIG_AUDIT
+	DYNAMIC_HOOK(audit_rule_init),
+	DYNAMIC_HOOK(audit_rule_known),
+	DYNAMIC_HOOK(audit_rule_match),
+	DYNAMIC_HOOK(audit_rule_free),
+#endif /* CONFIG_AUDIT */
+#ifdef CONFIG_BPF_SYSCALL
+	DYNAMIC_HOOK(bpf),
+	DYNAMIC_HOOK(bpf_map),
+	DYNAMIC_HOOK(bpf_prog),
+	DYNAMIC_HOOK(bpf_map_alloc_security),
+	DYNAMIC_HOOK(bpf_map_free_security),
+	DYNAMIC_HOOK(bpf_prog_alloc_security),
+	DYNAMIC_HOOK(bpf_prog_free_security),
+#endif /* CONFIG_BPF_SYSCALL */
+};
+
+/**
+ * security_add_dynamic_hook - Add a dynamic hook to the dynamic hooks list
+ * @hook: A populated dynamic_security_hook object
+ *
+ * returns 0 if the hook was successfully installed
+ */
+int security_add_dynamic_hook(struct dynamic_security_hook *hook)
+{
+	WARN_ON(!try_module_get(hook->owner));
+	mutex_lock(&dynamic_hook_lock);
+	list_add_tail_rcu(&hook->list, &dynamic_hooks[hook->type].head);
+	mutex_unlock(&dynamic_hook_lock);
+	static_branch_enable(&dynamic_hooks_keys[hook->type]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(security_add_dynamic_hook);
+
+void __init security_init_dynamic_hooks(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dynamic_hooks); i++)
+		INIT_LIST_HEAD(&dynamic_hooks[i].head);
+}
diff --git a/security/dynamic.h b/security/dynamic.h
new file mode 100644
index 000000000000..575bc4e3d370
--- /dev/null
+++ b/security/dynamic.h
@@ -0,0 +1,18 @@
+#include <linux/lsm_hooks.h>
+#include <linux/srcu.h>
+#include <linux/list.h>
+#include <linux/jump_label.h>
+
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+extern struct static_key_false dynamic_hooks_keys[];
+
+struct dynamic_hook {
+	const char		*name;
+	struct list_head	head;
+};
+
+extern struct dynamic_hook dynamic_hooks[];
+extern void security_init_dynamic_hooks(void);
+#else
+static void security_init_dynamic_hooks(void) {}
+#endif
diff --git a/security/security.c b/security/security.c
index 1cd8526cb0b7..278f46ac8fc3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,12 +29,12 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <net/flow.h>
+#include "dynamic.h"
 
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
-
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
@@ -66,6 +66,8 @@ int __init security_init(void)
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct list_head);
 	     i++)
 		INIT_LIST_HEAD(&list[i]);
+
+	security_init_dynamic_hooks();
 	pr_info("Security Framework initialized\n");
 
 	/*
@@ -197,14 +199,61 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
  *	This is a hook that returns a value.
  */
 
+#define call_void_hook_builtin(FUNC, ...) do {			\
+	struct security_hook_list *P;				\
+	list_for_each_entry(P, &security_hook_heads.FUNC, list)	\
+		P->hook.FUNC(__VA_ARGS__);			\
+} while (0)
+
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+#define IS_DYNAMIC_HOOK_ENABLED(FUNC) \
+static_branch_unlikely(&dynamic_hooks_keys[DYNAMIC_SECURITY_HOOK_##FUNC])
+
+#define call_void_hook_dynamic(FUNC, ...) ({			\
+	struct dynamic_security_hook *dsh;			\
+	struct dynamic_hook *dh;				\
+	dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_##FUNC];	\
+	list_for_each_entry_rcu(dsh, &dh->head, list)		\
+		dsh->hook.FUNC(__VA_ARGS__);			\
+})
+
 #define call_void_hook(FUNC, ...)				\
 	do {							\
-		struct security_hook_list *P;			\
-								\
-		list_for_each_entry(P, &security_hook_heads.FUNC, list)	\
-			P->hook.FUNC(__VA_ARGS__);		\
+		call_void_hook_builtin(FUNC, __VA_ARGS__);	\
+		if (!IS_DYNAMIC_HOOK_ENABLED(FUNC))		\
+			break;					\
+		call_void_hook_dynamic(FUNC, __VA_ARGS__);	\
 	} while (0)
 
+#define call_int_hook(FUNC, IRC, ...) ({				\
+	int RC = IRC;							\
+	do {								\
+		struct dynamic_security_hook *dsh;			\
+		bool continue_iteration = true;				\
+		struct security_hook_list *P;				\
+		struct dynamic_hook *dh;				\
+		list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+			RC = P->hook.FUNC(__VA_ARGS__);			\
+			if (RC != 0) {					\
+				continue_iteration = false;		\
+				break;					\
+			}						\
+		}							\
+		if (!IS_DYNAMIC_HOOK_ENABLED(FUNC))			\
+			break;						\
+		if (!continue_iteration)				\
+			break;						\
+		dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_##FUNC];	\
+		list_for_each_entry(dsh, &dh->head, list) {		\
+			RC = dsh->hook.FUNC(__VA_ARGS__);		\
+			if (RC != 0)					\
+				break;					\
+		}							\
+	} while (0);							\
+	RC;								\
+})
+
+#else
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	do {							\
@@ -219,6 +268,10 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 	RC;							\
 })
 
+#define call_void_hook	call_void_hook_builtin
+#endif
+
+
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -304,6 +357,31 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
 	return call_int_hook(settime, 0, ts, tz);
 }
 
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+static int dynamic_vm_enough_memory_mm(struct mm_struct *mm, long pages)
+{
+	struct dynamic_security_hook *dsh;
+	struct dynamic_hook *dh;
+	int rc = 1;
+
+	if (!IS_DYNAMIC_HOOK_ENABLED(vm_enough_memory))
+		return 1;
+
+	dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_vm_enough_memory];
+	list_for_each_entry(dsh, &dh->head, list) {
+		rc = dsh->hook.vm_enough_memory(mm, pages);
+		if (rc <= 0)
+			break;
+	}
+	return rc;
+}
+#else
+static int dynamic_vm_enough_memory_mm(struct mm_struct *mm, long pages)
+{
+	return 1;
+}
+#endif
+
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	struct security_hook_list *hp;
@@ -321,9 +399,13 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
-			break;
+			goto out;
 		}
 	}
+
+	if (dynamic_vm_enough_memory_mm(mm, pages) <= 0)
+		cap_sys_admin = 0;
+out:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -1119,6 +1201,42 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 	return call_int_hook(task_kill, 0, p, info, sig, secid);
 }
 
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+static int dynamic_task_prctl(int option, unsigned long arg2,
+			      unsigned long arg3, unsigned long arg4,
+			      unsigned long arg5)
+{
+	struct dynamic_security_hook *dsh;
+	struct dynamic_hook *dh;
+	int rc = -ENOSYS;
+	int thisrc;
+
+	if (!IS_DYNAMIC_HOOK_ENABLED(task_prctl))
+		goto out;
+
+	dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_task_prctl];
+	list_for_each_entry(dsh, &dh->head, list) {
+		thisrc = dsh->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+		if (thisrc != -ENOSYS) {
+			rc = thisrc;
+			if (thisrc != 0)
+				break;
+		}
+	}
+
+out:
+	return rc;
+}
+#else
+static int dynamic_task_prctl(int option, unsigned long arg2,
+			      unsigned long arg3, unsigned long arg4,
+			      unsigned long arg5)
+{
+	return -ENOSYS;
+}
+
+#endif
+
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
@@ -1131,9 +1249,12 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
 			if (thisrc != 0)
-				break;
+				goto out;
 		}
 	}
+
+	rc = dynamic_task_prctl(option, arg2, arg3, arg4, arg5);
+out:
 	return rc;
 }
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
