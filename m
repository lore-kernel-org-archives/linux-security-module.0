From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 27 Feb 2018 14:50:14 -0800
Subject: [PATCH] security: mark kmem caches as __ro_after_init
In-Reply-To: <20180226203747.GB6886@avx2>
References: <20180226203747.GB6886@avx2>
Message-ID: <ab3bfefd-7fcf-a807-3e00-d103c9aa9cf1@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2/26/2018 12:37 PM, Alexey Dobriyan wrote:
> Kmem caches are never reallocated once set up.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  security/integrity/iint.c     |    3 ++-
>  security/selinux/avc.c        |    9 +++++----
>  security/selinux/hooks.c      |    5 +++--
>  security/selinux/ss/avtab.c   |    5 +++--
>  security/selinux/ss/ebitmap.c |    3 ++-
>  security/selinux/ss/hashtab.c |    3 ++-
>  security/smack/smack_lsm.c    |    3 ++-
>  7 files changed, 19 insertions(+), 12 deletions(-)
>
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -15,6 +15,7 @@
>   *	- cache integrity information associated with an inode
>   *	  using a rbtree tree.
>   */
> +#include <linux/cache.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
> @@ -25,7 +26,7 @@
>  
>  static struct rb_root integrity_iint_tree = RB_ROOT;
>  static DEFINE_RWLOCK(integrity_iint_lock);
> -static struct kmem_cache *iint_cache __read_mostly;
> +static struct kmem_cache *iint_cache __ro_after_init;
>  
>  /*
>   * __integrity_iint_find - return the iint associated with an inode
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -13,6 +13,7 @@
>   *	it under the terms of the GNU General Public License version 2,
>   *	as published by the Free Software Foundation.
>   */
> +#include <linux/cache.h>
>  #include <linux/types.h>
>  #include <linux/stddef.h>
>  #include <linux/kernel.h>
> @@ -91,10 +92,10 @@ DEFINE_PER_CPU(struct avc_cache_stats, avc_cache_stats) = { 0 };
>  
>  static struct avc_cache avc_cache;
>  static struct avc_callback_node *avc_callbacks;
> -static struct kmem_cache *avc_node_cachep;
> -static struct kmem_cache *avc_xperms_data_cachep;
> -static struct kmem_cache *avc_xperms_decision_cachep;
> -static struct kmem_cache *avc_xperms_cachep;
> +static struct kmem_cache *avc_node_cachep __ro_after_init;
> +static struct kmem_cache *avc_xperms_data_cachep __ro_after_init;
> +static struct kmem_cache *avc_xperms_decision_cachep __ro_after_init;
> +static struct kmem_cache *avc_xperms_cachep __ro_after_init;
>  
>  static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
>  {
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -24,6 +24,7 @@
>   *	as published by the Free Software Foundation.
>   */
>  
> +#include <linux/cache.h>
>  #include <linux/init.h>
>  #include <linux/kd.h>
>  #include <linux/kernel.h>
> @@ -129,8 +130,8 @@ __setup("selinux=", selinux_enabled_setup);
>  int selinux_enabled = 1;
>  #endif
>  
> -static struct kmem_cache *sel_inode_cache;
> -static struct kmem_cache *file_security_cache;
> +static struct kmem_cache *sel_inode_cache __ro_after_init;
> +static struct kmem_cache *file_security_cache __ro_after_init;
>  
>  /**
>   * selinux_secmark_enabled - Check to see if SECMARK is currently enabled
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -17,14 +17,15 @@
>   *	Tuned number of hash slots for avtab to reduce memory usage
>   */
>  
> +#include <linux/cache.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include "avtab.h"
>  #include "policydb.h"
>  
> -static struct kmem_cache *avtab_node_cachep;
> -static struct kmem_cache *avtab_xperms_cachep;
> +static struct kmem_cache *avtab_node_cachep __ro_after_init;
> +static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
>  
>  /* Based on MurmurHash3, written by Austin Appleby and placed in the
>   * public domain.
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -16,6 +16,7 @@
>   *      Applied standard bit operations to improve bitmap scanning.
>   */
>  
> +#include <linux/cache.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
> @@ -25,7 +26,7 @@
>  
>  #define BITS_PER_U64	(sizeof(u64) * 8)
>  
> -static struct kmem_cache *ebitmap_node_cachep;
> +static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
>  
>  int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
>  {
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -4,13 +4,14 @@
>   *
>   * Author : Stephen Smalley, <sds@tycho.nsa.gov>
>   */
> +#include <linux/cache.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/sched.h>
>  #include "hashtab.h"
>  
> -static struct kmem_cache *hashtab_node_cachep;
> +static struct kmem_cache *hashtab_node_cachep __ro_after_init;
>  
>  struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
>  			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -18,6 +18,7 @@
>   *      as published by the Free Software Foundation.
>   */
>  
> +#include <linux/cache.h>
>  #include <linux/xattr.h>
>  #include <linux/pagemap.h>
>  #include <linux/mount.h>
> @@ -55,7 +56,7 @@
>  DEFINE_MUTEX(smack_ipv6_lock);
>  static LIST_HEAD(smk_ipv6_port_list);
>  #endif
> -static struct kmem_cache *smack_inode_cache;
> +static struct kmem_cache *smack_inode_cache __ro_after_init;

Have you tried this to see if it works?


>  int smack_enabled;
>  
>  static const match_table_t smk_mount_tokens = {
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
