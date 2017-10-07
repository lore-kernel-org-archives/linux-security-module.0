From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Sat, 7 Oct 2017 12:56:44 +0200
Subject: Digest list extension for IMA
Message-ID: <a557c9ac-a06e-8bb5-fce7-ddf2663d5b9d@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Mimi

since the next merge window is approaching, I would like to ask
you which steps should be done to have the digest list extension
accepted in the mainline kernel.

Regarding the concerns expressed in the mailing lists:

TPM performance issues should be fixed in the TPM driver

Both improvements can be useful especially, as it was shown at LSS,
there will be around 50000 PCR extends which introduce some overhead
(I applied the ignore burstcount patches and the boot time decreased
from 1 minute and 30 seconds to 24 seconds, which is a great improvement
but maybe not enough, considering that the system I used performed
1500 PCR extends). The digest list extension does not only reduce
the number of PCR extends, but also the size of the measurement list.
In a scenario where many systems are attested, sending and analyzing
small integrity reports could be an advantage.


Loss of information reported to verifiers

The temporal sequence and which files are actually accessed is not
reported anymore to verifiers. On the other hand, the advantage
would be to have a predictable system state, which could be useful
to enforce sealing policies, for example. This issue could be mitigated
by letting users specify which subset of files can be accessed, among
those signed by software vendors. Files accessed by the IMA TCB (root
processes) are a very small subset of what is shipped by a Linux
distribution. There will be two checks for the integrity verification:
files accessed are provided by the software vendors; files accessed are
in the subset specified by the user. Finally, to be sure that a subset
of files was actually accessed, IMA could report only one additional
event, when the last file of the subset is accessed.


The kernel should not parse arbitrary file formats

The digest list extension uses the same mechanism used to load
a policy. The loaded digest lists are measured, and their digest
is reported to verifiers. It will be possible, as it happens
for the policy, to allow IMA to load only signed digest lists.


The measurement list will have a different meaning

With the digest list extension, the measurement list will contain
a measurement for digest lists and unknown measurements. To avoid
this issue, I suggest to record the measurement of digest list
with a different template name.


The digest list extension does not alter the current behavior of IMA,
if no digest lists are loaded into the kernel. I think it would be
worthwhile to merge this functionality into IMA, to have these benefits:
small measurement lists; better performance, take advantage of
information already available today (digest list, included in RPM
headers are signed by vendors), and predictable system state.

I understand the concern of reporting less information to verifiers,
especially in the scenario where IMA is expected to report the
current state of the system. A reasonable usage, in my opinion,
would be for measuring the TCB, which is small and does not change
too often. Remaining events could be reported (by using a different
PCR, so that PCR 10 remains predictable) regardless of the fact that
the file digest is in a loaded digest list.

Any comment and suggestion will be very appreciated!

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
