Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB421F5F6
	for <linux-security-module@vger.kernel.org>; Sun,  6 Oct 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728231644; cv=none; b=J8TuhlyBsgArj3ZgGHSRF+2OrUoGdJpT+2WUNiv4pRhFpweQFqEkMeCzRccu8sxhGVy6oku9koF0elExvUciT5LUMsOMbHH+w/DGh4qEbX+I+OoS7cl2RKzgnpsSZfAXXYejmhktoGTCknO0F29yKXx94fUTtW+i4ZCJOrfy4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728231644; c=relaxed/simple;
	bh=gY/FEf0C0HB6Ux4n5IDvEJw5lgJxHYiymIy2UG1uVnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWKLMWPPaGzHjV0PKMB8m7z3xaLaojbDH4Lp0NYDdAJlgbDzy8/hB4vGazv85Ev1t5c6ZfR/+z1XsIIaV2c1zNofORhr/rVp8PmMJdE62TwyZbWrJ9hekEG2ceAXh8GpkSINNMU44m8p1wVe8/CnRZP8iDJU6fVM597wsJOffAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 496GIc0E029340;
	Sun, 6 Oct 2024 11:18:38 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 496GIZBB029339;
	Sun, 6 Oct 2024 11:18:35 -0500
Date: Sun, 6 Oct 2024 11:18:35 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
        Fan Wu <wufan@linux.microsoft.com>, Micka??l Sala??n <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-security-module@vger.kernel.org
Subject: Re: TOMOYO's pull request for v6.12
Message-ID: <20241006161835.GA29292@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com> <202410041305.544EA7E4E@keescook> <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp> <202410041645.27A48DA@keescook> <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp> <4eaea237-d259-44bb-a546-26a0558a4453@schaufler-ca.com> <20241005170235.GA24016@wind.enjellic.com> <034409ae-5d36-49d6-8073-adbff2a4404c@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034409ae-5d36-49d6-8073-adbff2a4404c@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 06 Oct 2024 11:18:39 -0500 (CDT)

On Sat, Oct 05, 2024 at 11:58:32AM -0700, Casey Schaufler wrote:

Hi, I hope the weekend is going well for everyone.

> On 10/5/2024 10:02 AM, Dr. Greg wrote:
> > On Sat, Oct 05, 2024 at 09:10:08AM -0700, Casey Schaufler wrote:
> >
> > Good morning to everyone, I hope the weekend is going well.
> >
> > I saw this go by while I was multi-tasking between draining the oil
> > out of the lower unit on my boat motor and welding the boat lift
> > canopy frame and wanted to make sure that Tetsuo's comment is
> > interpreted in the correct context.

> Playing with welders and petrochemicals at the same time is not
> recommended. Boom! Ack!

Actually 80/90 VIS gear lube isn't all that exciting, but we did have
some excitement.

Given that the 40 MPH sustained wind coming across the lake was making
MIG welding impossible [1], I drug the broken part of the lift into
the garage with the electric winch on my pickup and started welding on
it.  The MIG gun went dead and I flipped up my helmet to see what was
going on and my 95 year old Dad was leaning on his walker after
throwing the main breaker switch in the garage.

I told him he had ruined my bead and he said I had two five gallon
cans of gas sitting behind me.  I told him I had checked to make sure
the caps were on so we were good to go.

I haven't seen him that excited since Uncle Larry started welding on
the broken tongue of our homemade trailer that had three pallets of
gunpowder and a bunch of bee boxes on it that we had just hauled up
from Iowa [2].

