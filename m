From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Mon, 6 Aug 2018 08:58:47 -0400
Subject: [PATCH] selinux: stricter parsing in mls_context_to_sid()
In-Reply-To: <20180803093604.38254-1-jannh@google.com>
References: <20180803093604.38254-1-jannh@google.com>
Message-ID: <a4c0b0a6-3331-1abc-266c-7e6589a04208@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/03/2018 05:36 AM, Jann Horn wrote:
> mls_context_to_sid incorrectly accepted MLS context strings that are
> followed by a dash and trailing garbage.
> 
> Before this change, the following command works:
> 
> # mount -t tmpfs -o 'context=system_u:object_r:tmp_t:s0-s0:c0-BLAH' \
> none mount
> 
> After this change, it fails with the following error message in dmesg:
> 
> SELinux: security_context_str_to_sid(system_u:object_r:tmp_t:s0-s0:c0-BLAH)
> failed for (dev tmpfs, type tmpfs) errno=-22
> 
> This is not an important bug; but it is a small quirk that was useful for
> exploiting a vulnerability in fusermount.
> 
> This patch does not change the behavior when the policy does not have MLS
> enabled.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/mls.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 39475fb455bc..2c73d612d2ee 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -344,7 +344,7 @@ int mls_context_to_sid(struct policydb *pol,
>   					break;
>   			}
>   		}
> -		if (delim == '-') {
> +		if (delim == '-' && l == 0) {
>   			/* Extract high sensitivity. */
>   			scontextp = p;
>   			while (*p && *p != ':')
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
