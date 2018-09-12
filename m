From: keescook@chromium.org (Kees Cook)
Date: Wed, 12 Sep 2018 16:04:10 -0700
Subject: [PATCH 02/10] Smack: Abstract use of cred security blob
In-Reply-To: <18c20c50-3ec5-0c85-93ef-58a3dbf3498c@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<18c20c50-3ec5-0c85-93ef-58a3dbf3498c@schaufler-ca.com>
Message-ID: <CAGXu5jLZaDxv140w5L48yNLikUs-=JMJ82oDW-sP=4b3tRC_bA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack.h        | 14 +++++++--
>  security/smack/smack_access.c |  4 +--
>  security/smack/smack_lsm.c    | 57 +++++++++++++++++------------------
>  security/smack/smackfs.c      | 18 +++++------
>  4 files changed, 50 insertions(+), 43 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index f7db791fb566..0b55d6a55b26 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -356,6 +356,11 @@ extern struct list_head smack_onlycap_list;
>  #define SMACK_HASH_SLOTS 16
>  extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
>
> +static inline struct task_smack *smack_cred(const struct cred *cred)
> +{
> +       return cred->security;
> +}
> +
>  /*
>   * Is the directory transmuting?
>   */
> @@ -382,13 +387,16 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
>         return tsp->smk_task;
>  }
>
> -static inline struct smack_known *smk_of_task_struct(const struct task_struct *t)
> +static inline struct smack_known *smk_of_task_struct(
> +                                               const struct task_struct *t)
>  {
>         struct smack_known *skp;
> +       const struct cred *cred;
>
>         rcu_read_lock();
> -       skp = smk_of_task(__task_cred(t)->security);
> +       cred = __task_cred(t);
>         rcu_read_unlock();
> +       skp = smk_of_task(smack_cred(cred));

Hm, why is this safe? (i.e. what is pinning the cred?) I would expect
get_cred()/put_cred() since this is not for "current"? And then what
controls the skp lifetime?

Everything else looks to be mechanical replacement, so that's fine.
Did you use some tooling to do the mechanical replacement or was it
done by hand?

-Kees

-- 
Kees Cook
Pixel Security