> >> On 10/5/2024 12:10 AM, Tetsuo Handa wrote:
> >>> ... It is possible that an attempt to make it
> >>> possible to use SELinux and Smack together is a wrong direction. Even if SELinux
> >>> and TSEM conflicts about their security models (and cannot be used together), it
> >>> might not be something we need to care...
> >> In the past I have said that having SELinux and Smack on the same
> >> system is the test case for module stacking, but that I didn't see
> >> it having a practical application. I have since been presented with
> >> a use case that seems reasonable. Because LSM is a mechanism for
> >> additional restrictions it is impossible for two security models to
> >> "conflict". LSMs *must* be written to allow for cases where access
> >> is denied for other reasons. You never get to the MAC check if the
> >> DAC check has already failed. If TSEM can't handle what SELinux or
> >> TOMOYO decides it shouldn't be accepted.
> > I believe that Tetsuo misinterpreted the discussions you and I have
> > had about what represents a 'security model'.
> >
> > For the record, TSEM has no issue with handling whatever SeLinux,
> > SMACK, Tomoyo, AppArmor et.al. decide to do, full stop.
> >
> > It functions like all of the rest of the LSM modules, it determines
> > whether or not a security event is inconsistent with the 'model' that
> > the process is running in, and if so denies it, otherwise it stands
> > aside and lets the other LSM's have a run at it.
> >
> > If some other LSM in front of it decides to deny an event, well and
> > good, the event is over with from TSEM's perspective, as well as
> > anything else behind the denying LSM for that matter.
> >
> > You raised the issue, I believe in V1, as to where we had positioned
> > TSEM in the LSM call list.  After you expressed concern we moved it to
> > the front of the call list because we don't care and everyone else
> > seems to want to be later in the stack, particularly at the end, which
> > would now seem to be be a privileged position held only by BPF.
> >
> > To extend on this a bit for further clarification.
> >
> > As we have evolved TSEM we realized that we actually want to be first,
> > if that isn't also a coveted position.

> The current thought is that we frown on an LSM desiring a specific
> ordering and would probably reject one that required it.

As well we should.

Which is why TSEM has no interest in whether it is first, last,
fourth, sixth, ninth or somewhere else in between, we would embrace
someone choosing for us.

Our preference, only internally, for going first is that when TSEM is
in an infrastructure verification role, such as extended attribute
verification, and since the last time we checked first fail terminates
the LSM call chain, it seemed prudent with an eye on safety (we are
big on safety out here in the Upper Midwest) to bail as fast as we can
and issue a loud warning if there was evidence the LSM infrastructure
or integrity status of the operating system had been tampered with.

Casey, this is a time for you to have legendary impact on Linux
security, well beyond LSM stacking and SMACK, you choose for us... :-)

> > For example, internally, we have TSEM 'models' whose only function is
> > to validate that the extended security attributes of an inode match
> > what the workload was unit tested to, in order to thwart offline
> > modification attacks.  In this case you want TSEM to be running ahead
> > of the security attribute based models, since presumably, you would
> > not want those models making a decision on extended attributes that
> > have been modified.
> >
> > Hopefully this clarifies the issue.
> >
> > We have a long standing question, that has never been answered,
> > regarding module stacking and multiple MAC implementations on the same
> > OS instance but we will leave that to another conversation.

> I would be open to hearing which of the many open questions you're
> referring to.

It is no doubt a question that is simply secondary to our novitiate
status in all of this.

There was an LSM list thread started by, I believe a Korean Linux
integrator.  I believe they were on an Ubuntu OS base platform running
AppArmor and running a containerized Fedora implementation to
experiment with SeLinux, I don't remember all the details, the
exchange would be on lore.  They were somewhat disconcerted by the
fact that when they threw the switch on SeLinux in the Fedora
implementation things pretty much collapsed around them.

Paul replied back and said that the LSM doesn't know anything about
namespaces, so the impact of enabling SeLinux was OS wide.  He
commented further that the above scheme could be implemented but there
would have to be very sophisticated mutual exception policies in place
between the two modeling strategies and composing something like that
would be the domain of experts in the field.

I had replied back to Paul and indicated that it was our understanding
that with LSM stacking you get the union of all the implemented
security models.  We had posed the question, in this hypothetical, if
an unconfined system wide SeLinux policy would be needed to disallow
all action by SeLinux, except for subject/object interactions that
would occur in the subordinate OS instance, but I don't remember
seeing a response, we may have missed it.

Are we missing something in our interpretation of how this needs to
work?

Now off to cook sunfish for breakfast.

Have a good remainder of the weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

[1]: For those who pretty much only do computers.  I is largely
impossible to aluminum MIG weld in a high wind.  It disrupts the argon
shield gas flow and the molten aluminum reacts with the oxygen in the
air and forms aluminum oxide that cold caps the weld since the melting
point of aluminum oxide is higher than the melting point of the
aluminum base metal.

[2]: Yes, TSEM originates from a very rural part of America and we wear
that on our sleeves.
