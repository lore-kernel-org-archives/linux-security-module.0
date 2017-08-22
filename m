From: dmitry.kasatkin@gmail.com (Dmitry Kasatkin)
Date: Tue, 22 Aug 2017 16:41:09 +0300
Subject: [PATCH v6 6/6] ima: define "fs_unsafe" builtin policy
In-Reply-To: <1503407620.8360.55.camel@linux.vnet.ibm.com>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502808237-2035-7-git-send-email-zohar@linux.vnet.ibm.com>
	<CACE9dm8mKkVNWCtOYb57UGGKCRrq2FX=qTmvndadO0FLr-iGBQ@mail.gmail.com>
	<1503407620.8360.55.camel@linux.vnet.ibm.com>
Message-ID: <CACE9dm-WPV9ftEiwetJbv_OW_CcK2Yahj7DPhASgUm9_NdPjUQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

Yes, please add one of appropriate.

Thanks,
Dmitry

On Tue, Aug 22, 2017 at 4:13 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-08-22 at 13:07 +0300, Dmitry Kasatkin wrote:
>> Looks good to me.
>
> Thank you for reviewing the code!  Can I add your Reviewed-by/Acked-by?
>
> Mimi
>
>>
>> On Tue, Aug 15, 2017 at 5:43 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> > Permit normally denied access/execute permission for files in policy
>> > on IMA unsupported filesystems.  This patch defines "fs_unsafe", a
>> > builtin policy.
>> >
>> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> >
>> > ---
>> > Changelog v3:
>> > - include dont_failsafe rule when displaying policy
>> >
>> >  Documentation/admin-guide/kernel-parameters.txt |  8 +++++++-
>> >  security/integrity/ima/ima_policy.c             | 12 ++++++++++++
>> >  2 files changed, 19 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> > index d9c171ce4190..4e303be83df6 100644
>> > --- a/Documentation/admin-guide/kernel-parameters.txt
>> > +++ b/Documentation/admin-guide/kernel-parameters.txt
>> > @@ -1502,7 +1502,7 @@
>> >
>> >         ima_policy=     [IMA]
>> >                         The builtin policies to load during IMA setup.
>> > -                       Format: "tcb | appraise_tcb | secure_boot"
>> > +                       Format: "tcb | appraise_tcb | secure_boot | fs_unsafe"
>> >
>> >                         The "tcb" policy measures all programs exec'd, files
>> >                         mmap'd for exec, and all files opened with the read
>> > @@ -1517,6 +1517,12 @@
>> >                         of files (eg. kexec kernel image, kernel modules,
>> >                         firmware, policy, etc) based on file signatures.
>> >
>> > +                       The "fs_unsafe" policy permits normally denied
>> > +                       access/execute permission for files in policy on IMA
>> > +                       unsupported filesystems.  Note this option, as the
>> > +                       name implies, is not safe and not recommended for
>> > +                       any environments other than testing.
>> > +
>> >         ima_tcb         [IMA] Deprecated.  Use ima_policy= instead.
>> >                         Load a policy which meets the needs of the Trusted
>> >                         Computing Base.  This means IMA will measure all
>> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> > index 43b85a4fb8e8..cddd9dfb01e1 100644
>> > --- a/security/integrity/ima/ima_policy.c
>> > +++ b/security/integrity/ima/ima_policy.c
>> > @@ -169,6 +169,10 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
>> >          .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
>> >  };
>> >
>> > +static struct ima_rule_entry dont_failsafe_rules[] __ro_after_init = {
>> > +       {.action = DONT_FAILSAFE}
>> > +};
>> > +
>> >  static LIST_HEAD(ima_default_rules);
>> >  static LIST_HEAD(ima_policy_rules);
>> >  static LIST_HEAD(ima_temp_rules);
>> > @@ -188,6 +192,7 @@ __setup("ima_tcb", default_measure_policy_setup);
>> >
>> >  static bool ima_use_appraise_tcb __initdata;
>> >  static bool ima_use_secure_boot __initdata;
>> > +static bool ima_use_dont_failsafe __initdata;
>> >  static int __init policy_setup(char *str)
>> >  {
>> >         char *p;
>> > @@ -201,6 +206,10 @@ static int __init policy_setup(char *str)
>> >                         ima_use_appraise_tcb = 1;
>> >                 else if (strcmp(p, "secure_boot") == 0)
>> >                         ima_use_secure_boot = 1;
>> > +               else if (strcmp(p, "fs_unsafe") == 0) {
>> > +                       ima_use_dont_failsafe = 1;
>> > +                       set_failsafe(0);
>> > +               }
>> >         }
>> >
>> >         return 1;
>> > @@ -470,6 +479,9 @@ void __init ima_init_policy(void)
>> >                         temp_ima_appraise |= IMA_APPRAISE_POLICY;
>> >         }
>> >
>> > +       if (ima_use_dont_failsafe)
>> > +               list_add_tail(&dont_failsafe_rules[0].list, &ima_default_rules);
>> > +
>> >         ima_rules = &ima_default_rules;
>> >         ima_update_policy_flag();
>> >  }
>> > --
>> > 2.7.4
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
>> > the body of a message to majordomo at vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>



-- 
Thanks,
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
