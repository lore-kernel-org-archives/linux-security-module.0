From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 21 Nov 2017 16:25:19 +0100
Subject: IMA appraisal master plan?
In-Reply-To: <1511273148.4729.206.camel@linux.vnet.ibm.com>
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
	<alpine.LFD.2.20.1711200746120.25470@localhost>
	<1511173252.5979.45.camel@intel.com>
	<fd3f5cd3-a6a8-a540-f634-4ac489a171e8@huawei.com>
	<1511273148.4729.206.camel@linux.vnet.ibm.com>
Message-ID: <e84b74a4-be06-8c15-5bbe-c4e7ee8abe42@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/21/2017 3:05 PM, Mimi Zohar wrote:
> On Tue, 2017-11-21 at 10:33 +0100, Roberto Sassu wrote:
>> On 11/20/2017 11:20 AM, Patrick Ohly wrote:
>>> On Mon, 2017-11-20 at 07:47 +1100, James Morris wrote:
>>>> On Fri, 17 Nov 2017, Roberto Sassu wrote:
>>>>
>>>>> LSMs are responsible to enforce a security policy at run-time,
>>>>> while IMA/EVM protect data and metadata against offline attacks.
>>>>
>>>> In my view, IMA can also protect against making an online attack
>>>> persistent across boots, and that would be the most compelling use of
>>>> it?for many general purpose applications.
>>
>> It would be possible, if IMA knows when the system is in the expected
>> state. For example, if the system is in the expected state after digest
>> lists have been loaded, IMA could erase the EVM key, sealed to that
>> state, when a file with unknown digest is measured. The system won't be
>> able to produce valid HMACs, and files modified after the attack can be
>> identified at the next boot, due to the invalid HMAC. Also accessing
>> files with invalid HMAC will cause the EVM key to be zeroed.
> 
> Roberto, allowing the system to boot with an EVM HMAC key, but then
> transition to a point when it can't be used, is a good idea. ?The
> transitioning, however, shouldn't be tied to white lists. ?Please keep
> these concepts independent of each other.

A predictable system state can be achieved also with file signatures.
The system works as expected when it uses the provided public key to
verify signatures and grants access to signed files. But also in this
case, IMA should know if mutable files are good or not. With the
enforcement of an integrity policy on appraised files, a mutable file is
good if it has a valid HMAC.

An important remark is that having a predictable state does not prevent
reporting all measurements protected with another PCR. The predictable
state is necessary to determine when the EVM key can be used to
calculate HMACs. Also, the EVM key should be securely generated (e.g. by
setting the sensitiveDataOrigin bit with TPM 2.0) and available only
when the sealing policy is verified.


> Preventing a device from booting is major. ?Is there a less drastic
> solution that would allow detection, without resealing the EVM HMAC
> key so it can't be used?

With the enforcement of the Biba strict policy, the EVM key will not be
erased, because IMA prevents corruption of mutable files. I suggest to
not measure files if access will be denied by appraisal.

In the next version of the patch set 'ima: preserve integrity of dynamic
data', I will introduce the policy low watermark for objects. Instead of
denying writing of mutable files by processes outside the TCB, IMA will
allow the operation and demote those files (remove the HMAC).

If appraisal is in enforcing mode, access to demoted files will be
denied. Otherwise, they will be measured (patch 2/2 of the patch set
excludes from measurement only files with appraisal status
INTEGRITY_PASS). The EVM key will be erased before a TCB process reads a
demoted file. At the next boot, the EVM key can be used if demoted files
are not accessed by TCB processes.


> Years ago Dave and I had a prototype of "locking" mutable files, after
> a certain point in the boot process, working. ?It allowed the ~20
> mutable files to be created/updated, as necessary. ?The limitation was
> that any package updates or new packages installations needed to be
> done during this window, before the transition, as well.

If the TCB contains only processes that don't corrupt mutable files and
those files are protected with the enforcement of an integrity policy,
locking them wouldn't be necessary.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
