From: keescook@chromium.org (Kees Cook)
Date: Thu, 13 Sep 2018 14:12:50 -0700
Subject: [PATCH 04/10] LSM: Infrastructure management of the cred security
	blob
In-Reply-To: <5a17beeb-c83c-ce8e-162c-1fbeb74aaae8@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<d92f5457-c7b0-a768-2411-5a5528f88fc8@schaufler-ca.com>
	<CAGXu5jLxnmyNzWV2VV0tq-ikAnMAPfebfqxSWvHPUVDZ_xYsyg@mail.gmail.com>
	<5a17beeb-c83c-ce8e-162c-1fbeb74aaae8@schaufler-ca.com>
Message-ID: <CAGXu5j+apDE-E-FM-55pE7hPQbuKV+x22XK0QrO4qyGnq-6T3A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 13, 2018 at 12:01 PM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 9/12/2018 4:53 PM, Kees Cook wrote:
>> On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Move management of the cred security blob out of the
>>> security modules and into the security infrastructure.
>>> Instead of allocating and freeing space the security
>>> modules tell the infrastructure how much space they
>>> require.
>> There's a lot of changes here that I think deserve some longer
>> discussion in the changelog. Notably, now we run _two_ cycles of init
>> calls? That seems... odd. Notes below...
>
> The first pass adds up the blob sizes. This has to be done because
> some modules allocate blobs during the init phase. I have investigated
> alternatives, including blobs that include information about what they
> contain, but they're all significantly more complicated.

Agreed: I liked the idea of not burdening each LSM with a state
machine, but I guess it's not much. Note that "finished" then should
be __initdata.

>>> -       if (selinux_is_enabled() && cred->security) {
>>> -               if ((unsigned long) cred->security < PAGE_SIZE)
>>> -                       return true;
>>> -               if ((*(u32 *)cred->security & 0xffffff00) ==
>>> -                   (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
>>> -                       return true;
>> These aren't unreasonable checks -- can we add them back in later?
>> (They don't need to be selinux specific, in fact: the LSM could do the
>> poison...)
>
> I had asked the maintainers about the value of these checks, and
> they said that they were primarily there for debugging during the
> original cred breakout development. I'd have not problem making them
> infrastructure managed if there's a strong desire to keep them.

Since it was only SELinux doing this, and it was from old debugging,
then I concur: drop it. It would be easy to restore (and for all LSMs)
in the future.

>>> +static inline void set_cred_label(const struct cred *cred,
>>> +                                 struct aa_label *label)
>>> +{
>>> +       struct aa_label **blob = cred->security;
>>> +
>>> +       AA_BUG(!blob);
>>> +       *blob = label;
>>> +}
>> This feels like it should be a separate patch? Shouldn't AA not be
>> playing with cred->security directly before we get to this "sizing and
>> allocation" patch?
>
> You're correct. This is a harmless patch break-up mistake. The end
> result of the set is correct, and the interim state works as intended,
> albeit with unnecessary code.

I much prefer lots of small easy-to-understand patches than trying to
piece together many separate things. Let's please break out each LSM's
changes and any refactoring into separate patches. Complexity is
harder to review than quantity, IMO.

>>> + */
>>> +void lsm_early_cred(struct cred *cred)
>>> +{
>>> +       int rc;
>>> +
>>> +       if (cred == NULL)
>>> +               panic("%s: NULL cred.\n", __func__);
>> I have been given strongly worded advice to never BUG nor panic. I would:
>>
>> if (WARN_ON(!cred || !cred->security))
>>        return;
>>
>>> +       if (cred->security != NULL)
>>> +               return;
>>> +       rc = lsm_cred_alloc(cred, GFP_KERNEL);
>>> +       if (rc)
>>> +               panic("%s: Early cred alloc failed.\n", __func__);
>> And:
>>
>> WARN_ON(lsm_cred_alloc(cred, GFP_KERNEL));
>
> This duplicates the previous behavior from the SELinux and Smack code.
> A WARN_ON will result in an immediate panic when the calling code tries
> to dereference the blob.

I guess what I'm trying to say is, if you have a patch that does:

+ .... panic()

or

+ .... BUG()

and it has "security" anywhere in the topic, you run an extremely high
risk of Linus NAKing the entire series.

>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 9d6cdd21acb6..9b49698754a7 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -213,12 +213,9 @@ static void cred_init_security(void)
>>>         struct cred *cred = (struct cred *) current->real_cred;
>>>         struct task_security_struct *tsec;
>>>
>>> -       tsec = kzalloc(sizeof(struct task_security_struct), GFP_KERNEL);
>>> -       if (!tsec)
>>> -               panic("SELinux:  Failed to initialize initial task.\n");
>>> -
>>> +       lsm_early_cred(cred);
>>> +       tsec = selinux_cred(cred);
>> Perhaps leave the existing panic() as-is?
>
> Moving the panic into lsm_early_cred() reduces the panic count
> and avoids code duplication here and in the Smack equivalent.

Agreed: but it means intentionally adding a machine-stop condition
which Linus is very opposed to.

>> Shouldn't this Tomoyo cred handling get split out?
>
> Yeah. Again, it's the patch size/count balance.

I really do like lots of little patches. SO much easier. The main
brain-drain on large patches is that things end up out of order due to
filename ordering, etc, so a lot more needs to be kept in your head as
you're reading a long patch. Much prefer lots of small patches.

-Kees

-- 
Kees Cook
Pixel Security
