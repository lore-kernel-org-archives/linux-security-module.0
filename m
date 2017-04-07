From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 7 Apr 2017 14:32:39 -0500
Subject: [RFC][PATCH] audit: add ambient capabilities to CAPSET and
	BPRM_FCAPS records
In-Reply-To: <fb96ad9e604033a5d51607bdbb0b46f50442f5b6.1491471625.git.rgb@redhat.com>
References: <fb96ad9e604033a5d51607bdbb0b46f50442f5b6.1491471625.git.rgb@redhat.com>
Message-ID: <20170407193238.GB557@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> Capabilities were augmented to include ambient capabilities in v4.3
> commit 58319057b784 ("capabilities: ambient capabilities").
> 
> Add ambient capabilities to the audit BPRM_FCAPS and CAPSET records.
> 
> The record contains fields "old_pp", "old_pi", "old_pe", "new_pp",
> "new_pi", "new_pe" so in keeping with the previous record
> normalizations, change the "new_*" variants to simply drop the "new_"
> prefix.
> 
> A sample of the replaced BPRM_FCAPS record:
> RAW: type=BPRM_FCAPS msg=audit(1491468034.252:237): fver=2 fp=0000000000200000 fi=0000000000000000 fe=1 old_pp=0000000000000000 old_pi=0000000000000000 old_pe=0000000000000000 old_pa=0000000000000000 pp=0000000000200000 pi=0000000000000000 pe=0000000000200000 pa=0000000000000000
> 
> INTERPRET: type=BPRM_FCAPS msg=audit(04/06/2017 04:40:34.252:237) : fver=2 fp=sys_admin fi=none fe=chown old_pp=none old_pi=none old_pe=none old_pa=none pp=sys_admin pi=none pe=sys_admin pa=none
> 
> A sample of the replaced CAPSET record:
> RAW: type=CAPSET msg=audit(1491469502.371:242): pid=833 cap_pi=0000003fffffffff cap_pp=0000003fffffffff cap_pe=0000003fffffffff cap_pa=0000000000000000
> 
> INTERPRET: type=CAPSET msg=audit(04/06/2017 05:05:02.371:242) : pid=833
> cap_pi=chown,dac_override,dac_read_search,fowner,fsetid,kill,setgid,setuid,setpcap,linux_immutable,net_bind_service,net_broadcast,net_admin,net_raw,ipc_lock,ipc_owner,sys_module,sys_rawio,sys_chroot,sys_ptrace,sys_pacct,sys_admin,sys_boot,sys_nice,sys_resource,sys_time,sys_tty_config,mknod,lease,audit_write,audit_control,setfcap,mac_override,mac_admin,syslog,wake_alarm,block_suspend,audit_read
> cap_pp=chown,dac_override,dac_read_search,fowner,fsetid,kill,setgid,setuid,setpcap,linux_immutable,net_bind_service,net_broadcast,net_admin,net_raw,ipc_lock,ipc_owner,sys_module,sys_rawio,sys_chroot,sys_ptrace,sys_pacct,sys_admin,sys_boot,sys_nice,sys_resource,sys_time,sys_tty_config,mknod,lease,audit_write,audit_control,setfcap,mac_override,mac_admin,syslog,wake_alarm,block_suspend,audit_read
> cap_pe=chown,dac_override,dac_read_search,fowner,fsetid,kill,setgid,setuid,setpcap,linux_immutable,net_bind_service,net_broadcast,net_admin,net_raw,ipc_lock,ipc_owner,sys_module,sys_rawio,sys_chroot,sys_ptrace,sys_pacct,sys_admin,sys_boot,sys_nice,sys_resource,sys_time,sys_tty_config,mknod,lease,audit_write,audit_control,setfcap,mac_override,mac_admin,syslog,wake_alarm,block_suspend,audit_read
> cap_pa=none
> 
> See: https://github.com/linux-audit/audit-kernel/issues/40
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  kernel/audit.h   |    1 +
>  kernel/auditsc.c |   12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 144b7eb..364b155 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -68,6 +68,7 @@ struct audit_cap_data {
>  		unsigned int	fE;		/* effective bit of file cap */
>  		kernel_cap_t	effective;	/* effective set of process */
>  	};
> +	kernel_cap_t		ambient;
>  };
>  
>  /* When fs/namei.c:getname() is called, we store the pointer in name and bump
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4db32e8..ebfa93d 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1260,6 +1260,7 @@ static void show_special(struct audit_context *context, int *call_panic)
>  		audit_log_cap(ab, "cap_pi", &context->capset.cap.inheritable);
>  		audit_log_cap(ab, "cap_pp", &context->capset.cap.permitted);
>  		audit_log_cap(ab, "cap_pe", &context->capset.cap.effective);
> +		audit_log_cap(ab, "cap_pa", &context->capset.cap.ambient);
>  		break;
>  	case AUDIT_MMAP:
>  		audit_log_format(ab, "fd=%d flags=0x%x", context->mmap.fd,
> @@ -1381,9 +1382,11 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
>  			audit_log_cap(ab, "old_pp", &axs->old_pcap.permitted);
>  			audit_log_cap(ab, "old_pi", &axs->old_pcap.inheritable);
>  			audit_log_cap(ab, "old_pe", &axs->old_pcap.effective);
> -			audit_log_cap(ab, "new_pp", &axs->new_pcap.permitted);
> -			audit_log_cap(ab, "new_pi", &axs->new_pcap.inheritable);
> -			audit_log_cap(ab, "new_pe", &axs->new_pcap.effective);
> +			audit_log_cap(ab, "old_pa", &axs->old_pcap.ambient);
> +			audit_log_cap(ab, "pp", &axs->new_pcap.permitted);
> +			audit_log_cap(ab, "pi", &axs->new_pcap.inheritable);
> +			audit_log_cap(ab, "pe", &axs->new_pcap.effective);
> +			audit_log_cap(ab, "pa", &axs->new_pcap.ambient);
>  			break; }
>  
>  		}
> @@ -2340,10 +2343,12 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
>  	ax->old_pcap.permitted   = old->cap_permitted;
>  	ax->old_pcap.inheritable = old->cap_inheritable;
>  	ax->old_pcap.effective   = old->cap_effective;
> +	ax->old_pcap.ambient     = old->cap_ambient;
>  
>  	ax->new_pcap.permitted   = new->cap_permitted;
>  	ax->new_pcap.inheritable = new->cap_inheritable;
>  	ax->new_pcap.effective   = new->cap_effective;
> +	ax->new_pcap.ambient     = new->cap_ambient;
>  	return 0;
>  }
>  
> @@ -2362,6 +2367,7 @@ void __audit_log_capset(const struct cred *new, const struct cred *old)
>  	context->capset.cap.effective   = new->cap_effective;
>  	context->capset.cap.inheritable = new->cap_effective;
>  	context->capset.cap.permitted   = new->cap_permitted;
> +	context->capset.cap.ambient     = new->cap_ambient;
>  	context->type = AUDIT_CAPSET;
>  }
>  
> -- 
> 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
