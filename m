From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 8 Nov 2017 11:16:57 +0100
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C002317307@ALPMBAPA12.e2k.ad.ge.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<BCA04D5D9A3B764C9B7405BBA4D4A3C002317307@ALPMBAPA12.e2k.ad.ge.com>
Message-ID: <c833ce48-e33e-e47a-f9ab-f25e9982b836@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/7/2017 7:03 PM, Safford, David (GE Global Research, US) wrote:
>> -----Original Message-----
>> From: linux-integrity-owner at vger.kernel.org [mailto:linux-integrity-
>> owner at vger.kernel.org] On Behalf Of Roberto Sassu
>> Sent: Tuesday, November 07, 2017 5:37 AM
>> To: linux-integrity at vger.kernel.org
>> Cc: linux-security-module at vger.kernel.org; linux-fsdevel at vger.kernel.org;
>> linux-doc at vger.kernel.org; linux-kernel at vger.kernel.org;
>> silviu.vlasceanu at huawei.com; Roberto Sassu <roberto.sassu@huawei.com>
>> Subject: EXT: [PATCH v2 00/15] ima: digest list feature
>>
>> IMA is a security module with the objective of reporting or enforcing the
>> integrity of a system, by measuring files accessed with the execve(),
>> mmap() and open() system calls. For reporting, it takes advantage of the
>> TPM and extends a PCR with the digest of an evaluated event. For enforcing,
>> it returns a value which is zero if the operation should be allowed, negative if
>> it should be denied.
>>
>> Measuring files of an operating system introduces three main issues. First,
>> since the overhead introduced by the TPM is noticeable, the performance of
>> the system decreases linearly with the number of measurements taken.
>> This can be seen especially at boot time.
> 
> If you want the measurement chain of trust, every link must be extended in the TPM.
> This is inherent in the model. Doing local verification of TCB files is really no substitute.

Digest list measurement is extended in the TPM. If not, digest lookup
is disabled until reboot. The same happens for appraisal: if the digital
signature of digest lists is invalid, digest list cannot be used for
local verification. This check is done in patch 10/15.

The Trusted Computing paradigm measure and load is respected: either the
digest list has been measured and local verification can be done, or
individual digests are reported.

I would compare the digest list measurement as the same as the
measurement of a security policy containing allowed permissions.
Trusting the measurement of the policy and the system means trusting the
system to enforce the security policy.


> Not to mention that leaving out "known" hashes from attestation eliminates the
> ability to do analytics on the patterns of usage of the good files. Local appraisal is a
> good thing, but not a complete substitute for remote attestation.

Patch 11/15 gives the possibility to selectively enable digest list
lookup for specific rules. This means that, for example, digest lookup
can be enabled for PCR 10, so that its value is predictable and can be
used for sealing policies, and disabled for a different PCR, which can
be used to report more information.


>> Second, managing large measurement
>> lists requires computation power and network bandwidth.
> 
> So 200 nodes with 5000 entries, 100bytes per entry average (that's a pretty large TCB, but OK):
> that's roughly .8 seconds total on a single Gb link.

I was also considering the overhead due to using the TCG format (XML).


>> Third, it is
>> necessary to obtain reference measurements (i.e. digests of software
>> known to be good) to evaluate/enforce the integrity of the system. If file
>> signatures are used to enforce access, Linux distribution vendors have to
>> modify their building systems in order to include signatures in their packages.
> 
> Or you can use the initial enrollment to transfer a reference manifest.
> Or you can use SWIDS. Or you can sign everything yourself. (That's what we do.)

The first two suggestions look similar to what I'm proposing, having a
list of digests signed by the vendor.


>> Digest lists aim at mitigating these issues. A digest list is a list of digests that
>> are taken by IMA as reference measurements and loaded before files are
>> accessed. Then, IMA compares calculated digests of accessed files with
>> digests from loaded digest lists. If the digest is found, measurement,
>> appraisal and audit are not performed.
> 
> So who manages the "good" hash lists? They have to go into the initramfs,
> and be updated with every package update. And Leaving out attestation of
> good TCB files reduces the potential power of analytics.

The initial ram disk should contain at least (for appraisal) the digests
of files that will be accessed before the root filesystem is mounted.
Then, the remaining digest lists can be loaded by systemd, for example.

Previously, I mentioned the possibility of using different PCRs for a
more complete report. But, if a sealing policy for PCR 10 should provide
more guarantees than just which set of files can be possibly accessed
(for example, which subset of files have been actually accessed), this
can be achieved by extending the TPM with the digest of a policy to 
check that condition, and creating a measurement entry when the
condition becomes true. This will keep the PCR 10 value predictable.

I have an use case for the predictable state: I want to seal the EVM key
to PCR 10, use the key to protect mutable files and enforce the Biba 
strict policy in order to allow writes to mutable files only by the TCB.
Then, if the EVM key is securely generated (sensitiveDataOrigin is set),
and the system proves during remote attestation that the expected key
has been loaded and PCR values match those used to seal the key, the
measurement of mutable files can be avoided.


>> Multiple digest lists can be loaded at the same time, by providing to IMA
>> metadata for each list: digest, signature and path. The digest is specified so
>> that loaded digest lists can be identified only with the measurement of
>> metadata. The signature is used for appraisal. If the verification succeeds,
>> IMA loads the digest list even if security.ima is missing.
>>
>> Digest lists address the first issue because the TPM is used only if the digest
>> of a measured file is unknown. On a minimal system, 10 of 1400
>> measurements are unknown because of mutable files (e.g. log files).
> 
> At 5ms per extend, you at most save 7 seconds at boot. But the savings are
> actually much less, as the extends run simultaneously with most of the
> other boot operations. I typically can't tell the difference without a
> stopwatch.

I performed some tests on a HP EliteDesk 800 G2. The boot time without
an IMA policy is 8.5 seconds. With the IMA policy and without the
TPM performance patches is 1 minute and 30 seconds. With the TPM
performance patches is 24 seconds. 1400 measurements are recorded.

Roberto


>> Digest lists mitigate the second issue because, since digest lists do not
>> change, they don't have to be sent at every remote attestation. Sending
>> unknown measurements and a reference to digest lists would be sufficient.
> 
> The .8 second isn't a problem, and even that can be pretty much eliminated by
> sending just the delta measurements.
> 
>> Finally, digest lists address also the third issue because Linux distribution
>> vendors already provide the digests of files included in each RPM package.
>> The digest list is stored in the RPM header, signed by the vendor.
> 
> But then tooling is needed to select the desired hashes and put them in
> the initramfs for loading.
> 
> I guess I don't see the problem, and think the cure introduces issues of its own.
> 
> dave
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
