From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 25 Jan 2018 08:02:53 -0500
Subject: [PATCH V6 1/2] security: Add a cred_getsecid hook
In-Reply-To: <CACdnJutphETV-aGj9QTN0Z=VyQYod9R7=HjQSrXDVL2ASQfOzA@mail.gmail.com>
References: <20180108213620.170042-1-mjg59@google.com>
	<CACdnJuutxPpzr4DPaJLuffHCcMWQN_22dA6wzxMQq3XR2R6+Gg@mail.gmail.com>
	<8b7f9729-af09-a59e-0cd0-8db58d82ea56@schaufler-ca.com>
	<CACdnJutphETV-aGj9QTN0Z=VyQYod9R7=HjQSrXDVL2ASQfOzA@mail.gmail.com>
Message-ID: <1516885373.3751.52.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-01-25 at 11:58 +1100, Matthew Garrett wrote:
> On Mon, Jan 22, 2018 at 5:14 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 1/21/2018 9:27 PM, Matthew Garrett wrote:
> >> On Tue, Jan 9, 2018 at 8:36 AM, Matthew Garrett <mjg59@google.com> wrote:
> >>> For IMA purposes, we want to be able to obtain the prepared secid in the
> >>> bprm structure before the credentials are committed. Add a cred_getsecid
> >>> hook that makes this possible.
> >> Any feedback on this version of the set?
> >
> >
> > Sorry for the delay. I'm having a mindset crisis on secids just
> > now, and I'm not completely sure if I have any issue with this
> > particular hook. Don't wait for me. If everyone else is OK with
> > it, go ahead.
> 
> Thanks Casey - Mimi, are you ok with the IMA changes? If so, which
> tree should these go through?

The IMA patch needs to be upstreamed via the IMA tree, but the only
additional IMA patches being upstreamed for 4.16, at this point, are
bug fixes.

Sorry, I'm only getting back to this now. ?Assuming all is good with
the patch, I'll queue it for after resync'ing with ~4.16.0-rc2.

thanks,

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
