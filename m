From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Wed, 28 Feb 2018 09:34:07 -0500
Subject: [PATCH] security: mark kmem caches as __ro_after_init
In-Reply-To: <CAHC9VhSx4--OpFNv_NXb9LYrKTqRG6jR1WKuyWhVHO=YSjK3kA@mail.gmail.com>
References: <20180226203747.GB6886@avx2>
	<CAHC9VhSx4--OpFNv_NXb9LYrKTqRG6jR1WKuyWhVHO=YSjK3kA@mail.gmail.com>
Message-ID: <050858c8-2a7d-d53d-d50a-a3218364d140@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 02/27/2018 05:19 PM, Paul Moore wrote:
> On Mon, Feb 26, 2018 at 3:37 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>> Kmem caches are never reallocated once set up.
>>
>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>> ---
>>
>>  security/integrity/iint.c     |    3 ++-
>>  security/selinux/avc.c        |    9 +++++----
>>  security/selinux/hooks.c      |    5 +++--
>>  security/selinux/ss/avtab.c   |    5 +++--
>>  security/selinux/ss/ebitmap.c |    3 ++-
>>  security/selinux/ss/hashtab.c |    3 ++-
>>  security/smack/smack_lsm.c    |    3 ++-
>>  7 files changed, 19 insertions(+), 12 deletions(-)
> 
> In the future you're probably better off separating the SELinux,
> Smack, and IMA pieces into separate patches.  SELinux comments inline
> ...
> 
>> --- a/security/selinux/ss/avtab.c
>> +++ b/security/selinux/ss/avtab.c
>> @@ -17,14 +17,15 @@
>>   *     Tuned number of hash slots for avtab to reduce memory usage
>>   */
>>
>> +#include <linux/cache.h>
>>  #include <linux/kernel.h>
>>  #include <linux/slab.h>
>>  #include <linux/errno.h>
>>  #include "avtab.h"
>>  #include "policydb.h"
>>
>> -static struct kmem_cache *avtab_node_cachep;
>> -static struct kmem_cache *avtab_xperms_cachep;
>> +static struct kmem_cache *avtab_node_cachep __ro_after_init;
>> +static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
> 
> Both avtab_node_cachep and avtab_xperms_cachep get allocated in
> avtab_cache_init() which is called during the first policy load (from
> userspace) which happens after we are past __init, yes?
> 
> This is why we don't mark avtab_cache_init() with the __init macro.

NB My "selinux: wrap global selinux state" patch moves this
initialization to selinux_init(), at which point we can in fact mark
these caches this way.  I think that is more correct anyway, but it was
specifically motivated by the fact that we only want to perform this
initialization once and first policy load becomes a per-state/namespace
operation.

> 
>> --- a/security/selinux/ss/ebitmap.c
>> +++ b/security/selinux/ss/ebitmap.c
>> @@ -16,6 +16,7 @@
>>   *      Applied standard bit operations to improve bitmap scanning.
>>   */
>>
>> +#include <linux/cache.h>
>>  #include <linux/kernel.h>
>>  #include <linux/slab.h>
>>  #include <linux/errno.h>
>> @@ -25,7 +26,7 @@
>>
>>  #define BITS_PER_U64   (sizeof(u64) * 8)
>>
>> -static struct kmem_cache *ebitmap_node_cachep;
>> +static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
> 
> Same.
> 
>> --- a/security/selinux/ss/hashtab.c
>> +++ b/security/selinux/ss/hashtab.c
>> @@ -4,13 +4,14 @@
>>   *
>>   * Author : Stephen Smalley, <sds@tycho.nsa.gov>
>>   */
>> +#include <linux/cache.h>
>>  #include <linux/kernel.h>
>>  #include <linux/slab.h>
>>  #include <linux/errno.h>
>>  #include <linux/sched.h>
>>  #include "hashtab.h"
>>
>> -static struct kmem_cache *hashtab_node_cachep;
>> +static struct kmem_cache *hashtab_node_cachep __ro_after_init;
> 
> Same.
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
