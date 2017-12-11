From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Mon, 11 Dec 2017 19:22:09 +0900
Subject: [RFC v2 1/3] security: Add safe,
	dynamic (runtime-loadable) hook support
In-Reply-To: <alpine.LFD.2.20.1712110909081.19397@localhost>
References: <cover.1512704909.git.sargun@netflix.com>
	<5c089f6eb3bcec36e6021db7dcfcd4409be99111.1512704909.git.sargun@netflix.com>
	<0f07d85c-7434-a92b-0060-a31ad31ab962@schaufler-ca.com>
	<alpine.LFD.2.20.1712110909081.19397@localhost>
Message-ID: <201712111922.CJC34800.JOOLtHSVQMOFFF@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Morris wrote:
> On Fri, 8 Dec 2017, Casey Schaufler wrote:
> > Would it make sense to have lsm_dynamic.h ?
> 
> Yes.

OK, you are going to consider LKM based LSMs, aren't you?
Any chance changing "struct security_hook_heads" to pure
"struct list_head[]" with enum (below patch) ?

Below patch looses __randomize_layout, but how helpful is that?
How does it differ from randomizing "enum LSM_HOOK_INDEX" (like
__randomize_enum in future)?

---
 include/linux/lsm_hooks.h | 680 +++++++++++++++-------------------------------
 security/Makefile         |   1 -
 security/dynamic.c        | 269 ------------------
 security/dynamic.h        |  18 --
 security/security.c       | 262 ++++++++----------
 5 files changed, 337 insertions(+), 893 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9c44300..3abc98a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1730,233 +1730,234 @@
 #endif /* CONFIG_BPF_SYSCALL */
 };
 
