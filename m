From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 21 Nov 2017 10:33:42 +0100
Subject: IMA appraisal master plan?
In-Reply-To: <1511173252.5979.45.camel@intel.com>
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
Message-ID: <fd3f5cd3-a6a8-a540-f634-4ac489a171e8@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/20/2017 11:20 AM, Patrick Ohly wrote:
> On Mon, 2017-11-20 at 07:47 +1100, James Morris wrote:
>> On Fri, 17 Nov 2017, Roberto Sassu wrote:
>>
>>> LSMs are responsible to enforce a security policy at run-time,
>>> while IMA/EVM protect data and metadata against offline attacks.
>>
>> In my view, IMA can also protect against making an online attack
>> persistent across boots, and that would be the most compelling use of
>> it?for many general purpose applications.

It would be possible, if IMA knows when the system is in the expected
state. For example, if the system is in the expected state after digest
lists have been loaded, IMA could erase the EVM key, sealed to that
state, when a file with unknown digest is measured. The system won't be
able to produce valid HMACs, and files modified after the attack can be
identified at the next boot, due to the invalid HMAC. Also accessing
files with invalid HMAC will cause the EVM key to be zeroed.

Since IMA would erase the EVM key when a new measurement entry is
created, digests of mutable files with valid HMAC should not be added to
the measurement list (the initial digest must be provided with a digest
list, or files must be signed). This requires that the integrity of
mutable files is guaranteed by LSMs or by IMA, with the patch set 'ima:
preserve integrity of dynamic data'.


> I do not quite buy that interpretation. If the online attack succeeds
> in bypassing the run-time checks, for example with a full root exploit,
> then he has pretty much the same capabilities to make persistent file
> changes as during an offline attack.

If the full root exploit modifies the current system state, persistent
changes can be detected, as I explained above. The effectiveness of the
solution depends on which checks are done by the system. For example, in
addition to checking if the digest of measured files is in a digest
list, IMA could check that a specific application is running (e.g.
antivirus) and that the firewall has been started before network
services. More checks increase the likelihood that the full root exploit
causes a system state change.

Roberto


> When allowing local hashing, it's actually worse: during an offline
> attack, the attacker might not have access to the TPM and thus cannot
> easily update the EVM HMAC. During an online attack, the kernel will
> happily update that and the IMA hash for the attacker, resulting in a
> file that passes appraisal after a reboot.
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
