From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 21 Feb 2018 16:46:33 -0600
Subject: [PATCH v1 1/2] ima: fail signature verification on untrusted
	filesystems
In-Reply-To: <1519224379.3736.154.camel@linux.vnet.ibm.com> (Mimi Zohar's
	message of "Wed, 21 Feb 2018 09:46:19 -0500")
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
	<87zi44mz26.fsf@xmission.com>
	<alpine.LRH.2.21.1802201152240.883@namei.org>
	<87tvucifji.fsf@xmission.com>
	<1519135329.3736.88.camel@linux.vnet.ibm.com>
	<20180220201636.GA1565@mail.hallyn.com>
	<1519224379.3736.154.camel@linux.vnet.ibm.com>
Message-ID: <87mv02c65y.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

>> > > On the flip side when it really is a trusted mounter, and it is in a
>> > > configuration that IMA has a reasonable expectation of seeing all of
>> > > the changes it would be nice if we can say please trust this mount.
>> > 
>> > IMA has no way of detecting file change. ?This was one of the reasons
>> > for the original patch set's not using the cached IMA results.
>> > 
>> > Even in the case of a trusted mounter and not using IMA cached
>> > results, there are no guarantees that the data read to calculate the
>> > file hash, will be the same as what is subsequently read. ?In some
>> > environments this might be an acceptable risk, while in others not.
>> 
>> So for the cases where it's not, there should be an IMA option or policy
>> to say any SB_I_IMA_UNVERIFIABLE_SIGNATURES mounts should be not
>> trusted, with the default being both SB_I_IMA_UNVERIFIABLE_SIGNATURES and
>> SB_I_UNTRUSTED_MOUNTER must be true to not trust, right?
>
> Right. ?To summarize, we've identified 3 scenarios:
> 1. Fail signature verification on unprivileged non-init root mounted
> file systems.
>
> flags: SB_I_IMA_UNVERIFIABLE_SIGNATURES and SB_I_UNTRUSTED_MOUNTER
> (always enabled)
>
> 2. Permit signature verification on privileged file system mounts in a
> secure system environment. ?Willing to accept the risk. ?Does not rely
> on cached integrity results, but forces re-evaluation.
>
> flags: SB_I_IMA_UNVERIFIABLE_SIGNATURES, not SB_I_UNTRUSTED_MOUNTER or
> IMA_FAIL_UNVERIFICABLE_SIGNATURES (default behavior)
>
> 3. Fail signature verification also on privileged file system mounts.
> Fail safe, unwilling to accept the risk.
>
> flags:
> SB_I_IMA_UNVERIFIABLE_SIGNATURES and IMA_FAIL_UNVERIFIABLE_SIGNATURES
>
> Enabled by specifying "ima_policy=unverifiable_sigs" on the boot
> command line.

There is another scenaro.
4. Permit signature verification on out of kernel but otherwise fully
   capable and trusted filesystems.

Fuse has a mode where it appears to be cache coherent, and guaranteed to
be local. AKA when fuse block is used and FUSE_WRITEBACK_CACHE is set.
That configuratioin plus the the allow_other mount option appear to
signal a fuse mount that can be reasonably be trusted as much as an
in-kernel block based filesystem.

That is a mode someone might use to mount exFat or ntfs-3g.

As all writes come from the kernel, and it is safe to have a write-back
cache I believe ima can reasonably verify signatures.  There may be
something technical like the need to verify i_version in this case,
but for purposes of argument let's say fuse has implemented all of the
necessary technical details.

In that case we have a case where it is reasonable to say that
SB_I_IMA_UNVERIFIABLE_SIGNATURES would be incorrect to set on a fuse
filesystem.

Mimi do you agree or am I missing something?

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
