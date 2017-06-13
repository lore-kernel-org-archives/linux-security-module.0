From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 13 Jun 2017 11:10:15 -0700
Subject: [PATCH] security: smack: smack.h - style fix
In-Reply-To: <20170610002855.23473-1-robsonde@gmail.com>
References: <20170610002855.23473-1-robsonde@gmail.com>
Message-ID: <4b1a45a9-7d11-cc13-3858-d750af21d5bc@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/9/2017 5:28 PM, Derek Robson wrote:
> Fixed checkpatch.pl warnings of "function definition argument FOO should
>  also have an identifier name"
> Found using checkpatch
>
> Signed-off-by: Derek Robson <robsonde@gmail.com>

Can you please update this to apply to:

	git://github.com/cschaufler/smack-next#smack-for-4.13


> ---
>  security/smack/smack.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 612b810fbbc6..f6563c2205b0 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -308,18 +308,21 @@ struct smk_audit_info {
>  /*
>   * These functions are in smack_access.c
>   */
> -int smk_access_entry(char *, char *, struct list_head *);
> -int smk_access(struct smack_known *, struct smack_known *,
> -	       int, struct smk_audit_info *);
> -int smk_tskacc(struct task_smack *, struct smack_known *,
> -	       u32, struct smk_audit_info *);
> -int smk_curacc(struct smack_known *, u32, struct smk_audit_info *);
> -struct smack_known *smack_from_secid(const u32);
> +int smk_access_entry(char *subject_label, char *object_label,
> +		     struct list_head *rule_list);
> +int smk_access(struct smack_known *subject, struct smack_known *object,
> +		int request, struct smk_audit_info *a);
> +int smk_tskacc(struct task_smack *tsp, struct smack_known *obj_known,
> +		u32 mode, struct smk_audit_info *a);
> +int smk_curacc(struct smack_known *obj_known,
> +		u32 mode, struct smk_audit_info *a);
> +struct smack_known *smack_from_secid(const u32 secid);
>  char *smk_parse_smack(const char *string, int len);
> -int smk_netlbl_mls(int, char *, struct netlbl_lsm_secattr *, int);
> -struct smack_known *smk_import_entry(const char *, int);
> +int smk_netlbl_mls(int level, char *catset,
> +		   struct netlbl_lsm_secattr *sap, int len);
> +struct smack_known *smk_import_entry(const char *string, int len);
>  void smk_insert_entry(struct smack_known *skp);
> -struct smack_known *smk_find_entry(const char *);
> +struct smack_known *smk_find_entry(const char *string);
>  int smack_privileged(int cap);
>  void smk_destroy_label_list(struct list_head *list);
>  

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
