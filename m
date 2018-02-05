From: alban@kinvolk.io (Alban Crequy)
Date: Mon, 5 Feb 2018 15:16:04 +0100
Subject: [RFC PATCH v4 1/2] fuse: introduce new fs_type flag
	FS_IMA_NO_CACHE
In-Reply-To: <CAJfpegvt5W-q0W8_VRML-MNW6+n2ZQYW+51utRXDDKSbvsqf3w@mail.gmail.com>
References: <cover.1517314847.git.dongsu@kinvolk.io>
	<86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
	<1517584816.3171.61.camel@linux.vnet.ibm.com>
	<1517585624.3171.64.camel@linux.vnet.ibm.com>
	<CAJfpegvt5W-q0W8_VRML-MNW6+n2ZQYW+51utRXDDKSbvsqf3w@mail.gmail.com>
Message-ID: <CADZs7q6cXaRqsapPOA_h62ayny+AtJ02Zr3tbQxVGA7JoChiyA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Feb 2, 2018 at 5:10 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Fri, Feb 2, 2018 at 4:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> On Fri, 2018-02-02 at 10:20 -0500, Mimi Zohar wrote:
>>> Hi Miklos,
>>>
>>> On Tue, 2018-01-30 at 19:06 +0100, Dongsu Park wrote:
>>> > From: Alban Crequy <alban@kinvolk.io>
>>> >
>>> > This new fs_type flag FS_IMA_NO_CACHE means files should be re-measured,
>>> > re-appraised and re-audited each time. Cached integrity results should
>>> > not be used.
>>> >
>>> > It is useful in FUSE because the userspace FUSE process can change the
>>> > underlying files at any time without notifying the kernel.
>
> I don't really have an understanding what IMA is doing, I think the
> same thing applies to any network filesystem (i.e. ones with
> d_revalidate).
>
> Isn't that the case?

Hi Miklos,

>From my limited understanding, network filesystems might need that
too, yes. I don't know if there are people interested in using both
IMA and network filesystems. If so, they would have to write that
patch and test it.

It is not a new issue, for neither network filesystems or FUSE. But I
am more interested in the FUSE use case because FUSE can be mounted by
unprivileged users either today with fusermount installed with setuid,
or soon with the coming patches to allow FUSE mounts in a non-init
user namespace. That makes the issue more visible than for network
filesystems where unprivileged users cannot mount.

Cheers,
Alban
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
