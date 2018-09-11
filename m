From: kai.huang@intel.com (Huang, Kai)
Date: Tue, 11 Sep 2018 03:15:22 +0000
Subject: [RFC 00/12] Multi-Key Total Memory Encryption API (MKTME)
In-Reply-To: <20180910191059.GA26529@alison-desk.jf.intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
	<105F7BF4D0229846AF094488D65A098935424961@PGSMSX112.gar.corp.intel.com>
	<20180910191059.GA26529@alison-desk.jf.intel.com>
Message-ID: <1536635716.5860.17.camel@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-09-10 at 12:10 -0700, Alison Schofield wrote:
> On Sun, Sep 09, 2018 at 06:10:19PM -0700, Huang, Kai wrote:
> > 
> > > -----Original Message-----
> > > From: keyrings-owner at vger.kernel.org [mailto:keyrings-
> > > owner at vger.kernel.org] On Behalf Of Alison Schofield
> > > Sent: Saturday, September 8, 2018 10:23 AM
> > > To: dhowells at redhat.com; tglx at linutronix.de
> > > Cc: Huang, Kai <kai.huang@intel.com>; Nakajima, Jun
> > > <jun.nakajima@intel.com>; Shutemov, Kirill <kirill.shutemov@intel
> > > .com>;
> > > Hansen, Dave <dave.hansen@intel.com>; Sakkinen, Jarkko
> > > <jarkko.sakkinen@intel.com>; jmorris at namei.org; keyrings at vger.ker
> > > nel.org;
> > > linux-security-module at vger.kernel.org; mingo at redhat.com; hpa at zyto
> > > r.com;
> > > x86 at kernel.org; linux-mm at kvack.org
> > > Subject: [RFC 00/12] Multi-Key Total Memory Encryption API
> > > (MKTME)
> > > 
> > > Seeking comments on the APIs supporting MKTME on future Intel
> > > platforms.
> > > 
> > > MKTME (Multi-Key Total Memory Encryption) is a technology
> > > supporting
> > > memory encryption on upcoming Intel platforms. Whereas TME allows
> > > encryption of the entire system memory using a single key, MKTME
> > > allows
> > > mulitple encryption domains, each having their own key. While the
> > > main use
> > > case for the feature is virtual machine isolation, the API needs
> > > the flexibility to
> > > work for a wide range of use cases.
> > > 
> > > This RFC presents the 2 API additions that enable userspace to:
> > >  1) Create Encryption Keys: Kernel Key Service type "mktme"
> > >  2) Use the Encryption Keys: system call encrypt_mprotect()
> > > 
> > > In order to share between: the Kernel Key Service, the new system
> > > call, and the
> > > existing mm code, helper functions were created in arch/x86/mktme
> > 
> > IMHO, we can separate this series into 2 parts, as you did above,
> > and send out them separately. The reason is, in general I think
> > adding new MKTME type to key retention services is not that related
> > to memory management code, namely the encrypt_mprotect() API part.
> > 
> > So if we split the two parts and send them out separately, the
> > first part can be reviewed by keyring and security guys, without
> > involving mm guys, and the encrypt_mprotect() part can be more
> > reviewed more by mm guys. 
> > 
> 
> Kai,
> 
> That was the direction I had in mind at the onset: the MKTME key
> service
> would be one patch(set) and the MKTME encrypt_mprotect() system call
> would
> be delivered in another patch(set).
> 
> That separation falls apart when the shared structures and functions
> are
> introduced. That 'mktme_map' (maps userspace keys to hardware keyid
> slots),
> and the 'encrypt_count' array (counts vma's outstanding for each key)
> need
> to be shared by both pieces. These mktme special shared structures
> and the
> functions that operate on them are all defined in
> arch/x86/mm/mktme.h,.c.
> From there they can be shared with the security/keys/mktme_keys.c
> 
> Once I made that separation, I stuck with it. Those structures, and
> any
> functions that manipulate those structures live in
> arch/x86/mm/mktme.h,c
> 
> You noted that some of the functions that operate on the
> encrypt_count
> might not need to be over in arch/x86/mm/mktme.c because they are not
> used
> in the mm code. That is true.  

Yes IMO this is better.

> But, then I'd be splitting up the definition
> of the struct and the funcs that operate on it. So, I stuck with
> keeping it
> all together in the arch specific mktme files.

Definition can also be in include/keys/mktme-type.h, right?

> 
> Having said all the above, I do welcome other ideas on how to better
> organize
> the code. 
> 
> Back to your request- to split it into smaller patchsets might look
> something
> like:
> 1) the MKTME API helpers

Exactly what helpers?

> 2) the MKTME Key Service
> 3) the MKTME syscall encrypt_mprotect()
> 
> I'm not clear that would make anyones review life easier, than
> picking
> the same pieces out of the greater patchset.

