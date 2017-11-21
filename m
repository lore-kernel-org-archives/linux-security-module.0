From: james.l.morris@oracle.com (James Morris)
Date: Tue, 21 Nov 2017 21:05:19 +1100 (AEDT)
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
Message-ID: <alpine.LFD.2.20.1711212102370.6690@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 20 Nov 2017, Mimi Zohar wrote:

> On Mon, 2017-11-20 at 11:20 +0100, Patrick Ohly wrote:
> > On Mon, 2017-11-20 at 07:47 +1100, James Morris wrote:
> > > On Fri, 17 Nov 2017, Roberto Sassu wrote:
> > > 
> > > > LSMs are responsible to enforce a security policy at run-time,
> > > > while IMA/EVM protect data and metadata against offline attacks.
> > > 
> > > In my view, IMA can also protect against making an online attack?
> > > persistent across boots, and that would be the most compelling use of
> > > it?for many general purpose applications.
> > 
> > I do not quite buy that interpretation. If the online attack succeeds
> > in bypassing the run-time checks, for example with a full root exploit,
> > then he has pretty much the same capabilities to make persistent file
> > changes as during an offline attack.
> 
> In the face of a full root exploit, there is not much that one can do,
> "other" than to detect it. ?This is why remote attestation is so
> important.

Right, although the consensus seems to be that RA is essential rather than 
simply important.


-- 
James Morris
<james.l.morris@oracle.com>
