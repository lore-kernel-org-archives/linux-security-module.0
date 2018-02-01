From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 01 Feb 2018 16:51:52 -0500
Subject: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
In-Reply-To: <875e5d2d-9ffe-14ab-090a-4a9632af0f35@landley.net>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
	<1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
	<1517436423.3469.237.camel@linux.vnet.ibm.com>
	<a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
	<20180201020331.GA3774@rani.riverdale>
	<1517458921.3329.2.camel@linux.vnet.ibm.com>
	<f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
	<1517500500.3974.45.camel@linux.vnet.ibm.com>
	<875e5d2d-9ffe-14ab-090a-4a9632af0f35@landley.net>
Message-ID: <1517521912.3619.0.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-02-01 at 11:09 -0600, Rob Landley wrote:
> On 02/01/2018 09:55 AM, Mimi Zohar wrote:
> > On Thu, 2018-02-01 at 09:20 -0600, Rob Landley wrote:
> > 
> >>> With your patch and specifying "root=tmpfs", dracut is complaining:
> >>>
> >>> dracut: FATAL: Don't know how to handle 'root=tmpfs'
> >>> dracut: refusing to continue
> >>
> >> [googles]... I do not understand why this package exists.
> >>
> >> If you're switching to another root filesystem, using a tool that
> >> wikipedia[citation needed] says has no purpose but to switch to another
> >> root filesystem, (so let's reproduce the kernel infrastructure in
> >> userspace while leaving it the kernel too)... why do you need initramfs
> >> to be tmpfs? You're using it for half a second, then discarding it,
> >> what's the point of it being tmpfs?
> > 
> > Unlike the kernel image which is signed by the distros, the initramfs
> > doesn't come signed, because it is built on the target system. ?Even
> > if the initramfs did come signed, it is beneficial to measure and
> > appraise the individual files in the initramfs.
> 
> You can still shoot yourself in the foot with tmpfs. People mount a /run
> and a /tmp and then as a normal user you can go
> https://twitter.com/landley/status/959103235305951233 and maybe the
> default should be a little more clever there...
> 
> I'll throw it on the todo heap. :)
> 
> >> Sigh. If people are ok with having rootfs just be tmpfs whenever tmpfs
> >> is configured in, even when you're then going to overmount it with
> >> something else like you're doing, let's just _remove_ the test. If it
> >> can be tmpfs, have it be tmpfs.
> > 
> > Very much appreciated!
> 
> Not yet tested, but something like the attached? (Sorry for the
> half-finished doc changes in there, I'm at work and have a 5 minute
> break. I can test properly this evening if you don't get to it...)

Yes, rootfs is being mounted as tmpfs.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
