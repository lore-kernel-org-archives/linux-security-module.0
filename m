From: dongsu@kinvolk.io (Dongsu Park)
Date: Mon, 29 Jan 2018 18:40:16 +0100
Subject: [RFC PATCH v3 2/2] ima: force re-appraisal on filesystems with
	FS_IMA_NO_CACHE
In-Reply-To: <1517243585.29187.546.camel@linux.vnet.ibm.com>
References: <20180122162452.8756-1-alban@kinvolk.io>
	<20180122162452.8756-3-alban@kinvolk.io>
	<20180124175234.GA29811@mail.hallyn.com>
	<1516881401.3751.37.camel@linux.vnet.ibm.com>
	<1517243585.29187.546.camel@linux.vnet.ibm.com>
Message-ID: <CANxcAMs_1r0xz=D4bZ9C0k+gdkfrP=DJR0r97G1hG=nUKzKrcw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Mimi,

On Mon, Jan 29, 2018 at 5:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Hi Alban,
>
> On Thu, 2018-01-25 at 06:56 -0500, Mimi Zohar wrote:
>> > > @@ -228,9 +229,28 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>> > >                            IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
>> > >                            IMA_ACTION_FLAGS);
>> > >
>> > > - if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
>> > > -         /* reset all flags if ima_inode_setxattr was called */
>> > > + /*
>> > > +  * Reset the measure, appraise and audit cached flags either if:
>> > > +  * - ima_inode_setxattr was called, or
>> > > +  * - based on filesystem feature flag
>> > > +  * forcing the file to be re-evaluated.
>> > > +  */
>> > > + if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
>> > >           iint->flags &= ~IMA_DONE_MASK;
>> > > + } else if (inode->i_sb->s_type->fs_flags & FS_IMA_NO_CACHE) {
>> > > +         if (action & IMA_MEASURE) {
>> > > +                 iint->measured_pcrs = 0;
>> > > +                 iint->flags &=
>> > > +                     ~(IMA_COLLECTED | IMA_MEASURE | IMA_MEASURED);
>> > > +         }
>> > > +         if (action & IMA_APPRAISE)
>> > > +                 iint->flags &=
>> > > +                     ~(IMA_COLLECTED | IMA_APPRAISE | IMA_APPRAISED |
>> > > +                       IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK);
>> > > +         if (action & IMA_AUDIT)
>> > > +                 iint->flags &=
>> > > +                     ~(IMA_COLLECTED | IMA_AUDIT | IMA_AUDITED);
>> > > + }
>> > >
>>
>> Alban, I don't know what I was thinking, but this can be simplified
>> like for the IMA_CHANGE_XATTR case.  Except in the IMA_CHANGE_XATTR
>> case, "measured_pcrs" was already reset, whereas in this case
>> "measured_pcrs" needs to be reset.
>
> Did you get a chance to make the change and test it?

Alban has been on holidays, so he will be back on Wednesday or so.
So I'll try to understand what you meant in the last email.

As IMA_DONE_MASK contains all other bitmasks, it's possible to
optimize the code like this:

        if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
                iint->flags &= ~IMA_DONE_MASK;
        } else if (inode->i_sb->s_type->fs_flags & FS_IMA_NO_CACHE) {
                iint->flags &= ~IMA_DONE_MASK;
                if (action & IMA_MEASURE)
                        iint->measured_pcrs = 0;
        }

Is that what you want to see? Please let me know if it's not.
Tomorrow I will try to test with a new patch.

Thanks,
Dongsu

> Mimi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
