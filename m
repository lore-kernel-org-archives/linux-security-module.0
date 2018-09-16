From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 18:47:30 -0700
Subject: [PATCH 11/18] LSM: Lift LSM selection out of individual LSMs
In-Reply-To: <CAG48ez1TPsz30WebxQPkZbjfPTyT2ui7L+4ZQ94FStCkWcJ0VA@mail.gmail.com>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-12-keescook@chromium.org>
	<CAG48ez1TPsz30WebxQPkZbjfPTyT2ui7L+4ZQ94FStCkWcJ0VA@mail.gmail.com>
Message-ID: <CAGXu5jKYqxZpRjct6zcUgh27bZDrEYPhejRzdCXc8fmLHX_Y=g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Sep 15, 2018 at 6:32 PM, Jann Horn <jannh@google.com> wrote:
> On Sun, Sep 16, 2018 at 3:14 AM Kees Cook <keescook@chromium.org> wrote:
>> In order to adjust LSM selection logic in the future, this moves the
>> selection logic up out of the individual LSMs, making their init functions
>> only run when actually enabled.
> [...]
>> +/* Is an LSM allowed to be enabled? */
>> +static bool __init lsm_enabled(struct lsm_info *lsm)
>> +{
>> +       /* Report explicit disabling. */
>> +       if (lsm->enabled && !*lsm->enabled) {
>> +               pr_info("%s disabled with boot parameter\n", lsm->name);
>> +               return false;
>> +       }
>> +
>> +       /* If LSM isn't exclusive, ignore exclusive LSM selection rules. */
>> +       if (lsm->type != LSM_TYPE_EXCLUSIVE)
>> +               return true;
>> +
>> +       /* Disabled if another exclusive LSM already selected. */
>> +       if (exclusive)
>> +               return false;
>
> What is this check for, given that you have the strcmp() just below
> here? From a quick look, it (together with everything else that
> touches the "exclusive" variable) seems superfluous to me, unless
> there are two LSMs with the same name (which really shouldn't happen,
> right?).
>
>> +       /* Disabled if this LSM isn't the chosen one. */
>> +       if (strcmp(lsm->name, chosen_lsm) != 0)
>> +               return false;
>> +
>> +       return true;
>> +}

Mainly it's for composition with later patches where the name check is
moved. It seemed easier to explain the logical progression with the
hunk here.

-Kees

-- 
Kees Cook
Pixel Security
