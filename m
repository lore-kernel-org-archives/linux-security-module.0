From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 6 Dec 2017 10:13:23 +0100
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <5060980f-2b70-6b77-89f2-5ef66ff4cace@linux.vnet.ibm.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<5060980f-2b70-6b77-89f2-5ef66ff4cace@linux.vnet.ibm.com>
Message-ID: <bca7c2af-def4-17cd-7b91-c1122877d3d4@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 12/5/2017 11:03 PM, Ken Goldman wrote:
> On 11/7/2017 5:36 AM, Roberto Sassu wrote:
>>
>> Digest lists aim at mitigating these issues. A digest list is a list of
>> digests that are taken by IMA as reference measurements and loaded before
>> files are accessed. Then, IMA compares calculated digests of accessed 
>> files
>> with digests from loaded digest lists. If the digest is found, 
>> measurement,
>> appraisal and audit are not performed.
> 
> If you don't do measurements (the extends), then the remote appraiser
> can't determine what's running.? Doesn't that break the whole point of 
> remote attestation?

There are two different approaches:

a) report everything

The local system just measures what is specified in the policy. The
system state is unpredictable, which means that PCRs cannot be used for
anything else than remote attestation.

b) report differences from an expected state

The expected state is defined in advance. This includes which files can
be accessed by the local system (digest lists), but could also include
which files must be accessed, and in which sequence. PCRs can be used
also for sealing policies (data can be unsealed if the system is in the
expected state).

Example of expected state:

1) only files with digest in the loaded digest lists can be accessed
2) the antivirus must be executed
3) sshd must be executed after iptables

The expected state (policy) is measured.

At run-time, the local system verifies the conditions above. If the
system is in the expected state, the measurement list will contain:

digest lists
the event 'antivirus was executed'

If 1 is false, unknown digests are added to the measurement list.
If 2 is false, the event 'antivirus was executed' is not added to the
measurement list.
If 3 is false, the event 'sshd was executed before iptables' is added to
the measurement list.


>> Digest lists address the first issue because the TPM is used only if the
>> digest of a measured file is unknown. On a minimal system, 10 of 1400
>> measurements are unknown because of mutable files (e.g. log files).
>>
>> Digest lists mitigate the second issue because, since digest lists do not
>> change, they don't have to be sent at every remote attestation. Sending
>> unknown measurements and a reference to digest lists would be sufficient.
> 
> Typically, one would not send the entire log at every attestation.? The
> algorithm I use is:

I think this is not suitable for scenarios where unknown Requestors are
attested.

https://trustedcomputinggroup.org/wp-content/uploads/IWG_Architecture_v1_0_r1.pdf 
(Section 4)


> - if it's the first quote after a reboot, send the entire log, else
> - if PCRs haven't changed, don't send anything, else
> - send a delta since the last attestation.
> 
> Even without this obvious optimization, the transmit time is negligible 
> compared to the quote signature generation time.
Having large measurement lists introduces additional issues:

1) overhead to generate/parse the TCG Integrity Report
    (Requestor/Verifier)
2) storage requirement (Verifier)
3) overhead to build the complete Integrity Report from base + delta if
    the verification tool is not stateful (Verifier)

Roberto

> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at? http://vger.kernel.org/majordomo-info.html

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
