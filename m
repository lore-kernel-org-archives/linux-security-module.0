From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Fri, 17 Nov 2017 12:54:09 -0500
Subject: IMA appraisal master plan?
In-Reply-To: <1510926170.5920.80.camel@linux.vnet.ibm.com>
References: <20171107151742.25122-1-mjg59@google.com>
	<1510766803.5979.17.camel@intel.com>
	<CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
	<1510770065.5979.21.camel@intel.com>
	<alpine.LFD.2.20.1711161101360.27132@localhost>
	<CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
	<1510798382.3711.389.camel@linux.vnet.ibm.com>
	<8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
	<1510837595.3711.420.camel@linux.vnet.ibm.com>
	<a88aff89-1e75-9019-4394-640f5fb318da@huawei.com>
	<1510926170.5920.80.camel@linux.vnet.ibm.com>
Message-ID: <1510934285.16082.5.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-11-17 at 08:42 -0500, Mimi Zohar wrote:
> On Fri, 2017-11-17 at 13:20 +0100, Roberto Sassu wrote:
> > On 11/16/2017 2:06 PM, Mimi Zohar wrote:
> > > On Thu, 2017-11-16 at 10:23 +0100, Roberto Sassu wrote:
> > > > On 11/16/2017 3:13 AM, Mimi Zohar wrote:
> > > > > On Wed, 2017-11-15 at 16:05 -0800, Matthew Garrett wrote:
> > > > > > On Wed, Nov 15, 2017 at 4:02 PM, James Morris <james.l.morr
> > > > > > is at oracle.com> wrote:
> > > > > > > On Wed, 15 Nov 2017, Patrick Ohly wrote:
> > > > > > > 
> > > > > > > > I have some experience with SMACK, but not with
> > > > > > > > Apparmor. At least with
> > > > > > > > SMACK the problem is that the LSM depends on integrity
> > > > > > > > protection of
> > > > > > > > the xattrs, but the integrity protection itself depends
> > > > > > > > on the LSM, so
> > > > > > > > there's a cycle. An attacker can much too easily make
> > > > > > > > offline changes
> > > > > > > > which then defeat whatever IMA policy the system might
> > > > > > > > be using.
> > > > > > > 
> > > > > > > Isn't this what EVM is supposed to mitigate?
> > > > 
> > > > With the default appraisal policy, it can't. IMA determines if
> > > > a file
> > > > must be appraised depending on metadata whose integrity has not
> > > > been
> > > > verified yet. A root process is able to load appraised files
> > > > with
> > > > i_uid = 0 and files with missing/invalid HMAC and i_uid != 0,
> > > > at the
> > > > same time.
> > > 
> > > The LSMs are responsible for protecting their own
> > > labels.??Theyhave
> > > the opportunity to verify and deny access to files based on LSM
> > > labels, BEFORE IMA-appraisal is called to verify the file's
> > > integrity.
> > 
> > Adding in CC the linux-security-module mailing list.
> 
> We need to first clarify, for those reading this thread, that are not
> fully aware of the context of this discussion, that the discussion is
> not relevant to the "lockdown" patch set.
> 
> Kernel modules, the kexec image, IMA policy and firmware call the pre
> and post LSM kernel_read_file hooks. ?For these LSM hooks, IMA policy
> rules are not written in terms of LSM labels or any other file
> metadata. ?File signatures will always be appraised.
> 
> > LSMs are responsible to enforce a security policy at run-time,
> > while
> > IMA/EVM protect data and metadata against offline attacks. However,
> > if
> > IMA/EVM protect only part of the system, the security policy might
> > not
> > be enforced as expected. I give an example.
> > 
> > Suppose that a security policy preserves the integrity of a
> > database by
> > allowing only one application to modify it. Suppose also, that the
> > security policy allows that application to modify files which are
> > not
> > appraised by IMA. Only the database is appraised.
> 
> This use case scenario is really strange. ?The IMA policy should be
> verifying the integrity of the application that is allowed to modify
> the database, not the database.
> 
> > From my limited knowledge of databases, databases tend to manage
> > data
> 
> caching themselves at the application level (eg. Direct IO), and
> avoid
> file buffer caching. ?Having IMA calculate the file hash, would
> negate
> the performance benefits of doing their own data caching.
> 
> > Then, the integrity of the database cannot be guaranteed anymore.
> > When
> > the system is offline, the database label is swapped with one that
> > is
> > not included in the IMA policy. When the system is online again,
> > LSMs
> > would allow the application to access the database, but its
> > integrity
> > is no longer verified. From the users perspective, the application
> > is
> > working correctly, while unauthorized modifications could have be
> > done
> > on the database.
> > 
> > In my opinion, protecting the integrity of a TCB against offline
> > and
> > online attacks with LSMs and IMA/EVM, can be achieved in two ways:
> 
> I really doubt that anyone's definition of TCB would include
> databases.
> 
> > 
> > - all objects accessed by LSM TCB subjects are a subset of IMA TCB
> > ???objects, and LSM prevents accesses to LSM TCB objects by
> > processes
> > ???outside LSM TCB
> > 
> > - all objects accessed by IMA TCB subjects are protected by IMA,
> > IMA
> > ???prevents accesses to IMA TCB objects by processes outside IMA
> > TCB, and
> > ???LSM TCB subjects are a subset of IMA TCB subjects
> > 
> > As you can see, in both cases there is a dependency between the LSM
> > policy and the IMA policy. In the first case, the dependency is on
> > objects and LSM is enforcing integrity. In the second case, the
> > dependency is on subjects, IMA is enforcing integrity and LSM could
> > enforce a more strict integrity policy or a policy with different
> > goals.
> > 
> > I prefer the second option because:
> > 
> > 1) it easier to write a policy in term of subjects rather than
> > objects
> > 
> > 2) LSM does not necessarily enforce an integrity policy; LSM could
> > ????enforce a policy for isolation and containment, while IMA could
> > ????enforce an integrity policy
> > 
> > 3) an integrity policy can be enforced without LSM, and both LSM
> > and IMA
> > ????can enforce their own integrity policy
> > 
> > 4) the effort necessary to enforce an integrity policy with IMA is
> > very
> > ????low: if files with valid signature/HMAC are in the IMA TCB and
> > the
> > ????IMA policy identifies TCB subjects, the required modification
> > would
> > ????be to simply deny access to appraised files if the subject does
> > not
> > ????match policy criteria
> > 
> > The first version of the patch set which adds support for the
> > enforcement of the Biba strict policy can be found at the URL:
> > 
> > https://www.spinics.net/lists/linux-integrity/msg00392.html
> 
> I'd be interested in hearing what other people think.

