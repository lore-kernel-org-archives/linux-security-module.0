From: paul@paul-moore.com (Paul Moore)
Date: Wed, 7 Jun 2017 09:50:24 -0400
Subject: [PATCH] security: selinux: use kmem_cache for ebitmap
In-Reply-To: <872857aa-7587-79a9-cf31-4508eacdb3f7@lge.com>
References: <1496653814-3653-1-git-send-email-junil0814.lee@lge.com>
	<CAHC9VhSDux6oAcD1ZULOTcCp69JFY1c4Jati3odg4ROoRROp-w@mail.gmail.com>
	<872857aa-7587-79a9-cf31-4508eacdb3f7@lge.com>
Message-ID: <CAHC9VhTU9fgZxfeyo_ViPcdEONxYaBxnMGCgM8yb35-52CBNtw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 6, 2017 at 7:38 PM, ???/???/MC??? BSP?
BSP6?(junil0814.lee at lge.com) <junil0814.lee@lge.com> wrote:
> Paul Moore wrote on 2017-06-06 ?? 6:39:
>> On Mon, Jun 5, 2017 at 5:10 AM, Junil Lee <junil0814.lee@lge.com> wrote:
>>> The allocated size for each ebitmap_node is 192byte by kzalloc().
>>> Then, ebitmap_node size is fixed, so it's possible to use only 144byte
>>> for each object by kmem_cache_zalloc().
>>> It can reduce some dynamic allocation size.
>>>
>>> Signed-off-by: Junil Lee <junil0814.lee@lge.com>
>>> ---
>>> security/selinux/ss/ebitmap.c | 24 +++++++++++++++++++-----
>>> security/selinux/ss/ebitmap.h | 3 +++
>>> security/selinux/ss/services.c | 4 ++++
>>> 3 files changed, 26 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/security/selinux/ss/ebitmap.c
>> b/security/selinux/ss/ebitmap.c
>>> index 9db4709a..076c96f 100644
>>> --- a/security/selinux/ss/ebitmap.c
>>> +++ b/security/selinux/ss/ebitmap.c
>>> @@ -24,6 +24,8 @@
>>>
>>> #define BITS_PER_U64 (sizeof(u64) * 8)
>>>
>>> +static struct kmem_cache *ebitmap_node_cachep;
>>> +
>>> int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
>>> {
>>> struct ebitmap_node *n1, *n2;
>>> @@ -54,7 +56,7 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap
>> *src)
>>> n = src->node;
>>> prev = NULL;
>>> while (n) {
>>> - new = kzalloc(sizeof(*new), GFP_ATOMIC);
>>> + new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>>> if (!new) {
>>> ebitmap_destroy(dst);
>>> return -ENOMEM;
>>> @@ -162,7 +164,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
>>> if (e_iter == NULL ||
>>> offset >= e_iter->startbit + EBITMAP_SIZE) {
>>> e_prev = e_iter;
>>> - e_iter = kzalloc(sizeof(*e_iter), GFP_ATOMIC);
>>> + e_iter = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>>> if (e_iter == NULL)
>>> goto netlbl_import_failure;
>>> e_iter->startbit = offset - (offset % EBITMAP_SIZE);
>>> @@ -299,7 +301,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned
>> long bit, int value)
>>> if (!value)
>>> return 0;
>>>
>>> - new = kzalloc(sizeof(*new), GFP_ATOMIC);
>>> + new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>>> if (!new)
>>> return -ENOMEM;
>>
>> I believe there is a kfree() in ebitmap_set_bit() that also needs to
>> be converted.
>>
>
> Thanks for your advice Paul.
> reattach patch v2.

Please submit patches inline, just as you did for your original
posting.  It make it easier to review and apply.

Thanks.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
