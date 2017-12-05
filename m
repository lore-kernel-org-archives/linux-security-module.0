From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Tue, 5 Dec 2017 17:03:15 -0500
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <5060980f-2b70-6b77-89f2-5ef66ff4cace@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/7/2017 5:36 AM, Roberto Sassu wrote:
> 
> Digest lists aim at mitigating these issues. A digest list is a list of
> digests that are taken by IMA as reference measurements and loaded before
> files are accessed. Then, IMA compares calculated digests of accessed files
> with digests from loaded digest lists. If the digest is found, measurement,
> appraisal and audit are not performed.

If you don't do measurements (the extends), then the remote appraiser
can't determine what's running.  Doesn't that break the whole point of 
remote attestation?

> Digest lists address the first issue because the TPM is used only if the
> digest of a measured file is unknown. On a minimal system, 10 of 1400
> measurements are unknown because of mutable files (e.g. log files).
> 
> Digest lists mitigate the second issue because, since digest lists do not
> change, they don't have to be sent at every remote attestation. Sending
> unknown measurements and a reference to digest lists would be sufficient.

Typically, one would not send the entire log at every attestation.  The
algorithm I use is:

- if it's the first quote after a reboot, send the entire log, else
- if PCRs haven't changed, don't send anything, else
- send a delta since the last attestation.

Even without this obvious optimization, the transmit time is negligible 
compared to the quote signature generation time.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