-struct security_hook_heads {
-	struct list_head binder_set_context_mgr;
-	struct list_head binder_transaction;
-	struct list_head binder_transfer_binder;
-	struct list_head binder_transfer_file;
-	struct list_head ptrace_access_check;
-	struct list_head ptrace_traceme;
-	struct list_head capget;
-	struct list_head capset;
-	struct list_head capable;
-	struct list_head quotactl;
-	struct list_head quota_on;
-	struct list_head syslog;
-	struct list_head settime;
-	struct list_head vm_enough_memory;
-	struct list_head bprm_set_creds;
-	struct list_head bprm_check_security;
-	struct list_head bprm_committing_creds;
-	struct list_head bprm_committed_creds;
-	struct list_head sb_alloc_security;
-	struct list_head sb_free_security;
-	struct list_head sb_copy_data;
-	struct list_head sb_remount;
-	struct list_head sb_kern_mount;
-	struct list_head sb_show_options;
-	struct list_head sb_statfs;
-	struct list_head sb_mount;
-	struct list_head sb_umount;
-	struct list_head sb_pivotroot;
-	struct list_head sb_set_mnt_opts;
-	struct list_head sb_clone_mnt_opts;
-	struct list_head sb_parse_opts_str;
-	struct list_head dentry_init_security;
-	struct list_head dentry_create_files_as;
+enum LSM_HOOK_INDEX {
+	LSM_HOOK_binder_set_context_mgr,
+	LSM_HOOK_binder_transaction,
+	LSM_HOOK_binder_transfer_binder,
+	LSM_HOOK_binder_transfer_file,
+	LSM_HOOK_ptrace_access_check,
+	LSM_HOOK_ptrace_traceme,
+	LSM_HOOK_capget,
+	LSM_HOOK_capset,
+	LSM_HOOK_capable,
+	LSM_HOOK_quotactl,
+	LSM_HOOK_quota_on,
+	LSM_HOOK_syslog,
+	LSM_HOOK_settime,
+	LSM_HOOK_vm_enough_memory,
+	LSM_HOOK_bprm_set_creds,
+	LSM_HOOK_bprm_check_security,
+	LSM_HOOK_bprm_committing_creds,
+	LSM_HOOK_bprm_committed_creds,
+	LSM_HOOK_sb_alloc_security,
+	LSM_HOOK_sb_free_security,
+	LSM_HOOK_sb_copy_data,
+	LSM_HOOK_sb_remount,
+	LSM_HOOK_sb_kern_mount,
+	LSM_HOOK_sb_show_options,
+	LSM_HOOK_sb_statfs,
+	LSM_HOOK_sb_mount,
+	LSM_HOOK_sb_umount,
+	LSM_HOOK_sb_pivotroot,
+	LSM_HOOK_sb_set_mnt_opts,
+	LSM_HOOK_sb_clone_mnt_opts,
+	LSM_HOOK_sb_parse_opts_str,
+	LSM_HOOK_dentry_init_security,
+	LSM_HOOK_dentry_create_files_as,
 #ifdef CONFIG_SECURITY_PATH
-	struct list_head path_unlink;
-	struct list_head path_mkdir;
-	struct list_head path_rmdir;
-	struct list_head path_mknod;
-	struct list_head path_truncate;
-	struct list_head path_symlink;
-	struct list_head path_link;
-	struct list_head path_rename;
-	struct list_head path_chmod;
-	struct list_head path_chown;
-	struct list_head path_chroot;
+	LSM_HOOK_path_unlink,
+	LSM_HOOK_path_mkdir,
+	LSM_HOOK_path_rmdir,
+	LSM_HOOK_path_mknod,
+	LSM_HOOK_path_truncate,
+	LSM_HOOK_path_symlink,
+	LSM_HOOK_path_link,
+	LSM_HOOK_path_rename,
+	LSM_HOOK_path_chmod,
+	LSM_HOOK_path_chown,
+	LSM_HOOK_path_chroot,
 #endif
-	struct list_head inode_alloc_security;
-	struct list_head inode_free_security;
-	struct list_head inode_init_security;
-	struct list_head inode_create;
-	struct list_head inode_link;
-	struct list_head inode_unlink;
-	struct list_head inode_symlink;
-	struct list_head inode_mkdir;
-	struct list_head inode_rmdir;
-	struct list_head inode_mknod;
-	struct list_head inode_rename;
-	struct list_head inode_readlink;
-	struct list_head inode_follow_link;
-	struct list_head inode_permission;
-	struct list_head inode_setattr;
-	struct list_head inode_getattr;
-	struct list_head inode_setxattr;
-	struct list_head inode_post_setxattr;
-	struct list_head inode_getxattr;
-	struct list_head inode_listxattr;
-	struct list_head inode_removexattr;
-	struct list_head inode_need_killpriv;
-	struct list_head inode_killpriv;
-	struct list_head inode_getsecurity;
-	struct list_head inode_setsecurity;
-	struct list_head inode_listsecurity;
-	struct list_head inode_getsecid;
-	struct list_head inode_copy_up;
-	struct list_head inode_copy_up_xattr;
-	struct list_head file_permission;
-	struct list_head file_alloc_security;
-	struct list_head file_free_security;
-	struct list_head file_ioctl;
-	struct list_head mmap_addr;
-	struct list_head mmap_file;
-	struct list_head file_mprotect;
-	struct list_head file_lock;
-	struct list_head file_fcntl;
-	struct list_head file_set_fowner;
-	struct list_head file_send_sigiotask;
-	struct list_head file_receive;
-	struct list_head file_open;
-	struct list_head task_alloc;
-	struct list_head task_free;
-	struct list_head cred_alloc_blank;
-	struct list_head cred_free;
-	struct list_head cred_prepare;
-	struct list_head cred_transfer;
-	struct list_head kernel_act_as;
-	struct list_head kernel_create_files_as;
-	struct list_head kernel_read_file;
-	struct list_head kernel_post_read_file;
-	struct list_head kernel_module_request;
-	struct list_head task_fix_setuid;
-	struct list_head task_setpgid;
-	struct list_head task_getpgid;
-	struct list_head task_getsid;
-	struct list_head task_getsecid;
-	struct list_head task_setnice;
-	struct list_head task_setioprio;
-	struct list_head task_getioprio;
-	struct list_head task_prlimit;
-	struct list_head task_setrlimit;
-	struct list_head task_setscheduler;
-	struct list_head task_getscheduler;
-	struct list_head task_movememory;
-	struct list_head task_kill;
-	struct list_head task_prctl;
-	struct list_head task_to_inode;
-	struct list_head ipc_permission;
-	struct list_head ipc_getsecid;
-	struct list_head msg_msg_alloc_security;
-	struct list_head msg_msg_free_security;
-	struct list_head msg_queue_alloc_security;
-	struct list_head msg_queue_free_security;
-	struct list_head msg_queue_associate;
-	struct list_head msg_queue_msgctl;
-	struct list_head msg_queue_msgsnd;
-	struct list_head msg_queue_msgrcv;
-	struct list_head shm_alloc_security;
-	struct list_head shm_free_security;
-	struct list_head shm_associate;
-	struct list_head shm_shmctl;
-	struct list_head shm_shmat;
-	struct list_head sem_alloc_security;
-	struct list_head sem_free_security;
-	struct list_head sem_associate;
-	struct list_head sem_semctl;
-	struct list_head sem_semop;
-	struct list_head netlink_send;
-	struct list_head d_instantiate;
-	struct list_head getprocattr;
-	struct list_head setprocattr;
-	struct list_head ismaclabel;
-	struct list_head secid_to_secctx;
-	struct list_head secctx_to_secid;
-	struct list_head release_secctx;
-	struct list_head inode_invalidate_secctx;
-	struct list_head inode_notifysecctx;
-	struct list_head inode_setsecctx;
-	struct list_head inode_getsecctx;
+	LSM_HOOK_inode_alloc_security,
+	LSM_HOOK_inode_free_security,
+	LSM_HOOK_inode_init_security,
+	LSM_HOOK_inode_create,
+	LSM_HOOK_inode_link,
+	LSM_HOOK_inode_unlink,
+	LSM_HOOK_inode_symlink,
+	LSM_HOOK_inode_mkdir,
+	LSM_HOOK_inode_rmdir,
+	LSM_HOOK_inode_mknod,
+	LSM_HOOK_inode_rename,
+	LSM_HOOK_inode_readlink,
+	LSM_HOOK_inode_follow_link,
+	LSM_HOOK_inode_permission,
+	LSM_HOOK_inode_setattr,
+	LSM_HOOK_inode_getattr,
+	LSM_HOOK_inode_setxattr,
+	LSM_HOOK_inode_post_setxattr,
+	LSM_HOOK_inode_getxattr,
+	LSM_HOOK_inode_listxattr,
+	LSM_HOOK_inode_removexattr,
+	LSM_HOOK_inode_need_killpriv,
+	LSM_HOOK_inode_killpriv,
+	LSM_HOOK_inode_getsecurity,
+	LSM_HOOK_inode_setsecurity,
+	LSM_HOOK_inode_listsecurity,
+	LSM_HOOK_inode_getsecid,
+	LSM_HOOK_inode_copy_up,
+	LSM_HOOK_inode_copy_up_xattr,
+	LSM_HOOK_file_permission,
+	LSM_HOOK_file_alloc_security,
+	LSM_HOOK_file_free_security,
+	LSM_HOOK_file_ioctl,
+	LSM_HOOK_mmap_addr,
+	LSM_HOOK_mmap_file,
+	LSM_HOOK_file_mprotect,
+	LSM_HOOK_file_lock,
+	LSM_HOOK_file_fcntl,
+	LSM_HOOK_file_set_fowner,
+	LSM_HOOK_file_send_sigiotask,
+	LSM_HOOK_file_receive,
+	LSM_HOOK_file_open,
+	LSM_HOOK_task_alloc,
+	LSM_HOOK_task_free,
+	LSM_HOOK_cred_alloc_blank,
+	LSM_HOOK_cred_free,
+	LSM_HOOK_cred_prepare,
+	LSM_HOOK_cred_transfer,
+	LSM_HOOK_kernel_act_as,
+	LSM_HOOK_kernel_create_files_as,
+	LSM_HOOK_kernel_read_file,
+	LSM_HOOK_kernel_post_read_file,
+	LSM_HOOK_kernel_module_request,
+	LSM_HOOK_task_fix_setuid,
+	LSM_HOOK_task_setpgid,
+	LSM_HOOK_task_getpgid,
+	LSM_HOOK_task_getsid,
+	LSM_HOOK_task_getsecid,
+	LSM_HOOK_task_setnice,
+	LSM_HOOK_task_setioprio,
+	LSM_HOOK_task_getioprio,
+	LSM_HOOK_task_prlimit,
+	LSM_HOOK_task_setrlimit,
+	LSM_HOOK_task_setscheduler,
+	LSM_HOOK_task_getscheduler,
+	LSM_HOOK_task_movememory,
+	LSM_HOOK_task_kill,
+	LSM_HOOK_task_prctl,
+	LSM_HOOK_task_to_inode,
+	LSM_HOOK_ipc_permission,
+	LSM_HOOK_ipc_getsecid,
+	LSM_HOOK_msg_msg_alloc_security,
+	LSM_HOOK_msg_msg_free_security,
+	LSM_HOOK_msg_queue_alloc_security,
+	LSM_HOOK_msg_queue_free_security,
+	LSM_HOOK_msg_queue_associate,
+	LSM_HOOK_msg_queue_msgctl,
+	LSM_HOOK_msg_queue_msgsnd,
+	LSM_HOOK_msg_queue_msgrcv,
+	LSM_HOOK_shm_alloc_security,
+	LSM_HOOK_shm_free_security,
+	LSM_HOOK_shm_associate,
+	LSM_HOOK_shm_shmctl,
+	LSM_HOOK_shm_shmat,
+	LSM_HOOK_sem_alloc_security,
+	LSM_HOOK_sem_free_security,
+	LSM_HOOK_sem_associate,
+	LSM_HOOK_sem_semctl,
+	LSM_HOOK_sem_semop,
+	LSM_HOOK_netlink_send,
+	LSM_HOOK_d_instantiate,
+	LSM_HOOK_getprocattr,
+	LSM_HOOK_setprocattr,
+	LSM_HOOK_ismaclabel,
+	LSM_HOOK_secid_to_secctx,
+	LSM_HOOK_secctx_to_secid,
+	LSM_HOOK_release_secctx,
+	LSM_HOOK_inode_invalidate_secctx,
+	LSM_HOOK_inode_notifysecctx,
+	LSM_HOOK_inode_setsecctx,
+	LSM_HOOK_inode_getsecctx,
 #ifdef CONFIG_SECURITY_NETWORK
-	struct list_head unix_stream_connect;
-	struct list_head unix_may_send;
-	struct list_head socket_create;
-	struct list_head socket_post_create;
-	struct list_head socket_bind;
-	struct list_head socket_connect;
-	struct list_head socket_listen;
-	struct list_head socket_accept;
-	struct list_head socket_sendmsg;
-	struct list_head socket_recvmsg;
-	struct list_head socket_getsockname;
-	struct list_head socket_getpeername;
-	struct list_head socket_getsockopt;
-	struct list_head socket_setsockopt;
-	struct list_head socket_shutdown;
-	struct list_head socket_sock_rcv_skb;
-	struct list_head socket_getpeersec_stream;
-	struct list_head socket_getpeersec_dgram;
-	struct list_head sk_alloc_security;
-	struct list_head sk_free_security;
-	struct list_head sk_clone_security;
-	struct list_head sk_getsecid;
-	struct list_head sock_graft;
-	struct list_head inet_conn_request;
-	struct list_head inet_csk_clone;
-	struct list_head inet_conn_established;
-	struct list_head secmark_relabel_packet;
-	struct list_head secmark_refcount_inc;
-	struct list_head secmark_refcount_dec;
-	struct list_head req_classify_flow;
-	struct list_head tun_dev_alloc_security;
-	struct list_head tun_dev_free_security;
-	struct list_head tun_dev_create;
-	struct list_head tun_dev_attach_queue;
-	struct list_head tun_dev_attach;
-	struct list_head tun_dev_open;
+	LSM_HOOK_unix_stream_connect,
+	LSM_HOOK_unix_may_send,
+	LSM_HOOK_socket_create,
+	LSM_HOOK_socket_post_create,
+	LSM_HOOK_socket_bind,
+	LSM_HOOK_socket_connect,
+	LSM_HOOK_socket_listen,
+	LSM_HOOK_socket_accept,
+	LSM_HOOK_socket_sendmsg,
+	LSM_HOOK_socket_recvmsg,
+	LSM_HOOK_socket_getsockname,
+	LSM_HOOK_socket_getpeername,
+	LSM_HOOK_socket_getsockopt,
+	LSM_HOOK_socket_setsockopt,
+	LSM_HOOK_socket_shutdown,
+	LSM_HOOK_socket_sock_rcv_skb,
+	LSM_HOOK_socket_getpeersec_stream,
+	LSM_HOOK_socket_getpeersec_dgram,
+	LSM_HOOK_sk_alloc_security,
+	LSM_HOOK_sk_free_security,
+	LSM_HOOK_sk_clone_security,
+	LSM_HOOK_sk_getsecid,
+	LSM_HOOK_sock_graft,
+	LSM_HOOK_inet_conn_request,
+	LSM_HOOK_inet_csk_clone,
+	LSM_HOOK_inet_conn_established,
+	LSM_HOOK_secmark_relabel_packet,
+	LSM_HOOK_secmark_refcount_inc,
+	LSM_HOOK_secmark_refcount_dec,
+	LSM_HOOK_req_classify_flow,
+	LSM_HOOK_tun_dev_alloc_security,
+	LSM_HOOK_tun_dev_free_security,
+	LSM_HOOK_tun_dev_create,
+	LSM_HOOK_tun_dev_attach_queue,
+	LSM_HOOK_tun_dev_attach,
+	LSM_HOOK_tun_dev_open,
 #endif	/* CONFIG_SECURITY_NETWORK */
 #ifdef CONFIG_SECURITY_INFINIBAND
-	struct list_head ib_pkey_access;
-	struct list_head ib_endport_manage_subnet;
-	struct list_head ib_alloc_security;
-	struct list_head ib_free_security;
+	LSM_HOOK_ib_pkey_access,
+	LSM_HOOK_ib_endport_manage_subnet,
+	LSM_HOOK_ib_alloc_security,
+	LSM_HOOK_ib_free_security,
 #endif	/* CONFIG_SECURITY_INFINIBAND */
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-	struct list_head xfrm_policy_alloc_security;
-	struct list_head xfrm_policy_clone_security;
-	struct list_head xfrm_policy_free_security;
-	struct list_head xfrm_policy_delete_security;
-	struct list_head xfrm_state_alloc;
-	struct list_head xfrm_state_alloc_acquire;
-	struct list_head xfrm_state_free_security;
-	struct list_head xfrm_state_delete_security;
-	struct list_head xfrm_policy_lookup;
-	struct list_head xfrm_state_pol_flow_match;
-	struct list_head xfrm_decode_session;
+	LSM_HOOK_xfrm_policy_alloc_security,
+	LSM_HOOK_xfrm_policy_clone_security,
+	LSM_HOOK_xfrm_policy_free_security,
+	LSM_HOOK_xfrm_policy_delete_security,
+	LSM_HOOK_xfrm_state_alloc,
+	LSM_HOOK_xfrm_state_alloc_acquire,
+	LSM_HOOK_xfrm_state_free_security,
+	LSM_HOOK_xfrm_state_delete_security,
+	LSM_HOOK_xfrm_policy_lookup,
+	LSM_HOOK_xfrm_state_pol_flow_match,
+	LSM_HOOK_xfrm_decode_session,
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 #ifdef CONFIG_KEYS
-	struct list_head key_alloc;
-	struct list_head key_free;
-	struct list_head key_permission;
-	struct list_head key_getsecurity;
+	LSM_HOOK_key_alloc,
+	LSM_HOOK_key_free,
+	LSM_HOOK_key_permission,
+	LSM_HOOK_key_getsecurity,
 #endif	/* CONFIG_KEYS */
 #ifdef CONFIG_AUDIT
-	struct list_head audit_rule_init;
-	struct list_head audit_rule_known;
-	struct list_head audit_rule_match;
-	struct list_head audit_rule_free;
+	LSM_HOOK_audit_rule_init,
+	LSM_HOOK_audit_rule_known,
+	LSM_HOOK_audit_rule_match,
+	LSM_HOOK_audit_rule_free,
 #endif /* CONFIG_AUDIT */
 #ifdef CONFIG_BPF_SYSCALL
-	struct list_head bpf;
-	struct list_head bpf_map;
-	struct list_head bpf_prog;
-	struct list_head bpf_map_alloc_security;
-	struct list_head bpf_map_free_security;
-	struct list_head bpf_prog_alloc_security;
-	struct list_head bpf_prog_free_security;
+	LSM_HOOK_bpf,
+	LSM_HOOK_bpf_map,
+	LSM_HOOK_bpf_prog,
+	LSM_HOOK_bpf_map_alloc_security,
+	LSM_HOOK_bpf_map_free_security,
+	LSM_HOOK_bpf_prog_alloc_security,
+	LSM_HOOK_bpf_prog_free_security,
 #endif /* CONFIG_BPF_SYSCALL */
-} __randomize_layout;
+	LSM_HOOK_MAX
+};
 
 /*
  * Security module hook list structure.
@@ -1964,7 +1965,7 @@ struct security_hook_heads {
  */
 struct security_hook_list {
 	struct list_head		list;
-	struct list_head		*head;
+	enum LSM_HOOK_INDEX             index;
 	union security_list_options	hook;
 	char				*lsm;
 } __randomize_layout;
