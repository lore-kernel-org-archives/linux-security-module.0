From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 22 Aug 2017 08:54:54 -0400
Subject: [PATCH v6 5/6] ima: define "dont_failsafe" policy action rule
In-Reply-To: <CACE9dm__acDM9A4VGwcKd+zSmG7Q-MOAG3ZZ1T586_LH0v-dCA@mail.gmail.com>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502808237-2035-6-git-send-email-zohar@linux.vnet.ibm.com>
	<CACE9dm__acDM9A4VGwcKd+zSmG7Q-MOAG3ZZ1T586_LH0v-dCA@mail.gmail.com>
Message-ID: <1503406494.8360.53.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-08-22 at 13:07 +0300, Dmitry Kasatkin wrote:
> On Tue, Aug 15, 2017 at 5:43 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Permit normally denied access/execute permission for files in policy
> > on IMA unsupported filesystems.  This patch defines the "dont_failsafe"
> > policy action rule.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> >
> > ---
> > Changelog v3:
> > - include dont_failsafe rule when displaying policy
> > - fail attempt to add dont_failsafe rule when appending to the policy
> >
> >  Documentation/ABI/testing/ima_policy |  3 ++-
> >  security/integrity/ima/ima.h         |  1 +
> >  security/integrity/ima/ima_main.c    | 12 +++++++++++-
> >  security/integrity/ima/ima_policy.c  | 29 ++++++++++++++++++++++++++++-
> >  4 files changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> > index e76432b9954d..f271207743e5 100644
> > --- a/Documentation/ABI/testing/ima_policy
> > +++ b/Documentation/ABI/testing/ima_policy
> > @@ -17,7 +17,8 @@ Description:
> >
> >                 rule format: action [condition ...]
> >
> > -               action: measure | dont_measure | appraise | dont_appraise | audit
> > +               action: measure | dont_meaure | appraise | dont_appraise |
> > +                       audit | dont_failsafe
> >                 condition:= base | lsm  [option]
> >                         base:   [[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
> >                                 [euid=] [fowner=]]
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index d52b487ad259..c5f34f7c5b0f 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -224,6 +224,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos);
> >  void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
> >  void ima_policy_stop(struct seq_file *m, void *v);
> >  int ima_policy_show(struct seq_file *m, void *v);
> > +void set_failsafe(bool flag);
> >
> >  /* Appraise integrity measurements */
> >  #define IMA_APPRAISE_ENFORCE   0x01
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index d23dfe6ede18..b00186914df8 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -38,6 +38,12 @@ int ima_appraise;
> >  int ima_hash_algo = HASH_ALGO_SHA1;
> >  static int hash_setup_done;
> >
> > +static bool ima_failsafe = 1;
> > +void set_failsafe(bool flag)
> > +{
> > +       ima_failsafe = flag;
> > +}
> > +
> >  static int __init hash_setup(char *str)
> >  {
> >         struct ima_template_desc *template_desc = ima_template_desc_current();
> > @@ -260,8 +266,12 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> >                 __putname(pathbuf);
> >  out:
> >         inode_unlock(inode);
> > -       if ((rc && must_appraise) && (ima_appraise & IMA_APPRAISE_ENFORCE))
> > +       if ((rc && must_appraise) && (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> > +               if (!ima_failsafe && rc == -EBADF)
> > +                       return 0;
> > +
> 
> By default IMA is failsafe. ima_failsafe is true.
> Return 0 is needed in failsafe mode. right?
> But in this logic it will happen if ima_failsafe is false. meaning it
> is not failsafe.
> 
> Is it a typo?

No, the default, as you pointed out above, is failsafe mode. ?Only when we are not in failsafe mode, do we allow the file access/execute for file's that we could not appraise.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