My $0.02, take or leave it as you wish:

First, Biba integrity models don't work well in the real world; that
was one of the motivations for the introduction of Type Enforcement
(c.f. Boebert and Kain 1985, Ross Anderson's Security Engineering, and
many other works in the literature). SELinux TE can be used to enforce
integrity access control goals, and is successfully enforcing such
goals in Android (and to some degree in Fedora/RHEL, modulo the
presence of unconfined domains in the default policy and the
complexities associated with the large and dynamic GNU/Linux TCB). Even
Windows Mandatory Integrity Controls, which are based on Biba, disable
half the Biba model by default to avoid breaking normal system
operation, and are only used in a very constrained manner due to the
limitations of the model.

Second, if you want to protect against offline attacks, use dm-verity
or dm-crypt with an integrity-preserving algorithm.  Trying to keep
extending IMA/EVM to provide a complete solution in this space is a
losing proposition IMHO; you will only end up with something that is
either unusable or insecure - take your pick.  Use IMA for what it was
originally designed to do, i.e. userspace measurement and remote
attestation. 

Third, the integrity framework/modules shouldn't be defining or
enforcing an access control policy; leave that to the security
framework/modules, please.  Some might argue that they started doing
that the day they introduced IMA-appraisal (which itself is an
interesting topic; there is a reason why "remote" is in "remote
attestation", but we'll leave that to another day) but I think it would
be a mistake to extend it to a conventional access control policy like
Biba.  If you truly want a Biba integrity policy, then do it in a small
LSM and use that to motivate extreme stacking.  But think hard whether
Biba is truly the right answer (and if so, what was question that
motivated it), given that it really doesn't work in practice.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