@@ -1976,261 +1977,16 @@ struct security_hook_list {
  * text involved.
  */
 #define LSM_HOOK_INIT(HEAD, HOOK) \
-	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+	{ .index = LSM_HOOK_##HEAD, .hook = { .HEAD = HOOK } }
 
-extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 #ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
-enum dynamic_security_hook_type {
-	DYNAMIC_SECURITY_HOOK_binder_set_context_mgr,
-	DYNAMIC_SECURITY_HOOK_binder_transaction,
-	DYNAMIC_SECURITY_HOOK_binder_transfer_binder,
-	DYNAMIC_SECURITY_HOOK_binder_transfer_file,
-	DYNAMIC_SECURITY_HOOK_ptrace_access_check,
-	DYNAMIC_SECURITY_HOOK_ptrace_traceme,
-	DYNAMIC_SECURITY_HOOK_capget,
-	DYNAMIC_SECURITY_HOOK_capset,
-	DYNAMIC_SECURITY_HOOK_capable,
-	DYNAMIC_SECURITY_HOOK_quotactl,
-	DYNAMIC_SECURITY_HOOK_quota_on,
-	DYNAMIC_SECURITY_HOOK_syslog,
-	DYNAMIC_SECURITY_HOOK_settime,
-	DYNAMIC_SECURITY_HOOK_vm_enough_memory,
-	DYNAMIC_SECURITY_HOOK_bprm_set_creds,
-	DYNAMIC_SECURITY_HOOK_bprm_check_security,
-	DYNAMIC_SECURITY_HOOK_bprm_committing_creds,
-	DYNAMIC_SECURITY_HOOK_bprm_committed_creds,
-	DYNAMIC_SECURITY_HOOK_sb_alloc_security,
-	DYNAMIC_SECURITY_HOOK_sb_free_security,
-	DYNAMIC_SECURITY_HOOK_sb_copy_data,
-	DYNAMIC_SECURITY_HOOK_sb_remount,
-	DYNAMIC_SECURITY_HOOK_sb_kern_mount,
-	DYNAMIC_SECURITY_HOOK_sb_show_options,
-	DYNAMIC_SECURITY_HOOK_sb_statfs,
-	DYNAMIC_SECURITY_HOOK_sb_mount,
-	DYNAMIC_SECURITY_HOOK_sb_umount,
-	DYNAMIC_SECURITY_HOOK_sb_pivotroot,
-	DYNAMIC_SECURITY_HOOK_sb_set_mnt_opts,
-	DYNAMIC_SECURITY_HOOK_sb_clone_mnt_opts,
-	DYNAMIC_SECURITY_HOOK_sb_parse_opts_str,
-	DYNAMIC_SECURITY_HOOK_dentry_init_security,
-	DYNAMIC_SECURITY_HOOK_dentry_create_files_as,
-#ifdef CONFIG_SECURITY_PATH
-	DYNAMIC_SECURITY_HOOK_path_unlink,
-	DYNAMIC_SECURITY_HOOK_path_mkdir,
-	DYNAMIC_SECURITY_HOOK_path_rmdir,
-	DYNAMIC_SECURITY_HOOK_path_mknod,
-	DYNAMIC_SECURITY_HOOK_path_truncate,
-	DYNAMIC_SECURITY_HOOK_path_symlink,
-	DYNAMIC_SECURITY_HOOK_path_link,
-	DYNAMIC_SECURITY_HOOK_path_rename,
-	DYNAMIC_SECURITY_HOOK_path_chmod,
-	DYNAMIC_SECURITY_HOOK_path_chown,
-	DYNAMIC_SECURITY_HOOK_path_chroot,
-#endif
-	DYNAMIC_SECURITY_HOOK_inode_alloc_security,
-	DYNAMIC_SECURITY_HOOK_inode_free_security,
-	DYNAMIC_SECURITY_HOOK_inode_init_security,
-	DYNAMIC_SECURITY_HOOK_inode_create,
-	DYNAMIC_SECURITY_HOOK_inode_link,
-	DYNAMIC_SECURITY_HOOK_inode_unlink,
-	DYNAMIC_SECURITY_HOOK_inode_symlink,
-	DYNAMIC_SECURITY_HOOK_inode_mkdir,
-	DYNAMIC_SECURITY_HOOK_inode_rmdir,
-	DYNAMIC_SECURITY_HOOK_inode_mknod,
-	DYNAMIC_SECURITY_HOOK_inode_rename,
-	DYNAMIC_SECURITY_HOOK_inode_readlink,
-	DYNAMIC_SECURITY_HOOK_inode_follow_link,
-	DYNAMIC_SECURITY_HOOK_inode_permission,
-	DYNAMIC_SECURITY_HOOK_inode_setattr,
-	DYNAMIC_SECURITY_HOOK_inode_getattr,
-	DYNAMIC_SECURITY_HOOK_inode_setxattr,
-	DYNAMIC_SECURITY_HOOK_inode_post_setxattr,
-	DYNAMIC_SECURITY_HOOK_inode_getxattr,
-	DYNAMIC_SECURITY_HOOK_inode_listxattr,
-	DYNAMIC_SECURITY_HOOK_inode_removexattr,
-	DYNAMIC_SECURITY_HOOK_inode_need_killpriv,
-	DYNAMIC_SECURITY_HOOK_inode_killpriv,
-	DYNAMIC_SECURITY_HOOK_inode_listsecurity,
-	DYNAMIC_SECURITY_HOOK_inode_getsecid,
-	DYNAMIC_SECURITY_HOOK_inode_copy_up,
-	DYNAMIC_SECURITY_HOOK_inode_copy_up_xattr,
-	DYNAMIC_SECURITY_HOOK_file_permission,
-	DYNAMIC_SECURITY_HOOK_file_alloc_security,
-	DYNAMIC_SECURITY_HOOK_file_free_security,
-	DYNAMIC_SECURITY_HOOK_file_ioctl,
-	DYNAMIC_SECURITY_HOOK_mmap_addr,
-	DYNAMIC_SECURITY_HOOK_mmap_file,
-	DYNAMIC_SECURITY_HOOK_file_mprotect,
-	DYNAMIC_SECURITY_HOOK_file_lock,
-	DYNAMIC_SECURITY_HOOK_file_fcntl,
-	DYNAMIC_SECURITY_HOOK_file_set_fowner,
-	DYNAMIC_SECURITY_HOOK_file_send_sigiotask,
-	DYNAMIC_SECURITY_HOOK_file_receive,
-	DYNAMIC_SECURITY_HOOK_file_open,
-	DYNAMIC_SECURITY_HOOK_task_alloc,
-	DYNAMIC_SECURITY_HOOK_task_free,
-	DYNAMIC_SECURITY_HOOK_cred_alloc_blank,
-	DYNAMIC_SECURITY_HOOK_cred_free,
-	DYNAMIC_SECURITY_HOOK_cred_prepare,
-	DYNAMIC_SECURITY_HOOK_cred_transfer,
-	DYNAMIC_SECURITY_HOOK_kernel_act_as,
-	DYNAMIC_SECURITY_HOOK_kernel_create_files_as,
-	DYNAMIC_SECURITY_HOOK_kernel_read_file,
-	DYNAMIC_SECURITY_HOOK_kernel_post_read_file,
-	DYNAMIC_SECURITY_HOOK_kernel_module_request,
-	DYNAMIC_SECURITY_HOOK_task_fix_setuid,
-	DYNAMIC_SECURITY_HOOK_task_setpgid,
-	DYNAMIC_SECURITY_HOOK_task_getpgid,
-	DYNAMIC_SECURITY_HOOK_task_getsid,
-	DYNAMIC_SECURITY_HOOK_task_getsecid,
-	DYNAMIC_SECURITY_HOOK_task_setnice,
-	DYNAMIC_SECURITY_HOOK_task_setioprio,
-	DYNAMIC_SECURITY_HOOK_task_getioprio,
-	DYNAMIC_SECURITY_HOOK_task_prlimit,
-	DYNAMIC_SECURITY_HOOK_task_setrlimit,
-	DYNAMIC_SECURITY_HOOK_task_setscheduler,
-	DYNAMIC_SECURITY_HOOK_task_getscheduler,
-	DYNAMIC_SECURITY_HOOK_task_movememory,
-	DYNAMIC_SECURITY_HOOK_task_kill,
-	DYNAMIC_SECURITY_HOOK_task_prctl,
-	DYNAMIC_SECURITY_HOOK_task_to_inode,
-	DYNAMIC_SECURITY_HOOK_ipc_permission,
-	DYNAMIC_SECURITY_HOOK_ipc_getsecid,
-	DYNAMIC_SECURITY_HOOK_msg_msg_alloc_security,
-	DYNAMIC_SECURITY_HOOK_msg_msg_free_security,
-	DYNAMIC_SECURITY_HOOK_msg_queue_alloc_security,
-	DYNAMIC_SECURITY_HOOK_msg_queue_free_security,
-	DYNAMIC_SECURITY_HOOK_msg_queue_associate,
-	DYNAMIC_SECURITY_HOOK_msg_queue_msgctl,
-	DYNAMIC_SECURITY_HOOK_msg_queue_msgsnd,
-	DYNAMIC_SECURITY_HOOK_msg_queue_msgrcv,
-	DYNAMIC_SECURITY_HOOK_shm_alloc_security,
-	DYNAMIC_SECURITY_HOOK_shm_free_security,
-	DYNAMIC_SECURITY_HOOK_shm_associate,
-	DYNAMIC_SECURITY_HOOK_shm_shmctl,
-	DYNAMIC_SECURITY_HOOK_shm_shmat,
-	DYNAMIC_SECURITY_HOOK_sem_alloc_security,
-	DYNAMIC_SECURITY_HOOK_sem_free_security,
-	DYNAMIC_SECURITY_HOOK_sem_associate,
-	DYNAMIC_SECURITY_HOOK_sem_semctl,
-	DYNAMIC_SECURITY_HOOK_sem_semop,
-	DYNAMIC_SECURITY_HOOK_netlink_send,
-	DYNAMIC_SECURITY_HOOK_d_instantiate,
-	DYNAMIC_SECURITY_HOOK_getprocattr,
-	DYNAMIC_SECURITY_HOOK_setprocattr,
-	DYNAMIC_SECURITY_HOOK_ismaclabel,
-	DYNAMIC_SECURITY_HOOK_secid_to_secctx,
-	DYNAMIC_SECURITY_HOOK_secctx_to_secid,
-	DYNAMIC_SECURITY_HOOK_release_secctx,
-	DYNAMIC_SECURITY_HOOK_inode_invalidate_secctx,
-	DYNAMIC_SECURITY_HOOK_inode_notifysecctx,
-	DYNAMIC_SECURITY_HOOK_inode_setsecctx,
-	DYNAMIC_SECURITY_HOOK_inode_getsecctx,
-#ifdef CONFIG_SECURITY_NETWORK
-	DYNAMIC_SECURITY_HOOK_unix_stream_connect,
-	DYNAMIC_SECURITY_HOOK_unix_may_send,
-	DYNAMIC_SECURITY_HOOK_socket_create,
-	DYNAMIC_SECURITY_HOOK_socket_post_create,
-	DYNAMIC_SECURITY_HOOK_socket_bind,
-	DYNAMIC_SECURITY_HOOK_socket_connect,
-	DYNAMIC_SECURITY_HOOK_socket_listen,
-	DYNAMIC_SECURITY_HOOK_socket_accept,
-	DYNAMIC_SECURITY_HOOK_socket_sendmsg,
-	DYNAMIC_SECURITY_HOOK_socket_recvmsg,
-	DYNAMIC_SECURITY_HOOK_socket_getsockname,
-	DYNAMIC_SECURITY_HOOK_socket_getpeername,
-	DYNAMIC_SECURITY_HOOK_socket_getsockopt,
-	DYNAMIC_SECURITY_HOOK_socket_setsockopt,
-	DYNAMIC_SECURITY_HOOK_socket_shutdown,
-	DYNAMIC_SECURITY_HOOK_socket_sock_rcv_skb,
-	DYNAMIC_SECURITY_HOOK_socket_getpeersec_stream,
-	DYNAMIC_SECURITY_HOOK_socket_getpeersec_dgram,
-	DYNAMIC_SECURITY_HOOK_sk_alloc_security,
-	DYNAMIC_SECURITY_HOOK_sk_free_security,
-	DYNAMIC_SECURITY_HOOK_sk_clone_security,
-	DYNAMIC_SECURITY_HOOK_sk_getsecid,
-	DYNAMIC_SECURITY_HOOK_sock_graft,
-	DYNAMIC_SECURITY_HOOK_inet_conn_request,
-	DYNAMIC_SECURITY_HOOK_inet_csk_clone,
-	DYNAMIC_SECURITY_HOOK_inet_conn_established,
-	DYNAMIC_SECURITY_HOOK_secmark_relabel_packet,
-	DYNAMIC_SECURITY_HOOK_secmark_refcount_inc,
-	DYNAMIC_SECURITY_HOOK_secmark_refcount_dec,
-	DYNAMIC_SECURITY_HOOK_req_classify_flow,
-	DYNAMIC_SECURITY_HOOK_tun_dev_alloc_security,
-	DYNAMIC_SECURITY_HOOK_tun_dev_free_security,
-	DYNAMIC_SECURITY_HOOK_tun_dev_create,
-	DYNAMIC_SECURITY_HOOK_tun_dev_attach_queue,
-	DYNAMIC_SECURITY_HOOK_tun_dev_attach,
-	DYNAMIC_SECURITY_HOOK_tun_dev_open,
-#endif	/* CONFIG_SECURITY_NETWORK */
-#ifdef CONFIG_SECURITY_INFINIBAND
-	DYNAMIC_SECURITY_HOOK_ib_pkey_access,
-	DYNAMIC_SECURITY_HOOK_ib_endport_manage_subnet,
-	DYNAMIC_SECURITY_HOOK_ib_alloc_security,
-	DYNAMIC_SECURITY_HOOK_ib_free_security,
-#endif	/* CONFIG_SECURITY_INFINIBAND */
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-	DYNAMIC_SECURITY_HOOK_xfrm_policy_alloc_security,
-	DYNAMIC_SECURITY_HOOK_xfrm_policy_clone_security,
-	DYNAMIC_SECURITY_HOOK_xfrm_policy_free_security,
-	DYNAMIC_SECURITY_HOOK_xfrm_policy_delete_security,
-	DYNAMIC_SECURITY_HOOK_xfrm_state_alloc,
-	DYNAMIC_SECURITY_HOOK_xfrm_state_alloc_acquire,
-	DYNAMIC_SECURITY_HOOK_xfrm_state_free_security,
-	DYNAMIC_SECURITY_HOOK_xfrm_state_delete_security,
-	DYNAMIC_SECURITY_HOOK_xfrm_policy_lookup,
-	DYNAMIC_SECURITY_HOOK_xfrm_decode_session,
-#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
-#ifdef CONFIG_KEYS
-	DYNAMIC_SECURITY_HOOK_key_alloc,
-	DYNAMIC_SECURITY_HOOK_key_free,
-	DYNAMIC_SECURITY_HOOK_key_permission,
-	DYNAMIC_SECURITY_HOOK_key_getsecurity,
-#endif	/* CONFIG_KEYS */
-#ifdef CONFIG_AUDIT
-	DYNAMIC_SECURITY_HOOK_audit_rule_init,
-	DYNAMIC_SECURITY_HOOK_audit_rule_known,
-	DYNAMIC_SECURITY_HOOK_audit_rule_match,
-	DYNAMIC_SECURITY_HOOK_audit_rule_free,
-#endif /* CONFIG_AUDIT */
-#ifdef CONFIG_BPF_SYSCALL
-	DYNAMIC_SECURITY_HOOK_bpf,
-	DYNAMIC_SECURITY_HOOK_bpf_map,
-	DYNAMIC_SECURITY_HOOK_bpf_prog,
-	DYNAMIC_SECURITY_HOOK_bpf_map_alloc_security,
-	DYNAMIC_SECURITY_HOOK_bpf_map_free_security,
-	DYNAMIC_SECURITY_HOOK_bpf_prog_alloc_security,
-	DYNAMIC_SECURITY_HOOK_bpf_prog_free_security,
-#endif /* CONFIG_BPF_SYSCALL */
-	__MAX_DYNAMIC_SECURITY_HOOK,
-};
-
-struct dynamic_security_hook {
-	struct list_head		list;
-	union security_list_options	hook;
-	enum dynamic_security_hook_type type;
-	const char			*lsm;
-	struct module			*owner;
-};
-
-#define DYNAMIC_SECURITY_HOOK(NAME, LSM_NAME, TYPE, CALLBACK)	\
-static struct dynamic_security_hook NAME = {			\
-	.type		= DYNAMIC_SECURITY_HOOK_##TYPE,		\
-	.lsm		= LSM_NAME,				\
-	.hook.TYPE	= CALLBACK,				\
-	.owner		= THIS_MODULE,				\
-}
-
-
-
-extern int security_add_dynamic_hook(struct dynamic_security_hook *hook);
-extern void security_remove_dynamic_hook(struct dynamic_security_hook *hook);
+extern int security_add_dynamic_hook(struct security_hook_list *hooks,
+				     int count, char *lsm);
 #endif
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
diff --git a/security/Makefile b/security/Makefile
index 59e695a..4d2d378 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_MMU)			+= min_addr.o
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
-obj-$(CONFIG_SECURITY_DYNAMIC_HOOKS)	+= dynamic.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
 obj-$(CONFIG_AUDIT)			+= lsm_audit.o
diff --git a/security/dynamic.c b/security/dynamic.c
index cc2f5d2..e69de29 100644
--- a/security/dynamic.c
+++ b/security/dynamic.c
@@ -1,269 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/lsm_hooks.h>
-#include <linux/srcu.h>
-#include <linux/list.h>
-#include <linux/jump_label.h>
-#include <linux/module.h>
-
-#include "dynamic.h"
-
-static DEFINE_MUTEX(dynamic_hook_lock);
-DEFINE_STATIC_KEY_ARRAY_FALSE(dynamic_hooks_keys, __MAX_DYNAMIC_SECURITY_HOOK);
-
-#define DYNAMIC_HOOK(FUNC) \
-[DYNAMIC_SECURITY_HOOK_##FUNC] = {					\
-	.name		= #FUNC,					\
-}
-
-
-struct dynamic_hook dynamic_hooks[__MAX_DYNAMIC_SECURITY_HOOK] = {
-	DYNAMIC_HOOK(binder_set_context_mgr),
-	DYNAMIC_HOOK(binder_transaction),
-	DYNAMIC_HOOK(binder_transfer_binder),
-	DYNAMIC_HOOK(binder_transfer_file),
-	DYNAMIC_HOOK(ptrace_access_check),
-	DYNAMIC_HOOK(ptrace_traceme),
-	DYNAMIC_HOOK(capget),
-	DYNAMIC_HOOK(capset),
-	DYNAMIC_HOOK(capable),
-	DYNAMIC_HOOK(quotactl),
-	DYNAMIC_HOOK(quota_on),
-	DYNAMIC_HOOK(syslog),
-	DYNAMIC_HOOK(settime),
-	DYNAMIC_HOOK(vm_enough_memory),
-	DYNAMIC_HOOK(bprm_set_creds),
-	DYNAMIC_HOOK(bprm_check_security),
-	DYNAMIC_HOOK(bprm_committing_creds),
-	DYNAMIC_HOOK(bprm_committed_creds),
-	DYNAMIC_HOOK(sb_alloc_security),
-	DYNAMIC_HOOK(sb_free_security),
-	DYNAMIC_HOOK(sb_copy_data),
-	DYNAMIC_HOOK(sb_remount),
-	DYNAMIC_HOOK(sb_kern_mount),
-	DYNAMIC_HOOK(sb_show_options),
-	DYNAMIC_HOOK(sb_statfs),
-	DYNAMIC_HOOK(sb_mount),
-	DYNAMIC_HOOK(sb_umount),
-	DYNAMIC_HOOK(sb_pivotroot),
-	DYNAMIC_HOOK(sb_set_mnt_opts),
-	DYNAMIC_HOOK(sb_clone_mnt_opts),
-	DYNAMIC_HOOK(sb_parse_opts_str),
-	DYNAMIC_HOOK(dentry_init_security),
-	DYNAMIC_HOOK(dentry_create_files_as),
-#ifdef CONFIG_SECURITY_PATH
-	DYNAMIC_HOOK(path_unlink),
-	DYNAMIC_HOOK(path_mkdir),
-	DYNAMIC_HOOK(path_rmdir),
-	DYNAMIC_HOOK(path_mknod),
-	DYNAMIC_HOOK(path_truncate),
-	DYNAMIC_HOOK(path_symlink),
-	DYNAMIC_HOOK(path_link),
-	DYNAMIC_HOOK(path_rename),
-	DYNAMIC_HOOK(path_chmod),
-	DYNAMIC_HOOK(path_chown),
-	DYNAMIC_HOOK(path_chroot),
-#endif
-	DYNAMIC_HOOK(inode_alloc_security),
-	DYNAMIC_HOOK(inode_free_security),
-	DYNAMIC_HOOK(inode_init_security),
-	DYNAMIC_HOOK(inode_create),
-	DYNAMIC_HOOK(inode_link),
-	DYNAMIC_HOOK(inode_unlink),
-	DYNAMIC_HOOK(inode_symlink),
-	DYNAMIC_HOOK(inode_mkdir),
-	DYNAMIC_HOOK(inode_rmdir),
-	DYNAMIC_HOOK(inode_mknod),
-	DYNAMIC_HOOK(inode_rename),
-	DYNAMIC_HOOK(inode_readlink),
-	DYNAMIC_HOOK(inode_follow_link),
-	DYNAMIC_HOOK(inode_permission),
-	DYNAMIC_HOOK(inode_setattr),
-	DYNAMIC_HOOK(inode_getattr),
-	DYNAMIC_HOOK(inode_setxattr),
-	DYNAMIC_HOOK(inode_post_setxattr),
-	DYNAMIC_HOOK(inode_getxattr),
-	DYNAMIC_HOOK(inode_listxattr),
-	DYNAMIC_HOOK(inode_removexattr),
-	DYNAMIC_HOOK(inode_need_killpriv),
-	DYNAMIC_HOOK(inode_killpriv),
-	DYNAMIC_HOOK(inode_listsecurity),
-	DYNAMIC_HOOK(inode_getsecid),
-	DYNAMIC_HOOK(inode_copy_up),
-	DYNAMIC_HOOK(inode_copy_up_xattr),
-	DYNAMIC_HOOK(file_permission),
-	DYNAMIC_HOOK(file_alloc_security),
-	DYNAMIC_HOOK(file_free_security),
-	DYNAMIC_HOOK(file_ioctl),
-	DYNAMIC_HOOK(mmap_addr),
-	DYNAMIC_HOOK(mmap_file),
-	DYNAMIC_HOOK(file_mprotect),
-	DYNAMIC_HOOK(file_lock),
-	DYNAMIC_HOOK(file_fcntl),
-	DYNAMIC_HOOK(file_set_fowner),
-	DYNAMIC_HOOK(file_send_sigiotask),
-	DYNAMIC_HOOK(file_receive),
-	DYNAMIC_HOOK(file_open),
-	DYNAMIC_HOOK(task_alloc),
-	DYNAMIC_HOOK(task_free),
-	DYNAMIC_HOOK(cred_alloc_blank),
-	DYNAMIC_HOOK(cred_free),
-	DYNAMIC_HOOK(cred_prepare),
-	DYNAMIC_HOOK(cred_transfer),
-	DYNAMIC_HOOK(kernel_act_as),
-	DYNAMIC_HOOK(kernel_create_files_as),
-	DYNAMIC_HOOK(kernel_read_file),
-	DYNAMIC_HOOK(kernel_post_read_file),
-	DYNAMIC_HOOK(kernel_module_request),
-	DYNAMIC_HOOK(task_fix_setuid),
-	DYNAMIC_HOOK(task_setpgid),
-	DYNAMIC_HOOK(task_getpgid),
-	DYNAMIC_HOOK(task_getsid),
-	DYNAMIC_HOOK(task_getsecid),
-	DYNAMIC_HOOK(task_setnice),
-	DYNAMIC_HOOK(task_setioprio),
-	DYNAMIC_HOOK(task_getioprio),
-	DYNAMIC_HOOK(task_prlimit),
-	DYNAMIC_HOOK(task_setrlimit),
-	DYNAMIC_HOOK(task_setscheduler),
-	DYNAMIC_HOOK(task_getscheduler),
-	DYNAMIC_HOOK(task_movememory),
-	DYNAMIC_HOOK(task_kill),
-	DYNAMIC_HOOK(task_prctl),
-	DYNAMIC_HOOK(task_to_inode),
-	DYNAMIC_HOOK(ipc_permission),
-	DYNAMIC_HOOK(ipc_getsecid),
-	DYNAMIC_HOOK(msg_msg_alloc_security),
-	DYNAMIC_HOOK(msg_msg_free_security),
-	DYNAMIC_HOOK(msg_queue_alloc_security),
-	DYNAMIC_HOOK(msg_queue_free_security),
-	DYNAMIC_HOOK(msg_queue_associate),
-	DYNAMIC_HOOK(msg_queue_msgctl),
-	DYNAMIC_HOOK(msg_queue_msgsnd),
-	DYNAMIC_HOOK(msg_queue_msgrcv),
-	DYNAMIC_HOOK(shm_alloc_security),
-	DYNAMIC_HOOK(shm_free_security),
-	DYNAMIC_HOOK(shm_associate),
-	DYNAMIC_HOOK(shm_shmctl),
-	DYNAMIC_HOOK(shm_shmat),
-	DYNAMIC_HOOK(sem_alloc_security),
-	DYNAMIC_HOOK(sem_free_security),
-	DYNAMIC_HOOK(sem_associate),
-	DYNAMIC_HOOK(sem_semctl),
-	DYNAMIC_HOOK(sem_semop),
-	DYNAMIC_HOOK(netlink_send),
-	DYNAMIC_HOOK(d_instantiate),
-	DYNAMIC_HOOK(getprocattr),
-	DYNAMIC_HOOK(setprocattr),
-	DYNAMIC_HOOK(ismaclabel),
-	DYNAMIC_HOOK(secid_to_secctx),
-	DYNAMIC_HOOK(secctx_to_secid),
-	DYNAMIC_HOOK(release_secctx),
-	DYNAMIC_HOOK(inode_invalidate_secctx),
-	DYNAMIC_HOOK(inode_notifysecctx),
-	DYNAMIC_HOOK(inode_setsecctx),
-	DYNAMIC_HOOK(inode_getsecctx),
-#ifdef CONFIG_SECURITY_NETWORK
-	DYNAMIC_HOOK(unix_stream_connect),
-	DYNAMIC_HOOK(unix_may_send),
-	DYNAMIC_HOOK(socket_create),
-	DYNAMIC_HOOK(socket_post_create),
-	DYNAMIC_HOOK(socket_bind),
-	DYNAMIC_HOOK(socket_connect),
-	DYNAMIC_HOOK(socket_listen),
-	DYNAMIC_HOOK(socket_accept),
-	DYNAMIC_HOOK(socket_sendmsg),
-	DYNAMIC_HOOK(socket_recvmsg),
-	DYNAMIC_HOOK(socket_getsockname),
-	DYNAMIC_HOOK(socket_getpeername),
-	DYNAMIC_HOOK(socket_getsockopt),
-	DYNAMIC_HOOK(socket_setsockopt),
-	DYNAMIC_HOOK(socket_shutdown),
-	DYNAMIC_HOOK(socket_sock_rcv_skb),
-	DYNAMIC_HOOK(socket_getpeersec_stream),
-	DYNAMIC_HOOK(socket_getpeersec_dgram),
-	DYNAMIC_HOOK(sk_alloc_security),
-	DYNAMIC_HOOK(sk_free_security),
-	DYNAMIC_HOOK(sk_clone_security),
-	DYNAMIC_HOOK(sk_getsecid),
-	DYNAMIC_HOOK(sock_graft),
-	DYNAMIC_HOOK(inet_conn_request),
-	DYNAMIC_HOOK(inet_csk_clone),
-	DYNAMIC_HOOK(inet_conn_established),
-	DYNAMIC_HOOK(secmark_relabel_packet),
-	DYNAMIC_HOOK(secmark_refcount_inc),
-	DYNAMIC_HOOK(secmark_refcount_dec),
-	DYNAMIC_HOOK(req_classify_flow),
-	DYNAMIC_HOOK(tun_dev_alloc_security),
-	DYNAMIC_HOOK(tun_dev_free_security),
-	DYNAMIC_HOOK(tun_dev_create),
-	DYNAMIC_HOOK(tun_dev_attach_queue),
-	DYNAMIC_HOOK(tun_dev_attach),
-	DYNAMIC_HOOK(tun_dev_open),
-#endif	/* CONFIG_SECURITY_NETWORK */
-#ifdef CONFIG_SECURITY_INFINIBAND
-	DYNAMIC_HOOK(ib_pkey_access),
-	DYNAMIC_HOOK(ib_endport_manage_subnet),
-	DYNAMIC_HOOK(ib_alloc_security),
-	DYNAMIC_HOOK(ib_free_security),
-#endif	/* CONFIG_SECURITY_INFINIBAND */
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-	DYNAMIC_HOOK(xfrm_policy_alloc_security),
-	DYNAMIC_HOOK(xfrm_policy_clone_security),
-	DYNAMIC_HOOK(xfrm_policy_free_security),
-	DYNAMIC_HOOK(xfrm_policy_delete_security),
-	DYNAMIC_HOOK(xfrm_state_alloc),
-	DYNAMIC_HOOK(xfrm_state_alloc_acquire),
-	DYNAMIC_HOOK(xfrm_state_free_security),
-	DYNAMIC_HOOK(xfrm_state_delete_security),
-	DYNAMIC_HOOK(xfrm_policy_lookup),
-	DYNAMIC_HOOK(xfrm_decode_session),
-#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
-#ifdef CONFIG_KEYS
-	DYNAMIC_HOOK(key_alloc),
-	DYNAMIC_HOOK(key_free),
-	DYNAMIC_HOOK(key_permission),
-	DYNAMIC_HOOK(key_getsecurity),
-#endif	/* CONFIG_KEYS */
-#ifdef CONFIG_AUDIT
-	DYNAMIC_HOOK(audit_rule_init),
-	DYNAMIC_HOOK(audit_rule_known),
-	DYNAMIC_HOOK(audit_rule_match),
-	DYNAMIC_HOOK(audit_rule_free),
-#endif /* CONFIG_AUDIT */
-#ifdef CONFIG_BPF_SYSCALL
-	DYNAMIC_HOOK(bpf),
-	DYNAMIC_HOOK(bpf_map),
-	DYNAMIC_HOOK(bpf_prog),
-	DYNAMIC_HOOK(bpf_map_alloc_security),
-	DYNAMIC_HOOK(bpf_map_free_security),
-	DYNAMIC_HOOK(bpf_prog_alloc_security),
-	DYNAMIC_HOOK(bpf_prog_free_security),
-#endif /* CONFIG_BPF_SYSCALL */
-};
-
-/**
- * security_add_dynamic_hook - Add a dynamic hook to the dynamic hooks list
- * @hook: A populated dynamic_security_hook object
- *
- * returns 0 if the hook was successfully installed
- */
-int security_add_dynamic_hook(struct dynamic_security_hook *hook)
-{
-	WARN_ON(!try_module_get(hook->owner));
-	mutex_lock(&dynamic_hook_lock);
-	list_add_tail_rcu(&hook->list, &dynamic_hooks[hook->type].head);
-	mutex_unlock(&dynamic_hook_lock);
-	static_branch_enable(&dynamic_hooks_keys[hook->type]);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(security_add_dynamic_hook);
-
-void __init security_init_dynamic_hooks(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(dynamic_hooks); i++)
-		INIT_LIST_HEAD(&dynamic_hooks[i].head);
-}
diff --git a/security/dynamic.h b/security/dynamic.h
index 575bc4e..e69de29 100644
--- a/security/dynamic.h
+++ b/security/dynamic.h
@@ -1,18 +0,0 @@
-#include <linux/lsm_hooks.h>
-#include <linux/srcu.h>
-#include <linux/list.h>
-#include <linux/jump_label.h>
-
-#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
-extern struct static_key_false dynamic_hooks_keys[];
-
-struct dynamic_hook {
-	const char		*name;
-	struct list_head	head;
-};
-
-extern struct dynamic_hook dynamic_hooks[];
-extern void security_init_dynamic_hooks(void);
-#else
-static void security_init_dynamic_hooks(void) {}
-#endif
diff --git a/security/security.c b/security/security.c
index 278f46a..f46a635 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,13 +29,18 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <net/flow.h>
-#include "dynamic.h"
 
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+static struct list_head static_hooks[LSM_HOOK_MAX] __lsm_ro_after_init;
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+static struct list_head dynamic_hooks[LSM_HOOK_MAX];
+#else
+/* Only to avoid build failure. */
+#define dynamic_hooks static_hooks
+#endif
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
@@ -60,14 +65,15 @@ static void __init do_security_initcalls(void)
  */
 int __init security_init(void)
 {
-	int i;
-	struct list_head *list = (struct list_head *) &security_hook_heads;
+	enum LSM_HOOK_INDEX i;
 
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct list_head);
-	     i++)
-		INIT_LIST_HEAD(&list[i]);
+	for (i = 0; i < LSM_HOOK_MAX; i++)
+		INIT_LIST_HEAD(&static_hooks[i]);
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	for (i = 0; i < LSM_HOOK_MAX; i++)
+		INIT_LIST_HEAD(&dynamic_hooks[i]);
+#endif
 
