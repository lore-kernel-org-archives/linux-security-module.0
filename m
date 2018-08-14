From: sargun@sargun.me (Sargun Dhillon)
Date: Tue, 14 Aug 2018 10:05:07 -0700
Subject: [PATCH v1 00/22] LSM: Full security module stacking
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Message-ID: <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 16, 2018 at 10:53 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> LSM: Full security module stacking
>
> I'm calling this v1 not because it's the first version
> I've put out but because it's the first version I'm getting
> serious external pressure to get upstream.
Awesome work, I'm glad that this is getting further.

>
> The blob management part (through "LSM: Sharing of security blobs")
> is ready for prime-time. These changes move the management of
> security blobs out of the security modules and into the security
> module infrastructure. With this change the proposed S.A.R.A,
> LandLock and PTAGS security modules could co-exist with any of
> the existing "major" security modules. The changes reduce some
> code duplication.
>
> Beyond the blob management there's a bit of clean-up.
> Mounting filesystems had to be changed so that options
> a security module doesn't recognize won't be considered
> a fatal error. The mount infrastructure is somewhat
> more complex than one might assume.
>

Casey,
Do you think you can break out 1 into its own patch? It seems like
that'd be valuable to everyone.


What's your thought here if we ever introduce dynamic security
modules? It's nice that we now have a way around rolling back blobs if
one fails, but what if a new module was activated, would we just
resize the slab cache?
