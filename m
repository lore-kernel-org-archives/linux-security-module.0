From: Golden_Miller83@protonmail.ch (Jordan Glover)
Date: Tue, 14 Aug 2018 23:22:03 +0000
Subject: [PATCH v1 00/22] LSM: Full security module stacking
In-Reply-To: <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
	<CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
	<a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
Message-ID: <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:

> On 8/14/2018 10:05 AM, Sargun Dhillon wrote:
>
> > On Mon, Jul 16, 2018 at 10:53 AM, Casey Schaufler
> > casey at schaufler-ca.com wrote:
> >
> > > LSM: Full security module stacking
> > > I'm calling this v1 not because it's the first version
> > > I've put out but because it's the first version I'm getting
> > > serious external pressure to get upstream.
> > > Awesome work, I'm glad that this is getting further.
>
> It's following the 90/90 rule pretty closely. The first
> 90% of the work took 90% of the time, and the last 10% is
> taking the other 90% of the time.
>
> > > The blob management part (through "LSM: Sharing of security blobs")
> > > is ready for prime-time. These changes move the management of
> > > security blobs out of the security modules and into the security
> > > module infrastructure. With this change the proposed S.A.R.A,
> > > LandLock and PTAGS security modules could co-exist with any of
> > > the existing "major" security modules. The changes reduce some
> > > code duplication.
> > > Beyond the blob management there's a bit of clean-up.
> > > Mounting filesystems had to be changed so that options
> > > a security module doesn't recognize won't be considered
> > > a fatal error. The mount infrastructure is somewhat
> > > more complex than one might assume.
> >
> > Casey,
> > Do you think you can break out 1 into its own patch? It seems like
> > that'd be valuable to everyone.
>
> Yes, I think that is a good idea. Landlock, S.A.R.A. and a couple
> other security modules could be added upstream if this part of the
> work was available. It would not provide everything needed to stack
> all the existing modules. I believe there is concern that if this
> much went upstream the work on finishing what's required to make
> everything work might be abandoned.
>

On the other hand there is concern that those security modules might
be abandoned if they have to wait until everything is finished :)

> > What's your thought here if we ever introduce dynamic security
> > modules? It's nice that we now have a way around rolling back blobs if
> > one fails, but what if a new module was activated, would we just
> > resize the slab cache?
>
> Making the blob size dynamic at run time makes the blob management
> more complicated because you have to keep track of the modules in
> play when the blob was allocated, and pay attention to that when hooks
> are called. It's a lot simpler if you don't let blobs get smaller,
> but still requires more bookkeeping than if the size is static. It
> is completely doable. I have played with it a bit. There are performance
> implications.

Jordan
