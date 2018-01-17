From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 17 Jan 2018 22:36:11 +0100
Subject: [PATCH] ima/policy: fix parsing of fsuuid
In-Reply-To: <1516213631-8974-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1516213631-8974-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <20180117213611.GA23599@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jan 17, 2018 at 08:27:11PM +0200, Mike Rapoport wrote:
> The switch to uuid_t invereted the logic of verfication that &entry->fsuuid
> is zero during parsing of "fsuuid=" rule. Instead of making sure the
> &entry->fsuuid field is not attempted to be overwriten, we bail out for
> perfectly correct rule.
> 
> Fixes: 787d8c530af7 ("ima/policy: switch to use uuid_t")
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
