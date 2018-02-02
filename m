From: miklos@szeredi.hu (Miklos Szeredi)
Date: Fri, 2 Feb 2018 17:10:24 +0100
Subject: [RFC PATCH v4 1/2] fuse: introduce new fs_type flag
	FS_IMA_NO_CACHE
In-Reply-To: <1517585624.3171.64.camel@linux.vnet.ibm.com>
References: <cover.1517314847.git.dongsu@kinvolk.io>
	<86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
	<1517584816.3171.61.camel@linux.vnet.ibm.com>
	<1517585624.3171.64.camel@linux.vnet.ibm.com>
Message-ID: <CAJfpegvt5W-q0W8_VRML-MNW6+n2ZQYW+51utRXDDKSbvsqf3w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Feb 2, 2018 at 4:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2018-02-02 at 10:20 -0500, Mimi Zohar wrote:
>> Hi Miklos,
>>
>> On Tue, 2018-01-30 at 19:06 +0100, Dongsu Park wrote:
>> > From: Alban Crequy <alban@kinvolk.io>
>> >
>> > This new fs_type flag FS_IMA_NO_CACHE means files should be re-measured,
>> > re-appraised and re-audited each time. Cached integrity results should
>> > not be used.
>> >
>> > It is useful in FUSE because the userspace FUSE process can change the
>> > underlying files at any time without notifying the kernel.

I don't really have an understanding what IMA is doing, I think the
same thing applies to any network filesystem (i.e. ones with
d_revalidate).

Isn't that the case?

Thanks,
Miklos
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
