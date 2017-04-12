From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Wed, 12 Apr 2017 08:31:47 -0400
Subject: [PATCH] selinux: add selinux_status_get_seq() function
In-Reply-To: <1491988335-4181-1-git-send-email-sbuisson@ddn.com>
References: <1491988335-4181-1-git-send-email-sbuisson@ddn.com>
Message-ID: <1492000307.3881.5.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-04-12 at 18:12 +0900, Sebastien Buisson wrote:
> Add selinux_status_get_seq() function to give access to sequence
> number of current SELinux policy loaded to the rest of the kernel.
> 
> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
> ---
> ?include/linux/selinux.h??????|??7 +++++++
> ?security/selinux/ss/status.c | 21 +++++++++++++++++++++
> ?2 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/selinux.h b/include/linux/selinux.h
> index 44f4596..926f9f0 100644
> --- a/include/linux/selinux.h
> +++ b/include/linux/selinux.h
> @@ -24,12 +24,19 @@
> ? * selinux_is_enabled - is SELinux enabled?
> ? */
> ?bool selinux_is_enabled(void);
> +u32 selinux_status_get_seq(void);
> ?#else
> ?
> ?static inline bool selinux_is_enabled(void)
> ?{
> ?	return false;
> ?}
> +
> +static inline u32 selinux_status_get_seq(void)
> +{
> +	return 0;
> +}
> +
> ?#endif	/* CONFIG_SECURITY_SELINUX */
> ?
> ?#endif /* _LINUX_SELINUX_H */
> diff --git a/security/selinux/ss/status.c
> b/security/selinux/ss/status.c
> index d982365..a0670d3 100644
> --- a/security/selinux/ss/status.c
> +++ b/security/selinux/ss/status.c
> @@ -124,3 +124,24 @@ void selinux_status_update_policyload(int seqno)
> ?	}
> ?	mutex_unlock(&selinux_status_lock);
> ?}
> +
> +/*
> + * selinux_status_get_seq
> + *
> + * It gets current sequence of policy loaded.
> + */
> +u32 selinux_status_get_seq(void)
> +{
> +	struct selinux_kernel_status???*status;
> +	u32				seq = 0;
> +
> +	mutex_lock(&selinux_status_lock);
> +	if (selinux_status_page) {
> +		status = page_address(selinux_status_page);
> +		seq = status->sequence;
> +	}
> +	mutex_unlock(&selinux_status_lock);
> +
> +	return seq;
> +}
> +EXPORT_SYMBOL_GPL(selinux_status_get_seq);

status->sequence is a sequence number for the seqlock logic, not the
policy sequence number.  You likely want avc_policy_seqno() instead,
although I can't tell without seeing the user of this function. 
Regardless, as with the other patch, there needs to be an in-tree user
and a LSM hook interface to use this outside of the SELinux code
itself.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
