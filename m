From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 15 Sep 2017 11:05:31 -0700
Subject: [PATCH 3/3] ima: use fs method to read integrity data
In-Reply-To: <1505466296.4200.86.camel@linux.vnet.ibm.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505451494-30228-4-git-send-email-zohar@linux.vnet.ibm.com>
	<CA+55aFwVujvsdaq09O216u-uBbBbo5i_1d6aw3ksottR_uiJ6w@mail.gmail.com>
	<1505466296.4200.86.camel@linux.vnet.ibm.com>
Message-ID: <CA+55aFwS39HcDEE3QrS0_nSahY9uQJBCYfqw1jhSa6x3Fg_=pw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 15, 2017 at 2:04 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Thu, 2017-09-14 at 22:50 -0700, Linus Torvalds wrote:
>> This is still wrong.
>>
>> (a) there is no explanation for why we need that exclusive lock in the
>> first place
>
>> Why should a read need exclusive access? You'd think shared is sufficient.
>
> True, reading a file shouldn't require an exclusive lock.  The
> exclusive lock is taken to prevent the file from changing while the
> file hash is being calculated.

That really shouldn't need an exclusive lock either. The whole point
is that you're just reading the file, so a shared lock should be fine.

There may be other *higher* level reasons why the caller then might
want an exclusive lock for other reasons, but that should have nothing
to do with the reading part.

So this is the thing I want explained. Right now there are no
explanations, and the few comments there are about exclusive locking
don't make sense, and don't match the lockdep tests.

So the patch itself may be fine, but the commentary and explanations
are broken and/or missing.

                     Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
