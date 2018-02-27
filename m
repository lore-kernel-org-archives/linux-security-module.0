From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 26 Feb 2018 20:12:55 -0600
Subject: [PATCH v1 1/2] ima: fail signature verification on untrusted
	filesystems
In-Reply-To: <1519255954.3400.16.camel@linux.vnet.ibm.com> (Mimi Zohar's
	message of "Wed, 21 Feb 2018 18:32:34 -0500")
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
	<87zi44mz26.fsf@xmission.com>
	<alpine.LRH.2.21.1802201152240.883@namei.org>
	<87tvucifji.fsf@xmission.com>
	<1519135329.3736.88.camel@linux.vnet.ibm.com>
	<20180220201636.GA1565@mail.hallyn.com>
	<1519224379.3736.154.camel@linux.vnet.ibm.com>
	<87mv02c65y.fsf@xmission.com>
	<1519253867.19593.25.camel@linux.vnet.ibm.com>
	<87r2peaqf0.fsf@xmission.com>
	<1519255954.3400.16.camel@linux.vnet.ibm.com>
Message-ID: <87606jw57c.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Wed, 2018-02-21 at 17:12 -0600, Eric W. Biederman wrote:
>> 
>> As I understand the second scenario SB_I_IMA_UNVERIFIABLE_SIGNATURES
>> is set, which implies that the filesystem is lacking something for IMA
>> to reliably know when a file has changed.  AKA a technical deficiency.
>> 
>> The fourth scenario is the case when SB_I_IMA_UNVERIFIABLE_SIGNATURES
>> can be legitimately be cleared, because the filesystem provides all
>> of the necessary support for IMA to reliably know when a file has
>> changed.
>
> The information might be there, but IMA currently detects a file
> change and resets the flags only when the last writer calls
> __fput().??Any other time, new support would be needed.

My point was only that for local NTFS or local exFAT with a quality
and trusted fuse implementation they should be as safe in this regard
as any other filesystem.   So in theory we could have fuse implementing
this level of filesystem as well.  Not that I suggest we try for that
out of the gate.

Thank you very much for the clarification about the last fput that helps
me understand SB_I_IMA_UNVERIFIEDABLE_SIGNATURES much better.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
