From: dongsu@kinvolk.io (Dongsu Park)
Date: Tue, 30 Jan 2018 19:13:05 +0100
Subject: [RFC PATCH v3 2/2] ima: force re-appraisal on filesystems with
	FS_IMA_NO_CACHE
In-Reply-To: <CANxcAMs_1r0xz=D4bZ9C0k+gdkfrP=DJR0r97G1hG=nUKzKrcw@mail.gmail.com>
References: <20180122162452.8756-1-alban@kinvolk.io>
	<20180122162452.8756-3-alban@kinvolk.io>
	<20180124175234.GA29811@mail.hallyn.com>
	<1516881401.3751.37.camel@linux.vnet.ibm.com>
	<1517243585.29187.546.camel@linux.vnet.ibm.com>
	<CANxcAMs_1r0xz=D4bZ9C0k+gdkfrP=DJR0r97G1hG=nUKzKrcw@mail.gmail.com>
Message-ID: <CANxcAMs1A_s-i=vDRfcYqi_149hkS47V3iaJzxdMNgzUyRS7GA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On Mon, Jan 29, 2018 at 6:40 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
> On Mon, Jan 29, 2018 at 5:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> On Thu, 2018-01-25 at 06:56 -0500, Mimi Zohar wrote:
...
>> Did you get a chance to make the change and test it?
>
> Alban has been on holidays, so he will be back on Wednesday or so.
> So I'll try to understand what you meant in the last email.
>
> As IMA_DONE_MASK contains all other bitmasks, it's possible to
> optimize the code like this:
>
>         if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
>                 iint->flags &= ~IMA_DONE_MASK;
>         } else if (inode->i_sb->s_type->fs_flags & FS_IMA_NO_CACHE) {
>                 iint->flags &= ~IMA_DONE_MASK;
>                 if (action & IMA_MEASURE)
>                         iint->measured_pcrs = 0;
>         }
>
> Is that what you want to see? Please let me know if it's not.
> Tomorrow I will try to test with a new patch.

Today I created a new patch, and tested it. It worked fine.
So I've just sent a new patchset v4. Please see:
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1598387.html

Thanks,
Dongsu

> Thanks,
> Dongsu
>
>> Mimi
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
