From: patrick.ohly@intel.com (Patrick Ohly)
Date: Mon, 20 Nov 2017 17:15:19 +0100
Subject: IMA appraisal master plan?
In-Reply-To: <1511189976.4729.110.camel@linux.vnet.ibm.com>
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
	<1511189976.4729.110.camel@linux.vnet.ibm.com>
Message-ID: <1511194519.5979.48.camel@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2017-11-20 at 09:59 -0500, Mimi Zohar wrote:
> > When allowing local hashing, it's actually worse: during an offline
> > attack, the attacker might not have access to the TPM and thus
> > cannot
> > easily update the EVM HMAC. During an online attack, the kernel
> > will
> > happily update that and the IMA hash for the attacker, resulting in
> > a
> > file that passes appraisal after a reboot.
> 
> The assumption is that most files in the TCB are not changing and are
> signed. ?Custom policies should require file signatures for these
> files.
> 
> Assuming that the private keys that are used to sign these files, as
> well as the private key used for signing other keys added to the IMA
> keyring, are stored off line, new files can not be signed.
> 
> The number of mutable files in the TCB should be very limited,
> probably < 20 files. ?Their usage can be constrained by MAC.

I'm not sure what exactly "constrained by MAC" implies, but I suspect
that these mutable files will be as important for the integrity of the
TCB as everything else (<insert my systemd configuration file example
again here>). Compromised is compromised, an installation cannot be
"half compromised". So once the policy allows mutable files, a run-time 
exploit that bypasses the MAC can compromise the TCB permanently.

> That said, IMA/IMA-appraisal is work in progress. ?There are still
> measurement/appraisal gaps that need to be closed. ?One such example
> are files read by interpreters and interpreted files. ?There have
> been some initial proposals in this area.

That's what brings us back to my initial question: are the current set
of patches enough to make appraisal useful? Matthew seems to be
optimistic that the answer is yes and I certainly don't want to
discourage him especially as he's doing some actual work while I
couldn't do that, but I remain a bit more skeptical.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