-	security_init_dynamic_hooks();
 	pr_info("Security Framework initialized\n");
 
 	/*
@@ -164,13 +170,44 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	int i;
 
 	for (i = 0; i < count; i++) {
+		enum LSM_HOOK_INDEX idx = hooks[i].index;
+
 		hooks[i].lsm = lsm;
-		list_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		if (idx < LSM_HOOK_MAX)
+			list_add_tail_rcu(&hooks[i].list, &static_hooks[idx]);
 	}
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
 }
 
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+
+/**
+ * security_add_dynamic_hook - Add a dynamic hook to the dynamic hooks list
+ * @hook: A populated dynamic_security_hook object
+ *
+ * returns 0 if the hook was successfully installed
+ */
+int security_add_dynamic_hook(struct security_hook_list *hooks, int count,
+			      char *lsm)
+{
+	int i;
+
+	if (lsm_append(lsm, &lsm_names) < 0)
+		return -ENOMEM;
+	for (i = 0; i < count; i++) {
+		enum LSM_HOOK_INDEX idx = hooks[i].index;
+
+		hooks[i].lsm = lsm;
+		if (idx < LSM_HOOK_MAX)
+			list_add_tail_rcu(&hooks[i].list, &dynamic_hooks[idx]);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(security_add_dynamic_hook);
+
+#endif
+
 int call_lsm_notifier(enum lsm_event event, void *data)
 {
 	return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
@@ -199,67 +236,31 @@ int unregister_lsm_notifier(struct notifier_block *nb)
  *	This is a hook that returns a value.
  */
 
-#define call_void_hook_builtin(FUNC, ...) do {			\
+#define call_void_hook(FUNC, ...) do {				\
 	struct security_hook_list *P;				\
-	list_for_each_entry(P, &security_hook_heads.FUNC, list)	\
+								\
+	list_for_each_entry(P, &static_hooks[LSM_HOOK_##FUNC], list) \
 		P->hook.FUNC(__VA_ARGS__);			\
+	if (IS_ENABLED(CONFIG_SECURITY_DYNAMIC_HOOKS))		\
+		list_for_each_entry(P, &dynamic_hooks[LSM_HOOK_##FUNC], list) \
+			P->hook.FUNC(__VA_ARGS__);		\
 } while (0)
 
-#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
-#define IS_DYNAMIC_HOOK_ENABLED(FUNC) \
-static_branch_unlikely(&dynamic_hooks_keys[DYNAMIC_SECURITY_HOOK_##FUNC])
-
-#define call_void_hook_dynamic(FUNC, ...) ({			\
-	struct dynamic_security_hook *dsh;			\
-	struct dynamic_hook *dh;				\
-	dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_##FUNC];	\
-	list_for_each_entry_rcu(dsh, &dh->head, list)		\
-		dsh->hook.FUNC(__VA_ARGS__);			\
-})
-
-#define call_void_hook(FUNC, ...)				\
-	do {							\
-		call_void_hook_builtin(FUNC, __VA_ARGS__);	\
-		if (!IS_DYNAMIC_HOOK_ENABLED(FUNC))		\
-			break;					\
-		call_void_hook_dynamic(FUNC, __VA_ARGS__);	\
-	} while (0)
-
-#define call_int_hook(FUNC, IRC, ...) ({				\
-	int RC = IRC;							\
-	do {								\
-		struct dynamic_security_hook *dsh;			\
-		bool continue_iteration = true;				\
-		struct security_hook_list *P;				\
-		struct dynamic_hook *dh;				\
-		list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);			\
-			if (RC != 0) {					\
-				continue_iteration = false;		\
-				break;					\
-			}						\
-		}							\
-		if (!IS_DYNAMIC_HOOK_ENABLED(FUNC))			\
-			break;						\
-		if (!continue_iteration)				\
-			break;						\
-		dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_##FUNC];	\
-		list_for_each_entry(dsh, &dh->head, list) {		\
-			RC = dsh->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)					\
-				break;					\
-		}							\
-	} while (0);							\
-	RC;								\
-})
-
-#else
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	do {							\
 		struct security_hook_list *P;			\
 								\
-		list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+		list_for_each_entry(P, &static_hooks[LSM_HOOK_##FUNC], \
+				    list) {			\
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (RC != 0)				\
+				break;				\
+		}						\
+		if (!IS_ENABLED(CONFIG_SECURITY_DYNAMIC_HOOKS) || RC != 0) \
+			break;					\
+		list_for_each_entry(P, &dynamic_hooks[LSM_HOOK_##FUNC], \
+				    list) {			\
 			RC = P->hook.FUNC(__VA_ARGS__);		\
 			if (RC != 0)				\
 				break;				\
@@ -268,10 +269,6 @@ int unregister_lsm_notifier(struct notifier_block *nb)
 	RC;							\
 })
 
-#define call_void_hook	call_void_hook_builtin
-#endif
-
-
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -357,31 +354,6 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
 	return call_int_hook(settime, 0, ts, tz);
 }
 
-#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
-static int dynamic_vm_enough_memory_mm(struct mm_struct *mm, long pages)
-{
-	struct dynamic_security_hook *dsh;
-	struct dynamic_hook *dh;
-	int rc = 1;
-
-	if (!IS_DYNAMIC_HOOK_ENABLED(vm_enough_memory))
-		return 1;
-
-	dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_vm_enough_memory];
-	list_for_each_entry(dsh, &dh->head, list) {
-		rc = dsh->hook.vm_enough_memory(mm, pages);
-		if (rc <= 0)
-			break;
-	}
-	return rc;
-}
-#else
-static int dynamic_vm_enough_memory_mm(struct mm_struct *mm, long pages)
-{
-	return 1;
-}
-#endif
-
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	struct security_hook_list *hp;
@@ -395,16 +367,24 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
-	list_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
+	list_for_each_entry(hp, &static_hooks[LSM_HOOK_vm_enough_memory],
+			    list) {
 		rc = hp->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
 			goto out;
 		}
 	}
