From: david.safford@ge.com (Safford, David (GE Global Research, US))
Date: Tue, 7 Nov 2017 18:03:44 +0000
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C002317307@ALPMBAPA12.e2k.ad.ge.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> -----Original Message-----
> From: linux-integrity-owner at vger.kernel.org [mailto:linux-integrity-
> owner at vger.kernel.org] On Behalf Of Roberto Sassu
> Sent: Tuesday, November 07, 2017 5:37 AM
> To: linux-integrity at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org; linux-fsdevel at vger.kernel.org;
> linux-doc at vger.kernel.org; linux-kernel at vger.kernel.org;
> silviu.vlasceanu at huawei.com; Roberto Sassu <roberto.sassu@huawei.com>
> Subject: EXT: [PATCH v2 00/15] ima: digest list feature
> 
> IMA is a security module with the objective of reporting or enforcing the
> integrity of a system, by measuring files accessed with the execve(),
> mmap() and open() system calls. For reporting, it takes advantage of the
> TPM and extends a PCR with the digest of an evaluated event. For enforcing,
> it returns a value which is zero if the operation should be allowed, negative if
> it should be denied.
> 
> Measuring files of an operating system introduces three main issues. First,
> since the overhead introduced by the TPM is noticeable, the performance of
> the system decreases linearly with the number of measurements taken. 
> This can be seen especially at boot time.

If you want the measurement chain of trust, every link must be extended in the TPM.
This is inherent in the model. Doing local verification of TCB files is really no substitute.
Not to mention that leaving out "known" hashes from attestation eliminates the 
ability to do analytics on the patterns of usage of the good files. Local appraisal is a 
good thing, but not a complete substitute for remote attestation.

> Second, managing large measurement
> lists requires computation power and network bandwidth. 

So 200 nodes with 5000 entries, 100bytes per entry average (that's a pretty large TCB, but OK):
that's roughly .8 seconds total on a single Gb link.

> Third, it is
> necessary to obtain reference measurements (i.e. digests of software
> known to be good) to evaluate/enforce the integrity of the system. If file
> signatures are used to enforce access, Linux distribution vendors have to
> modify their building systems in order to include signatures in their packages.

Or you can use the initial enrollment to transfer a reference manifest.
Or you can use SWIDS. Or you can sign everything yourself. (That's what we do.)

> Digest lists aim at mitigating these issues. A digest list is a list of digests that
> are taken by IMA as reference measurements and loaded before files are
> accessed. Then, IMA compares calculated digests of accessed files with
> digests from loaded digest lists. If the digest is found, measurement,
> appraisal and audit are not performed.

So who manages the "good" hash lists? They have to go into the initramfs,
and be updated with every package update. And Leaving out attestation of 
good TCB files reduces the potential power of analytics.

> Multiple digest lists can be loaded at the same time, by providing to IMA
> metadata for each list: digest, signature and path. The digest is specified so
> that loaded digest lists can be identified only with the measurement of
> metadata. The signature is used for appraisal. If the verification succeeds,
> IMA loads the digest list even if security.ima is missing.
> 
> Digest lists address the first issue because the TPM is used only if the digest
> of a measured file is unknown. On a minimal system, 10 of 1400
> measurements are unknown because of mutable files (e.g. log files).

At 5ms per extend, you at most save 7 seconds at boot. But the savings are
actually much less, as the extends run simultaneously with most of the
other boot operations. I typically can't tell the difference without a 
stopwatch.

> Digest lists mitigate the second issue because, since digest lists do not
> change, they don't have to be sent at every remote attestation. Sending
> unknown measurements and a reference to digest lists would be sufficient.

The .8 second isn't a problem, and even that can be pretty much eliminated by
sending just the delta measurements.

> Finally, digest lists address also the third issue because Linux distribution
> vendors already provide the digests of files included in each RPM package.
> The digest list is stored in the RPM header, signed by the vendor.

But then tooling is needed to select the desired hashes and put them in
the initramfs for loading.

I guess I don't see the problem, and think the cure introduces issues of its own.

dave
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
