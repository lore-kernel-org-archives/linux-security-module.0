From: john.johansen@canonical.com (John Johansen)
Date: Tue, 21 Aug 2018 16:39:41 -0700
Subject: [PATCH] apparmor: fix an error code in __aa_create_ns()
In-Reply-To: <20180802083823.qrx5ieekfvtz2w4d@kili.mountain>
References: <20180802083823.qrx5ieekfvtz2w4d@kili.mountain>
Message-ID: <ad3c3427-ab18-7b9e-f390-d463e6be76d5@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/02/2018 01:38 AM, Dan Carpenter wrote:
> We should return error pointers in this function.  Returning NULL
> results in a NULL dereference in the caller.
> 
> Fixes: 73688d1ed0b8 ("apparmor: refactor prepare_ns() and make usable from different views")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

applied to apparmor-next


> diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
> index b0f9dc3f765a..1a7cec5d9cac 100644
> --- a/security/apparmor/policy_ns.c
> +++ b/security/apparmor/policy_ns.c
> @@ -255,7 +255,7 @@ static struct aa_ns *__aa_create_ns(struct aa_ns *parent, const char *name,
>  
>  	ns = alloc_ns(parent->base.hname, name);
>  	if (!ns)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	ns->level = parent->level + 1;
>  	mutex_lock_nested(&ns->lock, ns->level);
>  	error = __aafs_ns_mkdir(ns, ns_subns_dir(parent), name, dir);
> 