-
-	if (dynamic_vm_enough_memory_mm(mm, pages) <= 0)
-		cap_sys_admin = 0;
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	list_for_each_entry(hp, &dynamic_hooks[LSM_HOOK_vm_enough_memory],
+			    list) {
+		rc = hp->hook.vm_enough_memory(mm, pages);
+		if (rc <= 0) {
+			cap_sys_admin = 0;
+			goto out;
+		}
+	}
+#endif
 out:
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
@@ -887,11 +867,20 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	list_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
+	list_for_each_entry(hp, &static_hooks[LSM_HOOK_inode_getsecurity],
+			    list) {
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
 			return rc;
 	}
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	list_for_each_entry(hp, &dynamic_hooks[LSM_HOOK_inode_getsecurity],
+			    list) {
+		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+#endif
 	return -EOPNOTSUPP;
 }
 
@@ -905,12 +894,22 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	list_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
+	list_for_each_entry(hp, &static_hooks[LSM_HOOK_inode_setsecurity],
+			    list) {
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
-								flags);
+						flags);
 		if (rc != -EOPNOTSUPP)
 			return rc;
 	}
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	list_for_each_entry(hp, &dynamic_hooks[LSM_HOOK_inode_setsecurity],
+			    list) {
+		rc = hp->hook.inode_setsecurity(inode, name, value, size,
+						flags);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+#endif
 	return -EOPNOTSUPP;
 }
 