Well, the reason I suggested we should split key retention services
from other staff and get it reviewed first is I think the
functionalities of MKTME key type has nothing to do w/ MM code. IMHO
what MKTME key type should provide includes:

1) Support add_key, keyctl (revoke, etc) obviously. THis also implies
keyID allocation, so you will need some info from MM or x86 code to get
 info such as number of keyIDs, etc. In fact I think number of keyIDs
is  the only info you need (0 keyIDs means MKTME is disabled).

2) You need to provide some APIs to munipulate key reference count.
Those functions can be declared in mktme-type.h, and implemented in
mktme_keys.c. I think this is more reasonable, as logically reference
count is part of MKTME key service.

I don't think you need to do anything else in MKTME key type?

I think you can even start upstreaming MKTME key type now w/o Kirill's
core-MKTME support, since 1) adding MKTME key type doesn't do any harm
w/o kirill's core-MKTME code; 2) logically MKTME key type has no true
dependency on core-MKTME code.

So IMHO, a better structure should be:

1) Current upstream code (maybe with some early detction code change,
ie, to disable MKTME for some SW reason, but I am not sure whether this
is truely needed, since when MKTME key type gets initialized, that part
should been done already).
2) MKTME key type
3) Kirill's core-MKTME
4) new syscall

And I think CONFIG_MKTME_KEYS doesn't really need to depend on
CONFIG_INTEL_MKTME at this point, although we can add such if needed
when kirill's core-MKTME code gets upstreamed.

Thanks,
-Kai
> 
> Suggestions welcome,
> Alison
> 
> > And since encrypt_mprotect() is a new syscall, you may need to add
> > more lists for the review, ie, linux-api, and maybe linux-kernel as
> > well.
> 
> Got it. Will include theses in v1.
> 
> > 
> > Thanks,
> > -Kai
> > 
> > > 
> > > This patchset is built upon Kirill Shutemov's patchset for the
> > > core MKTME
> > > support. You can find that here:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
> > > mktme/wip
> > > 
> > > 
> > > Alison Schofield (12):
> > >   docs/x86: Document the Multi-Key Total Memory Encryption API
> > >   mm: Generalize the mprotect implementation to support
> > > extensions
> > >   syscall/x86: Wire up a new system call for memory encryption
> > > keys
> > >   x86/mm: Add helper functions to manage memory encryption keys
> > >   x86/mm: Add a helper function to set keyid bits in encrypted
> > > VMA's
> > >   mm: Add the encrypt_mprotect() system call
> > >   x86/mm: Add helper functions to track encrypted VMA's
> > >   mm: Track VMA's in use for each memory encryption keyid
> > >   mm: Restrict memory encryption to anonymous VMA's
> > >   x86/pconfig: Program memory encryption keys on a system-wide
> > > basis
> > >   keys/mktme: Add a new key service type for memory encryption
> > > keys
> > >   keys/mktme: Do not revoke in use memory encryption keys
> > > 
> > >  Documentation/x86/mktme-keys.txt       | 153 ++++++++++++++++
> > >  arch/x86/Kconfig                       |   1 +
> > >  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
> > >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> > >  arch/x86/include/asm/intel_pconfig.h   |  42 ++++-
> > >  arch/x86/include/asm/mktme.h           |  21 +++
> > >  arch/x86/mm/mktme.c                    | 141 ++++++++++++++
> > >  fs/exec.c                              |   4 +-
> > >  include/keys/mktme-type.h              |  28 +++
> > >  include/linux/key.h                    |   2 +
> > >  include/linux/mm.h                     |   9 +-
> > >  include/linux/syscalls.h               |   2 +
> > >  include/uapi/asm-generic/unistd.h      |   4 +-
> > >  kernel/fork.c                          |   2 +
> > >  kernel/sys_ni.c                        |   2 +
> > >  mm/mmap.c                              |  12 ++
> > >  mm/mprotect.c                          |  93 +++++++++-
> > >  mm/nommu.c                             |   4 +
> > >  security/keys/Kconfig                  |  11 ++
> > >  security/keys/Makefile                 |   1 +
> > >  security/keys/internal.h               |   6 +
> > >  security/keys/keyctl.c                 |   7 +
> > >  security/keys/mktme_keys.c             | 325
> > > +++++++++++++++++++++++++++++++++
> > >  23 files changed, 855 insertions(+), 17 deletions(-)  create
> > > mode 100644
> > > Documentation/x86/mktme-keys.txt  create mode 100644
> > > include/keys/mktme-
> > > type.h  create mode 100644 security/keys/mktme_keys.c
> > > 
> > > --
> > > 2.14.1
