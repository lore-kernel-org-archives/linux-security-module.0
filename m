From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Sun, 16 Sep 2018 19:45:38 +0200
Subject: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and
	Landlock
In-Reply-To: <3cd46663-e566-5ffc-32a4-00a90cd1346e@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
	<alpine.LRH.2.21.1809130727310.19741@namei.org>
	<CAJHCu1+Nja-XqfFKdxu2hDcUBzgvvjcf42yeGnUuVY3wsrZfSQ@mail.gmail.com>
	<3cd46663-e566-5ffc-32a4-00a90cd1346e@schaufler-ca.com>
Message-ID: <CAJHCu1Jgkax3Y5Do9Y6-kYbiNLBFoF-8U9TYyeE0H=EM7xp18w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/16/2018 9:54 AM, Salvatore Mesoraca wrote:
> > On Wed, 12 Sep 2018, James Morris <jmorris@namei.org> wrote:
> >> Adding the SARA and LandLock authors for review & comment.
> >>
> >> Salvatore & Micka?l: does this patchset meet your needs for merging to
> >> mainline?
> > Since the last time I submitted the patch to the ML, it grew a bit: now it needs
> > inode's blob stacking (which is already included for Landlock) and
> > kern_ipc_perm's
> > blob stacking.
> > The last one isn't implemented in this patchset, but it isn't
> > absolutely necessary.
> > I can merge a version of SARA that doesn't need it and than update it
> > when possible.
> > I can provide the same level of protection without using kern_ipc_perm
> > blob, I'm using it
> > just to minimize some potential side effects.
>
> Adding kern_ipc_perm is easy. As it looks like there will need to be
> a few revisions I will add it to the next set.

Great! Thank you very much!