@@ -1201,60 +1200,33 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 	return call_int_hook(task_kill, 0, p, info, sig, secid);
 }
 
-#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
-static int dynamic_task_prctl(int option, unsigned long arg2,
-			      unsigned long arg3, unsigned long arg4,
-			      unsigned long arg5)
+int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
+			 unsigned long arg4, unsigned long arg5)
 {
-	struct dynamic_security_hook *dsh;
-	struct dynamic_hook *dh;
-	int rc = -ENOSYS;
 	int thisrc;
+	int rc = -ENOSYS;
+	struct security_hook_list *hp;
 
-	if (!IS_DYNAMIC_HOOK_ENABLED(task_prctl))
-		goto out;
-
-	dh = &dynamic_hooks[DYNAMIC_SECURITY_HOOK_task_prctl];
-	list_for_each_entry(dsh, &dh->head, list) {
-		thisrc = dsh->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+	list_for_each_entry(hp, &static_hooks[LSM_HOOK_task_prctl], list) {
+		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
 			if (thisrc != 0)
 				break;
 		}
 	}
-
-out:
-	return rc;
-}
-#else
-static int dynamic_task_prctl(int option, unsigned long arg2,
-			      unsigned long arg3, unsigned long arg4,
-			      unsigned long arg5)
-{
-	return -ENOSYS;
-}
-
-#endif
-
-int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
-			 unsigned long arg4, unsigned long arg5)
-{
-	int thisrc;
-	int rc = -ENOSYS;
-	struct security_hook_list *hp;
-
-	list_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	if (rc != -ENOSYS)
+		return rc;
+	list_for_each_entry(hp, &dynamic_hooks[LSM_HOOK_task_prctl], list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
 			rc = thisrc;
 			if (thisrc != 0)
-				goto out;
+				break;
 		}
 	}
-
-	rc = dynamic_task_prctl(option, arg2, arg3, arg4, arg5);
-out:
+#endif
 	return rc;
 }
 
@@ -1739,7 +1711,6 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       const struct flowi *fl)
 {
 	struct security_hook_list *hp;
-	int rc = 1;
 
 	/*
 	 * Since this function is expected to return 0 or 1, the judgment
@@ -1750,12 +1721,17 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
-	list_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
-		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
-		break;
-	}
-	return rc;
+	list_for_each_entry(hp,
+			    &static_hooks[LSM_HOOK_xfrm_state_pol_flow_match],
+			    list)
+		return hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
+#ifdef CONFIG_SECURITY_DYNAMIC_HOOKS
+	list_for_each_entry(hp,
+			    &dynamic_hooks[LSM_HOOK_xfrm_state_pol_flow_match],
+			    list)
+		return hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
+#endif
+	return 1;
 }
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
-- 
1.8.3.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
